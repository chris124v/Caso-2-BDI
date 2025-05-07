-- Habilitar inserción de datos
SET FOREIGN_KEY_CHECKS=0;

-- 1. Población de monedas y países (con foco en Costa Rica)
INSERT INTO `paymentAssistant`.`currencies` (`currencyId`, `name`, `acronym`, `countryid`, `symbol`) VALUES
(1, 'Colón Costarricense', 'CRC', 1, '₡'),
(2, 'Dólar Estadounidense', 'USD', 1, '$'),
(3, 'Euro', 'EUR', 2, '€'),
(4, 'Peso Mexicano', 'MXN', 3, '$'),
(5, 'Quetzal Guatemalteco', 'GTQ', 4, 'Q');

INSERT INTO `paymentAssistant`.`country` (`countryid`, `name`, `currencyId`) VALUES
(1, 'Costa Rica', 1),  -- CRC como moneda principal
(2, 'España', 3),
(3, 'México', 4),
(4, 'Guatemala', 5),
(5, 'Estados Unidos', 2);

-- 2. Población de provincias y cantones de Costa Rica
INSERT INTO `paymentAssistant`.`state` (`stateid`, `name`, `countryid`) VALUES
(1, 'San José', 1),
(2, 'Alajuela', 1),
(3, 'Cartago', 1),
(4, 'Heredia', 1),
(5, 'Guanacaste', 1),
(6, 'Puntarenas', 1),
(7, 'Limón', 1);

INSERT INTO `paymentAssistant`.`city` (`cityid`, `name`, `stateid`) VALUES
-- San José
(1, 'San José', 1),
(2, 'Escazú', 1),
(3, 'Desamparados', 1),
-- Alajuela
(4, 'Alajuela', 2),
(5, 'San Ramón', 2),
-- Cartago
(6, 'Cartago', 3),
(7, 'Paraíso', 3),
-- Heredia
(8, 'Heredia', 4),
(9, 'San Rafael', 4),
-- Guanacaste
(10, 'Liberia', 5),
(11, 'Nicoya', 5),
-- Puntarenas
(12, 'Puntarenas', 6),
(13, 'Quepos', 6),
-- Limón
(14, 'Limón', 7),
(15, 'Guápiles', 7);

-- 3. Lista de nombres y apellidos comunes en Costa Rica
SET @nombres_masculinos = 'Juan,Carlos,Luis,Miguel,José,Andrés,Diego,Fernando,Jorge,Daniel,Marco,Esteban,Alberto,Roberto,Eduardo,Pablo,Manuel,Ricardo,David,Francisco';
SET @nombres_femeninos = 'María,Ana,Laura,Sofía,Isabel,Carmen,Elena,Patricia,Adriana,Andrea,Silvia,Paula,Valeria,Natalia,Carolina,Jimena,Daniela,Mariana,Gabriela,Luisa';
SET @apellidos = 'González,Rodríguez,Hernández,Morales,Chaves,Vargas,Méndez,Jiménez,Rojas,Alvarado,Madriz,Castro,Quirós,Araya,Fernández,López,Ramírez,Pérez,Soto,Valverde';

-- 4. Función para generar nombres aleatorios
DELIMITER //
CREATE FUNCTION generar_nombre_costarricense() RETURNS VARCHAR(80)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(80);
    DECLARE genero INT;
    DECLARE nombre VARCHAR(40);
    DECLARE apellido1 VARCHAR(40);
    DECLARE apellido2 VARCHAR(40);
    
    -- Elegir género aleatorio
    SET genero = FLOOR(1 + RAND() * 2);
    
    -- Seleccionar nombre según género
    IF genero = 1 THEN
        SET nombre = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(@nombres_masculinos, ',', 1 + FLOOR(RAND() * 20)), ',', -1));
    ELSE
        SET nombre = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(@nombres_femeninos, ',', 1 + FLOOR(RAND() * 20)), ',', -1));
    END IF;
    
    -- Seleccionar dos apellidos
    SET apellido1 = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(@apellidos, ',', 1 + FLOOR(RAND() * 20)), ',', -1));
    SET apellido2 = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(@apellidos, ',', 1 + FLOOR(RAND() * 20)), ',', -1));
    
    -- Combinar nombre y apellidos
    SET nombre_completo = CONCAT(nombre, ' ', apellido1, ' ', apellido2);
    
    RETURN nombre_completo;
END //
DELIMITER ;

-- 5. Población de usuarios costarricenses con nombres reales (1000 usuarios activos)
DELIMITER //
CREATE PROCEDURE populate_cr_users_real_names()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE user_type VARCHAR(100);
    DECLARE city_id INT;
    DECLARE country_id TINYINT DEFAULT 1; -- Costa Rica
    DECLARE nombre_completo VARCHAR(80);
    
    WHILE i <= 1000 DO
        -- Asignar tipo de usuario (70% individual, 30% empresa)
        IF RAND() < 0.7 THEN
            SET user_type = 'individual';
            -- Generar nombre de persona real
            SET nombre_completo = generar_nombre_costarricense();
        ELSE
            SET user_type = 'empresa';
            -- Generar nombre de empresa costarricense
            SET nombre_completo = CONCAT(
                CASE 
                    WHEN RAND() < 0.3 THEN 'Grupo '
                    WHEN RAND() < 0.6 THEN 'Corporación '
                    WHEN RAND() < 0.8 THEN 'Servicios '
                    ELSE ''
                END,
                TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(@apellidos, ',', 1 + FLOOR(RAND() * 20)), ',', -1)),
                CASE 
                    WHEN RAND() < 0.4 THEN ' S.A.'
                    WHEN RAND() < 0.7 THEN ' & Asociados'
                    ELSE ' Costa Rica'
                END
            );
        END IF;
        
        -- Seleccionar ciudad aleatoria de Costa Rica (1-15)
        SET city_id = FLOOR(1 + RAND() * 15);
        
        -- Insertar usuario
        INSERT INTO `paymentAssistant`.`users` (`name`, `fecha_registro`, `password`, `usertype`, `isactive`, `countryid`)
        VALUES (
            nombre_completo,
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY),
            UNHEX(SHA2(CONCAT('password', i), 256)),
            user_type,
            1,
            country_id
        );
        
        -- Obtener el ID del usuario recién insertado
        SET @user_id = LAST_INSERT_ID();
        
        -- Insertar dirección para el usuario
        INSERT INTO `paymentAssistant`.`addresses` (`line1`, `line2`, `zipcode`, `cityid`, `latitude`, `longitude`, `isdefault`)
        VALUES (
            CONCAT('Calle ', FLOOR(1 + RAND() * 100), ', #', FLOOR(1 + RAND() * 50)),
            CASE WHEN RAND() < 0.7 THEN CONCAT('Apartado ', FLOOR(100 + RAND() * 900)) ELSE '' END,
            CONCAT(FLOOR(10000 + RAND() * 90000)),
            city_id,
            9 + (RAND() * 2),  -- Latitud aproximada de CR
            -84 - (RAND() * 2), -- Longitud aproximada de CR
            1
        );
        
        SET @address_id = LAST_INSERT_ID();
        
        -- Relacionar usuario con dirección
        INSERT INTO `paymentAssistant`.`useraddresses` (`userid`, `addressid`, `enabled`)
        VALUES (@user_id, @address_id, 1);
        
        -- Insertar información de contacto (teléfono costarricense)
        INSERT INTO `paymentAssistant`.`contactinfotype` (`contactinfotypeid`, `name`) VALUES 
        (1, 'Teléfono móvil'), (2, 'Teléfono fijo'), (3, 'Correo electrónico')
        ON DUPLICATE KEY UPDATE name=name;
        
        INSERT INTO `paymentAssistant`.`contactinfoperperson` (`userid`, `contactinfotypeid`, `value`, `enabled`, `lastupdate`)
        VALUES (
            @user_id,
            1,
            CONCAT('+506 ', FLOOR(60000000 + RAND() * 20000000)),
            1,
            NOW()
        );
        
        INSERT INTO `paymentAssistant`.`contactinfoperperson` (`userid`, `contactinfotypeid`, `value`, `enabled`, `lastupdate`)
        VALUES (
            @user_id,
            3,
            LOWER(CONCAT(
                REPLACE(SUBSTRING_INDEX(nombre_completo, ' ', 1), '.',
                REPLACE(SUBSTRING_INDEX(nombre_completo, ' ', -1)),
                '@',
                CASE 
                    WHEN RAND() < 0.3 THEN 'gmail.com'
                    WHEN RAND() < 0.6 THEN 'yahoo.com'
                    WHEN RAND() < 0.8 THEN 'hotmail.com'
                    ELSE 'costarricense.cr'
                END
            )),
            1,
            NOW()
        );
        
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL populate_cr_users_real_names();
DROP PROCEDURE populate_cr_users_real_names;
DROP FUNCTION IF EXISTS generar_nombre_costarricense;

-- [El resto del script permanece igual que en la versión anterior...]
-- Continúa con la población de planes, suscripciones, métodos de pago, etc.

-- 6. Población de planes (2 planes activos)
INSERT INTO `paymentAssistant`.`plans` (`plansid`, `name`, `description`, `isactive`, `createdat`, `updatedat`) VALUES
(1, 'Básico', 'Plan básico con funcionalidades esenciales', 1, NOW(), NOW()),
(2, 'Premium', 'Plan premium con todas las funcionalidades', 1, NOW(), NOW());

-- 7. Población de precios para los planes (en CRC y USD)
INSERT INTO `paymentAssistant`.`planpricing` (`billingperiod`, `price`, `createdat`, `updatedat`, `plansid`, `currencyId`) VALUES
-- Plan Básico
('monthly', 10000, NOW(), NOW(), 1, 1),  -- 10,000 CRC mensuales
('yearly', 100000, NOW(), NOW(), 1, 1),  -- 100,000 CRC anuales
('monthly', 20, NOW(), NOW(), 1, 2),     -- 20 USD mensuales
('yearly', 200, NOW(), NOW(), 1, 2),     -- 200 USD anuales
-- Plan Premium
('monthly', 20000, NOW(), NOW(), 2, 1),  -- 20,000 CRC mensuales
('yearly', 200000, NOW(), NOW(), 2, 1),  -- 200,000 CRC anuales
('monthly', 40, NOW(), NOW(), 2, 2),     -- 40 USD mensuales
('yearly', 400, NOW(), NOW(), 2, 2);     -- 400 USD anuales

-- 8. Población de suscripciones (70% mensual, 30% anual)
INSERT INTO `paymentAssistant`.`userssubscriptions` (`userid`, `start_date`, `end_date`, `autorenew`, `status`, `createdat`, `updateat`, `plansid`, `priceid`)
SELECT 
    u.userid,
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY) AS start_date,
    CASE 
        WHEN RAND() < 0.7 THEN DATE_ADD(NOW(), INTERVAL 1 MONTH)  -- 70% mensual
        ELSE DATE_ADD(NOW(), INTERVAL 1 YEAR)                      -- 30% anual
    END AS end_date,
    1 AS autorenew,
    'active' AS status,
    NOW() AS createdat,
    NOW() AS updateat,
    FLOOR(1 + RAND() * 2) AS plansid,  -- Plan 1 o 2
    CASE 
        WHEN RAND() < 0.7 THEN 
            CASE 
                WHEN FLOOR(1 + RAND() * 2) = 1 THEN 1  -- Básico mensual CRC
                ELSE 5                                -- Premium mensual CRC
            END
        ELSE
            CASE 
                WHEN FLOOR(1 + RAND() * 2) = 1 THEN 2  -- Básico anual CRC
                ELSE 6                                 -- Premium anual CRC
            END
    END AS priceid
FROM `paymentAssistant`.`users` u
WHERE u.userid <= 700;  -- 70% de 1000 usuarios tienen plan activo

-- 9. Población de métodos de pago comunes en Costa Rica
INSERT INTO `paymentAssistant`.`paymentmethods` (`paymentmethodid`, `name`, `APIurl`, `securityKey`, `key`, `enabled`) VALUES
(1, 'Tarjeta de Crédito', 'https://api.payments.com/cards', UNHEX(SHA2('securekey1', 256)), UNHEX(SHA2('apikey1', 256)), 1),
(2, 'Sinpe Móvil', 'https://api.sinpe.com/mobile', UNHEX(SHA2('securekey2', 256)), UNHEX(SHA2('apikey2', 256)), 1),
(3, 'Transferencia Bancaria', 'https://api.bancos.cr/transfer', UNHEX(SHA2('securekey3', 256)), UNHEX(SHA2('apikey3', 256)), 1),
(4, 'PayPal', 'https://api.paypal.com/v1', UNHEX(SHA2('securekey4', 256)), UNHEX(SHA2('apikey4', 256)), 1);

-- 10. Población de métodos de pago de usuarios
INSERT INTO `paymentAssistant`.`userpaymentmethods` (`userid`, `paymentmethodid`, `accountinfo`, `accountnumber`, `expirationdate`, `isdefault`, `enabled`, `createdat`, `updatedat`)
SELECT 
    u.userid,
    CASE 
        WHEN RAND() < 0.6 THEN 1  -- 60% Tarjeta de crédito
        WHEN RAND() < 0.8 THEN 2  -- 20% Sinpe Móvil (del restante 40%)
        WHEN RAND() < 0.9 THEN 3  -- 10% Transferencia bancaria
        ELSE 4                    -- 10% PayPal
    END AS paymentmethodid,
    CASE 
        WHEN RAND() < 0.6 THEN CONCAT('VISA ', FLOOR(1000 + RAND() * 9000), ' **** **** ', FLOOR(1000 + RAND() * 9000))
        WHEN RAND() < 0.8 THEN CONCAT('SINPE: ', FLOOR(60000000 + RAND() * 20000000))
        WHEN RAND() < 0.9 THEN CONCAT('BAC CR - Cuenta ', FLOOR(100000000 + RAND() * 900000000))
        ELSE CONCAT('PayPal: ', LOWER(REPLACE(SUBSTRING_INDEX(u.name, ' ', 1)), '.', REPLACE(SUBSTRING_INDEX(u.name, ' ', -1)), '@example.com')
    END AS accountinfo,
    CASE 
        WHEN RAND() < 0.6 THEN CONCAT(FLOOR(1000000000000000 + RAND() * 9000000000000000))
        WHEN RAND() < 0.8 THEN CONCAT(FLOOR(60000000 + RAND() * 20000000))
        WHEN RAND() < 0.9 THEN CONCAT(FLOOR(100000000 + RAND() * 900000000))
        ELSE CONCAT('PP', FLOOR(10000000 + RAND() * 90000000))
    END AS accountnumber,
    CASE 
        WHEN RAND() < 0.6 THEN DATE_ADD(NOW(), INTERVAL FLOOR(12 + RAND() * 24) MONTH)
        ELSE NULL
    END AS expirationdate,
    CASE WHEN RAND() < 0.3 THEN 1 ELSE 0 END AS isdefault,
    1 AS enabled,
    NOW() AS createdat,
    NOW() AS updatedat
FROM `paymentAssistant`.`users` u
WHERE u.userid <= 700;  -- Usuarios con suscripción activa

-- 11. Población de pagos
INSERT INTO `paymentAssistant`.`payments` (`amount`, `actualmamount`, `description`, `error`, `date`, `checksum`, `currencyId`, `userpaymentmethodid`, `usersubsid`)
SELECT
    pp.price AS amount,
    pp.price AS actualmamount,
    CONCAT('Pago de suscripción ', p.name) AS description,
    NULL AS error,
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY) AS date,
    UNHEX(SHA2(CONCAT('payment', us.usersubsid), 256)) AS checksum,
    pp.currencyId,
    upm.userpaymentmethodid,
    us.usersubsid
FROM `paymentAssistant`.`userssubscriptions` us
JOIN `paymentAssistant`.`planpricing` pp ON us.priceid = pp.priceid
JOIN `paymentAssistant`.`plans` p ON pp.plansid = p.plansid
JOIN `paymentAssistant`.`users` u ON us.userid = u.userid
JOIN `paymentAssistant`.`userpaymentmethods` upm ON u.userid = upm.userid
WHERE upm.isdefault = 1;

-- 12. Población de transacciones
INSERT INTO `paymentAssistant`.`transactions` (`transaction_date`, `idpayments`, `transaction_amount`, `transaction_state`, `error_description`, `paymentsid`, `description`, `referenceNumber`, `checksum`, `exchangeRateId`, `currencyId`)
SELECT
    p.date AS transaction_date,
    NULL AS idpayments,
    p.amount AS transaction_amount,
    'successful' AS transaction_state,
    '' AS error_description,
    p.paymentsid,
    p.description,
    CONCAT('REF-', FLOOR(100000 + RAND() * 900000)) AS referenceNumber,
    p.checksum,
    1 AS exchangeRateId,
    p.currencyId
FROM `paymentAssistant`.`payments` p;

-- Restaurar controles de integridad
SET FOREIGN_KEY_CHECKS=1;

-- Mensaje final
SELECT 'Base de datos poblada exitosamente con nombres reales costarricenses' AS Resultado;