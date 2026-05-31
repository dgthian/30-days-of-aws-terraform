### day05: passing the variables in different ways

# Valeur par défaut (Supprime ou renomme temporairement ton fichier terraform.tfvars)
mv terraform.tfvars terraform.tfvars.bak

# Valeur dans terraform.tfvars
environment = "demo"

# Variable d'environnement
export TF_VAR_environment=demo

# Option -var
# Avec la variable d'environnement toujours présente :
terraform plan -var="environment=demo"


# Fichier spécifique avec -var-file
# demo.tfvars
environment = "production"

terraform plan -var-file="demo.tfvars"

# Ordre de priorité (du plus fort au plus faible)
# 1. -var="environment=..."
# 2. -var-file=...
# 3. Variables d'environnement TF_VAR_environment
# 4. terraform.tfvars et *.auto.tfvars
# 5. Valeur default