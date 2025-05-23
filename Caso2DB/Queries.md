# Caso 2 Base de Datos Soltura: Queries

# Test de la base de datos

En este documento propiamente se delimitaran todas las secciones requeridas del caso 2 en lo que se refiere a los queries. Primeramente habria una explicacion breve de la seccion y como se abordo para conseguir el resultado y posteriormente se adjuntara el script del query. Ademas en las secciones que requieran mostrar un llenado de tabla se mostrara tanto el script como el query, de igual forma las tareas que solo pueden ser aplicadas en SQL Server se mostrara entonces solo el script. Importante mencionar que los scripts se encunetran individualmente en la carpeta de "ScriptsQueries" en caso de que sea necesario visitarlos ahi.

## 1. Poblacion de Datos (Chris)
En la poblacion de datos lo que estaremos realizando son mayormente un llenado de la mayoria de tablas del sistema. En esto inlcuiremos catalogos de servicios, comercios, beneficios, usuarios, metodos de pago etc...

### 1.1 Monedas

Aqui simplemente definimos las monedas que van a estar registradas en nuestro sistema. 

``` sql

--- 1. Monedas ----

insert into SocaiCurrencyTypes (name, acronym, symbol) values ('Dolar Estadounidense', 'USD', '$');

insert into SocaiCurrencyTypes (name, acronym, symbol) values ('Euro', 'EUR', '€');

insert into SocaiCurrencyTypes (name, acronym, symbol) values ('Colon Costarricense', 'CRC', '₡');

select * from SocaiCurrencyTypes

```

| CurrencyTypeId | name | acronym | symbol |
|----------------|------|---------|--------|
| 0 | Dolar Estadounidense | USD | $ |
| 1 | Euro | EUR | € |
| 2 | Colon Costarricense | CRC | ₡ |

### 1.2 Localizaciones
Aqui lo que hacemos es hacer el llenado propiamente de lugares de Costa Rica, esto ademas de dirrecciones random tanto para comercios como para usuarios. 

``` sql
--- 2. Localizaciones ---

--- Insercion de Pais ----

insert into SocaiCountries (Name, CreatedAt, UpdatedAt) values ('Costa Rica', getdate(), getdate());

select * from SocaiCountries

--- Insercion de Provincias ----

insert into SocaiProvinces (Name, Createdate, Updatedate, CountryId)

values ('San Jose', getdate(), getdate(), 1), ('Alajuela', getdate(), getdate(), 1),
('Cartago', getdate(), getdate(), 1), ('Heredia', getdate(), getdate(), 1),
('Guanacaste', getdate(), getdate(), 1), ('Puntarenas', getdate(), getdate(), 1),
('Limon', getdate(), getdate(), 1);

select * from SocaiProvinces

--- Insercion de Ciudades ----

insert into SocaiCities (Name, ProvinciasId, CreatedAt, UpdatedAt)

values
-- San Jose --
('San Jose Centro', 0, getdate(), getdate()),
('Escazu', 0, getdate(), getdate()),
('Santa Ana', 0, getdate(), getdate()),
('Desamparados', 0, getdate(), getdate()),
('Curridabat', 0, getdate(), getdate()),
-- Alajuela --
('Alajuela Centro', 1, getdate(), getdate()),
('Atenas', 1, getdate(), getdate()),
('San Ramon', 1, getdate(), getdate()),
-- Cartago --
('Cartago Centro', 2, getdate(), getdate()),
('Tres Rios', 2, getdate(), getdate()),
('Turrialba', 2, getdate(), getdate()),
-- Heredia --
('Heredia Centro', 3, getdate(), getdate()),
('Belen', 3, getdate(), getdate()),
('Santo Domingo', 3, getdate(), getdate()),
-- Guanacaste --
('Liberia', 4, getdate(), getdate()),
('Tamarindo', 4, getdate(), getdate()),
-- Puntarenas --
('Puntarenas Centro', 5, getdate(), getdate()),
('Jaco', 5, getdate(), getdate()),
-- Limon --
('Limon Centro', 6, getdate(), getdate()),
('Puerto Viejo', 6, getdate(), getdate());

select * from SocaiCities;

--- Insercion de Addresses (30 dirrecciones para usuarios) ---

insert into SocaiAdresses (PostalCode, CityId, direccion, CreatedAt, UpdatedAt, point)

values

('10101', 1, 'Calle 1, Av. Central', getdate(), getdate(), null),
('10101', 1, 'Calle 5, Av. Segunda', getdate(), getdate(), null),
('10101', 1, 'Barrio Escalante, Calle 33', getdate(), getdate(), null),
('10101', 2, 'Trejos Montealegre', getdate(), getdate(), null),
('10101', 2, 'San Rafael', getdate(), getdate(), null),
('10101', 3, 'Pozos', getdate(), getdate(), null),
('10101', 3, 'Brasil de Santa Ana', getdate(), getdate(), null),
('10101', 4, 'San Antonio', getdate(), getdate(), null),
('10101', 5, 'Lomas de Ayarco', getdate(), getdate(), null),
('10101', 5, 'Granadilla', getdate(), getdate(), null),
('20101', 6, 'La Guacima', getdate(), getdate(), null),
('20101', 6, 'El Coyol', getdate(), getdate(), null),
('20101', 7, 'Centro', getdate(), getdate(), null),
('20101', 8, 'Centro', getdate(), getdate(), null),
('30101', 9, 'Los Angeles', getdate(), getdate(), null),
('30101', 9, 'El Guarco', getdate(), getdate(), null),
('30101', 10, 'Concepcion', getdate(), getdate(), null),
('30101', 11, 'Centro', getdate(), getdate(), null),
('40101', 12, 'Mercedes Norte', getdate(), getdate(), null),
('40101', 12, 'San Francisco', getdate(), getdate(), null),
('40101', 13, 'La Ribera', getdate(), getdate(), null),
('40101', 14, 'Centro', getdate(), getdate(), null),
('50101', 15, 'Centro', getdate(), getdate(), null),
('50101', 16, 'Centro', getdate(), getdate(), null),
('60101', 17, 'El Roble', getdate(), getdate(), null),
('60101', 18, 'Centro', getdate(), getdate(), null),
('70101', 19, 'Centro', getdate(), getdate(), null),
('70101', 20, 'Centro', getdate(), getdate(), null),
('10101', 1, 'Barrio Mexico', getdate(), getdate(), null),
('10101', 2, 'Guachipelin', getdate(), getdate(), null);

select * from SocaiAdresses;


--- Insercion de Addresses (10 dirrecciones para comercios) ---

insert into SocaiAdresses (PostalCode, CityId, direccion, CreatedAt, UpdatedAt, point)

values
('10101', 1, 'Avenida Segunda, Edificio Comercial Plaza', getdate(), getdate(), null),
('10101', 2, 'Plaza Escazu, Local #15', getdate(), getdate(), null),
('10101', 3, 'Centro Comercial Momentum Santa Ana, Local A-5', getdate(), getdate(), null),
('20101', 6, 'Centro Comercial City Mall, Local 112-B', getdate(), getdate(), null),
('30101', 9, 'Centro Comercial Paseo Metropoli, Local 45', getdate(), getdate(), null),
('40101', 12, 'Paseo de las Flores, Local 201', getdate(), getdate(), null),
('50101', 16, 'Tamarindo Beach Plaza, Local #8', getdate(), getdate(), null),
('60101', 18, 'Centro Comercial Jaco Walk, Local 12', getdate(), getdate(), null),
('70101', 19, 'Boulevard Limon, Edificio Mar Caribe #3', getdate(), getdate(), null),
('40101', 13, 'Plaza Cariari, Local #25', getdate(), getdate(), null);

select * from SocaiAdresses;
```
#### Countries
| CountryId | Name | CreatedAt | UpdatedAt |
|-----------|------|-----------|-----------|
| 1 | Costa Rica | 2025-05-03 20:43:39.810 | 2025-05-03 20:43:39.810 |

#### Provincias
| ProvinciasId | Name | Createdate | Updatedate | CountryId |
|--------------|------|------------|------------|-----------|
| 0 | San Jose | 2025-05-03 20:44:56.300 | 2025-05-03 20:44:56.300 | 1 |
| 1 | Alajuela | 2025-05-03 20:44:56.300 | 2025-05-03 20:44:56.300 | 1 |
| 2 | Cartago | 2025-05-03 20:44:56.300 | 2025-05-03 20:44:56.300 | 1 |
| 3 | Heredia | 2025-05-03 20:44:56.300 | 2025-05-03 20:44:56.300 | 1 |
| 4 | Guanacaste | 2025-05-03 20:44:56.300 | 2025-05-03 20:44:56.300 | 1 |
| 5 | Puntarenas | 2025-05-03 20:44:56.300 | 2025-05-03 20:44:56.300 | 1 |
| 6 | Limon | 2025-05-03 20:44:56.300 | 2025-05-03 20:44:56.300 | 1 |

#### Ciudades
| CityID | Name | ProvinciasId | CreatedAt | UpdatedAt |
|--------|------|--------------|-----------|-----------|
| 1 | San Jose Centro | 0 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 2 | Escazu | 0 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 3 | Santa Ana | 0 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 4 | Desamparados | 0 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 5 | Curridabat | 0 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 6 | Alajuela Centro | 1 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 7 | Atenas | 1 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 8 | San Ramon | 1 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 9 | Cartago Centro | 2 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 10 | Tres Rios | 2 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 11 | Turrialba | 2 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 12 | Heredia Centro | 3 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 13 | Belen | 3 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 14 | Santo Domingo | 3 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 15 | Liberia | 4 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 16 | Tamarindo | 4 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 17 | Puntarenas Centro | 5 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 18 | Jaco | 5 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 19 | Limon Centro | 6 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |
| 20 | Puerto Viejo | 6 | 2025-05-03 21:52:34.247 | 2025-05-03 21:52:34.247 |

#### Adresses
| AddressId | PostalCode | CityId | direccion | CreatedAt | UpdatedAt | point |
|-----------|------------|--------|-----------|-----------|-----------|-------|
| 1 | 10101 | 1 | Calle 1, Av. Central | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 2 | 10101 | 1 | Calle 5, Av. Segunda | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 3 | 10101 | 1 | Barrio Escalante, Calle 33 | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 4 | 10101 | 2 | Trejos Montealegre | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 5 | 10101 | 2 | San Rafael | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 6 | 10101 | 3 | Pozos | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 7 | 10101 | 3 | Brasil de Santa Ana | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 8 | 10101 | 4 | San Antonio | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 9 | 10101 | 5 | Lomas de Ayarco | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 10 | 10101 | 5 | Granadilla | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 11 | 20101 | 6 | La Guacima | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 12 | 20101 | 6 | El Coyol | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 13 | 20101 | 7 | Centro | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 14 | 20101 | 8 | Centro | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 15 | 30101 | 9 | Los Angeles | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 16 | 30101 | 9 | El Guarco | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 17 | 30101 | 10 | Concepcion | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 18 | 30101 | 11 | Centro | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 19 | 40101 | 12 | Mercedes Norte | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 20 | 40101 | 12 | San Francisco | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 21 | 40101 | 13 | La Ribera | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 22 | 40101 | 14 | Centro | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 23 | 50101 | 15 | Centro | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 24 | 50101 | 16 | Centro | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 25 | 60101 | 17 | El Roble | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 26 | 60101 | 18 | Centro | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 27 | 70101 | 19 | Centro | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 28 | 70101 | 20 | Centro | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 29 | 10101 | 1 | Barrio Mexico | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 30 | 10101 | 2 | Guachipelin | 2025-05-03 21:55:31.610 | 2025-05-03 21:55:31.610 | NULL |
| 31 | 10101 | 1 | Avenida Segunda, Edificio Comercial Plaza | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |
| 32 | 10101 | 2 | Plaza Escazu, Local #15 | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |
| 33 | 10101 | 3 | Centro Comercial Momentum Santa Ana, Local A-5 | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |
| 34 | 20101 | 6 | Centro Comercial City Mall, Local 112-B | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |
| 35 | 30101 | 9 | Centro Comercial Paseo Metropoli, Local 45 | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |
| 36 | 40101 | 12 | Paseo de las Flores, Local 201 | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |
| 37 | 50101 | 16 | Tamarindo Beach Plaza, Local #8 | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |
| 38 | 60101 | 18 | Centro Comercial Jaco Walk, Local 12 | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |
| 39 | 70101 | 19 | Boulevard Limon, Edificio Mar Caribe #3 | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |
| 40 | 40101 | 13 | Plaza Cariari, Local #25 | 2025-05-04 16:06:34.697 | 2025-05-04 16:06:34.697 | NULL |

### 1.3 Comercios y Beneficios

#### Files
En este caso primeramente definimos los tipos de files para posteriormente establecer los contratos con los comercios.

``` sql
insert into SocaiFileTypes (name, mimeType, icon, enabled)

values 
('Documento PDF', 'pdf', 'https://soltura.com/icons/pdf.png', 1),
('Documento Word', 'docx', 'https://soltura.com/icons/docx.png', 1),
('Documento Excel', 'xlsx', 'https://soltura.com/icons/xlsx.png', 1),
('Imagen JPG', 'jpg', 'https://soltura.com/icons/jpg.png', 1),
('Imagen PNG', 'png', 'https://soltura.com/icons/png.png', 1);

select * from SocaiFileTypes;

```
| FileTypeId | name | mimeType | icon | enabled |
|------------|------|----------|------|---------|
| 0 | Documento PDF | pdf | https://soltura.com/icons/pdf.png | 1 |
| 1 | Documento Word | docx | https://soltura.com/icons/docx.png | 1 |
| 2 | Documento Excel | xlsx | https://soltura.com/icons/xlsx.png | 1 |
| 3 | Imagen JPG | jpg | https://soltura.com/icons/jpg.png | 1 |
| 4 | Imagen PNG | png | https://soltura.com/icons/png.png | 1 |

#### Comercios
Definimos un total de 10 comercios iniciales, esto junto con su direccion y una descripcion. 

``` sql
insert into SocaiCommerces (Name, Description, AddressId, PhoneNumber, Email, FileId, IsActive, CreatedAt, UpdatedAt)

values
('Crunch Fitness', 'Cadena de gimnasios con locaciones en todo el pais', 31, '2222-1111', 'contacto@curnch.cr', NULL, 1, getdate(), getdate()),
('The Spa', 'Servicios de spa y bienestar en San Jose y Heredia', 32, '2222-2222', 'info@thespa.cr', NULL, 1, getdate(), getdate()),
('YogaLife', 'Centro especializado en yoga y pilates con instructores certificados', 33, '2222-3333', 'yoga@yogalife.co.cr', NULL, 1, getdate(), getdate()),
('PetCare', 'Servicios veterinarios y de grooming para mascotas', 34, '2222-4444', 'info@petcare.cr', NULL, 1, getdate(), getdate()),
('HogarCleaner', 'Servicios de limpieza y lavanderia a domicilio', 35, '2222-5555', 'contacto@hogarcleaner.cr', NULL, 1, getdate(), getdate()),
('Gasolinera YAM', 'Red de estaciones de servicio en todo el pais', 36, '2222-6666', 'info@yam.cr', NULL, 1, getdate(), getdate()),
('Salud Integral Beneficiada', 'Servicios medicos y terapeuticos', 37, '2222-7777', 'citas@saludintegral.cr', NULL, 1, getdate(), getdate()),
('Barberia Paco', 'Cadena de barberias y salones de belleza', 38, '2222-8888', 'citas@pacothebarber.cr', NULL, 1, getdate(), getdate()),
('Fit Center Oxigeno', 'Gimnasio con entrenamiento personalizado', 39, '2222-9999', 'info@fitcenter.cr', NULL, 1, getdate(), getdate()),
('UberEats', 'Servicio de entrega de comida a domicilio', 40, '2222-0000', 'partners@ubereats.cr', NULL, 1, getdate(), getdate());


select * from SocaiCommerces;

```

| CommerceId | Name | Description | AddressId | PhoneNumber | Email | FileId | IsActive | CreatedAt | UpdatedAt |
|------------|------|-------------|-----------|-------------|-------|--------|----------|-----------|-----------|
| 1 | Crunch Fitness | Cadena de gimnasios con locaciones en todo el pais | 31 | 2222-1111 | contacto@crunch.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |
| 2 | The Spa | Servicios de spa y bienestar en San Jose y Heredia | 32 | 2222-2222 | info@thespa.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |
| 3 | YogaLife | Centro especializado en yoga y pilates con instructores certificados | 33 | 2222-3333 | yoga@yogalife.co.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |
| 4 | PetCare | Servicios veterinarios y de grooming para mascotas | 34 | 2222-4444 | info@petcare.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |
| 5 | HogarCleaner | Servicios de limpieza y lavanderia a domicilio | 35 | 2222-5555 | contacto@hogarcleaner.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |
| 6 | Gasolinera YAM | Red de estaciones de servicio en todo el pais | 36 | 2222-6666 | info@yam.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |
| 7 | Salud Integral Beneficiada | Servicios medicos y terapeuticos | 37 | 2222-7777 | citas@saludintegral.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |
| 8 | Barberia Paco | Cadena de barberias y salones de belleza | 38 | 2222-8888 | citas@pacothebarber.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |
| 9 | Fit Center Oxigeno | Gimnasio con entrenamiento personalizado | 39 | 2222-9999 | info@fitcenter.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |
| 10 | UberEats | Servicio de entrega de comida a domicilio | 40 | 2222-0000 | partners@ubereats.cr | NULL | 1 | 2025-05-04 16:25:36.127 | 2025-05-04 16:25:36.127 |

#### Personas de Contacto Comercio
Persona a la cual acudir cuando hay problemas con el comercio.

``` sql
insert into SocaiCommerceContactPerson (Name, Position, Department, PhoneNumber, Email, CommerceId)

values
('Carlos Rodriguez', 'Gerente General', 'Direccion General', '8811-1111', 'carlos.rodriguez@smartfit.cr', 1),
('Ana Vargas', 'Directora Comercial', 'Comercial', '8822-2222', 'ana.vargas@multispa.cr', 2),
('Patricia Jimenez', 'Coordinadora de Clases', 'Operaciones', '8833-3333', 'patricia.jimenez@yogalife.co.cr', 3),
('Roberto Mendez', 'Veterinario Jefe', 'Clinica Veterinaria', '8844-4444', 'roberto.mendez@petcare.cr', 4),
('Lucia Campos', 'Gerente de Operaciones', 'Operaciones', '8855-5555', 'lucia.campos@hogarclean.cr', 5),
('Miguel Soto', 'Director Regional', 'Ventas', '8866-6666', 'miguel.soto@recocr.cr', 6),
('Carmen Blanco', 'Directora Medica', 'Medicina General', '8877-7777', 'carmen.blanco@saludtotal.cr', 7),
('Jose Castro', 'Propietario', 'Administracion', '8888-8888', 'jose.castro@pacobarbers.cr', 8),
('Gabriela Mora', 'Entrenadora Jefe', 'Entrenamiento', '8899-9999', 'gabriela.mora@fitcenter.cr', 9),
('Daniel Herrera', 'Coordinador de Restaurantes', 'Alianzas', '8800-0000', 'daniel.herrera@ubereats.cr', 10);

select * from SocaiCommerceContactPerson;

```

| ContactPersonId | Name | Position | Department | PhoneNumber | Email | CommerceId |
|-----------------|------|----------|------------|-------------|-------|------------|
| 1 | Carlos Rodriguez | Gerente General | Direccion General | 8811-1111 | carlos.rodriguez@smartfit.cr | 1 |
| 2 | Ana Vargas | Directora Comercial | Comercial | 8822-2222 | ana.vargas@multispa.cr | 2 |
| 3 | Patricia Jimenez | Coordinadora de Clases | Operaciones | 8833-3333 | patricia.jimenez@yogalife.co.cr | 3 |
| 4 | Roberto Mendez | Veterinario Jefe | Clinica Veterinaria | 8844-4444 | roberto.mendez@petcare.cr | 4 |
| 5 | Lucia Campos | Gerente de Operaciones | Operaciones | 8855-5555 | lucia.campos@hogarclean.cr | 5 |
| 6 | Miguel Soto | Director Regional | Ventas | 8866-6666 | miguel.soto@recocr.cr | 6 |
| 7 | Carmen Blanco | Directora Medica | Medicina General | 8877-7777 | carmen.blanco@saludtotal.cr | 7 |
| 8 | Jose Castro | Propietario | Administracion | 8888-8888 | jose.castro@pacobarbers.cr | 8 |
| 9 | Gabriela Mora | Entrenadora Jefe | Entrenamiento | 8899-9999 | gabriela.mora@fitcenter.cr | 9 |
| 10 | Daniel Herrera | Coordinador de Restaurantes | Alianzas | 8800-0000 | daniel.herrera@ubereats.cr | 10 |

Ademas de ello aqui encontrariamos los files de contratos con los comercios y las propias condiciones de los contratos de los comercios.

#### Files de los comercios
```sql
insert into SocaiFiles (fileName, description, fileURL, deleted, lastUpdated, creation, fileSize, mimeType, UserId, FileTypeId)

values
('contrato_crunch.pdf', 'Contrato de servicios con Crunch Fitness', 'https://soltura.com/files/contratos/contrato_crunch.pdf', 0, getdate(), getdate(), 1550000, 'pdf', NULL, 1),
('tarifas_crunch.pdf', 'Tarifas y beneficios de Crunch Fitness', 'https://soltura.com/files/tarifas/tarifas_crunch.pdf', 0, getdate(), getdate(), 980000, 'pdf', NULL, 1),

('contrato_thespa.pdf', 'Contrato de servicios con The Spa', 'https://soltura.com/files/contratos/contrato_thespa.pdf', 0, getdate(), getdate(), 1620000, 'pdf', NULL, 1),
('catalogo_thespa.pdf', 'Catalogo de servicios de The Spa', 'https://soltura.com/files/catalogos/catalogo_thespa.pdf', 0, getdate(), getdate(), 2340000, 'pdf', NULL, 1),

('contrato_yogalife.pdf', 'Contrato de servicios con YogaLife', 'https://soltura.com/files/contratos/contrato_yogalife.pdf', 0, getdate(), getdate(), 1480000, 'pdf', NULL, 1),
('horarios_yogalife.pdf', 'Horarios de clases de YogaLife', 'https://soltura.com/files/horarios/horarios_yogalife.pdf', 0, getdate(), getdate(), 750000, 'pdf', NULL, 1),

('contrato_petcare.pdf', 'Contrato de servicios con PetCare', 'https://soltura.com/files/contratos/contrato_petcare.pdf', 0, getdate(), getdate(), 1520000, 'pdf', NULL, 1),
('servicios_petcare.pdf', 'Servicios veterinarios de PetCare', 'https://soltura.com/files/servicios/servicios_petcare.pdf', 0, getdate(), getdate(), 1890000, 'pdf', NULL, 1),

('contrato_hogarcleaner.pdf', 'Contrato de servicios con HogarCleaner', 'https://soltura.com/files/contratos/contrato_hogarcleaner.pdf', 0, getdate(), getdate(), 1370000, 'pdf', NULL, 1),
('coberturas_hogarcleaner.pdf', 'Areas de cobertura de HogarCleaner', 'https://soltura.com/files/coberturas/coberturas_hogarcleaner.pdf', 0, getdate(), getdate(), 890000, 'pdf', NULL, 1),

('contrato_gasolinerayam.pdf', 'Contrato de servicios con Gasolinera YAM', 'https://soltura.com/files/contratos/contrato_gasolinerayam.pdf', 0, getdate(), getdate(), 1450000, 'pdf', NULL, 1),
('beneficios_gasolinerayam.pdf', 'Beneficios de Gasolinera YAM', 'https://soltura.com/files/beneficios/beneficios_gasolinerayam.pdf', 0, getdate(), getdate(), 820000, 'pdf', NULL, 1),

('contrato_saludintegral.pdf', 'Contrato de servicios con Salud Integral Beneficiada', 'https://soltura.com/files/contratos/contrato_saludintegral.pdf', 0, getdate(), getdate(), 1580000, 'pdf', NULL, 1),
('especialidades_saludintegral.pdf', 'Especialidades medicas de Salud Integral Beneficiada', 'https://soltura.com/files/especialidades/especialidades_saludintegral.pdf', 0, getdate(), getdate(), 1920000, 'pdf', NULL, 1),

('contrato_barberiapaco.pdf', 'Contrato de servicios con Barberia Paco', 'https://soltura.com/files/contratos/contrato_barberiapaco.pdf', 0, getdate(), getdate(), 1290000, 'pdf', NULL, 1),
('servicios_barberiapaco.pdf', 'Servicios y precios de Barberia Paco', 'https://soltura.com/files/servicios/servicios_barberiapaco.pdf', 0, getdate(), getdate(), 760000, 'pdf', NULL, 1),

('contrato_fitcenteroxigeno.pdf', 'Contrato de servicios con Fit Center Oxigeno', 'https://soltura.com/files/contratos/contrato_fitcenteroxigeno.pdf', 0, getdate(), getdate(), 1520000, 'pdf', NULL, 1),
('planes_fitcenteroxigeno.pdf', 'Planes de entrenamiento de Fit Center Oxigeno', 'https://soltura.com/files/planes/planes_fitcenteroxigeno.pdf', 0, getdate(), getdate(), 1880000, 'pdf', NULL, 1),

('contrato_ubereats.pdf', 'Contrato de servicios con UberEats', 'https://soltura.com/files/contratos/contrato_ubereats.pdf', 0, getdate(), getdate(), 1640000, 'pdf', NULL, 1),
('restaurantes_ubereats.pdf', 'Listado de restaurantes afiliados a UberEats', 'https://soltura.com/files/restaurantes/restaurantes_ubereats.pdf', 0, getdate(), getdate(), 2850000, 'pdf', NULL, 1);


select * from SocaiFiles;

```
| FileId | fileName | description | fileURL | deleted | lastUpdated | creation | fileSize | mimeType | UserId | FileTypeId |
|--------|----------|-------------|---------|---------|-------------|----------|----------|----------|--------|------------|
| 2 | contrato_crunch.pdf | Contrato de servicios con Crunch Fitness | https://soltura.com/files/contratos/contrato_cru... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1550000 | pdf | NULL | 1 |
| 3 | tarifas_crunch.pdf | Tarifas y beneficios de Crunch Fitness | https://soltura.com/files/tarifas/tarifas_crunch.pdf | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 980000 | pdf | NULL | 1 |
| 4 | contrato_thespa.pdf | Contrato de servicios con The Spa | https://soltura.com/files/contratos/contrato_the... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1620000 | pdf | NULL | 1 |
| 5 | catalogo_thespa.pdf | Catálogo de servicios de The Spa | https://soltura.com/files/catalogos/catalogo_the... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 2340000 | pdf | NULL | 1 |
| 6 | contrato_yogalife.pdf | Contrato de servicios con YogaLife | https://soltura.com/files/contratos/contrato_yog... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1480000 | pdf | NULL | 1 |
| 7 | horarios_yogalife.pdf | Horarios de clases de YogaLife | https://soltura.com/files/horarios/horarios_yogal... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 750000 | pdf | NULL | 1 |
| 8 | contrato_petcare.pdf | Contrato de servicios con PetCare | https://soltura.com/files/contratos/contrato_pet... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1520000 | pdf | NULL | 1 |
| 9 | servicios_petcare.pdf | Servicios veterinarios de PetCare | https://soltura.com/files/servicios/servicios_pet... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1890000 | pdf | NULL | 1 |
| 10 | contrato_hogarcleaner.pdf | Contrato de servicios con HogarCleaner | https://soltura.com/files/contratos/contrato_hog... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1370000 | pdf | NULL | 1 |
| 11 | coberturas_hogarcleaner.pdf | Áreas de cobertura de HogarCleaner | https://soltura.com/files/coberturas/coberturas_... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 890000 | pdf | NULL | 1 |
| 12 | contrato_gasolinerayam.pdf | Contrato de servicios con Gasolinera YAM | https://soltura.com/files/contratos/contrato_gas... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1450000 | pdf | NULL | 1 |
| 13 | beneficios_gasolinerayam.pdf | Beneficios de Gasolinera YAM | https://soltura.com/files/beneficios/beneficios_g... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 820000 | pdf | NULL | 1 |
| 14 | contrato_saludintegral.pdf | Contrato de servicios con Salud Integral | https://soltura.com/files/contratos/contrato_salu... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1580000 | pdf | NULL | 1 |
| 15 | especialidades_saludintegral.pdf | Especialidades medicas de Salud Integral | https://soltura.com/files/especialidades/especialidades_... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1920000 | pdf | NULL | 1 |
| 16 | contrato_barberiapaco.pdf | Contrato de servicios con Barberia Paco | https://soltura.com/files/contratos/contrato_bar... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1290000 | pdf | NULL | 1 |
| 17 | servicios_barberiapaco.pdf | Servicios y precios de Barberia Paco | https://soltura.com/files/servicios/servicios_bar... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 760000 | pdf | NULL | 1 |
| 18 | contrato_fitcenteroxigeno.pdf | Contrato de servicios con Fit Center Oxigeno | https://soltura.com/files/contratos/contrato_fitc... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1520000 | pdf | NULL | 1 |
| 19 | planes_fitcenteroxigeno.pdf | Planes de entrenamiento de Fit Center | https://soltura.com/files/planes/planes_fitcenter... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1880000 | pdf | NULL | 1 |
| 20 | contrato_ubereats.pdf | Contrato de servicios con UberEats | https://soltura.com/files/contratos/contrato_ube... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 1640000 | pdf | NULL | 1 |
| 21 | restaurantes_ubereats.pdf | Listado de restaurantes afiliados a UberEats | https://soltura.com/files/restaurantes/restaurant... | 0 | 2025-05-04 16:37:04.627 | 2025-05-04 16:37:04.627 | 2850000 | pdf | NULL | 1 |

#### Contratos con los comercios

``` sql
--- Insercion de Contratos con Comercios ----

insert into SocaiContractCommerces (validFrom, validTo, contractType, contractDescription, isActive, CommerceId, inChargeSignature, FileId, CountryId)

values
('2024-01-01', '2026-01-01', 'Servicio Premium', 'Contrato de servicios gimnasio con descuento especial', 1, 1, 'Carlos Hernandez, Gerente General', 2, 1),
('2024-01-15', '2026-01-15', 'Servicio Premium', 'Contrato de servicios spa con descuento especial', 1, 2, 'Ana Maria Soto, Directora Comercial', 5, 1),
('2024-02-01', '2026-02-01', 'Servicio Estandar', 'Contrato de servicios yoga con descuento estandar', 1, 3, 'Elena Rojas, CEO', 7, 1),
('2024-02-15', '2026-02-15', 'Servicio Premium', 'Contrato de servicios para mascotas con descuento especial', 1, 4, 'Martin Jimenez, Gerente Operaciones', 9, 1),
('2024-03-01', '2026-03-01', 'Servicio Estandar', 'Contrato de servicios limpieza con descuento estandar', 1, 5, 'Sofia Mendez, Directora General', 11, 1),
('2024-03-15', '2026-03-15', 'Servicio Premium', 'Contrato de servicios combustible con descuento especial', 1, 6, 'Roberto Calderon, Gerente Comercial', 13, 1),
('2024-04-01', '2026-04-01', 'Servicio Premium', 'Contrato de servicios salud con descuento especial', 1, 7, 'Daniela Vargas, Directora Medica', 15, 1),
('2024-04-15', '2026-04-15', 'Servicio Estandar', 'Contrato de servicios belleza con descuento estandar', 1, 8, 'David Castro, Gerente Franquicias', 18, 1),
('2024-05-01', '2026-05-01', 'Servicio Premium', 'Contrato de servicios gimnasio con entrenamiento personalizado', 1, 9, 'Patricia Gonzalez, Directora General', 19, 1),
('2024-05-15', '2026-05-15', 'Servicio Estandar', 'Contrato de servicios entrega comida a domicilio', 1, 10, 'Jorge Ramirez, Gerente Regional', 20, 1);

select * from SocaiContractCommerces;

```

| ContractCommercesId | validFrom | validTo | contractType | contractDescription | isActive | CommerceId | inChargeSignature | FileId | CountryId |
|---------------------|-----------|---------|--------------|---------------------|----------|------------|-------------------|--------|-----------|
| 1 | 2024-01-01 00:00:00.000 | 2026-01-01 00:00:00.000 | Servicio Premium | Contrato de servicios gimnasio con descuento especial | 1 | 1 | Carlos Hernandez, Gerente General | 2 | 1 |
| 2 | 2024-01-15 00:00:00.000 | 2026-01-15 00:00:00.000 | Servicio Premium | Contrato de servicios spa con descuento especial | 1 | 2 | Ana Maria Soto, Directora Comercial | 5 | 1 |
| 3 | 2024-02-01 00:00:00.000 | 2026-02-01 00:00:00.000 | Servicio Estandar | Contrato de servicios yoga con descuento estandar | 1 | 3 | Elena Rojas, CEO | 7 | 1 |
| 4 | 2024-02-15 00:00:00.000 | 2026-02-15 00:00:00.000 | Servicio Premium | Contrato de servicios para mascotas con descuento especial | 1 | 4 | Martin Jimenez, Gerente Operaciones | 9 | 1 |
| 5 | 2024-03-01 00:00:00.000 | 2026-03-01 00:00:00.000 | Servicio Estandar | Contrato de servicios limpieza con descuento estandar | 1 | 5 | Sofia Mendez, Directora General | 11 | 1 |
| 6 | 2024-03-15 00:00:00.000 | 2026-03-15 00:00:00.000 | Servicio Premium | Contrato de servicios combustible con descuento especial | 1 | 6 | Roberto Calderon, Gerente Comercial | 13 | 1 |
| 7 | 2024-04-01 00:00:00.000 | 2026-04-01 00:00:00.000 | Servicio Premium | Contrato de servicios salud con descuento especial | 1 | 7 | Daniela Vargas, Directora Medica | 15 | 1 |
| 8 | 2024-04-15 00:00:00.000 | 2026-04-15 00:00:00.000 | Servicio Estandar | Contrato de servicios belleza con descuento estandar | 1 | 8 | David Castro, Gerente Franquicias | 18 | 1 |
| 9 | 2024-05-01 00:00:00.000 | 2026-05-01 00:00:00.000 | Servicio Premium | Contrato de servicios gimnasio con entrenamiento personalizado | 1 | 9 | Patricia Gonzalez, Directora General | 19 | 1 |
| 10 | 2024-05-15 00:00:00.000 | 2026-05-15 00:00:00.000 | Servicio Estandar | Contrato de servicios entrega comida a domicilio | 1 | 10 | Jorge Ramirez, Gerente Regional | 20 | 1 |

#### Tipos de Servicio 
Definimos algunos de los servicios mas habituales.

```sql

INSERT INTO SocaiServiceTypes (Name, Description, CreatedAt, UpdatedAt)

VALUES 
('Gimnasio', 'Servicios de acceso a gimnasios y entrenamiento fisico', GETDATE(), GETDATE()),
('Spa', 'Servicios de masajes y tratamientos de belleza', GETDATE(), GETDATE()),
('Combustible', 'Carga de combustible en estaciones afiliadas', GETDATE(), GETDATE()),
('Comida', 'Servicios de alimentación y restaurantes', GETDATE(), GETDATE()),
('Mascotas', 'Servicios veterinarios y de cuidado para mascotas', GETDATE(), GETDATE()),
('Transporte', 'Servicios de transporte y movilidad', GETDATE(), GETDATE()),
('Salud', 'Servicios médicos y de bienestar', GETDATE(), GETDATE()),
('Belleza', 'Servicios de barbería, peluquería y estetica', GETDATE(), GETDATE()),
('Limpieza', 'Servicios de limpieza y mantenimiento del hogar', GETDATE(), GETDATE()),
('Parqueo', 'Servicios de parqueo en centros comerciales y zonas urbanas', GETDATE(), GETDATE());

SELECT * FROM SocaiServiceTypes;
```
| ServiceTypeId | Name | Description | CreatedAt | UpdatedAt |
|---------------|------|-------------|-----------|-----------|
| 1 | Gimnasio | Servicios de acceso a gimnasios y entrenamiento... | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |
| 2 | Spa | Servicios de masajes y tratamientos de belleza | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |
| 3 | Combustible | Carga de combustible en estaciones afiliadas | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |
| 4 | Comida | Servicios de alimentación y restaurantes | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |
| 5 | Mascotas | Servicios veterinarios y de cuidado para mascotas | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |
| 6 | Transporte | Servicios de transporte y movilidad | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |
| 7 | Salud | Servicios médicos y de bienestar | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |
| 8 | Belleza | Servicios de barbería, peluquería y estética | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |
| 9 | Limpieza | Servicios de limpieza y mantenimiento del hogar | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |
| 10 | Parqueo | Servicios de parqueo en centros comerciales y zo... | 2025-05-04 17:03:52.113 | 2025-05-04 17:03:52.113 |

#### Insercion de los TaxRates

``` sql

INSERT INTO SocaiTaxRates (Name, Rate, CountryId, IsActive, ValidFrom, ValidTo)
VALUES ('IVA General', 13.00, 1, 1, '2024-01-01', NULL);

SELECT * FROM SocaiTaxRates;

```

| TaxRateId | Name | Rate | CountryId | IsActive | ValidFrom | ValidTo |
|-----------|------|------|-----------|----------|-----------|---------|
| 1 | IVA General | 13.00 | 1 | 1 | 2024-01-01 00:00:00.000 | NULL |

#### Insercion de los UnitTypes
Esta es la unidad de medida de los servicios.

``` sql
insert into SocaiUnitTypes (Name, Symbol, Description, IsActive)

values
('Horas', 'h', 'Tiempo medido en horas para servicios como gimnasio, yoga, etc.', 1),
('Minutos', 'min', 'Tiempo medido en minutos para servicios de corta duración', 1),
('Días', 'd', 'Tiempo medido en días para servicios como limpieza, alquiler, etc.', 1),
('Servicios', 'serv', 'Cantidad de servicios individuales (cortes de pelo, masajes, etc.)', 1),
('Visitas', 'vis', 'Número de visitas a establecimientos afiliados', 1),
('Colones', '₡', 'Monto en colones costarricenses para créditos monetarios', 1),
('Dólares', '$', 'Monto en dólares estadounidenses para créditos monetarios', 1),
('Kilómetros', 'km', 'Distancia en kilómetros para servicios de transporte', 1),
('Porcentaje', '%', 'Valor porcentual para descuentos y promociones', 1),
('Litros', 'L', 'Volumen en litros para combustible y otros líquidos', 1);

select * from SocaiUnitTypes;

```
| UnitTypeId | Name | Symbol | Description | IsActive |
|------------|------|--------|-------------|----------|
| 1 | Horas | h | Tiempo medido en horas para servicios como gimnasio, yoga, etc. | 1 |
| 2 | Minutos | min | Tiempo medido en minutos para servicios de corta duración | 1 |
| 3 | Días | d | Tiempo medido en días para servicios como limpieza, alquiler, etc. | 1 |
| 4 | Servicios | serv | Cantidad de servicios individuales (cortes de pelo, masajes, etc.) | 1 |
| 5 | Visitas | vis | Número de visitas a establecimientos afiliados | 1 |
| 6 | Colones | ₡ | Monto en colones costarricenses para créditos monetarios | 1 |
| 7 | Dólares | $ | Monto en dólares estadounidenses para créditos monetarios | 1 |
| 8 | Kilómetros | km | Distancia en kilómetros para servicios de transporte | 1 |
| 9 | Porcentaje | % | Valor porcentual para descuentos y promociones | 1 |
| 10 | Litros | L | Volumen en litros para combustible y otros líquidos | 1 |

#### Servicios o Beneficios
Aqui definimos el listado de los beneficios que hay en total.

```sql
insert into SocaiPlanFeatures (name, description, category, unittypeid, isactive, updatedtime, createdtime)

values
-- Unidades de Horas 
('acceso a gimnasio', 'acceso a instalaciones de gimnasio y equipo', 'fitness', 1, 1, getdate(), getdate()),
('clases de yoga', 'participacion en clases de yoga', 'fitness', 1, 1, getdate(), getdate()),
('parqueo', 'tiempo de parqueo en centros comerciales', 'transporte', 1, 1, getdate(), getdate()),

-- Unidades de Minutos 
('entrenamiento express', 'sesiones rapidas de entrenamiento guiado', 'fitness', 2, 1, getdate(), getdate()),
('masaje de espalda rapido', 'masaje de espalda de corta duracion', 'bienestar', 2, 1, getdate(), getdate()),

-- Unidades de Días 
('limpieza del hogar', 'servicio de limpieza basica del hogar', 'hogar', 3, 1, getdate(), getdate()),
('estancia de mascota', 'dias de estancia para mascota en hotel', 'mascotas', 3, 1, getdate(), getdate()),

-- Unidades de Servicios 
('sesiones de masaje', 'sesiones de masaje terapeutico', 'bienestar', 4, 1, getdate(), getdate()),
('grooming para mascotas', 'servicio de peluqueria para mascotas', 'mascotas', 4, 1, getdate(), getdate()),
('revision veterinaria', 'consulta veterinaria basica', 'mascotas', 4, 1, getdate(), getdate()),
('corte de cabello', 'servicio de corte de cabello en barberias afiliadas', 'belleza', 4, 1, getdate(), getdate()),
('almuerzos', 'comidas en restaurantes seleccionados', 'alimentacion', 4, 1, getdate(), getdate()),
('cenas', 'cenas en restaurantes seleccionados', 'alimentacion', 4, 1, getdate(), getdate()),
('lavanderia', 'servicio de lavado y planchado de ropa', 'hogar', 4, 1, getdate(), getdate()),
('consulta medica', 'consulta medica general', 'salud', 4, 1, getdate(), getdate()),

-- Unidades de Visitas 
('visitas a gimnasio', 'cantidad de visitas al gimnasio', 'fitness', 5, 1, getdate(), getdate()),
('visitas a spa', 'cantidad de visitas al spa', 'bienestar', 5, 1, getdate(), getdate()),

-- Unidades de Colones 
('combustible', 'credito para combustible en estaciones afiliadas', 'transporte', 6, 1, getdate(), getdate()),
('credito restaurantes', 'monto disponible para consumo en restaurantes', 'alimentacion', 6, 1, getdate(), getdate()),

-- Unidades de DOlares 
('crédito servicios médicos', 'monto en dolares para servicios medicos', 'salud', 7, 1, getdate(), getdate()),
('credito servicios spa', 'monto en dolares para servicios de spa premium', 'bienestar', 7, 1, getdate(), getdate()),

-- Unidades de KilOmetros 
('entrega a domicilio extendida', 'kilometros adicionales para entregas', 'alimentacion', 8, 1, getdate(), getdate()),
('servicio de limpieza extendido', 'cobertura extendida para servicio de limpieza', 'hogar', 8, 1, getdate(), getdate()),

-- Unidades de Porcentaje 
('descuento en servicios de belleza', 'porcentaje de descuento en barberia', 'belleza', 9, 1, getdate(), getdate()),
('descuento en servicios medicos', 'porcentaje de descuento en consultas medicas', 'salud', 9, 1, getdate(), getdate()),

-- Unidades de Litros 
('combustible premium', 'litros de combustible premium en estaciones seleccionadas', 'transporte', 10, 1, getdate(), getdate()),
('agua para limpieza', 'litros de agua purificada para servicios de limpieza', 'hogar', 10, 1, getdate(), getdate());

select * from SocaiPlanFeatures;

```
| FeatureId | Name | Description | Category | UnitTypeId | IsActive | UpdatedTime | CreatedTime |
|-----------|------|-------------|----------|------------|----------|-------------|-------------|
| 1 | acceso a gimnasio | acceso a instalaciones de gimnasio y equipo | fitness | 1 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 2 | clases de yoga | participación en clases de yoga | fitness | 1 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 3 | parqueo | tiempo de parqueo en centros comerciales | transporte | 1 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 4 | entrenamiento express | sesiones rápidas de entrenamiento guiado | fitness | 2 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 5 | masaje de espalda rápido | masaje de espalda de corta duración | bienestar | 2 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 6 | limpieza del hogar | servicio de limpieza básica del hogar | hogar | 3 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 7 | estancia de mascota | días de estancia para mascota en hotel | mascotas | 3 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 8 | sesiones de masaje | sesiones de masaje terapéutico | bienestar | 4 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 9 | grooming para mascotas | servicio de peluquería para mascotas | mascotas | 4 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 10 | revisión veterinaria | consulta veterinaria básica | mascotas | 4 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 11 | corte de cabello | servicio de corte de cabello en barberías afiliadas | belleza | 4 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 12 | almuerzos | comidas en restaurantes seleccionados | alimentación | 4 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 13 | cenas | cenas en restaurantes seleccionados | alimentación | 4 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 14 | lavandería | servicio de lavado y planchado de ropa | hogar | 4 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 15 | consulta medica | consulta medica general | salud | 4 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 16 | visitas a gimnasio | cantidad de visitas al gimnasio | fitness | 5 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 17 | visitas a spa | cantidad de visitas al spa | bienestar | 5 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 18 | combustible | crédito para combustible en estaciones afiliadas | transporte | 6 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 19 | crédito restaurantes | monto disponible para consumo en restaurantes | alimentación | 6 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 20 | crédito servicios médicos | monto en dólares para servicios médicos | salud | 7 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 21 | crédito servicios spa | monto en dólares para servicios de spa premium | bienestar | 7 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 22 | entrega a domicilio extendida | kilómetros adicionales para entregas | alimentación | 8 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 23 | servicio de limpieza extendido | cobertura extendida para servicio de limpieza | hogar | 8 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 24 | descuento en servicios de belleza | porcentaje de descuento en barbería | belleza | 9 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 25 | descuento en servicios médicos | porcentaje de descuento en consultas médicas | salud | 9 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 26 | combustible premium | litros de combustible premium en estaciones seleccionadas | transporte | 10 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |
| 27 | agua para limpieza | litros de agua purificada para servicios de limpieza | hogar | 10 | 1 | 2025-05-04 17:28:29.640 | 2025-05-04 17:28:29.640 |

#### Insercion de CommerceFeatures 
Esta insercion nos permite determinar los costos que ofrecen los comercios a Soltura para brindar los beneficios a los planes respectivos.

```sql
insert into SocaiCommercesFeatures (commercesid, planfeaturesid, isactive, validfrom, validto, createdat, updatedat, 
                                   originalprice, negotiatedprice, servicetypeid, isguaranteedright, discounttype, 
                                   discountvalue, solturamargin, ismarginpercentage, inlcudestax, taxrateid, 
                                   minquantity, maxquantity, termsandconditions, additionalbenefits, iscombined, contractcommercesid)
values 
-- Crunch Fitness 
(1, 1, 1, '2024-01-01', '2026-01-01', getdate(), getdate(), 30000.00, 20000.00, 1, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 30.00, 
'No transferible. Horario de 5am a 10pm', 'Incluye toallas y casillero', 0, 1),
(1, 4, 1, '2024-01-01', '2026-01-01', getdate(), getdate(), 15000.00, 10000.00, 1, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 10.00, 
'Reserva con 2h de anticipacion', 'Incluye instructor personal', 0, 1),
(1, 16, 1, '2024-01-01', '2026-01-01', getdate(), getdate(), 12000.00, 8000.00, 1, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 20.00, 
'Reserva necesaria', 'Incluye programa personalizado', 0, 1),

-- The Spa 
(2, 8, 1, '2024-01-15', '2026-01-15', getdate(), getdate(), 25000.00, 15000.00, 2, 1, 'P', 40.00, 20.00, 1, 1, 1, 1.00, 4.00, 
'Reserva con 24h de anticipacion. Cancelacion gratuita hasta 6h antes', 'Incluye uso de instalaciones', 0, 2),
(2, 5, 1, '2024-01-15', '2026-01-15', getdate(), getdate(), 12000.00, 7500.00, 2, 1, 'P', 37.50, 18.00, 1, 1, 1, 1.00, 5.00, 
'Duracion maxima 20 minutos', 'Incluye aromaterapia', 0, 2),
(2, 17, 1, '2024-01-15', '2026-01-15', getdate(), getdate(), 18000.00, 12000.00, 2, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 10.00, 
'Solo valido de lunes a jueves', 'Acceso a areas humedas', 0, 2),
(2, 21, 1, '2024-01-15', '2026-01-15', getdate(), getdate(), 55000.00, 40000.00, 2, 1, 'P', 27.27, 12.00, 1, 1, 1, NULL, NULL, 
'Valido para cualquier servicio premium', 'Horario preferencial', 0, 2),

-- YogaLife 
(3, 2, 1, '2024-02-01', '2026-02-01', getdate(), getdate(), 12000.00, 8000.00, 1, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 8.00, 
'Sujeto a disponibilidad. Reserva recomendada', 'Incluye prestamo de mat', 0, 3),

-- PetCare 
(4, 9, 1, '2024-02-15', '2026-02-15', getdate(), getdate(), 18000.00, 12000.00, 5, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 4.00, 
'Solo para perros y gatos hasta 25kg', 'Incluye corte de unas', 0, 4),
(4, 10, 1, '2024-02-15', '2026-02-15', getdate(), getdate(), 25000.00, 15000.00, 5, 1, 'P', 40.00, 20.00, 1, 1, 1, 1.00, 3.00, 
'Solo para consultas de rutina', 'Incluye desparasitacion basica', 0, 4),
(4, 7, 1, '2024-02-15', '2026-02-15', getdate(), getdate(), 30000.00, 20000.00, 5, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 5.00, 
'Mascotas menores a 15kg', 'Incluye bano y alimentacion', 0, 4),

-- HogarCleaner 
(5, 6, 1, '2024-03-01', '2026-03-01', getdate(), getdate(), 15000.00, 10000.00, 9, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 8.00, 
'Viviendas hasta 100m2. No incluye limpieza profunda', 'Incluye productos de limpieza', 0, 5),
(5, 14, 1, '2024-03-01', '2026-03-01', getdate(), getdate(), 12000.00, 8000.00, 9, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 5.00, 
'Hasta 5kg de ropa. No incluye prendas delicadas', 'Incluye entrega a domicilio', 0, 5),
(5, 27, 1, '2024-03-01', '2026-03-01', getdate(), getdate(), 20000.00, 15000.00, 9, 1, 'P', 25.00, 10.00, 1, 1, 1, 20.00, 100.00, 
'Servicios adicionales dentro del area metropolitana', 'Servicio prioritario', 0, 5),

-- Gasolinera YAM 
(6, 18, 1, '2024-03-15', '2026-03-15', getdate(), getdate(), 50000.00, 45000.00, 3, 1, 'P', 10.00, 5.00, 1, 1, 1, NULL, NULL, 
'Aplica en todas las estaciones del pais', 'Acumula puntos adicionales', 0, 6),
(6, 26, 1, '2024-03-15', '2026-03-15', getdate(), getdate(), 60000.00, 55000.00, 3, 1, 'P', 8.33, 4.00, 1, 1, 1, 20.00, 80.00, 
'Solo disponible en estaciones seleccionadas', 'Mayor rendimiento', 0, 6),

-- Salud Integral Beneficiada 
(7, 15, 1, '2024-04-01', '2026-04-01', getdate(), getdate(), 35000.00, 25000.00, 7, 1, 'P', 28.57, 12.00, 1, 1, 1, 1.00, 3.00, 
'Solo medicina general. Especialistas con costo adicional', 'Incluye receta medica', 0, 7),
(7, 20, 1, '2024-04-01', '2026-04-01', getdate(), getdate(), 20.00, 15.00, 7, 1, 'P', 25.00, 10.00, 1, 1, 1, NULL, NULL, 
'No acumulable con otros descuentos', 'Incluye examenes basicos', 0, 7),
(7, 25, 1, '2024-04-01', '2026-04-01', getdate(), getdate(), 45.00, 30.00, 7, 1, 'P', 33.33, 15.00, 1, 1, 1, NULL, NULL, 
'Valido para servicios seleccionados', 'Prioridad en citas', 0, 7),

-- Barberia Paco
(8, 11, 1, '2024-04-15', '2026-04-15', getdate(), getdate(), 12000.00, 8000.00, 8, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 3.00, 
'No incluye barba ni tratamientos capilares', 'Incluye lavado y peinado', 0, 8),
(8, 24, 1, '2024-04-15', '2026-04-15', getdate(), getdate(), 25.00, 15.00, 8, 1, 'P', 40.00, 20.00, 1, 1, 1, NULL, NULL, 
'Valido para todos los servicios regulares', 'Sin necesidad de cita', 0, 8),

-- Fit Center Oxigeno 
(9, 1, 1, '2024-05-01', '2026-05-01', getdate(), getdate(), 35000.00, 25000.00, 1, 1, 'P', 28.57, 12.00, 1, 1, 1, 1.00, 30.00, 
'No transferible. Horario completo', 'Incluye clases grupales', 0, 9),
(9, 16, 1, '2024-05-01', '2026-05-01', getdate(), getdate(), 15000.00, 10000.00, 1, 1, 'P', 33.33, 15.00, 1, 1, 1, 1.00, 10.00, 
'Solo en horarios especificos', 'Incluye evaluacion inicial', 0, 9),

-- UberEats 
(10, 19, 1, '2024-05-15', '2026-05-15', getdate(), getdate(), 45000.00, 40000.00, 4, 1, 'P', 11.11, 5.00, 1, 1, 1, NULL, NULL, 
'Valido en restaurantes seleccionados', 'No incluye costo de envio', 0, 10),
(10, 22, 1, '2024-05-15', '2026-05-15', getdate(), getdate(), 15000.00, 12000.00, 4, 1, 'P', 20.00, 10.00, 1, 1, 1, NULL, NULL, 
'Radio de entrega estandar', 'Valido todos los dias', 0, 10);
```
| CommercesFeaturesId | CommercesId | PlanFeaturesId | IsActive | ValidFrom | ValidTo | CreatedAt | UpdatedAt | OriginalPrice | NegotiatedPrice | ServiceTypeId | IsGuaranteedRight | DiscountType | DiscountValue | SolturaMargin | IsMarginPercentage | IncludesTax | TaxRateId | MinQuantity | MaxQuantity | TermsAndConditions | AdditionalBenefits | IsCombined | ContractCommercesId |
|---------------------|-------------|----------------|----------|-----------|---------|-----------|-----------|--------------|----------------|--------------|-------------------|--------------|--------------|--------------|-------------------|------------|-----------|-------------|-------------|---------------------|-------------------|------------|---------------------|
| 1 | 1 | 1 | 1 | 2024-01-01 00:00:00.000 | 2026-01-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 30000.00 | 20000.00 | 1 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 30.00 | No transferible. Horario de 5am a 10pm | Incluye toallas y casillero | 0 | 1 |
| 2 | 1 | 4 | 1 | 2024-01-01 00:00:00.000 | 2026-01-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 15000.00 | 10000.00 | 1 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 10.00 | Reserva con 2h de anticipación | Incluye instructor personal | 0 | 1 |
| 3 | 1 | 16 | 1 | 2024-01-01 00:00:00.000 | 2026-01-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 12000.00 | 8000.00 | 1 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 20.00 | Reserva necesaria | Incluye programa personalizado | 0 | 1 |
| 4 | 2 | 8 | 1 | 2024-01-15 00:00:00.000 | 2026-01-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 25000.00 | 15000.00 | 2 | 1 | P | 40.00 | 20.00 | 1 | 1 | 1 | 1.00 | 4.00 | Reserva con 24h de anticipación. Cancelación gratuita hasta 6h antes | Incluye uso de instalaciones | 0 | 2 |
| 5 | 2 | 5 | 1 | 2024-01-15 00:00:00.000 | 2026-01-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 12000.00 | 7500.00 | 2 | 1 | P | 37.50 | 18.00 | 1 | 1 | 1 | 1.00 | 5.00 | Duración máxima 20 minutos | Incluye aromaterapia | 0 | 2 |
| 6 | 2 | 17 | 1 | 2024-01-15 00:00:00.000 | 2026-01-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 18000.00 | 12000.00 | 2 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | NULL | Solo válido de lunes a jueves | Acceso a áreas húmedas | 0 | 2 |
| 7 | 2 | 21 | 1 | 2024-01-15 00:00:00.000 | 2026-01-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 55000.00 | 40000.00 | 2 | 1 | P | 27.27 | 12.00 | 1 | 1 | 1 | NULL | NULL | Válido para cualquier servicio premium | Horario preferencial | 0 | 2 |
| 8 | 3 | 2 | 1 | 2024-02-01 00:00:00.000 | 2026-02-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 12000.00 | 8000.00 | 1 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 8.00 | Sujeto a disponibilidad. Reserva recomendada | Incluye préstamo de mat | 0 | 3 |
| 9 | 4 | 9 | 1 | 2024-02-15 00:00:00.000 | 2026-02-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 18000.00 | 12000.00 | 5 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 4.00 | Solo para perros y gatos hasta 25kg | Incluye corte de uñas | 0 | 4 |
| 10 | 4 | 10 | 1 | 2024-02-15 00:00:00.000 | 2026-02-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 25000.00 | 15000.00 | 5 | 1 | P | 40.00 | 20.00 | 1 | 1 | 1 | 1.00 | 3.00 | Solo para consultas de rutina | Incluye desparasitación básica | 0 | 4 |
| 11 | 4 | 7 | 1 | 2024-02-15 00:00:00.000 | 2026-02-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 30000.00 | 20000.00 | 5 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 5.00 | Mascotas menores a 15kg | Incluye baño y alimentación | 0 | 4 |
| 12 | 5 | 6 | 1 | 2024-03-01 00:00:00.000 | 2026-03-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 15000.00 | 10000.00 | 9 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 8.00 | Viviendas hasta 100m2. No incluye limpieza profunda | Incluye productos de limpieza | 0 | 5 |
| 13 | 5 | 14 | 1 | 2024-03-01 00:00:00.000 | 2026-03-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 12000.00 | 8000.00 | 9 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 5.00 | Hasta 5kg de ropa. No incluye prendas delicadas | Incluye entrega a domicilio | 0 | 5 |
| 14 | 5 | 27 | 1 | 2024-03-01 00:00:00.000 | 2026-03-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 20000.00 | 15000.00 | 9 | 1 | P | 25.00 | 10.00 | 1 | 1 | 1 | 20.00 | 100.00 | Servicios adicionales dentro del área metropolitana | Servicio prioritario | 0 | 5 |
| 15 | 6 | 18 | 1 | 2024-03-15 00:00:00.000 | 2026-03-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 50000.00 | 45000.00 | 3 | 1 | P | 10.00 | 5.00 | 1 | 1 | 1 | NULL | NULL | Aplica en todas las estaciones del país | Acumula puntos adicionales | 0 | 6 |
| 16 | 6 | 26 | 1 | 2024-03-15 00:00:00.000 | 2026-03-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 60000.00 | 55000.00 | 3 | 1 | P | 8.33 | 4.00 | 1 | 1 | 1 | 20.00 | 80.00 | Solo disponible en estaciones seleccionadas | Mayor rendimiento | 0 | 6 |
| 17 | 7 | 15 | 1 | 2024-04-01 00:00:00.000 | 2026-04-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 35000.00 | 25000.00 | 7 | 1 | P | 28.57 | 12.00 | 1 | 1 | 1 | 1.00 | 3.00 | Solo medicina general. Especialistas con costo adicional | Incluye receta médica | 0 | 7 |
| 18 | 7 | 20 | 1 | 2024-04-01 00:00:00.000 | 2026-04-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 20.00 | 15.00 | 7 | 1 | P | 25.00 | 10.00 | 1 | 1 | 1 | NULL | NULL | No acumulable con otros descuentos | Incluye exámenes básicos | 0 | 7 |
| 19 | 7 | 25 | 1 | 2024-04-01 00:00:00.000 | 2026-04-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 45.00 | 30.00 | 7 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | NULL | NULL | Válido para servicios seleccionados | Prioridad en citas | 0 | 7 |
| 20 | 8 | 11 | 1 | 2024-04-15 00:00:00.000 | 2026-04-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 12000.00 | 8000.00 | 8 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 3.00 | No incluye barba ni tratamientos capilares | Incluye lavado y peinado | 0 | 8 |
| 21 | 8 | 24 | 1 | 2024-04-15 00:00:00.000 | 2026-04-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 25.00 | 15.00 | 8 | 1 | P | 40.00 | 20.00 | 1 | 1 | 1 | NULL | NULL | Válido para todos los servicios regulares | Sin necesidad de cita | 0 | 8 |
| 22 | 9 | 1 | 1 | 2024-05-01 00:00:00.000 | 2026-05-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 35000.00 | 25000.00 | 1 | 1 | P | 28.57 | 12.00 | 1 | 1 | 1 | 1.00 | 30.00 | No transferible. Horario completo | Incluye clases grupales | 0 | 9 |
| 23 | 9 | 16 | 1 | 2024-05-01 00:00:00.000 | 2026-05-01 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 15000.00 | 10000.00 | 1 | 1 | P | 33.33 | 15.00 | 1 | 1 | 1 | 1.00 | 10.00 | Solo en horarios específicos | Incluye evaluación inicial | 0 | 9 |
| 24 | 10 | 19 | 1 | 2024-05-15 00:00:00.000 | 2026-05-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 45000.00 | 40000.00 | 4 | 1 | P | 11.11 | 5.00 | 1 | 1 | 1 | NULL | NULL | Válido en restaurantes seleccionados | No incluye costo de envío | 0 | 10 |
| 25 | 10 | 22 | 1 | 2024-05-15 00:00:00.000 | 2026-05-15 00:00:00.000 | 2025-05-04 19:47:27.240 | 2025-05-04 19:47:27.240 | 15000.00 | 12000.00 | 4 | 1 | P | 20.00 | 10.00 | 1 | 1 | 1 | NULL | NULL | Radio de entrega estándar | Válido todos los días | 0 | 10 |

### 1.4 Suscripciones y Planes
En este apartado definimos los planes existentes y que beneficio contiene cada plan.

``` sql

insert into SocaiSubscriptions (name, description, iscustomizable, isactive, createdat, updatedat, amount, currencytypeid)

values 
-- 1. Plan Profesional Joven
('Profesional Joven', 'Plan para profesionales jovenes con servicios de gimnasio, comidas y movilidad', 0, 1, getdate(), getdate(), 65000.00, 2),

-- 2. Familia Moderna
('Familia Moderna', 'Plan familiar con servicios para toda la familia incluyendo mascotas y alimentacion', 0, 1, getdate(), getdate(), 110000.00, 2),

-- 3. Ejecutivo Premium
('Ejecutivo Premium', 'Plan para ejecutivos con servicios de bienestar, movilidad y alimentacion', 1, 1, getdate(), getdate(), 95000.00, 2),

-- 4. Entusiasta el gymm
('Entusiasta al Gym', 'Plan enfocado en fitness y bienestar para amantes del ejercicio', 1, 1, getdate(), getdate(), 55000.00, 2),

-- 5. Movilidad
('Movilidad Urbana', 'Plan enfocado en combustible, parqueo y alimentacion', 1, 1, getdate(), getdate(), 45000.00, 2),

-- 6. Petsss
('Amante de Mascotas', 'Plan para amantes de las mascotas con servicios veterinarios y de cuidado', 1, 1, getdate(), getdate(), 50000.00, 2),

-- 7. Hogar y Cuidado
('Hogar y Cuidado', 'Plan para el cuidado del hogar y servicios de salud basicos', 1, 1, getdate(), getdate(), 60000.00, 2),

-- 8. Gastronomia
('Amante de la Gastronomia', 'Plan para amantes de la gastronomia con servicios de alimentacion y delivery', 0, 1, getdate(), getdate(), 60000.00, 2);

select * from SocaiSubscriptions;

```

| SubscriptionId | Name | Description | isCustomizable | isActive | createdAt | updatedAt | amount | CurrencyTypeId |
|---------------|------|-------------|---------------|----------|-----------|-----------|--------|----------------|
| 2 | Profesional Joven | Plan para profesionales jovenes con servicios de... | 0 | 1 | 2025-05-04 20:02:24.493 | 2025-05-04 20:02:24.493 | 65000.00 | 2 |
| 3 | Familia Moderna | Plan familiar con servicios para toda la familia incluyendo... | 0 | 1 | 2025-05-04 20:02:24.493 | 2025-05-04 20:02:24.493 | 110000.00 | 2 |
| 4 | Ejecutivo Premium | Plan para ejecutivos con servicios de bienestar,... | 1 | 1 | 2025-05-04 20:02:24.493 | 2025-05-04 20:02:24.493 | 95000.00 | 2 |
| 5 | Entusiasta al Gym | Plan enfocado en fitness y bienestar para amantes... | 1 | 1 | 2025-05-04 20:02:24.493 | 2025-05-04 20:02:24.493 | 55000.00 | 2 |
| 6 | Movilidad Urbana | Plan enfocado en combustible, parqueo y alimentación | 1 | 1 | 2025-05-04 20:02:24.493 | 2025-05-04 20:02:24.493 | 45000.00 | 2 |
| 7 | Amante de Mascotas | Plan para amantes de las mascotas con servicios... | 1 | 1 | 2025-05-04 20:02:24.493 | 2025-05-04 20:02:24.493 | 50000.00 | 2 |
| 8 | Hogar y Cuidado | Plan para el cuidado del hogar y servicios de salud... | 1 | 1 | 2025-05-04 20:02:24.493 | 2025-05-04 20:02:24.493 | 60000.00 | 2 |
| 9 | Amante de la Gastronomía | Plan para amantes de la gastronomía con servicios... | 0 | 1 | 2025-05-04 20:02:24.493 | 2025-05-04 20:02:24.493 | 60000.00 | 2 |

#### Insercion de FeaturesSubscriptions
Definimos que beneficio va en cada plan.

``` sql

--- Beneficios de cada plan ---

insert into SocaiFeaturesSubscriptions (planfeatureid, subscriptionid, quantity, unittypeid, createdat, updatedat, servicetypeid, membercount, ismemberspecific)

values 
-- Plan 1: Profesional Joven
(1, 2, 6.00, 1, getdate(), getdate(), 1, 1, 0), -- 6 horas por semana de gimnasio
(14, 2, 1.00, 4, getdate(), getdate(), 9, 1, 0), -- 1 servicio de lavanderia
(6, 2, 2.00, 3, getdate(), getdate(), 9, 1, 0), -- 2 dias de limpieza basica
(18, 2, 50000.00, 6, getdate(), getdate(), 3, 1, 0), -- ₡50000 en combustible
(11, 2, 1.00, 4, getdate(), getdate(), 8, 1, 0), -- 1 corte de pelo
(13, 2, 2.00, 4, getdate(), getdate(), 4, 1, 0), -- 2 cenas
(12, 2, 4.00, 4, getdate(), getdate(), 4, 1, 0), -- 4 almuerzos
(3, 2, 10.00, 1, getdate(), getdate(), 10, 1, 0), -- 10 horas de parqueo

-- Plan 2: Familia Moderna
(1, 3, 4.00, 1, getdate(), getdate(), 1, 4, 0), -- 4 horas por semana de gimnasio (4 personas)
(2, 3, 4.00, 1, getdate(), getdate(), 1, 4, 0), -- 4 horas de yoga
(9, 3, 1.00, 4, getdate(), getdate(), 5, 1, 0), -- 1 servicio de grooming para mascota
(10, 3, 1.00, 4, getdate(), getdate(), 5, 1, 0), -- 1 consulta veterinaria
(7, 3, 1.00, 3, getdate(), getdate(), 5, 1, 0), -- 1 día de estancia de mascota
(18, 3, 100000.00, 6, getdate(), getdate(), 3, 1, 0), -- ₡100000 en combustible
(19, 3, 10000.00, 6, getdate(), getdate(), 4, 1, 0), -- ₡10000 en credito para restaurantes

-- Plan 3: Ejecutivo Premium
(1, 4, 8.00, 1, getdate(), getdate(), 1, 1, 0), -- 8 horas por semana de gimnasio
(8, 4, 2.00, 4, getdate(), getdate(), 2, 1, 0), -- 2 sesiones de masaje
(18, 4, 75000.00, 6, getdate(), getdate(), 3, 1, 0), -- ₡75000 en combustible
(11, 4, 1.00, 4, getdate(), getdate(), 8, 1, 0), -- 1 corte de pelo
(13, 4, 4.00, 4, getdate(), getdate(), 4, 1, 0), -- 4 cenas
(3, 4, 20.00, 1, getdate(), getdate(), 10, 1, 0), -- 20 horas de parqueo

-- Plan 4: Entusiasta Fitness
(1, 5, 10.00, 1, getdate(), getdate(), 1, 1, 0), -- 10 horas por semana de gimnasio
(2, 5, 3.00, 1, getdate(), getdate(), 1, 1, 0), -- 3 horas de yoga
(4, 5, 2.00, 2, getdate(), getdate(), 1, 1, 0), -- 2 sesiones de entrenamiento express
(8, 5, 1.00, 4, getdate(), getdate(), 2, 1, 0), -- 1 sesión de masaje

-- Plan 5: Movilidad 
(18, 6, 30000.00, 6, getdate(), getdate(), 3, 1, 0), -- ₡30000 en combustible
(26, 6, 10.00, 10, getdate(), getdate(), 3, 1, 0), -- 10 litros de combustible premium
(3, 6, 30.00, 1, getdate(), getdate(), 10, 1, 0), -- 30 horas de parqueo
(19, 6, 5000.00, 6, getdate(), getdate(), 4, 1, 0), -- ₡5,000 en credito para restaurantes

-- Plan 6: Amante de Mascotas
(9, 7, 2.00, 4, getdate(), getdate(), 5, 1, 0), -- 2 servicios de grooming para mascotas
(10, 7, 2.00, 4, getdate(), getdate(), 5, 1, 0), -- 2 consultas veterinarias
(7, 7, 3.00, 3, getdate(), getdate(), 5, 1, 0), -- 3 dias de estancia de mascota
(25, 7, 25.00, 9, getdate(), getdate(), 7, 1, 0), -- 25% de descuento en servicios medicos (para mascotas)

-- Plan 7: Hogar y Cuidado
(6, 8, 4.00, 3, getdate(), getdate(), 9, 1, 0), -- 4 dias de limpieza del hogar
(14, 8, 2.00, 4, getdate(), getdate(), 9, 1, 0), -- 2 servicios de lavanderia
(27, 8, 30.00, 10, getdate(), getdate(), 9, 1, 0), -- 30 litros de agua para limpieza
(15, 8, 1.00, 4, getdate(), getdate(), 7, 1, 0), -- 1 consulta medica
(25, 8, 15.00, 9, getdate(), getdate(), 7, 1, 0), -- 15% de descuento en servicios medicos

-- Plan 8: Explorador Gastronómico
(12, 9, 8.00, 4, getdate(), getdate(), 4, 1, 0), -- 8 almuerzos
(13, 9, 8.00, 4, getdate(), getdate(), 4, 1, 0), -- 8 cenas
(19, 9, 30000.00, 6, getdate(), getdate(), 4, 1, 0), -- ₡30000 en credito para restaurantes
(22, 9, 15.00, 8, getdate(), getdate(), 4, 1, 0); -- 15 km adicionales para entregas a domicilio

select * from SocaiFeaturesSubscriptions;

```
| FeaturesSubscriptionsId | PlanFeatureId | SubscriptionId | Quantity | UnitTypeId | CreatedAt | UpdatedAt | ServiceTypeId | MemberCount | IsMemberSpecific |
|-------------------------|---------------|----------------|----------|------------|-----------|-----------|---------------|-------------|------------------|
| 1 | 1 | 2 | 6.00 | 1 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 1 | 1 | 0 |
| 2 | 14 | 2 | 1.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 9 | 1 | 0 |
| 3 | 6 | 2 | 2.00 | 3 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 9 | 1 | 0 |
| 4 | 18 | 2 | 50000.00 | 6 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 3 | 1 | 0 |
| 5 | 11 | 2 | 1.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 8 | 1 | 0 |
| 6 | 13 | 2 | 2.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 4 | 1 | 0 |
| 7 | 12 | 2 | 4.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 4 | 1 | 0 |
| 8 | 3 | 2 | 10.00 | 1 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 10 | 1 | 0 |
| 9 | 1 | 3 | 4.00 | 1 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 1 | 4 | 0 |
| 10 | 2 | 3 | 4.00 | 1 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 1 | 4 | 0 |
| 11 | 9 | 3 | 1.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 5 | 1 | 0 |
| 12 | 10 | 3 | 1.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 5 | 1 | 0 |
| 13 | 7 | 3 | 1.00 | 3 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 5 | 1 | 0 |
| 14 | 18 | 3 | 100000.00 | 6 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 3 | 1 | 0 |
| 15 | 19 | 3 | 10000.00 | 6 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 4 | 1 | 0 |
| 16 | 1 | 4 | 8.00 | 1 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 1 | 1 | 0 |
| 17 | 8 | 4 | 2.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 2 | 1 | 0 |
| 18 | 18 | 4 | 75000.00 | 6 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 3 | 1 | 0 |
| 19 | 11 | 4 | 1.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 8 | 1 | 0 |
| 20 | 13 | 4 | 4.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 4 | 1 | 0 |
| 21 | 3 | 4 | 20.00 | 1 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 10 | 1 | 0 |
| 22 | 1 | 5 | 10.00 | 1 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 1 | 1 | 0 |
| 23 | 2 | 5 | 3.00 | 1 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 1 | 1 | 0 |
| 24 | 4 | 5 | 2.00 | 2 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 1 | 1 | 0 |
| 25 | 8 | 5 | 1.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 2 | 1 | 0 |
| 26 | 18 | 6 | 30000.00 | 6 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 3 | 1 | 0 |
| 27 | 26 | 6 | 10.00 | 10 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 3 | 1 | 0 |
| 28 | 3 | 6 | 30.00 | 1 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 10 | 1 | 0 |
| 29 | 19 | 6 | 5000.00 | 6 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 4 | 1 | 0 |
| 30 | 9 | 7 | 2.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 5 | 1 | 0 |
| 31 | 10 | 7 | 2.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 5 | 1 | 0 |
| 32 | 7 | 7 | 3.00 | 3 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 5 | 1 | 0 |
| 33 | 25 | 7 | 25.00 | 9 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 7 | 1 | 0 |
| 34 | 6 | 8 | 4.00 | 3 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 9 | 1 | 0 |
| 35 | 14 | 8 | 2.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 9 | 1 | 0 |
| 36 | 27 | 8 | 30.00 | 10 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 9 | 1 | 0 |
| 37 | 15 | 8 | 1.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 7 | 1 | 0 |
| 38 | 25 | 8 | 15.00 | 9 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 7 | 1 | 0 |
| 39 | 12 | 9 | 8.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 4 | 1 | 0 |
| 40 | 13 | 9 | 8.00 | 4 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 4 | 1 | 0 |
| 41 | 19 | 9 | 30000.00 | 6 | 2025-05-04 20:18:37.493 | 2025-05-04 20:18:37.493 | 4 | 1 | 0 |

### 1.5 Metodos de Pago
Aqui definimos los metodos de pago existentes.

```sql
insert into SocaiPaymentMethods (name, apiurl, secretkey, [key], logoiconurl, enable)

values 
-- Tarjetas de credito y debito
('Visa', 'https://api.visa.com/payments', cast('sk_visa_production_xj67klm9' as varbinary(255)), cast('pk_visa_2024_cr' as varbinary(255)), 'https://soltura.com/icons/visa.png', 1),
('Mastercard', 'https://api.mastercard.com/process', cast('sk_mastercard_prod_abc123def' as varbinary(255)), cast('pk_mastercard_2024_cr' as varbinary(255)), 'https://soltura.com/icons/mastercard.png', 1),
('American Express', 'https://api.amex.com/payments', cast('sk_amex_prod_456gh789ij' as varbinary(255)), cast('pk_amex_2024_cr' as varbinary(255)), 'https://soltura.com/icons/amex.png', 1),

-- Bancos de CR
('BAC Credomatic', 'https://api.baccredomatic.com/pagos', cast('sk_bac_prod_cr_2024xyz' as varbinary(255)), cast('pk_bac_cr_2024' as varbinary(255)), 'https://soltura.com/icons/bac.png', 1),
('Banco Nacional', 'https://api.bncr.fi.cr/pagos', cast('sk_bn_prod_567klm890' as varbinary(255)), cast('pk_bn_cr_2024' as varbinary(255)), 'https://soltura.com/icons/bncr.png', 1),
('Banco de Costa Rica', 'https://api.bancobcr.com/pagos', cast('sk_bcr_prod_qrs789tuv' as varbinary(255)), cast('pk_bcr_cr_2024' as varbinary(255)), 'https://soltura.com/icons/bcr.png', 1),

-- Billeteras digitales
('PayPal', 'https://api.paypal.com/v2/payments', cast('sk_paypal_prod_lmn123opq' as varbinary(255)), cast('pk_paypal_global_2024' as varbinary(255)), 'https://soltura.com/icons/paypal.png', 1),
('Apple Pay', 'https://api.apple.com/pay/process', cast('sk_applepay_prod_rst456uvw' as varbinary(255)), cast('pk_applepay_global_2024' as varbinary(255)), 'https://soltura.com/icons/applepay.png', 1),
('Google Pay', 'https://api.google.com/pay/process', cast('sk_googlepay_prod_xyz789abc' as varbinary(255)), cast('pk_googlepay_global_2024' as varbinary(255)), 'https://soltura.com/icons/googlepay.png', 1),

-- Otras opciones
('SINPE Movil', 'https://api.sinpe.fi.cr/pagos', cast('sk_sinpe_prod_def123ghi' as varbinary(255)), cast('pk_sinpe_cr_2024' as varbinary(255)), 'https://soltura.com/icons/sinpe.png', 1),
('Transferencia Bancaria', 'https://api.soltura.com/banktransfer', cast('sk_transfer_prod_jkl456mno' as varbinary(255)), cast('pk_transfer_cr_2024' as varbinary(255)), 'https://soltura.com/icons/transfer.png', 1);

select * from SocaiPaymentMethods;
```
| PaymentMethodId | name | apiURL | secretKey | key | logoIconURL | enable |
|-----------------|------|--------|-----------|-----|-------------|--------|
| 0 | Visa | https://api.visa.com/payments | 0x7368BF76697361BF7072BF645F73674356F6E5F786A3C576... | 0x706B5F7697361BF32303234BF6372 | https://soltura.com/icons/visa.png | 1 |
| 1 | Mastercard | https://api.mastercard.com/process | 0x7368BF6D61737465726357F7234BF7072BF645F6126333313... | 0x706B5F6D6174657265726453F32303234BF6372 | https://soltura.com/icons/mastercard.png | 1 |
| 2 | American Express | https://api.amex.com/payments | 0x7368BF616D65785F7072BF645F343536678373839696A | 0x706B5F616D65785F32303234BF6372 | https://soltura.com/icons/amex.png | 1 |
| 3 | BAC Credomatic | https://api.baccredomatic.com/pagos | 0x7368BF6261635F7072BF645F6372BF323032347879A | 0x706B5F6261635F6372BF32303234 | https://soltura.com/icons/bac.png | 1 |
| 4 | Banco Nacional | https://api.bncr.fi.cr/pagos | 0x7368BF626E5F7072BF645F626E6B6D38930 | 0x706B5F626E5F6372BF32303234 | https://soltura.com/icons/bncr.png | 1 |
| 5 | Banco de Costa Rica | https://api.bancobcr.com/pagos | 0x7368BF6263725F7072BF645F7172733738397457B | 0x706B5F6263725F6372BF32303234 | https://soltura.com/icons/bcr.png | 1 |
| 6 | PayPal | https://api.paypal.com/v2/payments | 0x7368BF7061797061C5F7072BF645F626D6E3123356F7071 | 0x706B5F7061797061C5F6762CF626125F32303234 | https://soltura.com/icons/paypal.png | 1 |
| 7 | Apple Pay | https://api.apple.com/pay/process | 0x7368BF6170706C657061795F7072BF645F727379343567... | 0x706B5F6170706C657061795F626F626125F3230... | https://soltura.com/icons/applepay.png | 1 |
| 8 | Google Pay | https://api.google.com/pay/process | 0x7368BF676F6F676C6570617965F7072BF645F675791732383... | 0x706B5F676F6F676C6570617965F76261C5F32... | https://soltura.com/icons/googlepay.png | 1 |
| 9 | SINPE Movil | https://api.sinpe.fi.cr/pagos | 0x7368BF73696E706D6F55F7072BF645F645663123267868 | 0x706B5F73696E706D6F55F6372BF32303234 | https://soltura.com/icons/sinpe.png | 1 |
| 10 | Transferencia Bancaria | https://api.soltura.com/banktransfer | 0x7368BF747261E736665725F7072BF645F64B6C5435358... | 0x706B5F747261E736665725F6372BF32303234 | https://soltura.com/icons/transfer.png | 1 |

#### Insercion de Currency Exchange
Nos permite definir las tasas de cambio.

``` sql
select* from SocaiCurrencyTypes;

insert into SocaiCurrencyExchange (startDate, 
    endDate, exchangeRate, 
    enabled, currentExchangeRate, 
    CurrencyTypeId, CurrencyTypeDestinyId, 
    CountryId
)

values (
    GETDATE(), 
    DATEADD(YEAR, 1, GETDATE()), 
    540.25, 
    1, 
    1, 
    2, 
    0, 
    1  
);

select* from SocaiCurrencyExchange;
select* from SocaiCurrencyTypes;

```
| CurrencyExchangeId | startDate | endDate | exchangeRate | enabled | currentExchangeRate | CurrencyTypeId | CurrencyTypeDestinyId | CountryId |
|-------------------|-----------|---------|--------------|---------|---------------------|----------------|------------------------|-----------|
| 1 | 2025-05-05 14:01:09.243 | 2025-05-05 14:01:09.243 | 540.25 | 1 | 1 | 2 | 0 | 1 |

#### Insercion de Resultados de Pago
Varios mensajes de los metodos de pago. 
```sql
insert into SocaiResultPayment (name, description)

values
    ('Exitoso', 'El pago se proceso correctamente'),
    ('Rechazado', 'El pago fue rechazado por la entidad financiera'),
    ('Pendiente', 'El pago está en proceso de verificacion'),
    ('Cancelado', 'El pago fue cancelado por el usuario'),
    ('Error', 'Ocurrio un error durante el procesamiento del pago');

select * from SocaiResultPayment;
```
| ResultPaymentId | name | description |
|-----------------|------|-------------|
| 0 | Exitoso | El pago se procesó correctamente |
| 1 | Rechazado | El pago fue rechazado por la entidad financiera |
| 2 | Pendiente | El pago está en proceso de verificación |
| 3 | Cancelado | El pago fue cancelado por el usuario |
| 4 | Error | Ocurrió un error durante el procesamiento del pago |

#### Insercion de Tipos de Transacciones
En este apartado definimos algunos de los tipos de transaccion mas comunes, esto incluyendo subtipos.

``` sql
insert into SocaiTransactionTypes (name, description)

values ('Pago', 'Transaccion de pago realizada por un usuario'),
    ('Reembolso', 'Devolucion de un pago a un usuario'),
    ('Ajuste', 'Ajuste manual de saldo'),
    ('Cobro de Membresia', 'Cobro automático por membresia'),
    ('Redención de Beneficio', 'Uso de un beneficio de la membresia');

select * from SocaiTransactionTypes;

--- Insercion Subtipos de Transacciones ---

insert into SocaiTransactionSubTypes (name, description)

values 
    ('Tarjeta de Credito', 'Pago mediante tarjeta de credito'),
    ('Tarjeta de Debito', 'Pago mediante tarjeta de debito'),
    ('Transferencia', 'Pago mediante transferencia bancaria'),
    ('Efectivo', 'Pago en efectivo'),
    ('Monedero Digital', 'Pago mediante billetera digital');

select * from SocaiTransactionSubTypes;

```

#### Transaction Types
| TransactionTypeId | name | description |
|------------------|------|-------------|
| 0 | Pago | Transacción de pago realizada por un usuario |
| 1 | Reembolso | Devolución de un pago a un usuario |
| 2 | Ajuste | Ajuste manual de saldo |
| 3 | Cobro de Membresía | Cobro automático por membresía |
| 4 | Redención de Beneficio | Uso de un beneficio de la membresía |

#### TransactionSubTypes
| TransactionSubTypeId | name | description |
|----------------------|------|-------------|
| 0 | Tarjeta de Crédito | Pago mediante tarjeta de crédito |
| 1 | Tarjeta de Débito | Pago mediante tarjeta de débito |
| 2 | Transferencia | Pago mediante transferencia bancaria |
| 3 | Efectivo | Pago en efectivo |
| 4 | Monedero Digital | Pago mediante billetera digital |

### 1.6 Usuarios
En este caso creamos un procedure para hacer una generacion de 30 usuarios con nombres aleatorios. Esto para posteriormente pasar a lo que seria la generacion de usuarios con suscripciones activas

``` sql
-- Procedimiento para generar usuarios aleatorios

DROP PROCEDURE IF EXISTS FillSocaiUsers;
GO

CREATE PROCEDURE FillSocaiUsers
AS

BEGIN
    DECLARE @i INT = 1;
    DECLARE @total_users INT = 30;
    DECLARE @nombre VARCHAR(50);
    DECLARE @apellido VARCHAR(50);
    DECLARE @email_usuario VARCHAR(100);
    DECLARE @email_dominio VARCHAR(20);
    DECLARE @telefono VARCHAR(20);
    DECLARE @direccion_id INT;
    DECLARE @password_hash VARBINARY(100);
    
    -- Generacioon de 30 usuarios
    WHILE @i <= @total_users

    BEGIN
        -- Generar datos aleatorios para el usuario con una lista ampliada
        SET @nombre = 
            CASE FLOOR(1 + RAND() * 30)
                WHEN 1 THEN 'Ana' WHEN 2 THEN 'Carlos' WHEN 3 THEN 'Maria' 
                WHEN 4 THEN 'Jose' WHEN 5 THEN 'Priscilla' WHEN 6 THEN 'Pedro'
                WHEN 7 THEN 'Sofia' WHEN 8 THEN 'Daniel' WHEN 9 THEN 'Gabriela'
                WHEN 10 THEN 'Luis' WHEN 11 THEN 'Natalia' WHEN 12 THEN 'Roberto'
                WHEN 13 THEN 'Monica' WHEN 14 THEN 'Alberto' WHEN 15 THEN 'Karla'
                WHEN 16 THEN 'Francisco' WHEN 17 THEN 'Adriana' WHEN 18 THEN 'Ricardo'
                WHEN 19 THEN 'Valeria' WHEN 20 THEN 'Ferran' WHEN 21 THEN 'Patricia'
                WHEN 22 THEN 'Christopher' WHEN 23 THEN 'Alejandra' WHEN 24 THEN 'David'
                WHEN 25 THEN 'Carolina' WHEN 26 THEN 'Fernando' WHEN 27 THEN 'Isabel'
                WHEN 28 THEN 'Adrian' WHEN 29 THEN 'Lamine' ELSE 'Alejandro'
            END;
            
        SET @apellido = 
            CASE FLOOR(1 + RAND() * 30)
                WHEN 1 THEN 'Rodriguez' WHEN 2 THEN 'Gonzalez' WHEN 3 THEN 'Hernandez'
                WHEN 4 THEN 'Lopez' WHEN 5 THEN 'Flick' WHEN 6 THEN 'Sanchez'
                WHEN 7 THEN 'Perez' WHEN 8 THEN 'Ramirez' WHEN 9 THEN 'Torres'
                WHEN 10 THEN 'Flores' WHEN 11 THEN 'Topuria' WHEN 12 THEN 'Gomez'
                WHEN 13 THEN 'Vargas' WHEN 14 THEN 'Cruz' WHEN 15 THEN 'Jimenez'
                WHEN 16 THEN 'Morales' WHEN 17 THEN 'Reyes' WHEN 18 THEN 'Ortiz'
                WHEN 19 THEN 'Gutierrez' WHEN 20 THEN 'Castro' WHEN 21 THEN 'Vargas'
                WHEN 22 THEN 'Poirier' WHEN 23 THEN 'Alvarez' WHEN 24 THEN 'Mendoza'
                WHEN 25 THEN 'Fernandez' WHEN 26 THEN 'Ruiz' WHEN 27 THEN 'Navarro'
                WHEN 28 THEN 'Molina' WHEN 29 THEN 'Delgado' ELSE 'Aguilar'
            END;
            
        SET @email_dominio = 
            CASE FLOOR(1 + RAND() * 8)
                WHEN 1 THEN '@gmail.com' WHEN 2 THEN '@hotmail.com' WHEN 3 THEN '@yahoo.com'
                WHEN 4 THEN '@outlook.com' WHEN 5 THEN '@icloud.com' WHEN 6 THEN '@me.com'
                WHEN 7 THEN '@casamail.com' ELSE '@eslive.com'
            END;
        
        SET @email_usuario = LOWER(@nombre) + '.' + LOWER(@apellido) + 
                            CAST(FLOOR(100 + RAND() * 900) AS VARCHAR) + @email_dominio;
                            
        SET @telefono = '8' + RIGHT('000' + CAST(FLOOR(100 + RAND() * 900) AS VARCHAR), 3) + '-' + 
                       RIGHT('0000' + CAST(FLOOR(1000 + RAND() * 9000) AS VARCHAR), 4);
                       
        SET @direccion_id = @i; -- Usamos la direccion generadas de 1 - 30
        
        SET @password_hash = CAST('hash_' + CONVERT(VARCHAR(32), HASHBYTES('MD5', 
                              @nombre + @apellido + CAST(FLOOR(RAND() * 1000) AS VARCHAR)), 2) AS VARBINARY(100));
        
        -- Insertar usuario
        INSERT INTO SocaiUsers (Name, Email, PhoneNumber, Password, AddressId, isActive, LastLogin, CreatedAt)
        VALUES ( @nombre + ' ' + @apellido,  @email_usuario, @telefono, @password_hash,
            @direccion_id, 1, DATEADD(DAY, -FLOOR(RAND() * 30), GETDATE()), 
            DATEADD(DAY, -(30 + FLOOR(RAND() * 180)), GETDATE()));
        
        SET @i = @i + 1;
    END
    
END;
GO

EXEC FillSocaiUsers;
GO

select * from SocaiUsers;

```
| UserId | Name | Email | PhoneNumber | Password | AddressId | isActive | LastLogin | CreatedAt |
|--------|------|-------|-------------|----------|-----------|----------|-----------|-----------|
| 1 | Pedro Aguilar | pedro.aguilar345@icloud.com | 8337-8760 | 0x686173685F443742454634113642374138332413242438... | 1 | 1 | 2025-04-28 22:25:28.320 | 2024-10-23 22:25:28.320 |
| 2 | Daniel Jimenez | daniel.jimenez615@alive.com | 8943-2788 | 0x686173685F33304346411464341383941712423203135... | 2 | 1 | 2025-04-27 22:25:28.323 | 2024-12-09 22:25:28.323 |
| 3 | Alejandro Vargas | alejandro.vargas298@outlook.com | 8628-6407 | 0x686173685F32424530363445354538314634313542441... | 3 | 1 | 2025-04-21 22:25:28.323 | 2024-12-22 22:25:28.323 |
| 4 | Alejandro Aguilar | alejandro.aguilar854@yahoo.com | 8967-9914 | 0x686173685F34314536384333373143430437394643438... | 4 | 1 | 2025-04-09 22:25:28.323 | 2024-12-10 22:25:28.323 |
| 5 | Alejandra Avila | alejandra.avila646@gmail.com | 8554-2796 | 0x686173685F34328643443938343934337443443444536... | 5 | 1 | 2025-04-26 22:25:28.327 | 2025-03-15 22:25:28.327 |
| 6 | Carolina Gomez | carolina.gomez960@icloud.com | 8907-8756 | 0x686173685F359313543944435463130414304131304... | 6 | 1 | 2025-04-08 22:25:28.327 | 2025-01-02 22:25:28.327 |
| 7 | Ferran Fernandez | ferran.fernandez404@gmail.com | 8657-9863 | 0x686173685F42463731364433424393737453438444533... | 7 | 1 | 2025-04-14 22:25:28.327 | 2025-04-02 22:25:28.327 |
| 8 | Sofia Aguilar | sofia.aguilar755@alive.com | 8692-2798 | 0x686173685F45323484364533683763533452334144... | 8 | 1 | 2025-04-22 22:25:28.327 | 2025-02-06 22:25:28.327 |
| 9 | Alejandro Lopez | alejandro.lopez936@eslive.com | 8132-6520 | 0x686173685F46313139353742934303930394331323943... | 9 | 1 | 2025-04-05 22:25:28.327 | 2025-02-16 22:25:28.327 |
| 10 | Karla Aguilar | karla.aguilar459@eslive.com | 8592-8532 | 0x686173685F42437383423136393643113744343538... | 10 | 1 | 2025-04-09 22:25:28.327 | 2024-10-27 22:25:28.327 |
| 11 | Adrian Aguilar | adrian.aguilar240@alive.com | 8354-7158 | 0x686173685F383131433143341354444332414539... | 11 | 1 | 2025-04-22 22:25:28.327 | 2024-10-18 22:25:28.327 |
| 12 | Alejandro Aguilar | alejandro.aguilar392@outlook.com | 8319-7875 | 0x686173685F34393945303834633444134413123293044... | 12 | 1 | 2025-04-26 22:25:28.327 | 2025-03-14 22:25:28.327 |
| 13 | Ana Vargas | ana.vargas168@yahoo.com | 8607-2885 | 0x686173685F44342434542363841343444433539330... | 13 | 1 | 2025-04-17 22:25:28.327 | 2025-03-28 22:25:28.327 |
| 14 | Isabel Aguilar | isabel.aguilar931@alive.com | 8471-7828 | 0x686173685F3335446313134341343443344534146... | 14 | 1 | 2025-04-06 22:25:28.327 | 2025-04-01 22:25:28.327 |
| 15 | Carlos Sanchez | carlos.sanchez725@icloud.com | 8102-4628 | 0x686173685F383939303534393633533243573846384230... | 15 | 1 | 2025-04-09 22:25:28.327 | 2025-02-09 22:25:28.327 |
| 16 | Alejandro Rick | alejandro.rick452@gmail.com | 8571-8040 | 0x686173685F44436434435039383241313843434534746... | 16 | 1 | 2025-04-28 22:25:28.327 | 2025-01-17 22:25:28.327 |
| 17 | David Gomez | david.gomez100@outlook.com | 8150-9313 | 0x686173685F3234543743381383413841373834230... | 17 | 1 | 2025-04-24 22:25:28.330 | 2024-10-18 22:25:28.330 |
| 18 | Jorge Ramirez | jorge.ramirez481@icloud.com | 8257-7883 | 0x686173685F4450423132437543131443132930358... | 18 | 1 | 2025-04-22 22:25:28.330 | 2025-03-25 22:25:28.330 |
| 19 | Alejandro Fernandez | alejandro.fernandez778@eslive... | 8951-7076 | 0x686173685F3437363324537383630464573630303936... | 19 | 1 | 2025-04-23 22:25:28.330 | 2025-02-05 22:25:28.330 |
| 20 | Ricardo Ortiz | ricardo.ortiz387@outlook.com | 8286-5225 | 0x686173685F3833354393834246414653942345245... | 20 | 1 | 2025-04-17 22:25:28.330 | 2024-11-28 22:25:28.330 |
| 21 | Daniel Aguilar | daniel.aguilar152@yahoo.com | 8774-1447 | 0x686173685F343334135423931342303134231344... | 21 | 1 | 2025-04-08 22:25:28.330 | 2025-02-23 22:25:28.330 |
| 22 | Alejandro Cruz | alejandro.cruz510@icloud.com | 8332-6540 | 0x686173685F383938433754443446344441359330343236... | 22 | 1 | 2025-04-23 22:25:28.330 | 2024-12-21 22:25:28.330 |
| 23 | Monica Rodriguez | monica.rodriguez126@outlook.c... | 8781-1978 | 0x686173685F30363945383433324125263043393134231... | 23 | 1 | 2025-04-18 22:25:28.330 | 2025-01-09 22:25:28.330 |
| 24 | Jorge Hurtado | jorge.hurtado872@icloud.com | 8461-0969 | 0x686173685F31304543433714836353263134641... | 24 | 1 | 2025-04-12 22:25:28.330 | 2025-02-21 22:25:28.330 |
| 25 | Alejandro Aguilar | alejandro.aguilar43@eslive.com | 8664-7545 | 0x686173685F3044424241384454632328423242383534... | 25 | 1 | 2025-04-22 22:25:28.330 | 2024-12-08 22:25:28.330 |
| 26 | Maria Fernandez | maria.fernandez289@eslive.com | 8570-6453 | 0x686173685F37453945393535734374231353337430... | 26 | 1 | 2025-04-24 22:25:28.330 | 2024-10-30 22:25:28.330 |
| 27 | Ferran Ramirez | ferran.ramirez878@gmail.com | 8913-7737 | 0x686173685F371363034354662323043313637945... | 27 | 1 | 2025-04-19 22:25:28.330 | 2025-01-18 22:25:28.330 |
| 28 | Ana Aguilar | ana.aguilar342@icloud.com | 8809-6016 | 0x686173685F46353843363731243363742463630304335... | 28 | 1 | 2025-05-04 22:25:28.330 | 2025-02-10 22:25:28.330 |
| 29 | Lamine Vargas | lamine.vargas607@eslive.com | 8897-2978 | 0x686173685F41373642434435433744454143731331... | 29 | 1 | 2025-04-13 22:25:28.330 | 2024-12-19 22:25:28.330 |
| 30 | Luis Aguilar | luis.aguilar316@eslive.com | 8202-5174 | 0x686173685F32136363831454633333393423034137471... | 30 | 1 | 2025-04-13 22:25:28.330 | 2025-04-04 22:25:28.330 |

#### Usuarios con Suscripciones
Aqui definimos diversas suscripciones para cada uno de los usuarios, esto manteniendo la regla de que hayan 25 usuarios con suscripcion activa y 5 con una suscripcion no activa, ademas de esto aseguramos que para cada plan haya aproximadamente entre 3 a 4 personas.

``` sql
DROP PROCEDURE IF EXISTS FillSocaiSubscriptions;
GO

CREATE PROCEDURE FillSocaiSubscriptions
AS

BEGIN
    -- Ok aqui definimos las variables para control
    DECLARE @total_active_subscriptions INT = 25;
    DECLARE @total_inactive_subscriptions INT = 5;
    DECLARE @current_plan INT = 2; -- Los planes comienzan en ID 2 debido a que cuando los generamos empezaron en 2
    DECLARE @max_plan INT = 9; -- Ultimo id son 8 planees en total
    DECLARE @subscriptions_per_plan INT;
    DECLARE @subscriptions_left INT;
    DECLARE @users_assigned TABLE (UserId INT);
    DECLARE @available_users TABLE (UserId INT);
    DECLARE @user_to_assign INT;
    DECLARE @active_user_count INT = 0;
    DECLARE @inactive_user_count INT = 0;
    DECLARE @rand_start_date DATETIME;
    DECLARE @rand_end_date DATETIME;
    
    -- Obtener todos los usuarios disponibles actualmente que son 30
    INSERT INTO @available_users (UserId)
    SELECT UserId FROM SocaiUsers ORDER BY UserId;
    
    -- Distribuimos suscripciones activas entre los planes
    -- iniciar con todos los planes teniendo 3 suscripciones
    WHILE @current_plan <= @max_plan

    BEGIN
        -- Asignar entre 3 y 6 suscripciones por plan esto para que no se acaben de un solo
        -- Pero no mas de las que quedan disponibles
        SET @subscriptions_left = @total_active_subscriptions - @active_user_count;
        
        -- Si este el ultimo plan, asignar todas las suscripciones restantes
        IF @current_plan = @max_plan AND @subscriptions_left > 0

        BEGIN
            SET @subscriptions_per_plan = @subscriptions_left;
        END

        ELSE

        BEGIN
            -- Calcular cuantas suscripciones quedan por plan
            DECLARE @remaining_plans INT = @max_plan - @current_plan + 1;
            DECLARE @min_per_remaining_plan INT = @subscriptions_left / @remaining_plans;
            
            -- Asignar entre 3 y 6, pero no menos de lo minimo necesario
            SET @subscriptions_per_plan = 
                CASE 
                    WHEN @min_per_remaining_plan <= 3 THEN 3
                    WHEN @min_per_remaining_plan >= 6 THEN 6
                    ELSE @min_per_remaining_plan
                END;
                
            -- Pero nunca mas de lo que queda disponible como tal
            IF @subscriptions_per_plan > @subscriptions_left
                SET @subscriptions_per_plan = @subscriptions_left;
        END
        
        -- Asignar suscripciones para este plan
        DECLARE @i INT = 0;
        WHILE @i < @subscriptions_per_plan
        BEGIN

            -- Seleccionar un usuario aleatorio no asignado aun
            SELECT TOP 1 @user_to_assign = UserId 
            FROM @available_users 
            ORDER BY NEWID();
            
            -- Generar fechas aleatorias para la suscripción activa
            -- Generar fechas aleatorias para la suscripción activa
            SET @rand_start_date = DATEADD(DAY, -FLOOR(RAND() * 25), GETDATE()); -- Inicio en los ultimos 30 dias
            SET @rand_end_date = DATEADD(DAY, 30, @rand_start_date); -- 30 días de suscripcion
            
            -- Insertar la suscripción activa
            INSERT INTO SocaiSubscriptionUser (enable, startDateTime, endDateTime, UserId, SubscriptionId)
            VALUES (1, @rand_start_date, @rand_end_date, @user_to_assign, @current_plan);
            
            -- Registrar el usuario como asignado
            INSERT INTO @users_assigned (UserId) VALUES (@user_to_assign);
            
            -- Eliminar el usuario de los disponibles
            DELETE FROM @available_users WHERE UserId = @user_to_assign;
            
            SET @i = @i + 1;
            SET @active_user_count = @active_user_count + 1;
        END
        
        SET @current_plan = @current_plan + 1;
    END
    
    -- Asignamos 5 suscripciones inactivas a usuarios no asignados aun
    WHILE @inactive_user_count < @total_inactive_subscriptions
    BEGIN

        -- Seleccionamos un usuario aleatorio no asignado aun
        SELECT TOP 1 @user_to_assign = UserId 
        FROM @available_users 
        ORDER BY NEWID();
        
        -- Generar fechas aleatorias para la suscripcion inactiva que existe
        SET @rand_start_date = DATEADD(DAY, -FLOOR(60 + RAND() * 30), GETDATE()); -- Inicio hace 60-90 dias
        SET @rand_end_date = DATEADD(DAY, 30, @rand_start_date); --  30 dias de suscripción, ya venció
        
        -- Seleccionar un plan aleatorio
        DECLARE @random_plan INT = FLOOR(2 + RAND() * 7); -- Entre 2 y 8 que son los plenes
        
        -- Insertar la suscripcion inactiva
        INSERT INTO SocaiSubscriptionUser (enable, startDateTime, endDateTime, UserId, SubscriptionId)
        VALUES (0, @rand_start_date, @rand_end_date, @user_to_assign, @random_plan);
        
        -- Eliminar el usuario de los disponibles
        DELETE FROM @available_users WHERE UserId = @user_to_assign;
        
        SET @inactive_user_count = @inactive_user_count + 1;
    END
    
END;
GO

-- Ejecutar el procedimiento
EXEC FillSocaiSubscriptions;
GO

```
Ahora en este apartado vamos a hacer una verificacion de los datos propuestos con el procedure.

``` sql
-- Verificamos los resultados 
SELECT su.SubscriptionUserId, su.UserId, u.Name AS UserName, 
       su.SubscriptionId, s.Name AS PlanName, 
       su.enable AS Estado, 
       CONVERT(VARCHAR, su.startDateTime, 103) AS FechaInicio, 
       CONVERT(VARCHAR, su.endDateTime, 103) AS FechaFin,
       DATEDIFF(DAY, su.startDateTime, su.endDateTime) AS DuracionDias
FROM SocaiSubscriptionUser su
JOIN SocaiUsers u ON su.UserId = u.UserId
JOIN SocaiSubscriptions s ON su.SubscriptionId = s.SubscriptionId
ORDER BY s.SubscriptionId, su.enable DESC;
```
| SubscriptionUserId | UserId | UserName | SubscriptionId | PlanName | Estado | FechaInicio | FechaFin | DuracionDias |
|-------------------|--------|----------|----------------|----------|--------|-------------|----------|--------------|
| 1 | 8 | Sofia Aguilar | 2 | Profesional Joven | 1 | 19/04/2025 | 19/05/2025 | 30 |
| 2 | 4 | Alejandro Aguilar | 2 | Profesional Joven | 1 | 21/04/2025 | 21/05/2025 | 30 |
| 3 | 3 | Alejandro Vargas | 2 | Profesional Joven | 1 | 02/05/2025 | 01/06/2025 | 30 |
| 26 | 5 | Alejandro Avila | 2 | Profesional Joven | 0 | 07/02/2025 | 09/03/2025 | 30 |
| 4 | 17 | David Gomez | 3 | Familia Moderna | 1 | 14/04/2025 | 14/05/2025 | 30 |
| 5 | 12 | Alejandro Aguilar | 3 | Familia Moderna | 1 | 13/04/2025 | 13/05/2025 | 30 |
| 6 | 10 | Karla Aguilar | 3 | Familia Moderna | 1 | 12/04/2025 | 12/05/2025 | 30 |
| 28 | 9 | Alejandro Lopez | 3 | Familia Moderna | 0 | 17/02/2025 | 19/03/2025 | 30 |
| 7 | 26 | Maria Fernandez | 4 | Ejecutivo Premium | 1 | 21/04/2025 | 21/05/2025 | 30 |
| 8 | 25 | Alejandro Aguilar | 4 | Ejecutivo Premium | 1 | 15/04/2025 | 15/05/2025 | 30 |
| 9 | 18 | Natalia Aguilar | 4 | Ejecutivo Premium | 1 | 30/04/2025 | 30/05/2025 | 30 |
| 10 | 16 | Alejandro Rick | 5 | Entusiasta al Gym | 1 | 22/04/2025 | 22/05/2025 | 30 |
| 11 | 14 | Isabel Aguilar | 5 | Entusiasta al Gym | 1 | 16/04/2025 | 16/05/2025 | 30 |
| 12 | 15 | Carlos Sanchez | 5 | Entusiasta al Gym | 1 | 22/04/2025 | 22/05/2025 | 30 |
| 27 | 20 | Ricardo Ortiz | 5 | Entusiasta al Gym | 0 | 20/02/2025 | 22/03/2025 | 30 |
| 13 | 29 | Lamine Vargas | 6 | Movilidad Urbana | 1 | 20/04/2025 | 20/05/2025 | 30 |
| 14 | 24 | Alejandro Aguilar | 6 | Movilidad Urbana | 1 | 10/04/2025 | 10/05/2025 | 30 |
| 15 | 11 | Adrian Aguilar | 6 | Movilidad Urbana | 1 | 25/04/2025 | 25/05/2025 | 30 |
| 30 | 2 | Daniel Aguilar | 6 | Movilidad Urbana | 0 | 16/02/2025 | 18/03/2025 | 30 |
| 16 | 13 | Ana Vargas | 7 | Amante de Mascotas | 1 | 01/05/2025 | 31/05/2025 | 30 |
| 17 | 21 | Ricardo Aguilar | 7 | Amante de Mascotas | 1 | 02/05/2025 | 01/06/2025 | 30 |
| 18 | 22 | Alejandro Cruz | 7 | Amante de Mascotas | 1 | 28/04/2025 | 28/05/2025 | 30 |
| 29 | 27 | Daniel Ramirez | 7 | Amante de Mascotas | 0 | 09/02/2025 | 11/03/2025 | 30 |
| 19 | 30 | Luis Aguilar | 8 | Hogar y Cuidado | 1 | 18/04/2025 | 18/05/2025 | 30 |
| 20 | 1 | Pedro Aguilar | 8 | Hogar y Cuidado | 1 | 30/04/2025 | 30/05/2025 | 30 |
| 21 | 23 | Monica Rodriguez | 8 | Hogar y Cuidado | 1 | 04/05/2025 | 03/06/2025 | 30 |
| 22 | 7 | Ferran Fernandez | 9 | Amante de la Gastronomía | 1 | 18/04/2025 | 18/05/2025 | 30 |
| 23 | 6 | Carolina Gomez | 9 | Amante de la Gastronomía | 1 | 03/05/2025 | 02/06/2025 | 30 |
| 24 | 28 | Ana Aguilar | 9 | Amante de la Gastronomía | 1 | 04/05/2025 | 03/06/2025 | 30 |
| 25 | 19 | Alejandro Fernandez | 9 | Amante de la Gastronomía | 1 | 22/04/2025 | 22/05/2025 | 30 |

En dicha tabla podemos observar el plan que le corresponde a cada usuario, esto ademas de que hay 25 suscripciones activas y 5 desactivadas. Ahora bien vamos con la tabla de la distribucion de suscripciones por plan.

``` sql
-- Aqui seria la distribucion de suscripciones por plan
SELECT s.SubscriptionId, s.Name AS PlanName, 
       COUNT(su.SubscriptionUserId) AS TotalSuscripciones,
       SUM(CAST(su.enable AS INT)) AS SuscripcionesActivas
FROM SocaiSubscriptions s
LEFT JOIN SocaiSubscriptionUser su ON s.SubscriptionId = su.SubscriptionId
GROUP BY s.SubscriptionId, s.Name
ORDER BY s.SubscriptionId;
GO

```
| SubscriptionId | PlanName | TotalSuscripciones | SuscripcionesActivas |
|---------------|----------|---------------------|----------------------|
| 2 | Profesional Joven | 4 | 3 |
| 3 | Familia Moderna | 4 | 3 |
| 4 | Ejecutivo Premium | 3 | 3 |
| 5 | Entusiasta al Gym | 4 | 3 |
| 6 | Movilidad Urbana | 4 | 3 |
| 7 | Amante de Mascotas | 4 | 3 |
| 8 | Hogar y Cuidado | 3 | 3 |
| 9 | Amante de la Gastronomía | 4 | 4 |


## 2. Demostraciones T-SQL (uso de instrucciones específicas) (Chris)
En esta parte de los queries vamos a asegurarnos de usar las instrucciones especificas de: cursor global&local, trigger, sp_recompile, MERGE, COALESCE, SUBSTRING, LTRIM, AVG, TOP, &&, SCHEMABINDING, with encryption, execute as, union y distinct.

Primeramente veamos a Cursor Local y Global.

#### Cursor Local

Este cursor recorre las suscripciones que vencerán en los próximos 7 días y genera mensajes personalizados. Al ser un cursor LOCAL, solo estará disponible en la sesión donde se creó y no podrá ser accedido desde otras conexiones, lo cual es importante para la gestión de recursos y la seguridad.

``` sql
-- Cursor local -----

---Suscripcion Proxima a vencer con un mensaje o notificacion ---

DECLARE @nombreUsuario VARCHAR(250)
DECLARE @email VARCHAR(220)
DECLARE @nombrePlan VARCHAR(100)
DECLARE @fechaVencimiento DATETIME
DECLARE @mensaje VARCHAR(500)

-- Declaramos el cursor local
DECLARE cursor_local_demo CURSOR LOCAL FOR 

SELECT 
    u.Name AS NombreUsuario, 
    u.Email,
    s.Name AS NombrePlan, 
    su.endDateTime AS FechaVencimiento

FROM SocaiSubscriptionUser su
JOIN SocaiUsers u ON su.UserId = u.UserId
JOIN SocaiSubscriptions s ON su.SubscriptionId = s.SubscriptionId

WHERE 
    su.enable = 1 AND 
    su.endDateTime BETWEEN GETDATE() AND DATEADD(DAY, 7, GETDATE());

-- Abrimos el cursor
OPEN cursor_local_demo

-- Obtenemos la primera fila
FETCH NEXT FROM cursor_local_demo INTO @nombreUsuario, @email, @nombrePlan, @fechaVencimiento

-- ahora revisamos propiamente si hay datos
IF @@FETCH_STATUS = 0

BEGIN
    PRINT '===== NOTIFICACIONES DE SUSCRIPCIONES PRÓXIMAS A VENCER ====='
END

ELSE

BEGIN
    PRINT 'No hay suscripciones próximas a vencer en los próximos 7 días.'
END

-- Procesamos cada fila
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Crear mensaje personalizado de recordatorio
    SET @mensaje = 'NOTIFICACIÓN: Estimado/a ' + @nombreUsuario + 
                  ', su suscripción al plan "' + @nombrePlan + 
                  '" vence el ' + CONVERT(VARCHAR, @fechaVencimiento, 103) + 
                  '. Por favor renueve para seguir disfrutando de sus beneficios.';
    
    -- Esta seria una notificacion para verificar que el cursor funciono
    PRINT @mensaje
    
    -- Obtenemos la siguiente fila
    FETCH NEXT FROM cursor_local_demo INTO @nombreUsuario, @email, @nombrePlan, @fechaVencimiento
END

-- Cerramos y liberamos el cursor local 
CLOSE cursor_local_demo
DEALLOCATE cursor_local_demo

```
Este seria el mensaje que nos da el cursor local:
===== NOTIFICACIONES DE SUSCRIPCIONES PRÓXIMAS A VENCER =====
NOTIFICACIÓN: Estimado/a Alejandro Aguilar, su suscripción al plan "Familia Moderna" vence el 13/05/2025. Por favor renueve para seguir disfrutando de sus beneficios.
NOTIFICACIÓN: Estimado/a Karla Aguilar, su suscripción al plan "Familia Moderna" vence el 12/05/2025. Por favor renueve para seguir disfrutando de sus beneficios.
NOTIFICACIÓN: Estimado/a Alejandro Aguilar, su suscripción al plan "Movilidad Urbana" vence el 10/05/2025. Por favor renueve para seguir disfrutando de sus beneficios.

Hora de finalización: 2025-05-06T23:08:17.3280025-06:00

#### Cursor Global
Este cursor global simplemente lista los principales comercios por servicios ofrecidos.

``` sql
DECLARE @nombreComercio VARCHAR(225)
DECLARE @serviciosOfrecidos INT
DECLARE @contactoPrincipal VARCHAR(60)

-- Declarar cursor explicitamente como global para ser accesado en otras sesiones
DECLARE cursor_global_demo CURSOR GLOBAL FOR

SELECT 
    c.Name AS NombreComercio,
    COUNT(cf.CommercesFeaturesId) AS ServiciosOfrecidos,
    cp.Name AS ContactoPrincipal
FROM SocaiCommerces c
JOIN SocaiCommercesFeatures cf ON c.CommerceId = cf.CommercesId
LEFT JOIN SocaiCommerceContactPerson cp ON c.CommerceId = cp.CommerceId
WHERE c.IsActive = 1
GROUP BY c.Name, cp.Name
ORDER BY COUNT(cf.CommercesFeaturesId) DESC;

-- Abrir el cursor
OPEN cursor_global_demo

-- Obtenemos la primera fila con fetch
FETCH NEXT FROM cursor_global_demo INTO @nombreComercio, @serviciosOfrecidos, @contactoPrincipal

-- Comprobamos si hay datos
IF @@FETCH_STATUS = 0

BEGIN
    PRINT '===== Comercicos con mas servicios ofrecidos ====='
END

ELSE

BEGIN
    PRINT 'No se encontraron comercios con servicios activos.'
END

-- Procesamos cada fila
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Comercio: ' + @nombreComercio + 
          ' | Servicios: ' + CAST(@serviciosOfrecidos AS VARCHAR) + 
          ' | Contacto: ' + ISNULL(@contactoPrincipal, 'No asignado');
    
    -- Obtenemos la siguiente fila
    FETCH NEXT FROM cursor_global_demo INTO @nombreComercio, @serviciosOfrecidos, @contactoPrincipal
END

-- Cerrar el cursor pero no usamos deallocate esto para demostrar que sigue siendo accesible
CLOSE cursor_global_demo

```
Este seria el mensaje que nos da el cursor global:

===== Comercicos con mas servicios ofrecidos =====
Comercio: The Spa | Servicios: 4 | Contacto: Ana Vargas
Comercio: Crunch Fitness | Servicios: 3 | Contacto: Carlos Rodriguez
Comercio: Salud Integral Beneficiada | Servicios: 3 | Contacto: Carmen Blanco
Comercio: HogarCleaner | Servicios: 3 | Contacto: Lucia Campos
Comercio: PetCare | Servicios: 3 | Contacto: Roberto Mendez
Comercio: Gasolinera YAM | Servicios: 2 | Contacto: Miguel Soto
Comercio: UberEats | Servicios: 2 | Contacto: Daniel Herrera
Comercio: Fit Center Oxigeno | Servicios: 2 | Contacto: Gabriela Mora
Comercio: Barberia Paco | Servicios: 2 | Contacto: Jose Castro
Comercio: YogaLife | Servicios: 1 | Contacto: Patricia Jimenez

Hora de finalización: 2025-05-06T23:10:10.1842568-06:00

#### Trigger, Substring, Ltrim, Coalesce, Top y Distinct 
En esta consulta de instruccion especifica usando las tablas de  SocaiLogs y SocaiTransactions creamos el trigger para registrar transacciones de pago en la tabla de logs existente. 

Aqui una pequena descripcion de que hace cadainstruccion:

1. TRIGGER: Implementado para SocaiPayments
2. SUBSTRING: Utilizado para truncar descripciones
3. LTRIM: Utilizado para limpiar espacios iniciales
4. COALESCE: Utilizado para manejar valores nulos
5. TOP: Utilizado para limitar resultados
6. DISTINCT: Utilizado para obtener valores únicos

``` sql
DROP TRIGGER IF EXISTS trg_SocaiPayments_Insert;
GO

CREATE TRIGGER trg_SocaiPayments_Insert
ON SocaiPayments
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Variables para el mensaje de log
    DECLARE @paymentMethod VARCHAR(30)
    DECLARE @logMessage VARCHAR(500)
    DECLARE @transactionId INT
    
    -- TOP: Obtener solo los 5 métodos de pago más utilizados
    DECLARE @topPaymentMethods VARCHAR(200) = '';
    
    -- Versión simplificada que evita el problema de ORDER BY en subconsulta
    SELECT TOP 5 @topPaymentMethods = @topPaymentMethods + pm.name + ', '
    FROM SocaiPaymentMethods pm
    JOIN SocaiPayments p ON pm.PaymentMethodId = p.PaymentMethodId
    GROUP BY pm.name, pm.PaymentMethodId
    ORDER BY COUNT(*) DESC;
    
    -- Quitar la última coma
    IF LEN(@topPaymentMethods) > 0
        SET @topPaymentMethods = LEFT(@topPaymentMethods, LEN(@topPaymentMethods) - 1);
    
    -- Para cada pago, crear transacción y log asociado
    INSERT INTO SocaiTransactions (
        amount,
        description,
        transactionDateTime,
        postTime,
        referenceNumber,
        checksum,
        TransactionTypeId,
        TransactionSubTypeId,
        CurrencyTypeId,
        PaymentId,
        UserId,
        ExchangeRateId
    )
    SELECT 
        COALESCE(i.actualAmount, i.amount, 0),  -- COALESCE: Manejo de valores nulos
        'Transacción generada a partir de pago ID: ' + CAST(i.PaymentId AS VARCHAR),
        GETDATE(),
        GETDATE(),
        LTRIM(i.reference),  -- LTRIM: Eliminar espacios al inicio
        i.checksum,
        0,  -- TransactionTypeId = 0 (Pago)
        0,  -- TransactionSubTypeId = 0 (Tarjeta de Crédito)
        i.CurrencyTypeId,
        i.PaymentId,
        i.UserId,
        1  -- CurrencyExchangeId = 1
    FROM inserted i;
    
    -- Obtener el ID de la transacción recién creada
    SET @transactionId = SCOPE_IDENTITY();
    
    -- Insertar en la tabla de logs
    INSERT INTO SocaiLogs (
        description,
        postTime,
        computer,
        username,
        trace,
        referenceID1,
        referenceID2,
        value1,
        value2,
        checksum,
        lastUpdate,
        LogTypeId,
        LogSourceId,
        LogSeverityId,
        UserId,
        TransactionId
    )
    SELECT 
        -- SUBSTRING: Limitar longitud del mensaje a 200 caracteres
        SUBSTRING(
            'Pago registrado: Usuario ID ' + CAST(i.UserId AS VARCHAR) + 
            ' realizó pago de ' + CAST(COALESCE(i.actualAmount, i.amount, 0) AS VARCHAR) + 
            ' usando ' + (SELECT pm.name FROM SocaiPaymentMethods pm WHERE pm.PaymentMethodId = i.PaymentMethodId),
            1, 200),
        GETDATE(),
        HOST_NAME(),
        SYSTEM_USER,
        'Trigger: trg_SocaiPayments_Insert',
        i.PaymentId,
        @transactionId,
        (SELECT pm.name FROM SocaiPaymentMethods pm WHERE pm.PaymentMethodId = i.PaymentMethodId),
        CAST(COALESCE(i.actualAmount, i.amount, 0) AS VARCHAR),  -- COALESCE: Otra vez
        i.checksum,
        GETDATE(),
        3,  -- LogTypeId = 3 (Transacción)
        0,  -- LogSourceId = 0 (Sistema)
        0,  -- LogSeverityId = 0 (Baja)
        i.UserId,
        @transactionId
    FROM inserted i;
    
    -- Mensaje de depuración
    SET @paymentMethod = (SELECT TOP 1 pm.name FROM SocaiPaymentMethods pm 
                          JOIN inserted i ON pm.PaymentMethodId = i.PaymentMethodId);
                          
    SET @logMessage = 'Trigger ejecutado: Se registró un nuevo pago con método ' + 
                      COALESCE(@paymentMethod, 'Desconocido') + -- COALESCE: Para valor predeterminado
                      ' y se generó la transacción ID: ' + CAST(@transactionId AS VARCHAR);
                      
    PRINT @logMessage;
END;
GO

PRINT 'Trigger trg_SocaiPayments_Insert creado exitosamente';

-- 2. Script para llenar datos de prueba
-- Crear DataPayments para diferentes usuarios
DECLARE @userCount INT;
SELECT @userCount = COUNT(*) FROM SocaiUsers;

-- Solo procesamos hasta 5 usuarios para no crear demasiados registros
DECLARE @usersToProcess INT = CASE WHEN @userCount > 5 THEN 5 ELSE @userCount END;
DECLARE @currentUser INT = 1;
DECLARE @methods TABLE (PaymentMethodId INT);

-- Obtenemos los IDs de métodos de pago existentes
INSERT INTO @methods
SELECT PaymentMethodId FROM SocaiPaymentMethods WHERE enable = 1;

WHILE @currentUser <= @usersToProcess
BEGIN
    -- Para cada usuario, creamos 2-3 métodos de pago diferentes
    DECLARE @methodCursor CURSOR;
    DECLARE @methodId INT;
    
    SET @methodCursor = CURSOR FOR
    SELECT PaymentMethodId FROM @methods
    WHERE PaymentMethodId IN (0, 1, 2, 6, 9) -- Visa, Mastercard, Amex, PayPal, SINPE
    ORDER BY NEWID();
    
    OPEN @methodCursor;
    FETCH NEXT FROM @methodCursor INTO @methodId;
    
    DECLARE @methodCount INT = 0;
    
    WHILE @@FETCH_STATUS = 0 AND @methodCount < 3
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM SocaiDataPayments 
                      WHERE UserId = @currentUser AND PaymentMethodId = @methodId)
        BEGIN
            INSERT INTO SocaiDataPayments (name, token, expToken, maskAccount, UserId, PaymentMethodId)
            VALUES (
                CASE 
                    WHEN @methodId = 0 THEN 'Visa Personal'
                    WHEN @methodId = 1 THEN 'Mastercard Principal'
                    WHEN @methodId = 2 THEN 'American Express Gold'
                    WHEN @methodId = 6 THEN 'Cuenta PayPal'
                    WHEN @methodId = 9 THEN 'SINPE Movil'
                    ELSE 'Método de pago ' + CAST(@methodId AS VARCHAR)
                END, 
                CAST('token_' + CAST(@currentUser AS VARCHAR) + '_' + CAST(@methodId AS VARCHAR) AS VARBINARY(255)), 
                DATEADD(YEAR, 1, GETDATE()), 
                CAST('****' + RIGHT('1000' + CAST((@currentUser * 10 + @methodId) AS VARCHAR), 4) AS VARBINARY(255)), 
                @currentUser, 
                @methodId
            );
            
            PRINT 'DataPayment creado: Usuario ' + CAST(@currentUser AS VARCHAR) + 
                  ', Método ' + CAST(@methodId AS VARCHAR);
            
            SET @methodCount = @methodCount + 1;
        END
        
        FETCH NEXT FROM @methodCursor INTO @methodId;
    END
    
    CLOSE @methodCursor;
    DEALLOCATE @methodCursor;
    
    SET @currentUser = @currentUser + 1;
END

PRINT 'Datos de pago adicionales creados';

-- 3. Insertar múltiples pagos para probar el trigger
DECLARE @paymentsToInsert INT = 15;
DECLARE @paymentCounter INT = 1;
DECLARE @randomUser INT;
DECLARE @randomMethod INT;
DECLARE @dataPaymentId INT;
DECLARE @resultPaymentId INT;
DECLARE @randomAmount INT;

-- Primero verificamos que exista al menos un ResultPaymentId
IF NOT EXISTS (SELECT 1 FROM SocaiResultPayment)
BEGIN
    INSERT INTO SocaiResultPayment (name, description)
    VALUES ('Exitoso', 'Pago procesado exitosamente');
    PRINT 'Resultado de pago creado';
END

SELECT TOP 1 @resultPaymentId = ResultPaymentId FROM SocaiResultPayment;

WHILE @paymentCounter <= @paymentsToInsert
BEGIN
    -- Seleccionar un usuario aleatorio
    SELECT TOP 1 @randomUser = UserId 
    FROM SocaiUsers 
    ORDER BY NEWID();
    
    -- Seleccionar un método de pago aleatorio de los existentes
    SELECT TOP 1 @randomMethod = PaymentMethodId 
    FROM SocaiPaymentMethods 
    WHERE enable = 1 AND PaymentMethodId IN (0, 1, 2, 6, 9) -- Usar métodos populares
    ORDER BY NEWID();
    
    -- Buscar un DataPaymentId para este usuario y método
    SELECT TOP 1 @dataPaymentId = DataPaymentId
    FROM SocaiDataPayments
    WHERE UserId = @randomUser AND PaymentMethodId = @randomMethod;
    
    -- Si no existe, lo creamos
    IF @dataPaymentId IS NULL
    BEGIN
        INSERT INTO SocaiDataPayments (name, token, expToken, maskAccount, UserId, PaymentMethodId)
        VALUES (
            CASE 
                WHEN @randomMethod = 0 THEN 'Visa Personal'
                WHEN @randomMethod = 1 THEN 'Mastercard Principal'
                WHEN @randomMethod = 2 THEN 'American Express Gold'
                WHEN @randomMethod = 6 THEN 'Cuenta PayPal'
                WHEN @randomMethod = 9 THEN 'SINPE Movil'
                ELSE 'Método de pago ' + CAST(@randomMethod AS VARCHAR)
            END, 
            CAST('token_auto_' + CAST(@paymentCounter AS VARCHAR) AS VARBINARY(255)), 
            DATEADD(YEAR, 1, GETDATE()), 
            CAST('****' + RIGHT('1000' + CAST((@randomUser * 10 + @randomMethod) AS VARCHAR), 4) AS VARBINARY(255)), 
            @randomUser, 
            @randomMethod
        );
        
        SET @dataPaymentId = SCOPE_IDENTITY();
        PRINT 'Nuevo DataPayment creado para usuario ' + CAST(@randomUser AS VARCHAR) + 
              ', método ' + CAST(@randomMethod AS VARCHAR);
    END
    
    -- Monto aleatorio entre 10,000 y 100,000
    SET @randomAmount = 10000 + (CAST(RAND() * 90000 AS INT));
    
    -- Insertar el pago - esto activará el trigger
    BEGIN TRY
        INSERT INTO SocaiPayments (
            amount, actualAmount, authentication, reference, chargeToken, date,
            checksum, DataPaymentId, PaymentMethodId, UserId, ResultPaymentId, CurrencyTypeId
        )
        VALUES (
            @randomAmount, 
            @randomAmount, 
            'AUTH' + RIGHT('00000' + CAST(@paymentCounter AS VARCHAR), 5), 
            '   REF-' + CAST(@paymentCounter AS VARCHAR) + '-' + CONVERT(VARCHAR(8), GETDATE(), 112) + '   ', -- Espacios para probar LTRIM 
            CAST('token_pay_' + CAST(@paymentCounter AS VARCHAR) AS VARBINARY(250)), 
            DATEADD(MINUTE, -@paymentCounter * 10, GETDATE()), -- Pagos distribuidos en el tiempo
            CAST('checksum_' + CAST(@paymentCounter AS VARCHAR) AS VARBINARY(250)), 
            @dataPaymentId, 
            @randomMethod, 
            @randomUser, 
            @resultPaymentId, 
            0 -- Usar el CurrencyTypeId 0
        );
        
        PRINT 'Pago #' + CAST(@paymentCounter AS VARCHAR) + ' insertado para usuario ' + CAST(@randomUser AS VARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar pago #' + CAST(@paymentCounter AS VARCHAR) + ': ' + ERROR_MESSAGE();
    END CATCH
    
    SET @paymentCounter = @paymentCounter + 1;
END
```
Ok ahora que tenemos la generacion de pagos realizada junto con la asignacion a usuarios realizaramos unas verificaciones de que se hayan ejecutado estas instrucciones.

#### TOP
Vamos a ver los ultimos 5 logs creados.

``` sql
PRINT '=== TOP: Últimos 5 logs creados ===';
SELECT TOP 5 LogId, description, postTime, value1, value2, UserId, TransactionId
FROM SocaiLogs
ORDER BY postTime DESC;
```

| LogId | description                                   | post Time                  | value1          | value2 | UserId | TransactionId |
|-------|----------------------------------------------|----------------------------|-----------------|--------|--------|---------------|
| 58    | Page registrado: Usuario ID 15 realizó pago de 3.. | 2025-05-06 23:16:38.413 | PayPal          | 36242  | 15     | 33            |
| 55    | Page registrado: Usuario ID 5 realizó pago de 75.. | 2025-05-06 23:16:38.410 | Mastercard      | 75899  | 5      | 30            |
| 56    | Page registrado: Usuario ID 7 realizó pago de 73.. | 2025-05-06 23:16:38.410 | American Express | 73857  | 7      | 31            |
| 57    | Page registrado: Usuario ID 22 realizó pago de 3.. | 2025-05-06 23:16:38.410 | Visa            | 34401  | 22     | 32            |
| 53    | Page registrado: Usuario ID 7 realizó pago de 39.. | 2025-05-06 23:16:38.407 | American Express | 39274  | 7      | 28            |

#### DISTINCT
Ver métodos de pago únicos utilizados en el sistema.

``` sql
PRINT '=== DISTINCT: Métodos de pago únicos utilizados ===';
SELECT DISTINCT pm.name AS 'Método de Pago'
FROM SocaiPayments p
JOIN SocaiPaymentMethods pm ON p.PaymentMethodId = pm.PaymentMethodId
ORDER BY pm.name;
```

|    | Método de Pago  |
|---|-----------------|
| 1 | American Express |
| 2 | Mastercard       |
| 3 | PayPal           |
| 4 | Visa             |

#### -- TOP y DISTINCT combinados
Vamos a mostrar los 3 usuarios con más transacciones.

``` sql
PRINT '=== TOP + DISTINCT: Top 3 usuarios con más transacciones ===';
SELECT TOP 3 u.Name AS 'Usuario', COUNT(DISTINCT t.TransactionId) AS 'Total de Transacciones'
FROM SocaiUsers u
JOIN SocaiTransactions t ON u.UserId = t.UserId
GROUP BY u.UserId, u.Name
ORDER BY COUNT(DISTINCT t.TransactionId) DESC;
```
| Usuario             | Total de Transacciones |
|---------------------|-----------------------|
| Alejandro Aguilar   | 3                     |
| Ferran Fernandez    | 2                     |
| Alejandro Lopez     | 1                     |

#### SUBSTRING
Lo usamos para demostrar texto truncado.

``` sql
PRINT '=== SUBSTRING: Descripción de transacciones truncada ===';
SELECT TransactionId, 
       SUBSTRING(description, 1, 30) + '...' AS 'Descripción Truncada',
       description AS 'Descripción Completa'
FROM SocaiTransactions
ORDER BY TransactionId DESC;
```
| #  | TransactionId | Descripción Truncada                    | Descripción Completa                        |
|----|--------------|----------------------------------------|---------------------------------------------|
| 1  | 33           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 34 |
| 2  | 32           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 33 |
| 3  | 31           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 32 |
| 4  | 30           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 31 |
| 5  | 29           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 30 |
| 6  | 28           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 29 |
| 7  | 27           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 28 |
| 8  | 26           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 27 |
| 9  | 25           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 26 |
| 10 | 24           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 25 |
| 11 | 23           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 24 |
| 12 | 22           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 23 |
| 13 | 21           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 22 |
| 14 | 20           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 21 |
| 15 | 19           | Transacción generada a partir ...       | Transacción generada a partir de pago ID. 20 |


#### LTRIM
Demostrar limpieza de espacios.

``` sql
PRINT '=== LTRIM: Referencias de pago sin espacios iniciales ===';
SELECT p.PaymentId, 
       '|' + p.reference + '|' AS 'Referencia Original',
       '|' + LTRIM(p.reference) + '|' AS 'Referencia sin Espacios Iniciales'
FROM SocaiPayments p
ORDER BY p.PaymentId DESC;
```
| #  | PaymentId | Reference Original      | Reference sin Espacios |
|----|-----------|-------------------------|------------------------|
| 1  | 34        | I REF-15-20250506       | IREF-15-20250506       |
| 2  | 33        | I REF-14-20250506       | IREF-14-20250506       |
| 3  | 32        | I REF-13-20250506       | IREF-13-20250506       |
| 4  | 31        | I REF-12-20250506       | IREF-12-20250506       |
| 5  | 30        | I REF-11-20250506       | IREF-11-20250506       |
| 6  | 29        | I REF-10-20250506       | IREF-10-20250506       |
| 7  | 28        | I REF-9-20250506        | IREF-9-20250506        |
| 8  | 27        | I REF-8-20250506        | IREF-8-20250506        |
| 9  | 26        | I REF-7-20250506        | IREF-7-20250506        |
| 10 | 25        | I REF-6-20250506        | IREF-6-20250506        |
| 11 | 24        | I REF-5-20250506        | IREF-5-20250506        |
| 12 | 23        | I REF-4-20250506        | IREF-4-20250506        |
| 13 | 22        | I REF-3-20250506        | IREF-3-20250506        |
| 14 | 21        | I REF-2-20250506        | IREF-2-20250506        |
| 15 | 20        | I REF-1-20250506        | IREF-1-20250506        |

#### COALESCE
Demostramos el manejo de valores nulos.

``` sql
PRINT '=== COALESCE: Manejo de valores nulos en montos ===';
SELECT p.PaymentId,
       p.amount AS 'Monto Original',
       p.actualAmount AS 'Monto Actual',
       COALESCE(p.actualAmount, p.amount, 0) AS 'Monto Final (con COALESCE)'
FROM SocaiPayments p
ORDER BY p.PaymentId DESC;

```
| #  | PaymentId | Monto Original | Monto Actual | Monto Final (con COALESCE) |
|----|-----------|---------------|--------------|----------------------------|
| 1  | 34        | 36242         | 36242        | 36242                      |
| 2  | 33        | 34401         | 34401        | 34401                      |
| 3  | 32        | 73857         | 73857        | 73857                      |
| 4  | 31        | 75899         | 75899        | 75899                      |
| 5  | 30        | 71324         | 71324        | 71324                      |
| 6  | 29        | 39274         | 39274        | 39274                      |
| 7  | 28        | 95069         | 95069        | 95069                      |
| 8  | 27        | 52276         | 52276        | 52276                      |
| 9  | 26        | 14798         | 14798        | 14798                      |
| 10 | 25        | 99824         | 99824        | 99824                      |
| 11 | 24        | 19791         | 19791        | 19791                      |
| 12 | 23        | 41900         | 41900        | 41900                      |
| 13 | 22        | 45408         | 45408        | 45408                      |
| 14 | 21        | 45408         | 45408        | 45408                      |
| 15 | 20        | 70433         | 70433        | 70433                      |

### SCHEMABINDING,  WITH ENCRYPTION, sp_recompile, AVG con agrupamiento, UNION, MERGE
Este seria el conjunto de instrucciones que usariamos para hacer un query de promedio de pagos por usuario.

1. SCHEMABINDING - Demostrado en la vista vw_PromedioPagosPorUsuario
2. WITH ENCRYPTION - Demostrado en los procedimientos SP_RegistrarRecompilacion y SP_RecompilacionPeriodica
3. sp_recompile - Implementado en el procedimiento de recompilación periódica
4. AVG con agrupamiento - Implementado en la vista a través de SUM/COUNT
5. UNION - Demostrado en la consulta de planes individuales y empresariales
6. MERGE - Demostrado en la sincronización de datos de suscripciones

``` sql
CREATE VIEW dbo.vw_PromedioPagosPorUsuario WITH SCHEMABINDING
AS
SELECT 
    u.UserId,
    u.Name AS NombreUsuario,
    COUNT_BIG(*) AS TotalPagos,
    SUM(ISNULL(p.amount, 0)) AS SumaTotal,
    COUNT_BIG(p.amount) AS ConteoValores,
    SUM(ISNULL(p.amount, 0)) AS MontoTotal
FROM 
    dbo.SocaiUsers u
    INNER JOIN dbo.SocaiPayments p ON u.UserId = p.UserId
GROUP BY 
    u.UserId, 
    u.Name;
GO

CREATE UNIQUE CLUSTERED INDEX IX_vw_PromedioPagosPorUsuario
ON dbo.vw_PromedioPagosPorUsuario(UserId);
GO

-- 2. Procedimiento para recompilar SP periódicamente (WITH ENCRYPTION)
CREATE OR ALTER PROCEDURE dbo.SP_RecompilacionProcedimientos
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Variables para el proceso
    DECLARE @SPName NVARCHAR(255);
    DECLARE @SQL NVARCHAR(500);
    DECLARE @Count INT = 0;
    DECLARE @LogMessage NVARCHAR(500);
    DECLARE @DummyTransactionId INT;
    
    -- Crear una transacción temporal para tener un ID de transacción
    -- Primero necesitamos obtener IDs válidos para las tablas relacionadas
    DECLARE @UserId INT = 1; -- Usar un ID de usuario existente
    DECLARE @PaymentId INT;
    DECLARE @PaymentMethodId INT = 1; -- Usar un ID de método de pago existente
    DECLARE @ResultPaymentId INT = 0; -- Usar un ID de resultado de pago existente
    DECLARE @CurrencyTypeId INT = 0; -- Usar un ID de moneda existente
    DECLARE @DataPaymentId INT;
    
    -- Verificar si existe un DataPaymentId para este usuario y método de pago
    SELECT TOP 1 @DataPaymentId = DataPaymentId 
    FROM SocaiDataPayments 
    WHERE UserId = @UserId AND PaymentMethodId = @PaymentMethodId;
    
    -- Si no existe, usar el primer DataPaymentId disponible
    IF @DataPaymentId IS NULL
    BEGIN
        SELECT TOP 1 @DataPaymentId = DataPaymentId 
        FROM SocaiDataPayments;
    END
    
    -- Crear una transacción temporal para tener un ID de transacción
    BEGIN TRANSACTION;
    
    -- Insertar un registro en SocaiPayments para obtener un PaymentId
    INSERT INTO SocaiPayments (
        amount, actualAmount, authentication, reference, chargeToken, date,
        checksum, DataPaymentId, PaymentMethodId, UserId, ResultPaymentId, CurrencyTypeId
    )
    VALUES (
        1.00, 1.00, 'RECOMPILE_AUTH', 'RECOMPILE_REF', 
        CAST('recompile_token' AS VARBINARY(250)), GETDATE(),
        CAST('recompile_checksum' AS VARBINARY(250)),
        @DataPaymentId, @PaymentMethodId, @UserId, @ResultPaymentId, @CurrencyTypeId
    );
    
    -- Obtener el PaymentId generado
    SET @PaymentId = SCOPE_IDENTITY();
    
    -- Insertar un registro en SocaiTransactions para obtener un TransactionId
    INSERT INTO SocaiTransactions (
        amount, description, transactionDateTime, postTime, referenceNumber,
        checksum, TransactionTypeId, TransactionSubTypeId, CurrencyTypeId,
        PaymentId, UserId, ExchangeRateId
    )
    VALUES (
        1.00, 'Transacción temporal para recompilación', GETDATE(), GETDATE(),
        'RECOMPILE_REF', CAST('recompile_checksum' AS VARBINARY(250)),
        0, 0, @CurrencyTypeId, @PaymentId, @UserId, 1
    );
    
    -- Obtener el TransactionId generado
    SET @DummyTransactionId = SCOPE_IDENTITY();
    
    -- Cursor para recorrer todos los procedimientos almacenados
    DECLARE SP_Cursor CURSOR FOR
        SELECT SCHEMA_NAME(schema_id) + '.' + name
        FROM sys.procedures
        WHERE is_ms_shipped = 0;
    
    OPEN SP_Cursor;
    FETCH NEXT FROM SP_Cursor INTO @SPName;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Ejecutar sp_recompile para el procedimiento actual
        BEGIN TRY
            SET @SQL = 'EXEC sp_recompile ''' + @SPName + '''';
            EXEC (@SQL);
            
            -- Registrar en SocaiLogs (tabla existente)
            SET @LogMessage = 'Procedimiento recompilado: ' + @SPName;
            
            INSERT INTO SocaiLogs (
                description, postTime, computer, username, trace, 
                LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId
            )
            VALUES (
                @LogMessage, GETDATE(), HOST_NAME(), SYSTEM_USER, 'SP_RecompilacionProcedimientos',
                3, 0, 0, @UserId, @DummyTransactionId
            );
            
            PRINT 'Object ''' + @SPName + ''' was successfully marked for recompilation.';
        END TRY
        BEGIN CATCH
            PRINT 'Error al recompilar ' + @SPName + ': ' + ERROR_MESSAGE();
        END CATCH
        
        SET @Count = @Count + 1;
        FETCH NEXT FROM SP_Cursor INTO @SPName;
    END

    CLOSE SP_Cursor;
    DEALLOCATE SP_Cursor;
    
    -- Registrar resumen en SocaiLogs
    SET @LogMessage = 'Recompilación completada. ' + CAST(@Count AS VARCHAR) + ' procedimientos recompilados.';
    
    INSERT INTO SocaiLogs (
        description, postTime, computer, username, trace, 
        LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId
    )
    VALUES (
        @LogMessage, GETDATE(), HOST_NAME(), SYSTEM_USER, 'SP_RecompilacionProcedimientos',
        3, 0, 0, @UserId, @DummyTransactionId
    );
    
    -- Finalizar la transacción
    COMMIT TRANSACTION;
    
    -- Mostrar estadísticas de pagos usando la vista con SCHEMABINDING
    SELECT TOP 5 
        NombreUsuario,
        TotalPagos,
        CASE 
            WHEN ConteoValores > 0 THEN SumaTotal / CAST(ConteoValores AS DECIMAL(18,2))
            ELSE 0 
        END AS MontoPagoPromedio,
        MontoTotal
    FROM dbo.vw_PromedioPagosPorUsuario
    ORDER BY MontoTotal DESC;
    
    PRINT @LogMessage;
END;
GO

-- 3. Ejecutar la recompilación para probar
EXEC dbo.SP_RecompilacionProcedimientos;
GO

```
#### Ejecucion del SP

| #  | NombreUsuario      | TotalPagos | MontoPagoPromedio | MontoTotal |
|----|-------------------|------------|-------------------|------------|
| 1  | Alejandro Aguilar | 3          | 62948.000000      | 188844     |
| 2  | Ferran Fernandez  | 2          | 56565.500000      | 113131     |
| 3  | Alejandro Aguilar | 1          | 95069.000000      | 95069      |
| 4  | Alejandro Aguilar | 1          | 75899.000000      | 75899      |
| 5  | Adrian Aguilar    | 1          | 71324.000000      | 71324      |

#### SP_Encryptado
Demostramos que es imposible ver un codigo con SP encryptado.

``` sql
PRINT 'Intentando ver el código del procedimiento encriptado:';
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.SP_RecompilacionProcedimientos')) AS CodigoEncriptado;
GO
```
| CodigoEncriptado |
|------------------|
| NULL             |

#### SCHEMABINDING
Intentar modificar una tabla base, esto debería fallar.
``` sql
PRINT 'Intentando modificar una columna en tabla referenciada por vista con SCHEMABINDING:';
BEGIN TRY
    ALTER TABLE dbo.SocaiUsers DROP COLUMN Name;
    PRINT 'La modificación fue exitosa (esto no debería verse)';
END TRY
BEGIN CATCH
    PRINT 'Error al modificar: ' + ERROR_MESSAGE();
    PRINT 'La modificación falló debido a SCHEMABINDING (comportamiento correcto)';
END CATCH;
GO
```
Mensaje de Fallo: 
Intentando modificar una columna en tabla referenciada por vista con SCHEMABINDING:
Error al modificar: ALTER TABLE DROP COLUMN Name failed because one or more objects access this column.
La modificación falló debido a SCHEMABINDING (comportamiento correcto)

Hora de finalización: 2025-05-06T23:42:25.8116570-06:00

#### UNION
Demostrar union con planes de suscripcion.

| TipoSuscripcion | SubscriptionId | NombrePlan             | Precio     |
|-----------------|---------------|------------------------|------------|
| Empresarial     | 8             | Hogar y Cuidado        | 60000.00   |
| Empresarial     | 9             | Amante de la Gastronomia| 60000.00  |
| Empresarial     | 5             | Entusiasta al Gym      | 55000.00   |
| Empresarial     | 7             | Amante de Mascotas     | 50000.00   |
| Empresarial     | 6             | Movilidad Urbana       | 45000.00   |
| Individual      | 3             | Familia Moderna        | 110000.00  |
| Individual      | 4             | Ejecutivo Premium      | 95000.00   |
| Individual      | 2             | Profesional Joven      | 65000.00   |

#### MERGE
Para sincronizar datos entre tablas existentes, en este caso, usamos SocaiPaymentMethods para actualizar la tabla SocaiDataPayments.

``` sql
PRINT 'Demostración de MERGE para sincronización de datos:';

BEGIN TRANSACTION;

-- Mostrar datos antes del MERGE
SELECT 'Antes de MERGE - SocaiDataPayments' AS Estado, 
       dp.DataPaymentId, dp.name, dp.UserId, dp.PaymentMethodId
FROM SocaiDataPayments dp
JOIN SocaiUsers u ON dp.UserId = u.UserId
ORDER BY dp.DataPaymentId;

-- Ejecutar MERGE para actualizar nombres de métodos de pago en DataPayments
-- basado en la tabla SocaiPaymentMethods
MERGE SocaiDataPayments AS destino
USING (
    SELECT dp.DataPaymentId, dp.UserId, dp.PaymentMethodId, 
           pm.name AS PaymentMethodName
    FROM SocaiDataPayments dp
    JOIN SocaiPaymentMethods pm ON dp.PaymentMethodId = pm.PaymentMethodId
) AS origen
ON destino.DataPaymentId = origen.DataPaymentId
WHEN MATCHED THEN
    UPDATE SET 
        destino.name = origen.PaymentMethodName + ' - ' + CAST(origen.UserId AS VARCHAR);

-- Mostrar datos después del MERGE
SELECT 'Después de MERGE - SocaiDataPayments' AS Estado, 
       dp.DataPaymentId, dp.name, dp.UserId, dp.PaymentMethodId
FROM SocaiDataPayments dp
JOIN SocaiUsers u ON dp.UserId = u.UserId
ORDER BY dp.DataPaymentId;

-- Revertir los cambios para no afectar la base de datos
ROLLBACK TRANSACTION;
GO
```
| Estado                                   | DataPaymentId | name                  | UserId | PaymentMethodId |
|-------------------------------------------|---------------|-----------------------|--------|-----------------|
| Antes de MERGE - SociaIDataPayments       | 20            | Cuenta PayPal         | 1      | 6               |
| Antes de MERGE - SociaIDataPayments       | 21            | American Express Gold | 1      | 2               |
| Antes de MERGE - SociaIDataPayments       | 22            | Mastercard Principal  | 1      | 1               |
| Antes de MERGE - SociaIDataPayments       | 23            | Cuenta PayPal         | 2      | 6               |
| Antes de MERGE - SociaIDataPayments       | 24            | American Express Gold | 2      | 2               |
| Antes de MERGE - SociaIDataPayments       | 25            | SINPE Movil           | 3      | 9               |
| Antes de MERGE - SociaIDataPayments       | 26            | SINPE Movil           | 3      | 9               |
| Antes de MERGE - SociaIDataPayments       | 27            | American Express Gold | 3      | 2               |
| Antes de MERGE - SociaIDataPayments       | 28            | Cuenta PayPal         | 3      | 6               |
| Antes de MERGE - SociaIDataPayments       | 29            | Cuenta PayPal         | 4      | 6               |
| Antes de MERGE - SociaIDataPayments       | 30            | American Express Gold | 4      | 2               |
| Antes de MERGE - SociaIDataPayments       | 31            | Visa Personal         | 4      | 0               |
| Antes de MERGE - SociaIDataPayments       | 32            | Cuenta PayPal         | 5      | 6               |
| Antes de MERGE - SociaIDataPayments       | 33            | SINPE Movil           | 5      | 9               |
| Antes de MERGE - SociaIDataPayments       | 34            | Mastercard Principal  | 5      | 1               |
| Antes de MERGE - SociaIDataPayments       | 35            | Cuenta PayPal         | 17     | 6               |

| Estado                                    | DataPaymentId | name                  | UserId | PaymentMethodId |
|--------------------------------------------|---------------|-----------------------|--------|-----------------|
| Después de MERGE - SociaIDataPayments      | 20            | PayPal - 1            | 1      | 6               |
| Después de MERGE - SociaIDataPayments      | 21            | American Express - 1  | 1      | 2               |
| Después de MERGE - SociaIDataPayments      | 22            | Mastercard - 1        | 1      | 1               |
| Después de MERGE - SociaIDataPayments      | 23            | PayPal - 2            | 2      | 6               |
| Después de MERGE - SociaIDataPayments      | 24            | American Express - 2  | 2      | 2               |
| Después de MERGE - SociaIDataPayments      | 25            | SINPE Movil - 2       | 3      | 9               |
| Después de MERGE - SociaIDataPayments      | 26            | SINPE Movil - 3       | 3      | 9               |
| Después de MERGE - SociaIDataPayments      | 27            | American Express - 3  | 3      | 2               |
| Después de MERGE - SociaIDataPayments      | 28            | PayPal - 3            | 3      | 6               |
| Después de MERGE - SociaIDataPayments      | 29            | American Express - 4  | 4      | 2               |
| Después de MERGE - SociaIDataPayments      | 30            | Visa Personal         | 4      | 0               |
| Después de MERGE - SociaIDataPayments      | 31            | PayPal - 4            | 4      | 6               |
| Después de MERGE - SociaIDataPayments      | 32            | SINPE Movil - 5       | 5      | 9               |
| Después de MERGE - SociaIDataPayments      | 33            | Mastercard - 5        | 5      | 1               |
| Después de MERGE - SociaIDataPayments      | 34            | PayPal - 5            | 5      | 6               |
| Después de MERGE - SociaIDataPayments      | 35            | PayPal - 17           | 17     | 6               |

#### AVG
Mostrar AVG con agrupamiento directamente desde las tablas

``` sql
PRINT 'Demostración de AVG con agrupamiento:';
SELECT 
    u.Name AS NombreUsuario,
    COUNT(*) AS TotalPagos,
    AVG(p.amount) AS MontoPagoPromedio,
    SUM(p.amount) AS MontoTotal
FROM 
    SocaiUsers u
    INNER JOIN SocaiPayments p ON u.UserId = p.UserId
GROUP BY 
    u.UserId, u.Name
ORDER BY 
    MontoTotal DESC;
GO
```
| #  | NombreUsuario        | TotalPagos | MontoPagoPromedio | MontoTotal |
|----|---------------------|------------|-------------------|------------|
| 1  | Alejandro Aguilar   | 3          | 62948.000000      | 188844     |
| 2  | Ferran Fernandez    | 2          | 56565.500000      | 113131     |
| 3  | Alejandro Aguilar   | 1          | 95069.000000      | 95069      |
| 4  | Alejandro Aguilar   | 1          | 75899.000000      | 75899      |
| 5  | Adrian Aguilar      | 1          | 71324.000000      | 71324      |
| 6  | David Gomez         | 1          | 70433.000000      | 70433      |
| 7  | Alejandro Lopez     | 1          | 45408.000000      | 45408      |
| 8  | Alejandro Aguilar   | 1          | 41900.000000      | 41900      |
| 9  | Carlos Sanchez      | 1          | 36242.000000      | 36242      |
| 10 | Alejandro Cruz      | 1          | 34401.000000      | 34401      |
| 11 | Lamine Vargas       | 1          | 14798.000000      | 14798      |
| 12 | Alejandro Vargas    | 1          | 14798.000000      | 14798      |
| 13 | Pedro Aguilar       | 1          | 1.000000          | 1          |

#### EXECUTE AS 
Creamos un usuario con permisos limitados.

``` sql
--- Execute As ----

-- Crear usuario con permisos limitados
CREATE USER UsuarioLectura WITHOUT LOGIN;
GO

-- Otorgar permisos de solo lectura
GRANT SELECT ON SocaiSubscriptions TO UsuarioLectura;
DENY UPDATE ON SocaiSubscriptions TO UsuarioLectura;
-- Conceder permiso para ejecutar el procedimiento
GRANT EXECUTE ON SP_ActualizarPrecios TO UsuarioLectura;
GO

-- Crear procedimiento con impersonificación
CREATE PROCEDURE SP_ActualizarPrecios
    @Porcentaje DECIMAL(5,2)
WITH EXECUTE AS 'dbo'  -- Usando WITH EXECUTE AS
AS
BEGIN
    -- Esta actualización funcionará aunque el usuario que llame
    -- al procedimiento no tenga permisos de actualización
    UPDATE SocaiSubscriptions 
    SET amount = amount * (1 + (@Porcentaje/100));
    
    PRINT 'Precios actualizados por usuario: ' + CAST(CURRENT_USER AS VARCHAR(50));
END;
GO
```
Aqui luega la verificacuion.
``` sql
-- Demostrar que funciona
EXECUTE AS USER = 'UsuarioLectura';
GO
EXEC SP_ActualizarPrecios @Porcentaje = 5.0;
GO
REVERT;  -- Regresar al contexto original
GO
```

Este mensaje nos da a entender que, aunque el usuario 'UsuarioLectura' no tiene permisos para actualizar la tabla directamente, pudo hacerlo a través del procedimiento almacenado que se ejecuta con los privilegios del propietario de la base de datos (dbo).

(8 filas afectadas)
Precios actualizados por usuario: dbo

Hora de finalización: 2025-05-06T23:50:35.1002445-06:00


## 3. Mantenimiento de la Seguridad (Santi)
*(corresponde al script `Scripts&Queries Mantenimiento de Seguridad.sql`)*

---

### 3.1 Logins

| Login | Propósito | Contraseña demo ¹ |
|-------|-----------|-------------------|
| `login_sinAcceso` | Cuenta bloqueada para pruebas negativas | `NoP@ss_demo1!` |
| `login_read` | Cuenta de solo‑lectura de catálogos | `Read0nly_demo1!` |
| `login_api` | Servicio Back‑End / API | `ApiP@ss_demo1!` |

---

### 3.2 Usuarios

| Usuario BD | Login asociado | Uso |
|------------|----------------|-----|
| `usr_noAccess` | `login_sinAcceso` | Asegurar que *DENY CONNECT* realmente impide el acceso |
| `usr_readOnly` | `login_read` | Lectura de tablas de catálogo |
| `usr_backEnd` | `login_api` | Invocar SP protegidos desde la API |

---

### 3.3 Roles y membresías

| Rol | Objetivo | Miembros |
|-----|----------|----------|
| `rl_catalogRead` | Lectura estricta de catálogos de la aplicación | `usr_readOnly` |
| `rl_backendApi`  | Operaciones permitidas al servicio back‑end | `usr_backEnd` |

---

### 3.4 Modelo de permisos

| Principal | `CONNECT` | `SELECT` catálogos | `SELECT/CRUD` liquidaciones | `EXEC` SP de pagos |
|-----------|-----------|--------------------|-----------------------------|--------------------|
| `usr_noAccess` | ❌ | ❌ | ❌ | ❌ |
| `usr_readOnly` | ✔️ | ✔️ (`SocaiSubscriptions`,`SocaiServiceTypes`) | ❌ | ❌ |
| `usr_backEnd`  | ✔️ | ❌ | ❌ (DENY directo) | ✔️ (`SocaiSP_PagarProveedorMesPasado`, `SocaiSP_GetToken`) |

---

### 3.5 Row-level Security

| Elemento | Detalle |
|----------|---------|
| **Función inline** | `dbo.fn_rls_Comercio(@CommerceId INT)` compara el parámetro con `SESSION_CONTEXT('ComId')`. |
| **Política** | `Policy_Comercio`; **FILTER** sobre `SocaiCommerces` y `SocaiCommerceSettlement`. |
| **Uso** | Antes de un `SELECT` el back‑end establece<br>`EXEC sp_set_session_context N'ComId', @idComercio;` |

---

### 3.6 Infraestructura criptográfica

| Objeto | Tipo / Algoritmo | Protegido por |
|--------|------------------|---------------|
| `##MS_DatabaseMasterKey##` | Master Key | Contraseña `MK$Caso2_demo!` |
| `CertPayments` | Certificado X.509 | — |
| `AK_Payments` | Llave asimétrica RSA‑3072 | — |
| `SK_PayToken` | Llave simétrica AES‑256 | `CertPayments`, `AK_Payments` |

Los *chargeToken* de la tabla `SocaiPayments.chargeToken` se cifran con
`ENCRYPTBYKEY(KEY_GUID('SK_PayToken'), @valor)`.

---

### 3.7 Procedimiento seguro de descrifrado
```sql
CREATE PROCEDURE dbo.SocaiSP_GetToken @PaymentId int AS
BEGIN
    OPEN SYMMETRIC KEY SK_PayToken DECRYPTION BY CERTIFICATE CertPayments;
    SELECT  p.PaymentId,
            CONVERT(varchar(250),DECRYPTBYKEY(p.chargeToken)) AS PlainToken
    FROM    dbo.SocaiPayments AS p
    WHERE   p.PaymentId = @PaymentId;
    CLOSE SYMMETRIC KEY SK_PayToken;
END
```

## 4. Consultas Misceláneas (Barquero)

## 4.1. Vista Indexada

### Vista: `vwResumenUsuarios`

Una vista indexada que proporciona información consolidada sobre los usuarios, sus suscripciones y servicios contratados.

#### Definición:

```sql
-- Vista Indexada sin SocaiPayments
CREATE VIEW dbo.vwResumenUsuarios
WITH SCHEMABINDING
AS
SELECT 
    u.UserId AS idUsuario,
    u.Name AS NombreUsuario,
    su.SubscriptionUserId AS idSuscripcion,
    su.startDateTime AS fechaInicio,
    su.endDateTime AS fechaFin,
    fs.FeaturesSubscriptionsId AS idServicio,
    pf.Name AS NombreServicio,
    CONCAT(u.UserId, '-', su.SubscriptionUserId, '-', fs.FeaturesSubscriptionsId) AS CodigoRelacional
FROM dbo.SocaiUsers u
INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
INNER JOIN dbo.SocaiPlanFeatures pf ON fs.PlanFeatureId = pf.FeatureId
WHERE u.isActive = 1 
  AND su.enable = 1;
  AND fs.FeaturesSubscriptionsId IS NOT NULL;
GO

```

#### Índice único agrupado:

```sql
CREATE UNIQUE CLUSTERED INDEX IX_ResumenUsuarios
ON dbo.vwResumenUsuarios (idUsuario, idSuscripcion, idServicio);
```

#### Uso:
```sql
SELECT * FROM dbo.vwResumenUsuarios;

Procedimiento: sp_ActualizarDatosResumenUsuarios
Este procedimiento permite actualizar los datos relacionados con la vista indexada.
Definición:
sqlCREATE OR ALTER PROCEDURE sp_ActualizarDatosResumenUsuarios
    @IdUsuario INT,
    @IdSuscripcion INT = NULL,
    @IdServicio INT = NULL,
    @NuevoNombre VARCHAR(250) = NULL,
    @NuevaFechaInicio DATETIME = NULL,
    @NuevaFechaFin DATETIME = NULL,
    @NuevoNombreServicio VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Errores TABLE (
        EntidadModificada VARCHAR(100),
        IdEntidad INT,
        Mensaje VARCHAR(500)
    );
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Actualizar información de usuario
        IF @NuevoNombre IS NOT NULL
        BEGIN
            UPDATE SocaiUsers
            SET Name = @NuevoNombre
            WHERE UserId = @IdUsuario;
            
            IF @@ROWCOUNT = 0
                INSERT INTO @Errores VALUES ('Usuario', @IdUsuario, 'Usuario no encontrado');
        END
        
        -- Actualizar información de suscripción
        IF @IdSuscripcion IS NOT NULL AND (@NuevaFechaInicio IS NOT NULL OR @NuevaFechaFin IS NOT NULL)
        BEGIN
            UPDATE SocaiSubscriptionUser
            SET startDateTime = ISNULL(@NuevaFechaInicio, startDateTime),
                endDateTime = ISNULL(@NuevaFechaFin, endDateTime)
            WHERE SubscriptionUserId = @IdSuscripcion
              AND UserId = @IdUsuario;
              
            IF @@ROWCOUNT = 0
                INSERT INTO @Errores VALUES ('Suscripción', @IdSuscripcion, 'Suscripción no encontrada o no pertenece al usuario');
        END
        
        -- Actualizar información de servicio
        IF @IdServicio IS NOT NULL AND @NuevoNombreServicio IS NOT NULL
        BEGIN
            -- Esta actualización es más compleja porque necesitamos encontrar el PlanFeature adecuado
            DECLARE @PlanFeatureId INT;
            
            -- Buscar o crear un PlanFeature con el nuevo nombre
            SELECT @PlanFeatureId = FeatureId
            FROM SocaiPlanFeatures
            WHERE Name = @NuevoNombreServicio;
            
            IF @PlanFeatureId IS NULL
            BEGIN
                -- Si no existe el nombre de servicio, crear uno nuevo
                INSERT INTO SocaiPlanFeatures (
                    Name, 
                    Description, 
                    Category, 
                    UnitTypeId, 
                    isActive, 
                    UpdatedTime, 
                    CreatedTime
                )
                VALUES (
                    @NuevoNombreServicio,
                    'Servicio creado automáticamente',
                    'Otros',
                    1,  -- UnitTypeId predeterminado
                    1,  -- activo
                    GETDATE(),
                    GETDATE()
                );
                
                SET @PlanFeatureId = SCOPE_IDENTITY();
            END
            
            -- Actualizar la característica de suscripción
            UPDATE SocaiFeaturesSubscriptions
            SET PlanFeatureId = @PlanFeatureId,
                UpdatedAt = GETDATE()
            WHERE FeaturesSubscriptionsId = @IdServicio;
            
            IF @@ROWCOUNT = 0
                INSERT INTO @Errores VALUES ('Servicio', @IdServicio, 'Servicio no encontrado');
        END
        
        -- Verificar si hay errores
        IF EXISTS (SELECT 1 FROM @Errores)
        BEGIN
            ROLLBACK TRANSACTION;
            
            SELECT 'Error' AS Resultado, 
                   EntidadModificada,
                   IdEntidad,
                   Mensaje
            FROM @Errores;
        END
        ELSE
        BEGIN
            COMMIT TRANSACTION;
            
            SELECT 'Éxito' AS Resultado, 
                   'Se actualizaron correctamente los datos solicitados' AS Mensaje;
                   
            -- Mostrar los datos actualizados
            SELECT *
            FROM dbo.vwResumenUsuarios
            WHERE idUsuario = @IdUsuario
            AND (@IdSuscripcion IS NULL OR idSuscripcion = @IdSuscripcion)
            AND (@IdServicio IS NULL OR idServicio = @IdServicio);
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SELECT 
            'Error' AS Resultado,
            ERROR_MESSAGE() AS Mensaje,
            ERROR_SEVERITY() AS Severidad,
            ERROR_STATE() AS Estado,
            ERROR_PROCEDURE() AS Procedimiento,
            ERROR_LINE() AS Linea;
    END CATCH;
END;
```
Características:

- Permite actualizar datos relacionados con la vista indexada
- Implementa transacciones para garantizar la integridad
- Maneja diferentes tipos de actualizaciones (usuario, suscripción, servicio)
- Incluye validación de datos y reporte de errores
- Muestra los datos actualizados tras la operación exitosa
## 4.2. Procedimiento Almacenado Transaccional

### Procedimiento: `spRegistrarSuscripcion`

Este procedimiento almacenado transaccional gestiona el registro de nuevas suscripciones y realiza modificaciones en al menos tres tablas relacionadas.

#### Parámetros:
- `@idUsuario`: ID del usuario
- `@idServicio`: ID del servicio a suscribir
- `@fechaInicio`: Fecha de inicio de la suscripción
- `@fechaFin`: Fecha de fin de la suscripción
- `@monto`: Monto del pago
- `@fechaPago`: Fecha del pago

#### Definición:

```sql
CREATE OR ALTER PROCEDURE spRegistrarSuscripcion
    @idUsuario INT,
    @idServicio INT,
    @fechaInicio DATE,
    @fechaFin DATE,
    @monto DECIMAL(10, 2),
    @fechaPago DATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
    DECLARE @Message VARCHAR(200)
    DECLARE @InicieTransaccion BIT = 0
    
    IF @@TRANCOUNT = 0 BEGIN
        SET @InicieTransaccion = 1
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        BEGIN TRANSACTION
    END
    
    BEGIN TRY
        SET @CustomError = 2001

        -- 1. Insertar en SocaiSubscriptionUser
        INSERT INTO dbo.SocaiSubscriptionUser (enable, startDateTime, endDateTime, UserId, SubscriptionId)
        VALUES (1, @fechaInicio, @fechaFin, @idUsuario, @idServicio);
        
        DECLARE @idSuscripcion INT = SCOPE_IDENTITY();
        
        -- 2. Insertar en SocaiPayments
        DECLARE @PaymentMethodId INT = (SELECT TOP 1 PaymentMethodId FROM dbo.SocaiPaymentMethods WHERE enable = 1);
        DECLARE @CurrencyTypeId INT = (SELECT TOP 1 CurrencyTypeId FROM dbo.SocaiCurrencyTypes WHERE acronym = 'CRC');
        DECLARE @ResultPaymentId INT = (SELECT TOP 1 ResultPaymentId FROM dbo.SocaiResultPayment WHERE name = 'Exitoso');
        
        INSERT INTO dbo.SocaiPayments (amount, actualAmount, date, DataPaymentId, PaymentMethodId, UserId, ResultPaymentId, CurrencyTypeId)
        VALUES (@monto, @monto, @fechaPago, 1, @PaymentMethodId, @idUsuario, @ResultPaymentId, @CurrencyTypeId);
        
        DECLARE @idPago INT = SCOPE_IDENTITY();
        
        -- 3. Insertar en SocaiTransactions
        INSERT INTO dbo.SocaiTransactions (amount, description, transactionDateTime, postTime, referenceNumber,
                                          TransactionTypeId, TransactionSubTypeId, CurrencyTypeId, PaymentId, UserId, ExchangeRateId)
        VALUES (@monto, 'Pago por suscripción a servicio', GETDATE(), GETDATE(), NEWID(),
                1, 1, @CurrencyTypeId, @idPago, @idUsuario, 1);
        
        -- 4. Actualizar SocaiFeaturesSubscriptions
        UPDATE dbo.SocaiFeaturesSubscriptions
        SET Quantity = COALESCE(Quantity, 0) + 1,
            UpdatedAt = GETDATE()
        WHERE FeaturesSubscriptionsId = @idServicio;
        
        IF @InicieTransaccion = 1 BEGIN
            COMMIT TRANSACTION
        END
        
        SELECT 'Éxito' AS Resultado, @idSuscripcion AS idSuscripcion, @idPago AS idPago;
    END TRY
    BEGIN CATCH
        SET @ErrorNumber = ERROR_NUMBER()
        SET @ErrorSeverity = ERROR_SEVERITY()
        SET @ErrorState = ERROR_STATE()
        SET @Message = ERROR_MESSAGE()
        
        IF @InicieTransaccion = 1 BEGIN
            ROLLBACK TRANSACTION
        END
        
        INSERT INTO dbo.SocaiLogs (description, postTime, computer, username, trace, 
                                  LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId)
        VALUES ('Error al registrar suscripción: ' + @Message, GETDATE(), 
                HOST_NAME(), SYSTEM_USER, 'spRegistrarSuscripcion', 3, 1, 3, @idUsuario, NULL);
        
        SELECT 'Error' AS Resultado, @Message AS MensajeError;
    END CATCH
END;
```

#### Funcionalidades:
- Inserta un nuevo registro en la tabla `SocaiSubscriptionUser`
- Registra un pago en la tabla `SocaiPayments`
- Registra una transacción en la tabla `SocaiTransactions`
- Actualiza la cantidad en la tabla `SocaiFeaturesSubscriptions`
- Proporciona manejo de errores y rollback en caso de fallo

#### Lógica de Negocio:
- Verificación de consistencia de datos
- Gestión de transacciones para asegurar integridad
- Registro de errores en la tabla de logs del sistema

## 4.3. Consulta con CASE para Agrupamiento Dinámico

### Procedimiento: `sp_ClasificacionUsuarios`

Este procedimiento utiliza la instrucción CASE para clasificar dinámicamente a los usuarios según su patrón de pagos.

#### Definición:

```sql
CREATE OR ALTER PROCEDURE sp_ClasificacionUsuarios
AS
BEGIN
    SELECT 
        u.UserId AS idUsuario,
        u.Name AS nombre,
        COUNT(p.PaymentId) AS CantidadPagos,
        CASE 
            WHEN COUNT(p.PaymentId) = 0 THEN 'Nuevo'
            WHEN COUNT(p.PaymentId) BETWEEN 1 AND 3 THEN 'Ocasional'
            ELSE 'Frecuente'
        END AS ClasificacionUsuario
    FROM dbo.SocaiUsers u
    LEFT JOIN dbo.SocaiPayments p ON u.UserId = p.UserId
    GROUP BY u.UserId, u.Name;
END;
```

#### Categorías de clasificación:
- **Nuevo**: Usuarios sin pagos registrados
- **Ocasional**: Usuarios con 1 a 3 pagos
- **Frecuente**: Usuarios con más de 3 pagos

#### Uso:
```sql
EXEC sp_ClasificacionUsuarios;
```

## 4.4. Consulta Compleja con JOINs, Funciones Agregadas y CTEs

### Procedimiento: `sp_ObtenerReporteAnalisisUsuarios`

Este procedimiento implementa una consulta compleja que utiliza múltiples técnicas avanzadas de T-SQL.

#### Definición:

```sql
CREATE OR ALTER PROCEDURE sp_ObtenerReporteAnalisisUsuarios
AS
BEGIN
    SET NOCOUNT ON;
    
    -- CTE 1: Información de usuarios y suscripciones
    WITH UsuariosSuscripciones AS (
        SELECT 
            u.UserId,
            u.Name,
            u.Email,
            u.PhoneNumber,
            u.CreatedAt AS FechaRegistro,
            su.SubscriptionUserId,
            su.startDateTime,
            su.endDateTime,
            su.enable,
            s.SubscriptionId,
            s.Name AS PlanName,
            s.amount AS PlanCost,
            c.acronym AS Currency,
            DATEDIFF(DAY, GETDATE(), su.endDateTime) AS DiasRestantes
        FROM dbo.SocaiUsers u
        INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
        INNER JOIN dbo.SocaiSubscriptions s ON su.SubscriptionId = s.SubscriptionId
        INNER JOIN dbo.SocaiCurrencyTypes c ON s.CurrencyTypeId = c.CurrencyTypeId
    ),
    -- CTE 2: Información de pagos
    PagosUsuario AS (
        SELECT 
            u.UserId,
            COUNT(p.PaymentId) AS TotalPagos,
            SUM(p.amount) AS MontoTotal,
            AVG(p.amount) AS PromedioGasto,
            MAX(p.date) AS UltimoPago
        FROM dbo.SocaiUsers u
        LEFT JOIN dbo.SocaiPayments p ON u.UserId = p.UserId
        GROUP BY u.UserId
    ),
    -- CTE 3: Servicios utilizados
    ServiciosUtilizados AS (
        SELECT 
            su.UserId,
            COUNT(fs.FeaturesSubscriptionsId) AS TotalServicios,
            STRING_AGG(pf.Name, ', ') AS Servicios
        FROM dbo.SocaiSubscriptionUser su
        INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
        INNER JOIN dbo.SocaiPlanFeatures pf ON fs.PlanFeatureId = pf.FeatureId
        GROUP BY su.UserId
    )
    
    -- Consulta principal que utiliza las 3 CTEs
    SELECT 
        us.UserId,
        us.Name AS NombreUsuario,
        us.Email,
        CONVERT(VARCHAR(10), us.FechaRegistro, 103) AS FechaRegistroFormateada,
        us.PlanName AS NombrePlan,
        CONCAT(us.PlanCost, ' ', us.Currency) AS CostoPlan,
        pu.TotalPagos,
        pu.MontoTotal,
        pu.PromedioGasto,
        CONVERT(VARCHAR(10), pu.UltimoPago, 103) AS UltimoPagoFormateado,
        su.TotalServicios,
        su.Servicios,
        us.DiasRestantes,
        CASE 
            WHEN us.DiasRestantes < 0 THEN 'Vencido'
            WHEN us.DiasRestantes BETWEEN 0 AND 7 THEN 'Vence esta semana'
            WHEN us.DiasRestantes BETWEEN 8 AND 30 THEN 'Vence este mes'
            ELSE 'Vigente'
        END AS EstadoSuscripcion,
        CASE
            WHEN pu.TotalPagos = 0 THEN 'Sin pagos'
            WHEN pu.TotalPagos = 1 THEN 'Primer pago'
            WHEN pu.TotalPagos BETWEEN 2 AND 5 THEN 'Cliente regular'
            ELSE 'Cliente frecuente'
        END AS CategoriaCliente
    FROM UsuariosSuscripciones us
    LEFT JOIN PagosUsuario pu ON us.UserId = pu.UserId
    LEFT JOIN ServiciosUtilizados su ON us.UserId = su.UserId
    WHERE 
        us.enable = 1
        AND EXISTS (
            SELECT 1 
            FROM dbo.SocaiBalances b 
            WHERE b.SubscriptionUserId = us.SubscriptionUserId
        )
        AND us.PlanCost IN (
            SELECT DISTINCT amount 
            FROM dbo.SocaiSubscriptions 
            WHERE isActive = 1
        )
        AND us.UserId NOT IN (
            SELECT l.UserId 
            FROM dbo.SocaiLogs l 
            WHERE l.LogTypeId = 3  -- Suponiendo que LogTypeId 3 es para errores
            AND l.postTime > DATEADD(DAY, -30, GETDATE())
        )
    HAVING 
        pu.TotalPagos > 0
    ORDER BY 
        us.DiasRestantes ASC,
        pu.MontoTotal DESC;
END;
```

#### Características:
- Utiliza 3 Common Table Expressions (CTEs):
  - `UsuariosSuscripciones`: Información base de usuarios y suscripciones
  - `PagosUsuario`: Información agregada de pagos por usuario
  - `ServiciosUtilizados`: Servicios contratados por usuario con STRING_AGG
- Implementa 4 JOINs entre tablas principales
- Incluye 2 funciones agregadas (COUNT, SUM)
- Utiliza operadores EXISTS y NOT IN para filtrado avanzado
- Implementa CASE para categorización dinámica
- Incluye formateo de fechas con CONVERT
- Usa HAVING para filtrar después de agregación

#### Propósito:
Generar un informe detallado del estado de los clientes, sus suscripciones, historial de pagos y servicios contratados, con clasificación de clientes según su comportamiento.

## 4.5. Consulta con INTERSECTION y SET DIFFERENCE

### Procedimiento: `sp_AnalisisUsuariosInterseccionDiferencia`

Este procedimiento demuestra el uso de operaciones de conjuntos en SQL.

#### Definición:

```sql
CREATE OR ALTER PROCEDURE sp_AnalisisUsuariosInterseccionDiferencia
AS
BEGIN
    -- INTERSECCIÓN: Usuarios con suscripción y al menos un pago registrado
    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    INNER JOIN dbo.SocaiPayments p ON u.UserId = p.UserId

    INTERSECT

    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
    WHERE su.enable = 1;

    -- DIFERENCIA: Usuarios con suscripción pero sin ningún pago
    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId

    EXCEPT

    SELECT DISTINCT u.UserId AS idUsuario, u.Name AS nombre
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiPayments p ON u.UserId = p.UserId;
END;
```

#### Operaciones:
1. **INTERSECT**: Encuentra usuarios que tienen tanto suscripciones como pagos registrados
2. **EXCEPT**: Identifica usuarios con suscripciones pero sin pagos registrados

#### Uso:
```sql
EXEC sp_AnalisisUsuariosInterseccionDiferencia;
```

## 4.6. Procedimientos Almacenados Transaccionales Anidados

### Procedimientos: 
- `sp_actualizarPagosYServicios`: Nivel más bajo
- `sp_actualizarUsuarioYSuscripcion`: Nivel intermedio
- `sp_procesoCompleto`: Nivel superior

#### Estructura de anidamiento:
- `sp_procesoCompleto` llama a `sp_actualizarUsuarioYSuscripcion`
- `sp_actualizarUsuarioYSuscripcion` llama a `sp_actualizarPagosYServicios`

#### Definición:

```sql
-- Procedimiento de nivel más bajo
CREATE OR ALTER PROCEDURE sp_actualizarPagosYServicios
    @idServicio INT,
    @idSuscripcion INT,
    @nuevoMonto DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN

        -- Actualizar servicios
        UPDATE dbo.SocaiFeaturesSubscriptions
        SET Quantity = COALESCE(Quantity, 0) + 1,
            MemberCount = COALESCE(MemberCount, 1),
            UpdatedAt = GETDATE()
        WHERE FeaturesSubscriptionsId = @idServicio;

        -- Datos para pago
        DECLARE @PaymentMethodId INT = (SELECT TOP 1 PaymentMethodId FROM dbo.SocaiPaymentMethods WHERE enable = 1);
        DECLARE @CurrencyTypeId INT = (SELECT TOP 1 CurrencyTypeId FROM dbo.SocaiCurrencyTypes WHERE acronym = 'CRC');
        DECLARE @ResultPaymentId INT = (SELECT TOP 1 ResultPaymentId FROM dbo.SocaiResultPayment WHERE name = 'Exitoso');
        
        DECLARE @UserId INT = (SELECT UserId FROM dbo.SocaiSubscriptionUser WHERE SubscriptionUserId = @idSuscripcion);
        SET @UserId = ISNULL(@UserId, 1);
        
        -- Registrar pago
        INSERT INTO dbo.SocaiPayments (amount, actualAmount, date, DataPaymentId, PaymentMethodId, UserId, ResultPaymentId, CurrencyTypeId)
        VALUES (@nuevoMonto, @nuevoMonto, GETDATE(), 1, @PaymentMethodId, @UserId, @ResultPaymentId, @CurrencyTypeId);

        COMMIT
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK
        THROW
    END CATCH
END
GO

-- Procedimiento de nivel intermedio
CREATE OR ALTER PROCEDURE sp_actualizarUsuarioYSuscripcion
    @idUsuario INT,
    @nuevoNombre NVARCHAR(100),
    @idSuscripcion INT,
    @idServicio INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN

        -- Actualizar usuario
        UPDATE dbo.SocaiUsers
        SET Name = @nuevoNombre
        WHERE UserId = @idUsuario;

        -- Actualizar suscripción
        UPDATE dbo.SocaiSubscriptionUser
        SET startDateTime = GETDATE()
        WHERE SubscriptionUserId = @idSuscripcion;

        -- Llamar al procedimiento de nivel más bajo
        EXEC sp_actualizarPagosYServicios @idServicio, @idSuscripcion, 5000;

        COMMIT
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK
        THROW
    END CATCH
END
GO

-- Procedimiento de nivel superior
CREATE OR ALTER PROCEDURE sp_procesoCompleto
    @idUsuario INT,
    @nuevoNombre NVARCHAR(100),
    @idSuscripcion INT,
    @idServicio INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN
        -- Llamar al procedimiento de nivel intermedio
        EXEC sp_actualizarUsuarioYSuscripcion @idUsuario, @nuevoNombre, @idSuscripcion, @idServicio;
        COMMIT
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK
        THROW
    END CATCH
END
```

#### Características:
- Demuestra el manejo de transacciones anidadas
- Implementa propagación de excepciones a través de los niveles
- Gestión coherente de commit y rollback en cascada
- Manejo de errores consistente mediante bloques TRY-CATCH

## 4.7. Consulta que Retorna JSON

### Procedimiento: `sp_ObtenerDetalleSubscripcionJSON`

Este procedimiento genera una salida en formato JSON para facilitar la integración con aplicaciones web y móviles.

#### Definición:

```sql
CREATE OR ALTER PROCEDURE sp_ObtenerDetalleSubscripcionJSON
    @UserId INT
AS
BEGIN
    SELECT 
        u.UserId AS idUsuario,
        u.Name AS nombreUsuario,
        su.SubscriptionUserId AS idSuscripcion,
        pf.Name AS nombreServicio,
        s.amount AS precioPlan,
        (
            SELECT 
                SUM(p.amount) AS totalPagado,
                MAX(p.date) AS ultimaFechaPago
            FROM dbo.SocaiPayments p
            WHERE p.UserId = u.UserId
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS detallesPago
    FROM dbo.SocaiUsers u
    INNER JOIN dbo.SocaiSubscriptionUser su ON u.UserId = su.UserId
    INNER JOIN dbo.SocaiFeaturesSubscriptions fs ON su.SubscriptionId = fs.SubscriptionId
    INNER JOIN dbo.SocaiPlanFeatures pf ON fs.PlanFeatureId = pf.FeatureId
    INNER JOIN dbo.SocaiSubscriptions s ON fs.SubscriptionId = s.SubscriptionId
    WHERE u.UserId = @UserId
    FOR JSON PATH, ROOT('suscripcionesUsuario');
END;
```

#### Características:
- Utiliza la cláusula FOR JSON PATH para formatear la salida
- Implementa JSON anidado para representar relaciones
- Utiliza WITHOUT_ARRAY_WRAPPER para simplificar la estructura
- Define ROOT para establecer el nodo raíz del JSON

#### Uso:
```sql
EXEC sp_ObtenerDetalleSubscripcionJSON @UserId = 1;
```

## 4.8. Procedimiento con Table-Valued Parameter

### Procedimiento: `sp_UpdateServiceContracts`

Este procedimiento demuestra el uso de parámetros de tipo tabla (TVP) para pasar múltiples valores en una sola llamada.

#### Definición del tipo de tabla:

```sql
CREATE TYPE dbo.ContractConditionsType AS TABLE (
    CommercesFeaturesId INT NULL,
    PlanFeaturesId INT NOT NULL,
    IsActive BIT NOT NULL,
    ValidFrom DATETIME NOT NULL,
    ValidTo DATETIME NOT NULL,
    OriginalPrice DECIMAL(18, 2) NOT NULL,
    NegotiatedPrice DECIMAL(18, 2) NOT NULL,
    ServiceTypeId INT NOT NULL,
    IsGuaranteedRight BIT NOT NULL,
    DiscountType CHAR(1) NOT NULL,
    DiscountValue DECIMAL(18, 2) NOT NULL,
    SolturaMargin DECIMAL(18, 2) NOT NULL,
    IsMarginPercentage BIT NOT NULL,
    InlcudesTax BIT NOT NULL,
    TaxRateId INT NOT NULL,
    MinQuantity DECIMAL(18, 2) NULL,
    MaxQuantity DECIMAL(18, 2) NULL,
    TermsAndConditions VARCHAR(500) NULL,
    AdditionalBenefits VARCHAR(500) NULL,
    IsCombined BIT NOT NULL
);
```

#### Definición del procedimiento:

```sql
CREATE OR ALTER PROCEDURE sp_UpdateServiceContracts
    @CommerceId INT,
    @CommerceName VARCHAR(225) = NULL,
    @CommerceDescription VARCHAR(250) = NULL,
    @CommerceAddressId INT = NULL,
    @CommercePhoneNumber VARCHAR(20) = NULL,
    @CommerceEmail VARCHAR(200) = NULL,
    @ContractCommercesId INT = NULL,
    @ValidFrom DATETIME = NULL,
    @ValidTo DATETIME = NULL,
    @ContractType VARCHAR(50) = NULL,
    @ContractDescription VARCHAR(150) = NULL,
    @InChargeSignature VARCHAR(100) = NULL,
    @FileId INT = NULL,
    @CountryId INT = NULL,
    @ContractConditions dbo.ContractConditionsType READONLY
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @NewCommerceId INT;
    DECLARE @NewContractId INT;
    DECLARE @ErrorMsg NVARCHAR(4000);
    DECLARE @ErrorState INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Actualizaciones de comercio y contrato...
        
        -- Parte principal: MERGE con el parámetro de tipo tabla
        MERGE SocaiCommercesFeatures AS target
        USING (
            SELECT 
                cc.CommercesFeaturesId,
                @NewCommerceId AS CommercesId,
                cc.PlanFeaturesId,
                cc.IsActive,
                cc.ValidFrom,
                cc.ValidTo,
                cc.OriginalPrice,
                cc.NegotiatedPrice,
                cc.ServiceTypeId,
                cc.IsGuaranteedRight,
                cc.DiscountType,
                cc.DiscountValue,
                cc.SolturaMargin,
                cc.IsMarginPercentage,
                cc.InlcudesTax,
                cc.TaxRateId,
                cc.MinQuantity,
                cc.MaxQuantity,
                cc.TermsAndConditions,
                cc.AdditionalBenefits,
                cc.IsCombined,
                @NewContractId AS ContractCommercesId
            FROM @ContractConditions cc
        ) AS source
        ON (target.CommercesFeaturesId = source.CommercesFeaturesId AND source.CommercesFeaturesId IS NOT NULL)
        WHEN MATCHED THEN
            UPDATE SET
                target.IsActive = source.IsActive,
                target.ValidFrom = source.ValidFrom,
                target.ValidTo = source.ValidTo,
                -- más actualizaciones...
        WHEN NOT MATCHED THEN
            INSERT (
                CommercesId, PlanFeaturesId, IsActive, ValidFrom, ValidTo, CreatedAt, UpdatedAt,
                -- más campos...
            )
            VALUES (
                source.CommercesId, source.PlanFeaturesId, source.IsActive, source.ValidFrom, source.ValidTo, GETDATE(), GETDATE(),
                -- más valores...
            );
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Manejo de errores...
    END CATCH;
END;
```

#### Características:
- Define un tipo `ContractConditionsType` como tabla
- Implementa la instrucción MERGE para sincronización eficiente de datos
- Maneja inserción y actualización en un solo paso
- Incluye transacciones para mantener la integridad
- Registra errores en una tabla temporal para reportarlos al cliente

#### Uso:
```sql
-- Declarar la variable de tipo tabla
DECLARE @condiciones ContractConditionsType;

-- Insertar datos en la variable de tipo tabla
INSERT INTO @condiciones (PlanFeaturesId, IsActive, ValidFrom, ValidTo, ...)
VALUES (1, 1, '2023-01-01', '2024-01-01', ...);

-- Ejecutar el procedimiento
EXEC sp_UpdateServiceContracts
    @CommerceId = 1,
    @CommerceName = 'Nombre Comercio',
    @ContractConditions = @condiciones;
```
## 4.9. Generación de Archivo CSV

### Descripción
Este procedimiento almacenado permite generar un archivo CSV con información de suscripciones de usuarios, utilizando el comando BCP (Bulk Copy Program) de SQL Server.

### Procedimiento: `sp_GenerateSubscriptionsCSV`

```sql
CREATE OR ALTER PROCEDURE sp_GenerateSubscriptionsCSV
    @FilePath VARCHAR(500) = 'C:\Exports\subscription_report.csv'
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @BCPCommand NVARCHAR(4000);
    DECLARE @SQLQuery NVARCHAR(4000);
    
    -- Crear la consulta SQL que generará los datos
    SET @SQLQuery = '
    SELECT 
        u.UserId,
        u.Name AS UserName,
        u.Email,
        u.PhoneNumber,
        s.SubscriptionId,
        s.Name AS PlanName,
        s.Description AS PlanDescription,
        su.startDateTime,
        su.endDateTime,
        s.amount AS PlanCost,
        c.acronym AS Currency,
        ''="'' + CONVERT(VARCHAR(20), su.startDateTime, 120) + ''"'' AS FormattedStartDate,
        ''="'' + CONVERT(VARCHAR(20), su.endDateTime, 120) + ''"'' AS FormattedEndDate
    FROM SocaiUsers u
    JOIN SocaiSubscriptionUser su ON u.UserId = su.UserId
    JOIN SocaiSubscriptions s ON su.SubscriptionId = s.SubscriptionId
    JOIN SocaiCurrencyTypes c ON s.CurrencyTypeId = c.CurrencyTypeId
    WHERE u.isActive = 1 AND su.enable = 1
    ORDER BY u.UserId, su.startDateTime DESC';
    
    -- Construir el comando BCP
    SET @BCPCommand = 'bcp "' + @SQLQuery + '" queryout "' + @FilePath + 
                      '" -c -t, -S ' + @@SERVERNAME + ' -T -C ACP';
    
    -- Ejecutar el comando
    EXEC master..xp_cmdshell @BCPCommand;
    
    -- Verificar si el archivo se generó correctamente
    IF @@ERROR = 0
        SELECT 'CSV file generated successfully at: ' + @FilePath AS Result;
    ELSE
        SELECT 'Error generating CSV file' AS Result;
END;
```

### Características

- **Parametrización**: Permite especificar la ruta del archivo CSV de salida.
- **Consulta Personalizada**: Genera un conjunto de datos completo con información de usuarios, suscripciones y planes.
- **Formateo de Fechas**: Formato especial para fechas que evita problemas de interpretación en Excel y otras herramientas de hoja de cálculo.
- **Utilización de xp_cmdshell**: Ejecuta comandos del sistema operativo para generar el archivo.
- **BCP (Bulk Copy Program)**: Utiliza la utilidad de SQL Server para exportación eficiente de datos.
- **Verificación de Resultados**: Comprueba si el archivo se generó correctamente y devuelve un mensaje apropiado.

### Parámetros

| Parámetro | Tipo | Descripción | Valor por defecto |
|-----------|------|-------------|-------------------|
| @FilePath | VARCHAR(500) | Ruta donde se generará el archivo CSV | 'C:\Exports\subscription_report.csv' |

### Uso del Procedimiento

```sql
-- Generar el archivo CSV en la ubicación por defecto
EXEC sp_GenerateSubscriptionsCSV;

-- Generar el archivo CSV en una ubicación personalizada
EXEC sp_GenerateSubscriptionsCSV @FilePath = 'D:\Reportes\suscripciones_soltura.csv';
```

### Requisitos Previos

- Permisos de xp_cmdshell para el usuario que ejecuta el procedimiento.
- Permisos de escritura en la carpeta de destino.
- Configuración habilitada de xp_cmdshell en el servidor SQL.

### Notas Técnicas

- El formato de fecha utilizado ('="yyyy-mm-dd hh:mi:ss"') permite que Excel reconozca correctamente las fechas sin convertirlas automáticamente.
- Se utiliza el separador de campos coma (,) que es el estándar para archivos CSV.
- El codificado ACP (ANSI Code Page) asegura la compatibilidad con caracteres especiales.

## 4.10. Bitácora en Servidor Remoto Vinculado

### Descripción

Este conjunto de scripts y procedimientos implementa un sistema de registro (logging) centralizado utilizando un servidor vinculado (Linked Server) para almacenar logs provenientes de múltiples bases de datos en un único repositorio.

### Configuración del Linked Server

```sql
-- Configuración del Linked Server (ejecutar en el servidor principal)
EXEC master.dbo.sp_addlinkedserver 
    @server = N'CENTRAL_LOG_SERVER', 
    @srvproduct = N'',
    @provider = N'SQLOLEDB', 
    @datasrc = N'localhost';

-- Configuración de impersonación
EXEC master.dbo.sp_addlinkedsrvlogin 
    @rmtsrvname = N'CENTRAL_LOG_SERVER',
    @useself = N'TRUE';

-- Habilitar RPC
EXEC master.dbo.sp_serveroption 
    @server = N'CENTRAL_LOG_SERVER', 
    @optname = N'rpc', 
    @optvalue = N'true';

EXEC master.dbo.sp_serveroption 
    @server = N'CENTRAL_LOG_SERVER', 
    @optname = N'rpc out', 
    @optvalue = N'true';
```

### Creación de la Base de Datos y Tabla de Logs en el Servidor Remoto

```sql
-- Crear la base de datos de logs si no existe
EXEC('
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = ''LoggingDB'')
BEGIN
    CREATE DATABASE LoggingDB;
END
') AT CENTRAL_LOG_SERVER;

-- Usar la base de datos y crear la tabla de logs
EXEC('
USE LoggingDB;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = ''SocaiRemoteLogs'')
BEGIN
    CREATE TABLE dbo.SocaiRemoteLogs(
        RemoteLogId INT IDENTITY(1,1) PRIMARY KEY,
        SourceServer VARCHAR(100) NOT NULL,
        SourceDatabase VARCHAR(100) NOT NULL,
        SourceProcedure VARCHAR(255) NULL,
        LogLevel VARCHAR(20) NOT NULL,
        Message VARCHAR(4000) NOT NULL,
        AdditionalInfo VARCHAR(MAX) NULL,
        UserName VARCHAR(100) NULL,
        HostName VARCHAR(100) NULL,
        ExecutionTime DATETIME2 NOT NULL DEFAULT GETDATE(),
        RelatedEntityId INT NULL,
        RelatedEntityType VARCHAR(50) NULL,
        OriginalLogId INT NULL,
        SessionId INT NULL,
        ErrorNumber INT NULL,
        ErrorLine INT NULL,
        ErrorState INT NULL,
        ErrorSeverity INT NULL,
        ErrorProcedure VARCHAR(255) NULL
    );
    
    CREATE INDEX IX_SocaiRemoteLogs_LogLevel ON SocaiRemoteLogs(LogLevel);
    CREATE INDEX IX_SocaiRemoteLogs_ExecutionTime ON SocaiRemoteLogs(ExecutionTime);
    CREATE INDEX IX_SocaiRemoteLogs_SourceProcedure ON SocaiRemoteLogs(SourceProcedure);
END
') AT CENTRAL_LOG_SERVER;
```

### Procedimiento para Logging Remoto

```sql
CREATE OR ALTER PROCEDURE dbo.sp_LogToRemoteServer
    @LogLevel VARCHAR(20),
    @Message VARCHAR(4000),
    @AdditionalInfo VARCHAR(MAX) = NULL,
    @SourceProcedure VARCHAR(255) = NULL,
    @RelatedEntityId INT = NULL,
    @RelatedEntityType VARCHAR(50) = NULL,
    @OriginalLogId INT = NULL,
    @ErrorNumber INT = NULL,
    @ErrorLine INT = NULL,
    @ErrorState INT = NULL,
    @ErrorSeverity INT = NULL,
    @ErrorProcedure VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Capturar información del contexto
    DECLARE @SourceServer VARCHAR(100) = @@SERVERNAME;
    DECLARE @SourceDatabase VARCHAR(100) = DB_NAME();
    DECLARE @UserName VARCHAR(100) = SUSER_SNAME();
    DECLARE @HostName VARCHAR(100) = HOST_NAME();
    DECLARE @SessionId INT = @@SPID;
    
    -- Si no se proporciona el procedimiento fuente, intentar capturarlo
    IF @SourceProcedure IS NULL
        SET @SourceProcedure = OBJECT_NAME(@@PROCID);
    
    BEGIN TRY
        -- Insertar en la tabla de bitácora remota
        INSERT INTO CENTRAL_LOG_SERVER.LoggingDB.dbo.SocaiRemoteLogs
        (
            SourceServer, SourceDatabase, SourceProcedure, LogLevel, 
            Message, AdditionalInfo, UserName, HostName, ExecutionTime,
            RelatedEntityId, RelatedEntityType, OriginalLogId, SessionId, 
            ErrorNumber, ErrorLine, ErrorState, ErrorSeverity, ErrorProcedure
        )
        VALUES
        (
            @SourceServer, @SourceDatabase, @SourceProcedure, @LogLevel,
            @Message, @AdditionalInfo, @UserName, @HostName, GETDATE(),
            @RelatedEntityId, @RelatedEntityType, @OriginalLogId, @SessionId,
            @ErrorNumber, @ErrorLine, @ErrorState, @ErrorSeverity, @ErrorProcedure
        );
        
        -- Registrar también localmente en caso de falla de conectividad (redundancia)
        INSERT INTO dbo.SocaiLogs 
        (
            description, postTime, computer, username, trace, 
            LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId
        )
        VALUES
        (
            @Message, 
            GETDATE(), 
            @HostName, 
            @UserName,
            ISNULL(@AdditionalInfo, N'Remote logging enabled'),
            -- Mapear LogLevel a LogTypeId
            CASE @LogLevel 
                WHEN 'Information' THEN 1
                WHEN 'Warning' THEN 2
                WHEN 'Error' THEN 3
                WHEN 'Critical' THEN 4
                ELSE 1
            END,
            5, -- Fuente: Remote Logging
            CASE @LogLevel 
                WHEN 'Information' THEN 1
                WHEN 'Warning' THEN 2
                WHEN 'Error' THEN 3
                WHEN 'Critical' THEN 4
                ELSE 1
            END,
            ISNULL(@RelatedEntityId, 1), -- Usuario administrador como fallback
            NULL
        );
        
        RETURN 0; -- Éxito
    END TRY
    BEGIN CATCH
        -- Capturar error de registro remoto y guardar localmente
        INSERT INTO dbo.SocaiLogs 
        (
            description, postTime, computer, username, trace, 
            LogTypeId, LogSourceId, LogSeverityId, UserId, TransactionId
        )
        VALUES
        (
            'Error al registrar en servidor remoto: ' + @Message, 
            GETDATE(), 
            @HostName, 
            @UserName,
            'Error: ' + ERROR_MESSAGE() + ', Mensaje original: ' + ISNULL(@AdditionalInfo, 'N/A'),
            3, -- Tipo: Error
            5, -- Fuente: Remote Logging
            3, -- Severidad: Alta
            1, -- Usuario admin
            NULL
        );
        
        RETURN ERROR_NUMBER(); -- Devolver código de error
    END CATCH;
END;
```

### Ejemplo de Uso del Procedimiento

```sql
CREATE OR ALTER PROCEDURE dbo.sp_EjemploUsoBitacoraRemota
    @UserId INT,
    @Operacion VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Lógica normal del procedimiento
        DECLARE @Resultado VARCHAR(100) = 'Operación ' + @Operacion + ' completada para usuario ' + CAST(@UserId AS VARCHAR);
        
        -- Registrar el éxito en bitácora remota
        EXEC dbo.sp_LogToRemoteServer 
            @LogLevel = 'Information',
            @Message = @Resultado,
            @RelatedEntityId = @UserId,
            @RelatedEntityType = 'Usuario';
            
        -- Devolver resultado
        SELECT @Resultado AS Resultado;
    END TRY
    BEGIN CATCH
        -- Registrar el error en bitácora remota
        EXEC dbo.sp_LogToRemoteServer 
            @LogLevel = 'Error',
            @Message = @Operacion,
            @AdditionalInfo = ERROR_MESSAGE(),
            @RelatedEntityId = @UserId,
            @RelatedEntityType = 'Usuario',
            @ErrorNumber = ERROR_NUMBER(),
            @ErrorLine = ERROR_LINE(),
            @ErrorState = ERROR_STATE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorProcedure = ERROR_PROCEDURE();
            
        -- Re-lanzar el error
        THROW;
    END CATCH;
END;
```

### Características

- **Centralización de Logs**: Permite almacenar logs de múltiples bases de datos/servidores en un único repositorio central.
- **Redundancia**: Mantiene un registro local en caso de fallos de conectividad con el servidor remoto.
- **Contexto Automático**: Captura automáticamente información del servidor, base de datos, usuario, host, etc.
- **Niveles de Severidad**: Soporta diferentes niveles de log (Information, Warning, Error, Critical).
- **Manejo de Errores**: Implementa captura y registro de detalles de error.
- **Integración con Sistema Existente**: Se integra con la tabla local SocaiLogs para mantener compatibilidad.

### Parámetros del Procedimiento sp_LogToRemoteServer

| Parámetro | Tipo | Descripción | Obligatorio |
|-----------|------|-------------|-------------|
| @LogLevel | VARCHAR(20) | Nivel de severidad del log (Information, Warning, Error, Critical) | Sí |
| @Message | VARCHAR(4000) | Mensaje principal del log | Sí |
| @AdditionalInfo | VARCHAR(MAX) | Información adicional o detallada | No |
| @SourceProcedure | VARCHAR(255) | Procedimiento que origina el log | No |
| @RelatedEntityId | INT | ID de la entidad relacionada (usuario, transacción, etc.) | No |
| @RelatedEntityType | VARCHAR(50) | Tipo de entidad relacionada | No |
| @OriginalLogId | INT | ID de un log relacionado | No |
| @ErrorNumber | INT | Número de error (en caso de excepciones) | No |
| @ErrorLine | INT | Línea donde ocurrió el error | No |
| @ErrorState | INT | Estado del error | No |
| @ErrorSeverity | INT | Severidad del error | No |
| @ErrorProcedure | VARCHAR(255) | Procedimiento donde ocurrió el error | No |

### Requisitos Previos

- Permisos para crear y configurar servidores vinculados.
- Permisos para ejecutar inserciones en el servidor remoto.
- Habilitación de RPC y RPC Out en la configuración del servidor.
- Existencia de la tabla SocaiLogs en la base de datos local.

### Consideraciones de Rendimiento

- Las operaciones de logging remoto pueden introducir latencia en las transacciones.
- Se recomienda usar este sistema principalmente para eventos importantes o errores críticos.
- Los índices en la tabla remota están diseñados para optimizar consultas comunes en los logs.


## 5. Concurrencia (Santi)

### 5.1 Objetivos  
1. **Dead‑locks** realistas (SELECT ⇄ UPDATE) y en *cascada*.  
2. Demostrar los cuatro **niveles de aislamiento** y sus efectos (lecturas sucias, phantom rows…).  
3. Ejemplo de **cursor de update** que bloquea fila‑a‑fila.  
4. **Transacción de volumen** (benchmark TPS) para medir y extrapolar capacidad.  
5. Vista auxiliar para comprobar en vivo el aislamiento de cada sesión.  

---

### 5.2 Escenario de Dead‑lock simple   `DL_A / DL_B`  
**Uso:** abrir **dos** conexiones.  
* Ventana‑1 → `EXEC dbo.DL_A`  
* Ventana‑2 → `EXEC dbo.DL_B`  
> El cruce SELECT → UPDATE / UPDATE → SELECT provoca el dead‑lock.
> 
```sql
IF OBJECT_ID('dbo.DL_A','P') IS NOT NULL DROP PROCEDURE dbo.DL_A;
GO
CREATE PROCEDURE dbo.DL_A AS
BEGIN
    BEGIN TRAN;
        SELECT *              FROM dbo.SocaiCommerceSettlement WHERE CommerceId = 1;
        WAITFOR DELAY '00:00:03';
        UPDATE dbo.SocaiPayments SET amount = amount WHERE PaymentId = 1;
    COMMIT;
END;
GO

IF OBJECT_ID('dbo.DL_B','P') IS NOT NULL DROP PROCEDURE dbo.DL_B;
GO
CREATE PROCEDURE dbo.DL_B AS
BEGIN
    BEGIN TRAN;
        UPDATE dbo.SocaiPayments SET amount = amount WHERE PaymentId = 1;
        WAITFOR DELAY '00:00:03';
        SELECT *              FROM dbo.SocaiCommerceSettlement WHERE CommerceId = 1;
    COMMIT;
END;
GO
```

### 5.3 Dead‑lock en cascada
**Uso**: tres conexiones independientes (A → B → C).
Demuestra que pueden formarse ciclos A bloquea B, B bloquea C, C bloquea A.

```sql
IF OBJECT_ID('dbo.Cascade_A','P') IS NOT NULL DROP PROCEDURE dbo.Cascade_A;
GO
CREATE PROCEDURE dbo.Cascade_A AS
BEGIN
    BEGIN TRAN;
        UPDATE dbo.SocaiSubscriptions SET amount = amount WHERE SubscriptionId = 1;   
        WAITFOR DELAY '00:00:05';
        SELECT 1 FROM dbo.SocaiPayments WHERE PaymentId = 1;                         
    COMMIT;
END;
GO

IF OBJECT_ID('dbo.Cascade_B','P') IS NOT NULL DROP PROCEDURE dbo.Cascade_B;
GO
CREATE PROCEDURE dbo.Cascade_B AS
BEGIN
    BEGIN TRAN;
        UPDATE dbo.SocaiPayments SET amount = amount WHERE PaymentId = 1;             
        WAITFOR DELAY '00:00:05';
        SELECT 1 FROM dbo.SocaiCommerceSettlement WHERE CommerceId = 1;              
    COMMIT;
END;
GO

IF OBJECT_ID('dbo.Cascade_C','P') IS NOT NULL DROP PROCEDURE dbo.Cascade_C;
GO
CREATE PROCEDURE dbo.Cascade_C AS
BEGIN
    BEGIN TRAN;
        UPDATE dbo.SocaiCommerceSettlement SET totalNet = totalNet WHERE CommerceId = 1; 
        WAITFOR DELAY '00:00:05';
        SELECT 1 FROM dbo.SocaiSubscriptions WHERE SubscriptionId = 1;                   
    COMMIT;
END;
GO
```
### 5.4 Demo de niveles de aislamiento
Permite repetir la misma lectura con distintos isolation levels y observar diferencias.
```sql
IF OBJECT_ID('dbo.demo_isolation','P') IS NOT NULL DROP PROCEDURE dbo.demo_isolation;
GO
CREATE PROCEDURE dbo.demo_isolation
    @level sysname = 'READ COMMITTED'     -- opciones: READ UNCOMMITTED | REPEATABLE READ | SERIALIZABLE
AS
BEGIN
    IF      @level = 'READ UNCOMMITTED'   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    ELSE IF @level = 'REPEATABLE READ'    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    ELSE IF @level = 'SERIALIZABLE'       SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    ELSE                                  SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    BEGIN TRAN;
        SELECT COUNT(*) AS totalAntes  FROM dbo.SocaiPayments;
        WAITFOR DELAY '00:00:05';          -- modificar datos en otra sesión durante la espera
        SELECT COUNT(*) AS totalDespues FROM dbo.SocaiPayments;
    ROLLBACK;
END;
GO
```
### 5.5 Cursor de actualización fila‑a‑fila
Ejemplo para que el equipo de desarrollo entienda cuándo un cursor bloquea registros.
```sql
IF OBJECT_ID('dbo.demo_cursorRegeneraSaldo','P') IS NOT NULL
    DROP PROCEDURE dbo.demo_cursorRegeneraSaldo;
GO
CREATE PROCEDURE dbo.demo_cursorRegeneraSaldo
AS
BEGIN
    DECLARE c CURSOR LOCAL FOR
        SELECT SuscriptionUserId
        FROM   dbo.SocaiBalancePerPerson
        ORDER BY SuscriptionUserId;

    DECLARE @id INT;
    OPEN c; FETCH NEXT FROM c INTO @id;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE dbo.SocaiBalancePerPerson
           SET updatedAt = SYSUTCDATETIME()
         WHERE CURRENT OF c;                     -- bloqueo por fila

        WAITFOR DELAY '00:00:02';
        FETCH NEXT FROM c INTO @id;
    END
    CLOSE c; DEALLOCATE c;
END;
GO
```
### 5.6 Transacción de volumen / Benchmark TPS
La “transacción de volumen” de Soltura es registrar una transacción de pago (INSERT INTO SocaiTransactions).
El procedimiento inserta en bucle durante n segundos y reporta TPS promedio.
```sql
IF OBJECT_ID('dbo.bench_volumenPago','P') IS NOT NULL
    DROP PROCEDURE dbo.bench_volumenPago;
GO
CREATE PROCEDURE dbo.bench_volumenPago
    @segundos INT = 10            -- duración de la prueba
AS
BEGIN
    DECLARE @ini DATETIME2 = SYSUTCDATETIME();

    WHILE DATEDIFF(SECOND,@ini,SYSUTCDATETIME()) < @segundos
    BEGIN
        INSERT dbo.SocaiTransactions
               (amount,transactionDateTime,postTime,
                TransactionTypeId,TransactionSubTypeId,
                CurrencyTypeId,PaymentId,UserId,ExchangeRateId)
        VALUES(1,SYSUTCDATETIME(),SYSUTCDATETIME(),1,1,1,1,1,1);
    END;

    DECLARE @total BIGINT =
        (SELECT COUNT(*) FROM dbo.SocaiTransactions
         WHERE transactionDateTime >= @ini);

    PRINT 'TPS ≈ ' + CONVERT(varchar,@total / NULLIF(@segundos,0))
        + '  (' + CONVERT(varchar,@total) + ' transacciones)';
END;
GO
```
### 5.7 Vista auxiliar
Muestra, por sesión de usuario, el nivel de aislamiento actualmente activo.
```sql
IF OBJECT_ID('dbo.vw_trxIsolation','V') IS NOT NULL
    DROP VIEW dbo.vw_trxIsolation;
GO
CREATE VIEW dbo.vw_trxIsolation
AS
SELECT  session_id,
        CASE transaction_isolation_level
             WHEN 0 THEN 'READ UNCOMMITTED'
             WHEN 1 THEN 'READ COMMITTED'
             WHEN 2 THEN 'REPEATABLE READ'
             WHEN 3 THEN 'SERIALIZABLE'
             WHEN 4 THEN 'SNAPSHOT' END AS isolation_level,
        last_request_start_time
FROM sys.dm_exec_sessions
WHERE is_user_process = 1;
GO
```
## 5.8 Cómo ejecutar las pruebas

| Objetivo                         | Sesión A (ventana 1)            | Sesión B (ventana 2)            | Sesión C (ventana 3) / Observación |
|---------------------------------|---------------------------------|---------------------------------|------------------------------------|
| **Dead‑lock simple**            | `EXEC dbo.DL_A;`                | `EXEC dbo.DL_B;`                | Dead‑lock visible en *Activity Monitor* o en `sys.dm_tran_deadlock_graph`. |
| **Dead‑lock en cascada**        | `EXEC dbo.Cascade_A;`           | `EXEC dbo.Cascade_B;`           | `EXEC dbo.Cascade_C;`              |
| **Demostración de aislamiento** | `EXEC dbo.demo_isolation 'READ COMMITTED';` (o nivel deseado) | Mientras corre, ejecutar DML que modifique `SocaiPayments`. | Comparar `totalAntes` vs `totalDespues`. |
| **Cursor de update**            | `EXEC dbo.demo_cursorRegeneraSaldo;` | (Opcional) segundo `UPDATE` sobre `SocaiBalancePerPerson` | Se observan bloqueos fila‑a‑fila. |
| **Benchmark TPS**               | `EXEC dbo.bench_volumenPago 15;` | *—* | El mensaje de salida muestra `TPS ≈ …`. |

> **Cómo triplicar el TPS sin hardware ni cambiar el query**  
> 1. Convertir `SocaiTransactions` en tabla **memory‑optimized** (Hekaton).  
> 2. Activar aislamiento **READ\_COMMITTED\_SNAPSHOT** para reducir bloqueos de lectura.  
> 3. Insertar en *lotes* (`INSERT … SELECT TOP (N)`) en lugar de fila a fila.

```sql
-- Activar versión optimista para lecturas
ALTER DATABASE Caso2 SET READ_COMMITTED_SNAPSHOT ON;
```

## 6. Noticias de Ultima Hora (Barquero)
## Migración de datos de Payment Assistant a SQL Server mediante Python

### 6.1. Contexto de la adquisición

Soltura ha adquirido "Payment Assistant" como parte de su estrategia de crecimiento en Costa Rica. Se ha decidido migrar completamente los usuarios y sus suscripciones a la plataforma Soltura, ofreciéndoles los mismos servicios que ya tenían más dos servicios adicionales por el mismo precio.

Entre las opciones disponibles para realizar esta migración (DBT, Logstash, SQL Server Integration Services), el equipo técnico ha optado por implementar la migración mediante **Python con Pandas**, desarrollando un notebook Jupyter que maneja todo el proceso de extracción, transformación y carga de datos.

### 6.2. Proceso de migración con Python

La migración se implementa en el archivo `migracionBD.ipynb`, un notebook de Jupyter que utiliza librerías como pandas, pyodbc y pymysql para manejar la migración de datos entre diferentes sistemas de bases de datos.

#### 6.2.1 Configuración de conexiones

El notebook configura las conexiones tanto para la base de datos de origen (MySQL - Payment Assistant) como para la de destino (SQL Server - Soltura):

```python
# Configuración de conexión a la base de datos fuente (MySQL) - Payment Assistant
mysql_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'password',
    'database': 'database'  
}

# Configuración de conexión a la base de datos destino (SQL Server) - Soltura
sqlserver_config = {
    'driver': '{ODBC Driver 17 for SQL Server}',
    'server': 'localhost',
    'database': 'Caso2',
    'trusted_connection': 'yes'
}

# Funciones de conexión
def connect_mysql():
    try:
        conn = pymysql.connect(
            host=mysql_config['host'],
            user=mysql_config['user'],
            password=mysql_config['password'],
            database=mysql_config['database']
        )
        return conn
    except Exception as e:
        print(f"Error conectando a MySQL: {e}")
        return None

def connect_sqlserver():
    try:
        conn = pyodbc.connect(
            f"DRIVER={sqlserver_config['driver']};"
            f"SERVER={sqlserver_config['server']};"
            f"DATABASE={sqlserver_config['database']};"
            f"Trusted_Connection={sqlserver_config['trusted_connection']};"
        )
        return conn
    except Exception as e:
        print(f"Error conectando a SQL Server: {e}")
        return None
```

#### 6.2.2 Proceso ETL (Extracción, Transformación y Carga)

El proceso de migración sigue el modelo ETL estándar, con funciones específicas para cada fase:

##### a) Extracción de datos de MySQL (Payment Assistant)

```python
# Función para extraer usuarios de Payment Assistant
def extract_users_from_source():
    conn = connect_mysql()
    if not conn:
        return None
    
    try:
        # Usamos la estructura real de las tablas de Payment Assistant
        query = """
        SELECT u.userid, u.name, ui.value as email, ua.addressid, u.fecha_registro, u.isactive,
               us.usersubsid, us.plansid, us.start_date, us.end_date, us.status, us.autorenew,
               pp.billingperiod as payment_frequency, pp.price, c.acronym as currency
        FROM users u
        LEFT JOIN contactinfoperperson ui ON u.userid = ui.userid
        LEFT JOIN contactinfotype ct ON ui.contactinfotypeid = ct.contactinfotypeid AND ct.name = 'Email'
        LEFT JOIN useraddresses ua ON u.userid = ua.userid
        LEFT JOIN userssubscriptions us ON u.userid = us.userid
        LEFT JOIN planpricing pp ON us.priceid = pp.priceid
        LEFT JOIN currencies c ON pp.currencyId = c.currencyId
        WHERE u.isactive = 1
        """
        
        df_users = pd.read_sql(query, conn)
        return df_users
    except Exception as e:
        print(f"Error extrayendo usuarios: {e}")
        return None
    finally:
        conn.close()
```

El notebook implementa funciones similares para extraer otros datos importantes:

```python
def extract_plans_from_source():
    # Extrae planes de suscripción
    
def extract_user_permissions():
    # Extrae permisos y roles de usuarios
    
def extract_user_contact_info():
    # Extrae información de contacto adicional
    
def extract_user_addresses():
    # Extrae direcciones de usuarios
    
def extract_user_payment_methods():
    # Extrae métodos de pago de usuarios
```

##### b) Transformación y mapeo de datos

La función clave para mapear planes del sistema adquirido a Soltura, creando planes equivalentes con beneficios adicionales:

```python
def map_plans_to_soltura(df_plans):
    """
    Mapea los planes del sistema fuente a los planes de Soltura
    Se crean nuevos planes en Soltura que incluyen lo del plan original más dos beneficios adicionales
    """
    conn = connect_sqlserver()
    if not conn:
        return None, None
    
    try:
        # Obtener planes actuales de Soltura
        cursor = conn.cursor()
        cursor.execute("SELECT SubscriptionId, Name, Description, amount, CurrencyTypeId FROM SocaiSubscriptions")
        soltura_plans = cursor.fetchall()
        
        # Mapear planes
        plan_mapping = {}
        new_plans = []
        
        for idx, plan in df_plans.iterrows():
            # Crear un nuevo plan en Soltura basado en el plan original
            new_plan_name = f"Migrado {plan['name']} Plus"
            new_plan_desc = f"Plan migrado desde {mysql_config['database']} con beneficios adicionales. {plan['description']}"
            
            # Los planes migrados serán personalizables
            is_customizable = 1
            
            # El monto será similar al original pero ajustado al tipo de moneda de Soltura
            amount = float(plan['price'])
            
            # Determinamos el CurrencyTypeId basado en la moneda del plan original
            currency_type_id = 3  # Default: CRC
            if plan['currency'] == 'USD':
                currency_type_id = 1
            elif plan['currency'] == 'EUR':
                currency_type_id = 2
            
            # Insertar el nuevo plan en Soltura
            sql = """
            INSERT INTO SocaiSubscriptions (Name, Description, isCustomizable, isActive, createdAt, updatedAt, amount, CurrencyTypeId)
            VALUES (?, ?, ?, 1, GETDATE(), GETDATE(), ?, ?)
            """
            cursor.execute(sql, (new_plan_name, new_plan_desc, is_customizable, amount, currency_type_id))
            
            # Obtener el ID del plan recién insertado
            cursor.execute("SELECT @@IDENTITY")
            new_plan_id = cursor.fetchone()[0]
            
            # Guardar la relación entre planes originales y nuevos
            plan_mapping[plan['plansid']] = new_plan_id
            new_plans.append({
                'source_plan_id': plan['plansid'],
                'soltura_plan_id': new_plan_id,
                'name': new_plan_name
            })
            
            # Agregar beneficios al nuevo plan
            # [Código de procesamiento de características originales]
            
            # Agregar dos beneficios adicionales (como prometió Soltura)
            cursor.execute("""
            SELECT TOP 2 f.FeatureId, f.UnitTypeId 
            FROM SocaiPlanFeatures f
            WHERE f.FeatureId NOT IN (
                SELECT fs.PlanFeatureId 
                FROM SocaiFeaturesSubscriptions fs 
                WHERE fs.SubscriptionId = ?
            )
            ORDER BY NEWID()
            """, (new_plan_id,))
            
            additional_features = cursor.fetchall()
            
            # Para cada característica adicional
            for feature in additional_features:
                feature_id = feature[0]
                unit_type_id = feature[1]
                
                # Seleccionamos un tipo de servicio apropiado
                cursor.execute("SELECT TOP 1 ServiceTypeId FROM SocaiServiceTypes ORDER BY NEWID()")
                service_type_id = cursor.fetchone()[0]
                
                # Insertamos la relación con un valor mayor para destacar que es un beneficio adicional
                sql = """
                INSERT INTO SocaiFeaturesSubscriptions 
                (PlanFeatureId, SubscriptionId, Quantity, UnitTypeId, CreatedAt, UpdatedAt, ServiceTypeId, MemberCount, IsMemberSpecific)
                VALUES (?, ?, 2.0, ?, GETDATE(), GETDATE(), ?, 1, 0)
                """
                cursor.execute(sql, (feature_id, new_plan_id, unit_type_id, service_type_id))
        
        conn.commit()
        return plan_mapping, new_plans
    except Exception as e:
        conn.rollback()
        print(f"Error mapeando planes: {e}")
        return None, None
    finally:
        conn.close()
```

##### c) Migración de usuarios y suscripciones

La función para migrar usuarios y sus suscripciones a Soltura:

```python
def migrate_users_and_subscriptions(df_users, plan_mapping, df_contact_info, df_addresses):
    """
    Migra los usuarios y sus suscripciones a Soltura utilizando los datos reales de Payment Assistant
    """
    conn = connect_sqlserver()
    if not conn:
        return None
    
    try:
        cursor = conn.cursor()
        
        # Crear tabla para mapeo de usuarios si no existe
        cursor.execute("""
        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SocaiUserMigrations')
        BEGIN
            CREATE TABLE SocaiUserMigrations (
                MigrationId INT IDENTITY(1,1) PRIMARY KEY,
                SourceUserId INT NOT NULL,
                SolturaUserId INT NOT NULL,
                SourceSystem VARCHAR(50) NOT NULL,
                MigrationDate DATETIME NOT NULL,
                ResetPassword BIT NOT NULL DEFAULT 1,
                OriginalEmail VARCHAR(255) NULL
            )
        END
        """)
        
        # Para cada usuario
        user_mapping = {}
        active_subscriptions = 0
        annual_subscriptions = 0
        
        # Agrupar usuarios por userid para evitar duplicados
        grouped_users = df_users.groupby('userid').first().reset_index()
        
        for idx, user in grouped_users.iterrows():
            # Verificamos si el usuario ya existe en Soltura (por email)
            if pd.notna(user['email']):
                cursor.execute("SELECT UserId FROM SocaiUsers WHERE Email = ?", (user['email'],))
                existing_user = cursor.fetchone()
            else:
                existing_user = None
            
            if existing_user:
                # Si existe, lo mapeamos
                user_mapping[user['userid']] = existing_user[0]
                
                # Registramos el mapeo
                cursor.execute("""
                INSERT INTO SocaiUserMigrations (SourceUserId, SolturaUserId, SourceSystem, MigrationDate, ResetPassword, OriginalEmail)
                VALUES (?, ?, ?, GETDATE(), 1, ?)
                """, (user['userid'], existing_user[0], mysql_config['database'], user['email']))
            else:
                # Si no existe, creamos un nuevo usuario
                # [Código para crear nuevo usuario y registrar mapeo...]
                
                # Si el usuario tiene una suscripción activa, la migramos
                if pd.notna(user['usersubsid']) and pd.notna(user['plansid']) and user['plansid'] in plan_mapping:
                    # Obtenemos el ID del plan en Soltura
                    soltura_plan_id = plan_mapping[user['plansid']]
                    
                    # Determinamos las fechas de inicio y fin
                    if pd.notna(user['start_date']):
                        start_date = user['start_date']
                    else:
                        start_date = datetime.now() - timedelta(days=random.randint(1, 15))
                    
                    if pd.notna(user['end_date']):
                        end_date = user['end_date']
                    else:
                        # Si es plan mensual, la fecha de fin es 30 días después del inicio
                        # Si es plan anual, la fecha de fin es 365 días después del inicio
                        if user['payment_frequency'] == 'monthly':
                            end_date = start_date + timedelta(days=30)
                            active_subscriptions += 1
                        else:  # anual
                            end_date = start_date + timedelta(days=365)
                            annual_subscriptions += 1
                            active_subscriptions += 1
                    
                    # Insertamos la suscripción
                    sql = """
                    INSERT INTO SocaiSubscriptionUser (enable, startDateTime, endDateTime, UserId, SubscriptionId)
                    VALUES (1, ?, ?, ?, ?)
                    """
                    cursor.execute(sql, (start_date, end_date, new_user_id, soltura_plan_id))
        
        conn.commit()
        print(f"Migración completa: {len(user_mapping)} usuarios migrados.")
        print(f"Suscripciones activas: {active_subscriptions}")
        print(f"Suscripciones anuales: {annual_subscriptions}")
        print(f"Suscripciones mensuales: {active_subscriptions - annual_subscriptions}")
        return user_mapping
    except Exception as e:
        conn.rollback()
        print(f"Error migrando usuarios: {e}")
        return None
    finally:
        conn.close()
```

##### d) Migración de permisos y métodos de pago

```python
def migrate_user_permissions(user_permissions, user_mapping):
    """
    Migra los permisos de los usuarios a Soltura
    """
    # [Código que implementa la migración de permisos...]

def migrate_payment_methods(df_payment_methods, user_mapping):
    """
    Migra los métodos de pago de los usuarios a Soltura
    """
    # [Código que implementa la migración de métodos de pago...]
```

##### e) Proceso de generación de emails para reseteo de contraseñas

Una parte importante de la migración es la generación de emails para que los usuarios restablezcan sus contraseñas, ya que no se migran las contraseñas originales:

```python
def generate_password_reset_emails():
    """
    Genera contenido para emails de restablecimiento de contraseña
    para los usuarios migrados
    """
    conn = connect_sqlserver()
    if not conn:
        return False
    
    try:
        cursor = conn.cursor()
        
        # Obtener usuarios con reseteo pendiente
        cursor.execute("""
        SELECT um.SolturaUserId, u.Email, u.Name, um.OriginalEmail
        FROM SocaiUserMigrations um
        JOIN SocaiUsers u ON um.SolturaUserId = u.UserId
        WHERE um.SourceSystem = ? AND um.ResetPassword = 1
        """, (mysql_config['database'],))
        
        users_to_reset = cursor.fetchall()
        
        # Crear contenido para emails
        reset_emails_content = []
        for user in users_to_reset:
            user_id = user[0]
            email = user[1]
            name = user[2]
            original_email = user[3] if user[3] else email
            
            # Generar token único para este usuario (simulado)
            reset_token = hashlib.sha256(f"{user_id}_{datetime.now()}".encode()).hexdigest()[:20]
            
            # Preparar contenido del email
            email_content = {
                "to": email,
                "subject": "Bienvenido a Soltura - Establece tu nueva contraseña",
                "body": f"""
                <html>
                <body>
                    <h2>Hola {name},</h2>
                    
                    <p>¡Bienvenido a Soltura! Tu cuenta de {mysql_config['database']} ha sido migrada exitosamente.</p>
                    
                    <p>Como parte del proceso de migración, necesitas establecer una nueva contraseña para acceder a todos tus beneficios, que ahora incluyen dos servicios adicionales sin costo extra.</p>
                    
                    <p>Para establecer tu contraseña, haz clic en el siguiente enlace:</p>
                    
                    <p><a href="https://soltura.com/reset-password?token={reset_token}&email={email}">Establecer mi nueva contraseña</a></p>
                    
                    <p>Este enlace expirará en 48 horas.</p>
                    
                    <p>Si no solicitaste este cambio o tienes alguna pregunta, por favor contáctanos respondiendo a este correo o llamando a nuestro servicio al cliente.</p>
                    
                    <p>Saludos,<br>
                    El equipo de Soltura</p>
                </body>
                </html>
                """
            }
            
            reset_emails_content.append(email_content)
        
        # Guardar los emails en un archivo JSON para procesamiento posterior
        with open("reset_password_emails.json", "w", encoding="utf-8") as f:
            json.dump(reset_emails_content, f, ensure_ascii=False, indent=4)
            
        print(f"Se generaron {len(reset_emails_content)} emails de restablecimiento de contraseña.")
        print("Los contenidos se guardaron en 'reset_password_emails.json' para su envío.")
        
        return True
    except Exception as e:
        print(f"Error generando emails de restablecimiento: {e}")
        return False
    finally:
        conn.close()
```

#### 6.2.3 Verificación del estado de la migración

Al final del proceso, el código implementa una verificación del estado general de la migración:

```python
def check_migration_status():
    """
    Verifica y muestra el estado de la migración:
    - Total de usuarios migrados
    - Distribución de usuarios por tipo de suscripción
    - Porcentaje de usuarios con credenciales reseteo pendiente
    """
    conn_sql = connect_sqlserver()
    if not conn_sql:
        return False
    
    try:
        cursor = conn_sql.cursor()
        
        # Verificar total de usuarios migrados
        cursor.execute("""
        SELECT COUNT(*) FROM SocaiUserMigrations
        WHERE SourceSystem = ?
        """, (mysql_config['database'],))
        
        total_migrated = cursor.fetchone()[0]
        
        # Verificar usuarios con reseteo de contraseña pendiente
        cursor.execute("""
        SELECT COUNT(*) FROM SocaiUserMigrations
        WHERE SourceSystem = ? AND ResetPassword = 1
        """, (mysql_config['database'],))
        
        reset_pending = cursor.fetchone()[0]
        
        # Verificar distribución de suscripciones
        cursor.execute("""
        SELECT s.Name AS PlanName, COUNT(su.SubscriptionUserId) AS UserCount
        FROM SocaiUserMigrations um
        JOIN SocaiUsers u ON um.SolturaUserId = u.UserId
        JOIN SocaiSubscriptionUser su ON u.UserId = su.UserId
        JOIN SocaiSubscriptions s ON su.SubscriptionId = s.SubscriptionId
        WHERE um.SourceSystem = ?
        GROUP BY s.Name
        ORDER BY UserCount DESC
        """, (mysql_config['database'],))
        
        subscription_distribution = cursor.fetchall()
        
        # Imprimir resultados
        print("\n=== ESTADO DE LA MIGRACIÓN ===")
        print(f"Total de usuarios migrados: {total_migrated}")
        if total_migrated > 0:
            print(f"Usuarios con reseteo de contraseña pendiente: {reset_pending} ({reset_pending/total_migrated*100:.2f}%)")
            
            print("\nDistribución de suscripciones:")
            for plan in subscription_distribution:
                print(f"  - {plan[0]}: {plan[1]} usuarios")
        
        return True
    except Exception as e:
        print(f"Error verificando estado de migración: {e}")
        return False
    finally:
        conn_sql.close()
```

#### 6.2.4 Función principal que coordina la ejecución

La función `main()` orquesta todo el proceso de migración, llamando a las funciones en el orden correcto:

```python
def main():
    print("Iniciando proceso de migración de datos a Soltura...")
    
    # 1. Extraer datos del sistema fuente
    print("Extrayendo usuarios...")
    df_users = extract_users_from_source()
    if df_users is None:
        print("Error: No se pudieron extraer los usuarios. Abortando.")
        return
    
    print(f"Se encontraron {len(df_users)} usuarios para migrar.")
    
    print("Extrayendo planes...")
    df_plans = extract_plans_from_source()
    if df_plans is None:
        print("Error: No se pudieron extraer los planes. Abortando.")
        return
    
    print(f"Se encontraron {len(df_plans)} planes para migrar.")
    
    print("Extrayendo permisos de usuarios...")
    user_permissions = extract_user_permissions()
    if user_permissions is None:
        print("Error: No se pudieron extraer los permisos. Abortando.")
        return
    
    print("Extrayendo información de contacto...")
    df_contact_info = extract_user_contact_info()
    if df_contact_info is None:
        print("Error: No se pudo extraer la información de contacto. Abortando.")
        return
    
    print("Extrayendo direcciones...")
    df_addresses = extract_user_addresses()
    if df_addresses is None:
        print("Error: No se pudieron extraer las direcciones. Abortando.")
        return
    
    print("Extrayendo métodos de pago...")
    df_payment_methods = extract_user_payment_methods()
    if df_payment_methods is None:
        print("Error: No se pudieron extraer los métodos de pago. Abortando.")
        return
    
    # 2. Mapear y migrar planes
    print("Mapeando planes a Soltura...")
    plan_mapping, new_plans = map_plans_to_soltura(df_plans)
    if plan_mapping is None:
        print("Error: No se pudieron mapear los planes. Abortando.")
        return
    
    print(f"Se mapearon {len(plan_mapping)} planes.")
    
    # 3. Migrar usuarios y sus suscripciones
    print("Migrando usuarios y suscripciones...")
    user_mapping = migrate_users_and_subscriptions(df_users, plan_mapping, df_contact_info, df_addresses)
    if user_mapping is None:
        print("Error: No se pudieron migrar los usuarios. Abortando.")
        return
    
    print(f"Se migraron {len(user_mapping)} usuarios.")
    
    # 4. Migrar permisos de usuarios
    print("Migrando permisos de usuarios...")
    success = migrate_user_permissions(user_permissions, user_mapping)
    if not success:
        print("Error: No se pudieron migrar los permisos.")
    
    # 5. Migrar métodos de pago
    print("Migrando métodos de pago...")
    success = migrate_payment_methods(df_payment_methods, user_mapping)
    if not success:
        print("Error: No se pudieron migrar los métodos de pago.")
    
    # 6. Crear banners de marketing
    print("Creando banners de marketing...")
    success = create_marketing_banners(mysql_config['database'])
    if not success:
        print("Error: No se pudieron crear los banners de marketing.")
    
    # 7. Generar emails de restablecimiento de contraseña
    print("Generando emails de restablecimiento de contraseña...")
    generate_password_reset_emails()
    
    # 8. Verificar estado final de la migración
    check_migration_status()
    
    print("\nProceso de migración completado.")
    
    # Resumen
    print("\n=== Resumen de la migración ===")
    print(f"Sistema origen: {mysql_config['database']}")
    print(f"Usuarios migrados: {len(user_mapping)}")
    print(f"Planes migrados: {len(plan_mapping)}")
    print("Nuevos planes creados:")
    for plan in new_plans:
        print(f"  - {plan['name']} (ID: {plan['soltura_plan_id']})")
```

### 6.3. Características clave de la implementación

#### 6.3.1 Tabla de mapeo para usuarios

Uno de los requerimientos importantes era crear un mecanismo para mantener la correspondencia entre usuarios del sistema adquirido y usuarios en Soltura. Esto se implementa mediante la creación de una tabla `SocaiUserMigrations`:

```sql
CREATE TABLE SocaiUserMigrations (
    MigrationId INT IDENTITY(1,1) PRIMARY KEY,
    SourceUserId INT NOT NULL,           -- ID en Payment Assistant
    SolturaUserId INT NOT NULL,          -- ID en Soltura
    SourceSystem VARCHAR(50) NOT NULL,   -- Nombre del sistema de origen
    MigrationDate DATETIME NOT NULL,     -- Fecha de migración
    ResetPassword BIT NOT NULL DEFAULT 1,-- Flag para reseteo de contraseña
    OriginalEmail VARCHAR(255) NULL      -- Email original en Payment Assistant
)
```

Esta tabla permite:
- Mantener la trazabilidad entre usuarios de ambos sistemas
- Identificar usuarios migrados para mostrarles banners específicos
- Gestionar el proceso de reseteo de contraseñas
- Permitir futuras integraciones o migraciones adicionales

#### 6.3.2 Creación de nuevos planes con beneficios adicionales

El sistema crea nuevos planes en Soltura basados en los planes existentes en Payment Assistant, pero con beneficios adicionales:

1. Se preservan todos los beneficios originales del plan de Payment Assistant
2. Se añaden automáticamente dos beneficios adicionales para cumplir con el requisito de ofrecer servicios extra sin costo adicional
3. Los planes nuevos tienen un nombre que indica su origen ("Migrado [Nombre Original] Plus")
4. Se mantienen los mismos precios originales, con conversión de moneda si es necesario

#### 6.3.3 Gestión de contraseñas y seguridad

Como fue requerido, las contraseñas no se migran. En su lugar:

1. Las cuentas migradas tienen una contraseña temporal (hash aleatorio)
2. Se marcan con un flag `ResetPassword = 1` en la tabla de mapeo
3. Se generan tokens de reseteo únicos para cada usuario
4. Se crean emails personalizados con enlaces para establecer nuevas contraseñas
5. Estos emails se almacenan en formato JSON para su posterior envío

#### 6.3.4 Preservación de información y relaciones

La migración preserva cuidadosamente:

1. **Información de contacto**: email, teléfono y direcciones
2. **Suscripciones activas**: se mantienen las fechas de inicio/fin y se respeta si son mensuales o anuales
3. **Permisos de usuario**: se mapean a roles y permisos equivalentes en Soltura
4. **Métodos de pago**: se migran con información enmascarada por seguridad

### 6.4. Métricas y estadísticas de la migración

La implementación incluye funciones para verificar y reportar el estado de la migración:

- Total de usuarios migrados
- Distribución entre suscripciones mensuales y anuales
- Cantidad de planes creados
- Distribución de usuarios por plan
- Porcentaje de usuarios con reseteo de contraseña pendiente

### 6.5. Mejoras potenciales para un entorno de producción

Para una implementación en producción, podrían considerarse las siguientes mejoras:

1. **Procesamiento por lotes**: Migrar usuarios en lotes de 100-200 para reducir el uso de memoria y mejorar la gestión de errores.

2. **Logs detallados**: Implementar un sistema de logs más robusto que registre cada operación y su resultado:

```python
def log_migration_step(step_name, source_id, destination_id, status, details=None):
    """
    Registra cada paso de la migración en una tabla de logs
    """
    conn = connect_sqlserver()
    try:
        cursor = conn.cursor()
        sql = """
        INSERT INTO SocaiMigrationLogs 
        (StepName, SourceId, DestinationId, Status, Details, LogDate)
        VALUES (?, ?, ?, ?, ?, GETDATE())
        """
        cursor.execute(sql, (step_name, source_id, destination_id, status, 
                            json.dumps(details) if details else None))
        conn.commit()
    except Exception as e:
        print(f"Error logging migration step: {e}")
    finally:
        conn.close()
```

3. **Proceso de rollback**: Implementar una función para deshacer la migración en caso de problemas:

```python
def rollback_migration(migration_batch_id):
    """
    Deshace una migración específica en caso de problemas
    """
    conn = connect_sqlserver()
    try:
        cursor = conn.cursor()
        # Identificar usuarios migrados en este lote
        cursor.execute("""
        SELECT SolturaUserId FROM SocaiUserMigrations 
        WHERE MigrationBatchId = ?
        """, (migration_batch_id,))
        
        users_to_rollback = [row[0] for row in cursor.fetchall()]
        
        # Eliminar suscripciones
        for user_id in users_to_rollback:
            cursor.execute("""
            DELETE FROM SocaiSubscriptionUser WHERE UserId = ?
            """, (user_id,))
        
        # Eliminar usuarios
        cursor.execute("""
        DELETE FROM SocaiUsers 
        WHERE UserId IN (SELECT SolturaUserId FROM SocaiUserMigrations WHERE MigrationBatchId = ?)
        """, (migration_batch_id,))
        
        # Eliminar registros de mapeo
        cursor.execute("""
        DELETE FROM SocaiUserMigrations WHERE MigrationBatchId = ?
        """, (migration_batch_id,))
        
        conn.commit()
        return True
    except Exception as e:
        conn.rollback()
        print(f"Error en rollback de migración: {e}")
        return False
    finally:
        conn.close()
```

4. **Implementación de transacciones**: Mejorar la gestión de transacciones para garantizar la integridad de los datos:

```python
def migrate_batch_with_transaction(batch_users):
    """
    Migra un lote de usuarios dentro de una única transacción
    """
    conn = connect_sqlserver()
    try:
        cursor = conn.cursor()
        cursor.execute("BEGIN TRANSACTION")
        
        # Generar ID de lote para seguimiento
        batch_id = str(uuid.uuid4())
        
        # Procesar cada usuario en el lote
        for user in batch_users:
            # Código de migración para este usuario
            # ...
        
        # Si todo fue exitoso, confirmar la transacción
        cursor.execute("COMMIT TRANSACTION")
        return True
    except Exception as e:
        cursor.execute("ROLLBACK TRANSACTION")
        print(f"Error en migración de lote: {e}")
        return False
    finally:
        conn.close()
```

### 6.6. Conclusión

La implementación de la migración mediante Python con Pandas demuestra varias ventajas:

1. **Flexibilidad**: El código puede adaptarse fácilmente a diferentes estructuras de datos de origen y destino.
2. **Trazabilidad**: Se mantiene un registro claro de la correspondencia entre usuarios y planes de ambos sistemas.
3. **Enriquecimiento**: Se añaden beneficios adicionales a los planes migrados según lo requerido.
4. **Seguridad**: Se implementa un proceso seguro para la gestión de contraseñas.
5. **Transparencia**: El proceso genera métricas y estadísticas detalladas sobre el resultado de la migración.

Esta solución cumple con todos los requisitos especificados por el CTO de Soltura para la migración de datos de Payment Assistant a la plataforma Soltura, facilitando la transición para los usuarios y asegurando que continúen recibiendo al menos los mismos servicios más beneficios adicionales por el mismo precio.
