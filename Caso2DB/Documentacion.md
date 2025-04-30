# Caso 2 Base de Datos Soltura

### Integrantes
* Santiago Calderón Zúñiga 
* Adrián Josué Barquero Sánchez
* Christopher Daniel Vargas Villalta

## 1. Introduccion
Este documento tiene el objetivo de explicar las relaciones y el modelo en general de la base de datos de la Empresa Soltura y sus diferentes gestiones. En esta documentacion explicaremos y detallaremos las relaciones entre las tablas y los objetivos que cumplen para maximizar la eficiencia de soltura y que propiamente tenga un buen funcionamiento. 

### 1.1 Entidades "Socai"
En el siguiente apartado se definen las entidades del modelo, importante mencionar que cada tabla en el diseno tiene un prefijo llamado "Socai", una combinacion entre las palabras "Soltura" y "Caipirinha". 

1. Users
2. Roles
   1. UserRoles
3. Permissions
   1. RolePermissions
4. Subscriptions
   1. SubscirptionUser
   2. PlanFeatures
   3. FeaturesSubscriptions
   4. SubscriptionMembers
   5. UnitTypes
5. Commerces
    1. CommercesFeatures
    2. Renewals
    3. ContractCommerces
    4. ContractObligations
    5. CommerceSettlement
    6. CommerceSettlementDetail
    7. CommerceBalance
    8. TaxRates
    9. ServiceTypes
6. Countries
    1. Provinces
    2. Cities
    3. Addresses
7. Transactions
    1. TransactionTypes
    2. TransactionSubTypes
8. CurrencyTypes
    1. CurrencyExchange
9. Payments
    1. DataPayments
    2. PaymentMethods
    3. ResultPaymenrt 
10. Files
    1. FileTypes
11. Logs
    1. LogTypes
    2. LogSources
    3. LogSeverities
12. Schedules
    1. ScheduleDetails
    2. SubscriptionSchedule
13. ValidationQR
14. Balance
    1. BalanceTypes
    2. BalancePerPerson

### 1.2 Tecnologias
* MongoDB
* SQL Server Management Studio Developer

## 2. Diagrama Entidad-Relacion

![Diagrama ER del Sistema Soltura](/Caso2DB/img/ModeloFisicoCasiFinal.png)

## 3. Grupos Funcionales de la Base de Datos 
En este apartado mencionaremos los grupos funcionales en que se divide la base de datos, esto para tener mejor esquematizado el orden de accion y como se da el flujo de datos en Soltura.

1. **Usuarios y Autenticacion:** Gestion de usuarios, miembros, roles y permisos. Inlcuye las validacione del codigo QR, tanto para descuentos, acceso a locales y demas.
2. **Suscripciones y Planes:** Definición de planes, características y suscripciones.
3. **Comercios y Contratos:** Información de proveedores y acuerdos comerciales, esto incluiria liquidacion de pagos y establecer el dinero que le pertence a soltura y a los provedores.
4. **Transacciones y Pagos:** Registro de pagos, transacciones y saldos.
5. **Geolocalizacion:**  Provincias, ciudades y direcciones. Incluye un apartado de paises para un posterior crecimiento de la empresa.
6. **Sistema:** Logs, archivos y configuracion. 

## 4. Descripcion de Tablas y Grupos Funcionales 
En este apartado se explicaran las tablas de cada uno de los grupos funcionales, describiendo su funcionamiento y como operan. 

### 4.1 Grupo Usuarios y Autenticacion

### 4.2 Grupo Suscripciones y Planes

### 4.3 Grupo Comercios y Contratos
En el grupo de comercios y contratos el objetivo principal es establecer claramente como se realizaran, tanto los acuerdos o contratos que posee Soltura con los proveedores, como la liquidacion de pagos que define que dinero le pertence tanto a Soltura como a los proveedores. Esto repercutira directamente en como los servicios que ofrencen los proveedores, seran incluidos en los planes de suscripcion que ofrece Soltura. Primeramente hay que definir las categorias de servicios que engloban los paquetes, serian las siguientes. 

1. Servicio por cantidad: Este tipo corresponde a la cantidad de veces que uno puede optar por determinado servicio en su plan, digamos en un plan basico puedo optar por 3 servicios de lavanderia al mes.
2. Servicio por monto: Este tipo de servicio corresponde a el dinero disponible que ofrece el plan para gastarlo en determinado servicio, un ejemplo de esto puede ser la gasolina, para todo el mes hay un monto fijo de ₡50,000 colones.
3. Servicio por descuento: Este tipo de servicio corresponde a un porcentaje de descuento incluido en el plan para determinado servicio, por ejemplo existe un acuerdo con Uber Eats para que cualquier miembro de Soltura con el plan basico tiene un 20% de descuento para el pedido.
4. Servicios combinados: Este tipo de servicios corresponden a una combinacion de varios tipos a la vez, por ejemplo en Uber Eats te dan unos 10 pedidos (envío gratis + 20% dto.)

Una vez explicado como se da el funcionamiento de los servicios que ofrece cada comercio o proveedor, es necesario analizar primeramente como se realiza la division del dinero entre Soltura y los proveedores. Este apartado de liquidicacion del dinero tiene que ver con el precio del servicio que da el proveedor a Soltura. Por ejemplo, el precio original del Smartfit es de ₡18,000 colones mensuales, dado a que Soltura asegura una cantidad de clientes a Smartfit estos le ofrecen un precio de ₡15,000 colones con IVA incluido que es del 13%. Osea serian ₡13,050 colones del precio que da el proveedor a Soltura, mas ₡1950 colones de IVA. A partir de esto soltura establece un precio que sea reducido y que se pueda incluir en el plan, entonces por ejemplo suben el precio a ₡16,500 colones, de esto ellos obtienen ₡1500 de ganancia sin tomar en cuenta el impuesto. Osea, serian ₡1305 colones de ganancia, esto mas ₡195 colones de IVA. Resumiendo asi que Soltura se llevaria ₡1500 colones de ganancia, y Smartfit se llevaria sus ₡15,000 colones por dar el servicio a soltura.

Tomando esto en cuenta 

### 4.4 Grupo Transacciones y Pagos

### 4.5 Grupo Geolocalizacion

### 4.6 Grupo Sistema 

