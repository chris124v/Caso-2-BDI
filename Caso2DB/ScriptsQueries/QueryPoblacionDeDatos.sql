
--- Scripts&Queries Poblacion de Datos ----

use Caso2;

--- 1. Monedas ----

insert into SocaiCurrencyTypes (name, acronym, symbol) values ('Dolar Estadounidense', 'USD', '$');

insert into SocaiCurrencyTypes (name, acronym, symbol) values ('Euro', 'EUR', '€');

insert into SocaiCurrencyTypes (name, acronym, symbol) values ('Colon Costarricense', 'CRC', '₡');

select * from SocaiCurrencyTypes


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

--- 3. Comercios y Beneficios ----

--- Insercion de Files ----

--- File Types ---
insert into SocaiFileTypes (name, mimeType, icon, enabled)

values 
('Documento PDF', 'pdf', 'https://soltura.com/icons/pdf.png', 1),
('Documento Word', 'docx', 'https://soltura.com/icons/docx.png', 1),
('Documento Excel', 'xlsx', 'https://soltura.com/icons/xlsx.png', 1),
('Imagen JPG', 'jpg', 'https://soltura.com/icons/jpg.png', 1),
('Imagen PNG', 'png', 'https://soltura.com/icons/png.png', 1);

select * from SocaiFileTypes;

---- Insercion de Comercios ----

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

--- Insercion de Contactos de Comercio ---

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

--- Insercion Files de Comercios ----

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


--- Insercion de Tipos de Servicio ----

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

--- Insercion de Tax Rates ---

INSERT INTO SocaiTaxRates (Name, Rate, CountryId, IsActive, ValidFrom, ValidTo)
VALUES ('IVA General', 13.00, 1, 1, '2024-01-01', NULL);

SELECT * FROM SocaiTaxRates;

--- Insercion de Unit Types ---

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

--- Insercion de Listado de Servicios ---

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

--- Insercion de CommerceFeatures ----

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

select * from SocaiCommercesFeatures;

--- 3. Suscripciones y Planes ---

--- Planes Existentes ---

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

--- 4. Metodos de Pago ---

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

--- 5. Usuarios ---

--- Procedure ----

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

---- Insercion de los Usuarios con Suscripciones ----

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

-- Aqui seria la distribucion de suscripciones por plan
SELECT s.SubscriptionId, s.Name AS PlanName, 
       COUNT(su.SubscriptionUserId) AS TotalSuscripciones,
       SUM(CAST(su.enable AS INT)) AS SuscripcionesActivas
FROM SocaiSubscriptions s
LEFT JOIN SocaiSubscriptionUser su ON s.SubscriptionId = su.SubscriptionId
GROUP BY s.SubscriptionId, s.Name
ORDER BY s.SubscriptionId;
GO

