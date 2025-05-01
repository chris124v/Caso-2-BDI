# Caso 2 Base de Datos Soltura

## Integrantes
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
5. Commerces ✓
    1. CommercesFeatures ✓
    2. Renewals ✓
    3. ContractCommerces ✓
    4. ContractObligations ✓
    5. CommerceSettlement ✓
    6. CommerceSettlementDetail ✓
    7. CommerceBalance ✓
    8. CommerceContactPerson ✓
    9. TaxRates ✓
    10. ServiceTypes ✓
6. Countries
    1. Provinces
    2. Cities
    3. Addresses
7. Transactions
    1. TransactionTypes
    2. TransactionSubTypes
8. CurrencyTypes
    1. CurrencyExchange
9. Payments ✓
    1. DataPayments ✓
    2. PaymentMethods ✓
    3. ResultPayment ✓
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
En el grupo de comercios y contratos el objetivo principal es establecer claramente como se realizaran, tanto los acuerdos o contratos que posee Soltura con los proveedores, como la liquidacion de pagos que define que dinero le pertence tanto a Soltura como a los proveedores. Esto repercutira directamente en como los servicios que ofrencen los proveedores que seran incluidos en los planes de suscripcion que ofrece Soltura. Primeramente hay que definir las categorias de servicios que engloban los paquetes, serian las siguientes. 

1. Servicio por cantidad: Este tipo corresponde a la cantidad de veces que uno puede optar por determinado servicio en su plan, digamos en un plan basico puedo optar por 3 servicios de lavanderia al mes.
2. Servicio por monto: Este tipo de servicio corresponde a el dinero disponible que ofrece el plan para gastarlo en determinado servicio, un ejemplo de esto puede ser la gasolina, para todo el mes hay un monto fijo de ₡50,000 colones.
3. Servicio por descuento: Este tipo de servicio corresponde a un porcentaje de descuento incluido en el plan para determinado servicio, por ejemplo existe un acuerdo con Uber Eats para que cualquier miembro de Soltura con el plan basico tiene un 20% de descuento para el pedido.
4. Servicios combinados: Este tipo de servicios corresponden a una combinacion de varios tipos a la vez, por ejemplo en Uber Eats te dan unos 10 pedidos (envío gratis + 20% dto.)

Una vez explicado como se da el funcionamiento de los servicios que ofrece cada comercio o proveedor, es necesario analizar primeramente como se realiza la division del dinero entre Soltura y los proveedores. Este apartado de liquidicacion del dinero tiene que ver con el precio del servicio que da el proveedor a Soltura. Por ejemplo, el precio original del Smartfit es de ₡18,000 colones mensuales, dado a que Soltura asegura una cantidad de clientes a Smartfit estos le ofrecen un precio de ₡15,000 colones con IVA incluido que es del 13%. Osea serian ₡13,050 colones del precio que da el proveedor a Soltura, mas ₡1950 colones de IVA. A partir de esto soltura establece un precio que sea reducido y que se pueda incluir en el plan, entonces por ejemplo suben el precio a ₡16,500 colones, de esto ellos obtienen ₡1500 de ganancia sin tomar en cuenta el impuesto. Osea, serian ₡1305 colones de ganancia, esto mas ₡195 colones de IVA. Resumiendo asi que Soltura se llevaria ₡1500 colones de ganancia, y Smartfit se llevaria sus ₡15,000 colones por dar el servicio a soltura.

Tomando esto en cuenta para entender los contratos con los proveedores y como van a ofrecer sus servicios procederemos a explicar cada una de las tablas de este grupo funcional.

#### 4.3.1 SocaiCommerces
Esta tabla es la que contiene la informacion general del comercio, osea del proveedor. Nos menciona todos los datos necesarios para identificarlo y si es un proveedor activo.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 CommerceId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(225) | 225 | □ | | ✓ | |
| Description | varchar(250) | 250 | □ | | ✓ | |
| 🔗 AddressId | int | 4 | □ | | □ | |
| PhoneNumber | varchar(20) | 20 | □ | | ✓ | |
| Email | varchar(200) | 200 | □ | | □ | |
| 🔗 FileId | int | 4 | □ | | □ | |
| IsActive | bit | 1 | □ | | □ | |
| CreatedAt | datetime | 8 | □ | | □ | |
| UpdatedAt | datetime | 8 | □ | | □ | |

#### 4.3.2 SocaiCommerceContactPerson
Esta tabla corresponde a la informacion del representante designado del proveedor, esto para facilitar la comunicacion y tener registrada a una persona fisica o juridica que sea capaz de comunicarse con Soltura propiamente.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 ContactPersonId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(60) | 60 | □ | | □ | |
| Position | varchar(100) | 100 | □ | | ✓ | |
| Department | varchar(100) | 100 | □ | | ✓ | |
| PhoneNumber | varchar(20) | 20 | □ | | □ | |
| Email | varchar(100) | 100 | □ | | ✓ | |
| 🔗 CommerceId | int | 4 | □ | | □ | |

#### 4.3.2 SocaiContractCommerces
En este apartado tenemos la tabla que corresponde al documento formal del contrato que tiene el comercio o proveedor con Soltura, importante mencionar que este contrato es el documento como tal que indica validez, descripcion, comercio, firma y si esta activo. Propiamente la distribucion de dinero se hace en una tabla aparte pero esta tabla posee el documento general que establece el acuerdo. 

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 ContractCommercesId | int | 4 | ✓ | 1 | □ | |
| validFrom | datetime | 8 | □ | | □ | |
| validTo | datetime | 8 | □ | | ✓ | |
| contractType | varchar(50) | 50 | □ | | ✓ | |
| contractDescription | varchar(150) | 150 | □ | | ✓ | |
| isActive | bit | 1 | □ | | □ | |
| 🔗 CommerceId | int | 4 | □ | | □ | |
| inChargeSignature | varchar(100) | 100 | □ | | □ | |
| 🔗 FileId | int | 4 | □ | | □ | |
| 🔗 CountryId | int | 4 | □ | | □ | |

#### 4.3.3 SocaiRenewals
Esta tabla almacena las renovaciones de contratos con comercios que ya tenian un contrato previamente, esta tabla nos sirve mas que todo para tener un registro del porque se continua dicha renovacion y que otras condiciones podrian agregarse a contratos futuros. 

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 RenewalId | int | 4 | ✓ | 1 | □ | |
| renewalDate | datetime | 8 | □ | | □ | |
| renewalMotive | varchar(500) | 500 | □ | | □ | |
| 🔗 ContractCommercesId | int | 4 | □ | | □ | |

#### 4.3.4 SocaiContractObligations
Este apartado serian las obligaciones financieras generales del proveedor a pagar o en este caso el precio que da propiamente a Soltura para ofrecer, se le adjunta el contrato, la moneda la que hay que pagar, si es una obligacion activa y finalmente la fecha de inicio y final.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 ObligationsId | int | 4 | ✓ | 1 | □ | |
| amountToPay | decimal(15, 2) | 9 | □ | | □ | |
| 🔗 CurrencyId | int | 4 | □ | | □ | |
| isActive | bit | 1 | □ | | □ | |
| startdate | datetime | 8 | □ | | □ | |
| limitdate | datetime | 8 | □ | | □ | |
| 🔗 ContractCommercesID | int | 4 | □ | | □ | |

#### 4.3.5 SocaiCommerceSettlement
Esta es la tabla que gestiona las liquidaciones periodicas con cada comercio, contiene todo lo que seria períodos de liquidación, montos brutos/netos, comisiones, impuestos. Esto nos permite llevar a gran escala el manejo de dinero de Soltura y gestionarlo de forma correcta. Se podria considerar como una factura.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 CommerceSettlementId | int | 4 | □ | | □ | |
| settlementPeriodStart | datetime | 8 | □ | | □ | |
| settlementPeriodEnd | datetime | 8 | □ | | □ | |
| totalGross | decimal(18, 2) | 9 | □ | | □ | |
| totalCommission | decimal(18, 2) | 9 | □ | | □ | |
| totalNet | decimal(18, 2) | 9 | □ | | □ | |
| settlementDate | datetime | 8 | □ | | ✓ | |
| status | varchar(20) | 20 | □ | | □ | |
| createdAt | datetime | 8 | □ | | □ | (getdate()) |
| updatedAt | datetime | 8 | □ | | ✓ | |
| 🔗 CommerceId | int | 4 | □ | | □ | |
| 🔗 TaxRateId | int | 4 | □ | | □ | |
| TaxAmount | decimal(18, 2) | 9 | □ | | ✓ | |
| IncludesTax | bit | 1 | □ | | □ | ((1)) |

#### 4.3.6 SocaiCommerceSettlementDetail
Esta seria una tabla casi igual que la anterior solo que detalla cada transacción individual dentro de una liquidacion, como podrian ser montos, comisiones, referencias a transacciones específicas y demas. 

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 CommerceSettlementDetailId | int | 4 | ✓ | 1 | □ | |
| grossAmount | decimal(18, 2) | 9 | □ | | □ | |
| commission | decimal(18, 2) | 9 | □ | | □ | |
| Termsandconditions | varchar(MAX) | -1 | □ | | □ | |
| netAmount | decimal(18, 2) | 9 | □ | | □ | |
| createdAt | datetime | 8 | □ | | □ | (getdate()) |
| updatedAt | datetime | 8 | □ | | ✓ | |
| 🔗 CommerceSettlementId | int | 4 | □ | | □ | |
| 🔗 TransactionId | int | 4 | □ | | □ | |
| 🔗 TaxRateId | int | 4 | □ | | □ | |
| TaxAmount | decimal(18, 2) | 9 | □ | | ✓ | |
| IncludesTax | bit | 1 | □ | | ✓ | ((1)) |

#### 4.3.7 SocaiCommerceBalance
Esta tabla simplemente mantiene el saldo actualizado con cada comercio o proveedor, define propiamente el balance actual y la ultima fecha de liquidicacion.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 CommerceBalanceId | int | 4 | ✓ | 1 | □ | |
| currentBalance | decimal(18, 2) | 9 | □ | | □ | ((0)) |
| lastSettlementDate | datetime | 8 | □ | | ✓ | |
| updatedAt | datetime | 8 | □ | | □ | (getdate()) |
| 🔗 CommerceId | int | 4 | □ | | □ | |

#### 4.3.8 SocaiTaxRates
Tabla que normaliza tasas de impuestos aplicables a diversos beneficios o servicios, nos permite agregarlo en liquidaciones y posteriormente en la division de dinero con el proveedor y Soltura. 

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 TaxRateId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(30) | 30 | □ | | □ | |
| Rate | decimal(5, 2) | 5 | □ | | □ | |
| 🔗 CountryId | int | 4 | □ | | □ | |
| IsActive | bit | 1 | □ | | □ | ((1)) |
| ValidFrom | datetime | 8 | □ | | □ | |
| ValidTo | datetime | 8 | □ | | ✓ | |

#### 4.3.9 SocaiCommerceFeatures
Esta tabla seria la mas importante en referencia a comercios o proveedores, en este caso designamos una tabla que gestiona el dinero de manera correcta para que tanto el proveedor como Soltura obtengan el dinero que deben llevarse. La tabla en terminos generales define que servicios especificos ofrece cada comercio y bajo que condiciones. Esto incluyendo precios originales, precios negociados, márgenes, impuestos, tipos de servicio, descuento aplicado, validez y finalmente el contrato al que pertenece dicho servicio. Esta tabla es de suma importancia no solo porque gestiona la division del dinero sino que tambien establece si es un servicio modificable de un plan o no en "IsGuaranteedRight", esto para determinar la cantidad de clientes y tambien define terminos y condiciones de la utilizacion de este servicio. Importante mencionar que tambien se define si el servicio es booleano, descuento, monto y cantidad.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 CommercesFeaturesId | int | 4 | ✓ | 1 | □ | |
| 🔗 CommercesId | int | 4 | □ | | □ | |
| 🔗 PlanFeatureId | int | 4 | □ | | □ | |
| IsActive | bit | 1 | □ | | □ | |
| ValidFrom | datetime | 8 | □ | | □ | |
| ValidTo | datetime | 8 | □ | | □ | |
| CreatedAt | datetime | 8 | □ | | □ | |
| UpdatedAt | datetime | 8 | □ | | □ | |
| OriginalPrice | decimal(18, 2) | 9 | □ | | □ | |
| NegotiatedPrice | decimal(18, 2) | 9 | □ | | □ | |
| 🔗 ServiceTypeId | int | 4 | □ | | □ | |
| IsGuaranteedRight | bit | 1 | □ | | □ | ((1)) |
| DiscountType | char(1) | 1 | □ | | □ | |
| DiscountValue | decimal(18, 2) | 9 | □ | | □ | |
| SolturaMargin | decimal(18, 2) | 9 | □ | | □ | |
| IsMarginPercentage | bit | 1 | □ | | □ | ((1)) |
| InlcudesTax | bit | 1 | □ | | □ | ((1)) |
| 🔗 TaxRateId | int | 4 | □ | | □ | |
| MinQuantity | decimal(18, 2) | 9 | □ | | ✓ | |
| MaxQuantity | decimal(18, 2) | 9 | □ | | ✓ | |
| TermsAndConditions | varchar(500) | 500 | □ | | ✓ | |
| AdditionalBenefits | varchar(500) | 500 | □ | | ✓ | |
| IsCombined | bit | 1 | □ | | □ | ((0)) |
| 🔗 ContractCommercesId | int | 4 | □ | | □ | |

#### 4.3.9.1 SocaiServiceTypes
Esta tabla como mencione anteriormente son los servicios que se pueden ofrecer como: cantidad, monto, descuento y combinados.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 ServiceTypeId | int | 4 | ✓ | 1 | □ | |
| Name | varchar(30) | 30 | □ | | □ | |
| Description | varchar(300) | 300 | □ | | ✓ | |
| CreatedAt | datetime | 8 | □ | | □ | |
| UpdatedAt | datetime | 8 | □ | | □ | |

### 4.4 Grupo Transacciones y Pagos
Este grupo funcional resulta super necesario para propiamente realizar los pagos de las suscripciones y no solo eso sino para llevar un registro del uso de beneficios de los usuarios, transaction esta presente casi que en todo el diseno y es muy importante para cuando se va a utilizar un beneficio del plan. Esto ademas de que se conecta con todas las tablas de balances que nos permiten llevar un registro nuevamente de los beneficios utilizados. 

#### 4.4.1 SocaiPayments 
Esta tabla registra cada pago realizado en el sistema incluyendo aspectos como monto, fecha, método, estado y referencias. Usamos checksum para verificar la inetegridad de los datos y una autenticacion para asegurar el mayor nivel de seguridad. Tambien estan las conexiones con el usuario, datapayment, paymentmethod y resultpayment que se detallaran un poco mas adelante.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 PaymentId | int | 4 | ✓ | 1 | □ | |
| amount | decimal(15, 0) | 9 | □ | | ✓ | |
| actualAmount | decimal(15, 0) | 9 | □ | | ✓ | |
| authentication | varchar(200) | 200 | □ | | ✓ | |
| reference | varchar(200) | 200 | □ | | ✓ | |
| chargeToken | varbinary(250) | 250 | □ | | □ | |
| date | datetime | 8 | □ | | ✓ | |
| checksum | varbinary(250) | 250 | □ | | □ | |
| 🔗 DataPaymentId | int | 4 | □ | | □ | |
| 🔗 PaymentMethodId | int | 4 | □ | | □ | |
| 🔗 UserId | int | 4 | □ | | □ | |
| 🔗 ResultPaymentId | int | 4 | □ | | □ | |
| 🔗 CurrencyTypeId | int | 4 | □ | | □ | |

#### 4.4.2 SocaiDataPayments 
Almacena informacion segura de metodos de paga de usuarios, esto mediante datos tokenizados de tarjetas, cuentas y preferencias. Esto se hace mediante una mascara y tambien tomando en cuenta los metodos de pagos disponibles.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 DataPaymentId | int | 4 | ✓ | 1 | □ | |
| name | varchar(30) | 30 | □ | | ✓ | |
| token | varbinary(255) | 255 | □ | | ✓ | |
| expToken | datetime | 8 | □ | | ✓ | |
| maskAccount | varbinary(255) | 255 | □ | | ✓ | |
| 🔗 UserId | int | 4 | □ | | □ | |
| 🔗 PaymentMethodId | int | 4 | □ | | □ | |

#### 4.4.3 SocaiPaymentMethods
Esta tabla seria propiamente el cataologo de los metodos de pago disponibles. Esto propiamente incluiria los nombres, URLs de API, llaves de integración y los logos.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 PaymentMethodId | int | 4 | ✓ | 1 | □ | |
| name | varchar(30) | 30 | □ | | ✓ | |
| apiURL | varchar(250) | 250 | □ | | ✓ | |
| secretKey | varbinary(255) | 255 | □ | | ✓ | |
| [key] | varbinary(255) | 255 | □ | | ✓ | |
| logoIconURL | varchar(200) | 200 | □ | | ✓ | |
| enable | bit | 1 | □ | | □ | |

#### 4.4.4 SocaiResultPayment
Esta tabla tiene como objetivo determinar posibles resultados de intentos de pago, en caso de que hubiera un error habria un nombre especifico para dicho mal intento y si es correcto habra un resultado que diga correcto.

| Nombre de columna | Tipo de datos | Longitud | Identidad | Incremento de identidad | Permitir valores NULL | Valor predeterminado |
|-------------------|---------------|----------|-----------|-------------------------|----------------------|---------------------|
| 🔑 ResultPaymentId | int | 4 | ✓ | 1 | □ | |
| name | varchar(30) | 30 | □ | | ✓ | |
| description | varchar(300) | 300 | □ | | ✓ | |



### 4.5 Grupo Geolocalizacion

### 4.6 Grupo Sistema 

