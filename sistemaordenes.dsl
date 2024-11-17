workspace "Plataforma de gestion de ordenes de compra" {

    !identifiers hierarchical
    
    description "Una API para gestionar órdenes de compra"
    
    model {
        pCliente = person "Cliente Final"
        pAdministrador = person "Administrador"
        ssOrdenes = softwareSystem "Plataforma de gestión de ordenes de compra" {
            
            appMobileCompras = container "App movil" {
                tags "Mobile"
                technology "Flutter"
                description "Aplicativo movil "
            }
            
            wepAppGestion = container "Web de gestión" {
                tags "AppWeb"
                technology "SPA Angular 16"
                description "Sitio web para la administración de parámertros del sistema"
            }
            
            wepAppCompras = container "Web de compras" {
                tags "AppWeb"
                technology "SPA Angular 16"
                description "Sitio web para solicitar ordenes"
            }
            
            apiCompras = container "Api de compras" {
                tags "Api"
                technology "Python 3"
                description "API REST para la consulta y envío de información a la base de datos"
                securityComponent = component "Security Component" "Provides functionality related to signing in, changing passwords, etc." "Spring Bean"
                mainframeBankingSystemFacade = component "Mainframe Banking System Facade" "A facade onto the mainframe banking system." "Spring Bean"
                emailComponent = component "E-mail Component" "Sends e-mails to users." "Spring Bean"
            }
            
            db = container "Base de datos" {
                tags "Database"
            }
        }

        pCliente -> ssOrdenes.wepAppCompras "Interactúa con la app para crear, leer, actualizar y eliminar órdenes"
        pCliente -> ssOrdenes.appMobileCompras "Interactúa con la app para crear, leer, actualizar y eliminar órdenes"
        pAdministrador -> ssOrdenes.wepAppGestion "Configura la API y monitorea su funcionamiento"
        ssOrdenes.apiCompras -> ssOrdenes.db "Lee y escribe informacion a"
        ssOrdenes.wepAppGestion -> ssOrdenes.apiCompras "Lee / escribe a " "https"
        ssOrdenes.wepAppCompras -> ssOrdenes.apiCompras "Lee / escribe a " "https"
        ssOrdenes.appMobileCompras -> ssOrdenes.apiCompras "Lee / escribe a " "https"
    }

    views {
        systemContext ssOrdenes {
            include *
            autolayout lr
        }

        container ssOrdenes {
            include *
            autolayout lr
        }
        
        component apiCompras {
            include *
            autolayout lr
        }

        styles {
            element "Element" {
                color #ffffff
            }
            element "Person" {
                background #741eba
                shape person
            }
            element "Software System" {
                background #8723d9
            }
            element "Container" {
                background #9a28f8
            }
            element "Database" {
                shape cylinder
            }
        }
        
        theme "https://srv-si-001.utpl.edu.ec/REST_PRO_ERP/Recursos/Imagenes/themeAZ_2023.json"
    }

    configuration {
        scope softwaresystem
    }
}
