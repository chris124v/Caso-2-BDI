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


## 2. Demostraciones T-SQL (uso de instrucciones específicas) (Chris)

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
