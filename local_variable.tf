locals {
  habilitar_publica      = false
  add_elastic_ip         = false
  usar_autoescalado      = false
  instancias_red_publica = false
  cantidad_rds           = 0
  cantidad_instancias    = 2
  cantidad_zonas         = 2
  cantidad_dynamo        = 1
  ami_code               = var.region == "us-west-2" ? "ami-02d3770deb1c746ec" : "ami-0ae8f15ae66fe8cda"
  script_inicial_ec2     = <<EOF
#!/bin/bash
#Update Yum
sudo yum -y update

# agregar repositorio node
#curl -sL https://rpm.nodesource.com/setup_20.x | bash -
curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo yum install -y nsolid

#instalacion node
#sudo yum -y install nodejs

#crear carpeta
sudo mkdir -p /var/app

#descargar la aplicacion
sudo wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/ILT-TF-100-TECESS-5/app/app.zip

#deszipear
sudo unzip app.zip -d /var/app
cd /var/app

sudo sed -i "s/DEFAULT_AWS_REGION || '';/DEFAULT_AWS_REGION || '${data.aws_region.current.name}';/" /var/app/api/common/constants.js

#sudo sed -i "s/169.254.169.254/localhost/" /var/app/api/controllers/settings.js

#instalar dependencias
sudo npm install

sudo npm start

EOF
}