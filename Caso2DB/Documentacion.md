# Caso 2 Base de Datos Soltura

### Integrantes
* Santiago Calderón Zúñiga 
* Adrián Josué Barquero Sánchez
* Christopher Daniel Vargas Villalta

## 1. Introduccion
Este documento tiene el objetivo de explicar las relaciones y el modelo en general de la base de datos de la Empresa Soltura y sus diferentes gestiones. En esta documentacion explicaremos y detallaremos las relaciones entre las tablas y los objetivos que cumplen para maximizar la eficiencia de soltura y que propiamente tenga un buen funcionamiento. 

### 1.1 Entidades "Socai"
En el siguiente apartado se definen las entidades del modelo, importante mencionar que cada tabla en el diseno tiene un prefijo llamado "Socai", una combinacion entre las palabras "Soltura" y "Caipirinha". 

1. Users ✓
2. Roles ✓
   1. UserRoles ✓
3. Permissions ✓
   1. RolePermissions ✓
4. Subscriptions ✓
   1. SubscirptionUser ✓
   2. PlanFeatures ✓
   3. FeaturesSubscriptions ✓
   4. SubscriptionMembers ✓
   5. UnitTypes ✓
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
13. ValidationQR ✓
    1. ValidationTypes ✓
14. Balance
    1. BalanceTypes
    2. BalancePerPerson

### 1.2 Tecnologias
* MongoDB
* SQL Server Management Studio Developer

## 2. Diagrama Entidad-Relacion

![Diagrama ER del Sistema Soltura](/Caso2DB/img/ModeloCorreccion.png)

## 3. Grupos Funcionales de la Base de Datos 
En este apartado mencionaremos los grupos funcionales en que se divide la base de datos, esto para tener mejor esquematizado el orden de accion y como se da el flujo de datos en Soltura.

1. **Usuarios y Autenticacion:** Gestion de usuarios, roles y permisos. Inlcuye las validacione del codigo QR, tanto para descuentos, acceso a locales y demas.
2. **Suscripciones y Planes:** Definición de planes, características y suscripciones.
3. **Comercios y Contratos:** Información de proveedores y acuerdos comerciales, esto incluiria liquidacion de pagos y establecer el dinero que le pertence a soltura y a los provedores.
4. **Transacciones y Pagos:** Registro de pagos, transacciones y saldos.
5. **Geolocalizacion:**  Provincias, ciudades y direcciones. Incluye un apartado de paises para un posterior crecimiento de la empresa.
6. **Sistema:** Logs, archivos y configuracion. 

## 4. Descripcion de Tablas y Grupos Funcionales 
En este apartado se explicaran las tablas de cada uno de los grupos funcionales, describiendo su funcionamiento y como operan. 

### 4.1 Grupo Usuarios y Autenticacion
En este apartado o grupo funcional se tiene como objetivo el englobar lo que serian los usuarios de Soltura. Esto ademas de las tablas de los codigos de validacion, un apartado reservado a tener acceso a los servicios que ofrece Soltura, esto ya sea para entrar a un establecimiento, canjear un descuento o utilizar dinero de un fondo. 

#### 4.1.1 SocaiUsers
Esta tabla permite registrar los datos basicos del usuario incluyendo, id, nombres, address, password etc. Tambien posee una llave foranea con "AddressId" para determinar la residencia del usuario o lugar de facturacion posteriormente.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 UserId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(250) | 250 | □ | | ✓ | |
| Email | varchar(220) | 220 | □ | | □ | |
| PhoneNumber | varchar(20) | 20 | □ | | □ | |
| Password | varbinary(100) | 100 | □ | | □ | |
| 🔗 AddressId | int | 4 | □ | | □ | |
| isActive | bit | 1 | □ | | □ | |
| LastLogin | datetime | 8 | □ | | □ | |
| CreatedAt | datetime | 8 | □ | | □ | |

#### 4.1.2 SocaiRoles
Tabla de las categorias de Roles que existen dentro de la base de datos, esto para dictaminar quien puede realizar cambios en la propia BD o incluso designar roles entre usuarios especificos, esto dependiendo de si son usuarios principales o miembros.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 RoleId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(25) | 25 | □ | | □ | |
| Description | varchar(125) | 125 | □ | | □ | |
| CreatedAt | datetime | 8 | □ | | □ | |
| UpdatedAt | datetime | 8 | □ | | □ | |

#### 4.1.3 SocaiPermissions
Tabla que lista todos los permisos existentes en la BD, esta posteriormente se conectara con los roles.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 PermissionID | int | 4 | ✓ | 1 | □ | |
| Name | varchar(25) | 25 | □ | | □ | |
| Description | varchar(125) | 125 | □ | | □ | |
| CreatedAt | datetime | 8 | □ | | □ | |
| UpdatedAt | datetime | 8 | □ | | □ | |

#### 4.1.4 SocaiRolePermissions
Tabla intermedia entre los roles y los permisos, dictamina que permisos son establecidos a que roles, corresponde a una relacion de muchos a muchos.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 RolePermissionId | int | 4 | ✓ | 1 | □ | |
| 🔗 RoleId | int | 4 | □ | | □ | |
| 🔗 PermissionID | int | 4 | □ | | □ | |
| UpdatedAt | datetime | 8 | □ | | □ | |

#### 4.1.5 SocaiUserRoles
Tabla intermedia en donde para cualquier usuario de la plataforma se establece un rol, desde desarrolladores hasta clientes. 

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 UserRoleId | int | 4 | ✓ | 1 | □ | |
| 🔗 UserId | int | 4 | □ | | □ | |
| 🔗 RoleId | int | 4 | □ | | □ | |
| UpdatedAt | datetime | 8 | □ | | □ | |

#### 4.1.6 SocaiValidationQr
Esta tabla corresponde a una de las partes mas fundamentales de Soltura, la validacion QR corresponde a un codigo escaneable y aplicable que te permite usar los beneficios que uno adquiere cuando compra un plan, en este caso manejamos dicha interaccion como si fuera una transaccion. Primeramente determinamos cuanto se uso, esto sin importar que sea un monto, cantidad, booleano o descuento se registrara como decimal. Posteriormente para identificar cual fue el uso del servicio se traen distintas llaves foraneas como la suscripcion del usuario, comercio, servicio especifico del plan, plan del cual se tomo y un id de transaccion. El rebajo por ejemplo de una cantidad usada como podria ser 1 clase zumba se reducira posteriormente en tablas como balance que actualiza el servicio que fue empleado o gastado. Tambien se encuentra una llave foranea llamada "ValidationType", en donde hay un listado de que tipo de validacion es, osea, si es entrada a un local con QR, generacion de codigo para uso y demas. 

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 ValidationId | int | 4 | □ | | □ | |
| validationDate | datetime | 8 | □ | | □ | (getdate()) |
| quantityUsed | decimal(10, 2) | 9 | □ | | □ | |
| appliedFromPlan | decimal(10, 2) | 9 | □ | | □ | |
| extraChange | decimal(10, 2) | 9 | □ | | □ | |
| ValidationStatusId | int | 4 | □ | | □ | |
| qrCodeData | varchar(100) | 100 | □ | | □ | |
| comments | varchar(200) | 200 | □ | | ✓ | |
| createdAt | datetime | 8 | □ | | ✓ | |
| updatedAt | datetime | 8 | □ | | ✓ | |
| 🔗 SubscriptionUserId | int | 4 | □ | | □ | |
| 🔗 CommerceId | int | 4 | □ | | □ | |
| 🔗 FeaturesSubscriptionId | int | 4 | □ | | □ | |
| 🔗 ValidationTypeId | int | 4 | □ | | □ | |
| 🔗 TransactionId | int | 4 | □ | | □ | |

#### 4.1.7 SocaiValidationTypes
Esta tabla como se menciono anteriormente es una lista de los tipos de validacion disponibles. Esto refiriendose a para que se va a usar ya sea, QR escaneable, generacion de codigo o validacion manual.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 ValidationTypeId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(60) | 60 | □ | | □ | |
| Description | varchar(300) | 300 | □ | | □ | |
| IsActive | bit | 1 | □ | | □ | ((1)) |


### 4.2 Grupo Suscripciones y Planes
En este apartado funcional basicamente se establecen las suscripciones de cada usuario, los miembros en caso de que sea un plan familiar y tambien propiamente los planes, cuales son los beneficios para cada plan. Importante mencionar que en este apartado solo definimos el listado de beneficios, en relacion a como se definen dichos beneficios eso seria un apartado a tratar en comercios y contratos.

#### 4.2.1 SocaiSubscriptions
En esta tabla se establecen propiamente las suscripciones o los planes existentes, se define si es customizable, activo, el precio, descripcion y el currency de pago.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 SubscriptionId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(100) | 100 | □ | | □ | |
| Description | varchar(250) | 250 | □ | | ✓ | |
| isCustomizable | bit | 1 | □ | | □ | |
| isActive | bit | 1 | □ | | □ | |
| createdAt | datetime | 8 | □ | | □ | |
| updatedAt | datetime | 8 | □ | | □ | |
| amount | decimal(15, 2) | 9 | □ | | □ | |
| 🔗 CurrencyTypeId | int | 4 | □ | | □ | |

#### 4.2.2 SocaiSubscriptionUser
Esta tabla intermedia entre las suscripciones y los usuarios es una parte esencial para saber el plan que haya adquirido cada usuario y simplemente vincurlarlos con su plan activo. 

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 SubscriptionUserId | int | 4 | ✓ | 1 | □ | |
| enable | bit | 1 | □ | | □ | |
| startDateTime | datetime | 8 | □ | | ✓ | |
| endDateTime | datetime | 8 | □ | | ✓ | |
| 🔗 UserId | int | 4 | □ | | □ | |
| 🔗 SubscriptionId | int | 4 | □ | | □ | |

#### 4.2.3 SocaiSubscriptionMembers
Esta tabla nos permite determinar cuales personas tienen acceso a un plan familiar, en este caso seria un usuario principal mas los miembros de su familia o grupo de amigos. Aqui definimos una seria de datos para llevar registro de quienes tienen acceso a este plan.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 SubscriptionMemberId | int | 4 | ✓ | 1 | □ | |
| 🔗 SubscriptionUserId | int | 4 | □ | | □ | |
| Name | varchar(40) | 40 | □ | | □ | |
| Email | varchar(60) | 60 | □ | | ✓ | |
| PhoneNumber | varchar(20) | 20 | □ | | ✓ | |
| Relationship | varchar(20) | 20 | □ | | ✓ | |
| DateofBirth | date | 3 | □ | | ✓ | |
| IsActive | bit | 1 | □ | | □ | ((1)) |
| 🔗 ValidationId | int | 4 | □ | | □ | |
| CreatedAt | datetime | 8 | □ | | ✓ | |

#### 4.2.4 SocaiPlanFeatures
Esta tabla seria propiamente el catagolo de todos los beneficios disponibles para los planes. Esta tabla incluiria una categoria para clasificar si es un beneficio de bienestar o algo similar, un "UnitType" que es digamos si es un beneficio de cantidad, monto, tiempo, descuento o booleano. Esto para saber como clasificarlo a la hora de su uso.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 FeatureId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(100) | 100 | □ | | □ | |
| Description | varchar(250) | 250 | □ | | ✓ | |
| Category | varchar(50) | 50 | □ | | ✓ | |
| 🔗 UnitTypeId | int | 4 | □ | | □ | |
| isActive | bit | 1 | □ | | □ | |
| UpdatedTime | datetime | 8 | □ | | □ | |
| CreatedTime | datetime | 8 | □ | | □ | |

#### 4.2.5 SocaiUnitTypes
Esta tabla de unittypes es la que propiamente nos permite identificar si es un beneficio que se maneja en dinero, cantidad, porcentaje o booleano. En este caso lo manejamos como unidad entonces por ejemplo unidad 1 podria ser colones. Esta es una clasificacion inicial que simplemente funciona de referencia para clasificar el beneficio. 

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 UnitTypeId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(40) | 40 | □ | | □ | |
| Symbol | varchar(10) | 10 | □ | | ✓ | |
| Description | varchar(200) | 200 | □ | | ✓ | |
| IsActive | bit | 1 | □ | | □ | ((1)) |

#### 4.2.6 SocaiFeaturesSubscriptions
Esta seria una tabla intermedia que define cuales beneficios o servicios incluye cada plan y su cantidad, esta cantidad es un valor decimal pero se puede aplicar tanto para boolenos (1.0), porcentajes, montos y cantidades; esto se refuerza con "ServiceTypeId" y "UnitTypeId". Por ejemplo un beneficio de descuento asociado a un plan seria asi: Uber Eats - 15% descuento, Quantity: 15.0, UnitTypeId: 4  // Porcentaje y ServiceTypeId: 3  // Servicio por descuento. Esta es la tabla que nos ayudara propiamente a usar estos beneficios o servicios en el dia a dia mediante la validacionQR, esto ademas de definir la relacion entre un plan y el beneficio como tal. 

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 FeaturesSubscriptionsId | int | 4 | ✓ | 1 | □ | |
| 🔗 PlanFeatureId | int | 4 | □ | | □ | |
| 🔗 SubscriptionId | int | 4 | □ | | □ | |
| Quantity | decimal(18, 2) | 9 | □ | | ✓ | |
| 🔗 UnitTypeId | int | 4 | □ | | □ | |
| CreatedAt | datetime | 8 | □ | | □ | |
| UpdatedAt | datetime | 8 | □ | | □ | |
| 🔗 ServiceTypeId | int | 4 | □ | | □ | |
| MemberCount | int | 4 | □ | | □ | |
| IsMemberSpecific | bit | 1 | □ | | □ | ((0)) |





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

