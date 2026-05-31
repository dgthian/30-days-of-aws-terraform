### day05: passing the variables in different ways

# Valeur par défaut (Supprime ou renomme temporairement ton fichier terraform.tfvars)
mv terraform.tfvars terraform.tfvars.bak

# Valeur dans terraform.tfvars

environment = "demo"

# Variable d'environnement
export TF_VAR_environment=demo