provider "google" {
  project = "project_id"
  region = "us-central1"
  zone = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "nombre_de_instancia"
  machine_type = "n1-standard-2" #2CPU virtuales + 7.5 GB memoria

  boot_disk {
    initialize_params {
      image = "nombre_de_imagen" #Imagen creada con Packer
    }
  }

  network_interface {
    # Red predeterminada para todos los proyectos de GCP
    network       = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
  //Se aplica regla de firewall para permitir que IP externas accedan a instancia
  tags = ["instancia01"]
}

resource "google_compute_network" "vpc_network" {
  name                    = "prueba-network" #Cambiar si es que se quiere crear una nueva red
  auto_create_subnetworks = "true"
}

//Configuración de una regla básica de firewall
resource "google_compute_firewall" "instancia01" {
  #Necesitamos crear distintas reglas firewall. Una para ssh, otra para BD, cada una con su descripción y rango de IP
  name    = "ssh-ssl-others"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", ,"443", "3306","5432"] #Separar por regla, no se recomienda todo en 1
  }

  source_ranges = ["0.0.0.0/0"]
  source_tags = ["instancia01"]
}

resource "google_sql_database_instance" "BD001" {
  #Creamos una instancia CloudSQL "básica".
  name             = "testv001" #Verificar antes de que no exista
  database_version = "POSTGRES_11" #Buscar versiones disponibles del motor elegido
  region           = "us-central1"

  settings {
    # Configuración para máquinas de 2da generación
    tier = "db-g1-small"
  }
}

