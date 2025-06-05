
Terraform + Jenkins + Apache en Azure

Este proyecto automatiza el despliegue de una máquina virtual en Azure con Apache preinstalado, utilizando **Terraform** como herramienta de infraestructura como código y **Jenkins** para la integración continua.

##Estructura del repositorio



terraform/
│
├── main.tf             # Recursos principales de Azure
├── variables.tf        # Definición de variables
├── outputs.tf          # Salidas clave del despliegue
├── provider.tf         # Configuración del proveedor Azure
├── Jenkinsfile         # Pipeline de Jenkins


##Tecnologías utilizadas

- **Terraform**: Automatización del aprovisionamiento en Azure.
- **Jenkins**: Automatización del pipeline de despliegue.
- **Azure**: Infraestructura en la nube.
- **Apache**: Servidor web instalado automáticamente en la VM.

##¿Qué hace este proyecto?

1. Crea un grupo de recursos, red virtual, subred, IP pública, NSG y una VM en Azure.
2. Instala Apache automáticamente en la máquina virtual.
3. Usa Jenkins para ejecutar un pipeline que:
   - Se autentica en Azure con credenciales seguras.
   - Ejecuta `terraform init`, `plan`, `apply` y `destroy`.
   - Espera a que Apache esté disponible.
   - Comprueba el estado del servidor web.

##Requisitos de Jenkins

- Credenciales almacenadas en Jenkins (ID):
  - `AZURE_CLIENT_ID`
  - `AZURE_CLIENT_SECRET`
  - `AZURE_TENANT_ID`
  - `AZURE_SUBSCRIPTION_ID`
- Jenkins debe estar configurado con:
  - Azure CLI instalado.
  - Terraform instalado.
  - Agente con capacidad para ejecutar scripts `sh` o `bat`.

##Cómo probar

```bash
# Clonar el repositorio
git clone https://github.com/MiguelAnthony23/terraform.git

# Ejecutar desde Jenkins mediante el pipeline definido en Jenkinsfile
````

##Verificación

El pipeline comprueba si Apache está funcionando accediendo por HTTP a la IP pública de la VM.

##Problemas comunes

* Errores de cuota (SKUs no disponibles): Cambia la región o solicita aumento.
* Conflictos con versiones de Terraform o incompatibilidades en Jenkins: Asegúrate de usar versiones compatibles.
* Apache puede tardar unos segundos en arrancar, por eso el pipeline incluye un `sleep`.

##Licencia

Este proyecto está disponible bajo licencia [MIT](LICENSE).

```

---

¿Quieres que lo suba formateado como archivo real para que puedas copiarlo tal cual o que lo integre directamente a tu repositorio vía instrucciones Git?
```
