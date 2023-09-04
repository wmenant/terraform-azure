# terraform-azure

ENGLISH
Repository for Terraform simple project using Azure and Terraform variables

This repository contains all the necessary files to deploy a Virtual Machine using Azure and Terraform as IaaC (Infrastructure As A Code) to understand how Terraform works with input variables and deployment settings.

Don't forget to modify the authentication variables of your Azure subscription in each "terraform.tfvars" file:

azure_tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_client_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_client_secret   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

You can also modify the values of the variables, such as for example the size of the Virtual machine for which I indicated Standard_B4ms, the IP address and the associated name.

------------

FRENCH
Dépôt pour projet simple Terraform utilisant Azure et des variables Tarraform

Ce référentiel contient tous les fichiers nécessaires pour déployer une machine virtuelle à l'aide d'Azure et Terraform comme IaaC (Infrastructure As A Code) afin notamment de comprendre comment Terraform fonctionne avec les variables d'entrée et paramétres de déploiements.

N'oubliez pas de modifier les variables d'authentification de votre abonnement Azure dans chaque fichier "terraform.tfvars" : 

azure_tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_client_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_client_secret   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

Vous pouvez aussi modifier les valeurs des variables, comme par exemple la taille de la machine Virtuelle dont j'ai indiqué Standard_B4ms, l'adresse IP et le nom associé.

