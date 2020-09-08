# Terraform-GoogleCloud
Probaremos herramientas proporcionadas por HashiCorp para la creación de imágenes e instancias de VM, las cuales serán utilizadas en Google Cloud.

## Pre-requisitos
Debemos tener instalado Terraform y Packer. En la sección **_Herramientas Utulizadas_** específicamos que es, como instalar y configurar cada una de ellas en Ubuntu 18.04 LTS.

## Creamos imágen de máquina a utilizar
Procedemos a crear nuestro directorio  y crear nuestro archivo de configuración image.json inicial para utilizar en Packer. 
```bash
mkdir nombre_proyecto
cd nombre_proyecto
touch config_imagen.json
```
_En la imagen, si es que así se necesita, se puede incluir una referencia a un fichero con la configuración de provisionamiento_
El archivo de provisionamiento es un script que se ejecutará en bash. El fichero referenciado puede ser observado en **_base-setup-init_**

Para finalizar la creación de la imagen ejecutamos
```bash
packer build config_imagen.json
```

## Herramientas utilizadas
 * #### Terraform
Herramienta que nos va a permite definir y configurar la infraestructura de nuestro DataCenter en un lenguaje de alto nivel. (https://www.terraform.io)
##### Instalando Terraform
```bash
wget https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip #wget preinstalado
unzip terraform_0.13.2_linux_amd64.zip #unzip preinstalado
mv terraform ~/bin #movemos
terraform version #Debería mostrar versión instalada
```
* #### Packer
Herramienta que automaiza la creación de imagenes de máquina a partir de un solo archivo de configuración JSON.(https://www.packer.io)
##### Instalando Packer
```bash
export VERSION="1.6.2" #Versión a utilizar
wget https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_linux_amd64.zip
unzip packer_${VERSION}_linux_amd64.zip
sudo mv packer /usr/local/bin
packer version #Debería mostrar versión instalada
```

* #### Google Cloud
Debemos tener habilitado un proyecto en https://cloud.google.com y tener el fichero cuenta_servicio.json (identificación de la cuenta de servicio) que vamos a referenciar para crear imagen de máquina. (También se puede autentificar con una variable de entorno, más info en https://cloud.google.com/iam/docs)






