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
5. Commerces
    1. CommercesFeatures
    2. Renewals
    3. ContractCommerces
    4. ContractObligations
    5. CommerceSettlement
    6. CommerceSettlementDetail
    7. CommerceBalance
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
