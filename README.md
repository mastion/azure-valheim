# Azure Valheim

Using terraform create a server (or maybe a hosted service?) to host the valheim server and then a public ip (api gateway?) to reach it.

## Tools

 - Docker
 - Terriform
 - Azure 
 
## Development

1. Clone & Build https://github.com/julie-ng/azure-terraform-cli 
    - `docker build --no-cache -t azure-terraform .`
1. `docker run -d -it --name azure-valheim-dev --entrypoint "/usr/bin/tail" -v ${pwd}:/home/devops azure-terraform -f /dev/null`
1. `docker exec -it azure-valheim-dev /bin/bash`
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway

## Links

 - https://github.com/lloesche/valheim-server-docker
 - https://github.com/julie-ng/azure-terraform-cli
 - https://github.com/benc-uk/terraform-mgmt-bootstrap
 - https://www.reddit.com/r/valheim/comments/ln8jqv/valheim_dedicated_server_running_in_azure/
 