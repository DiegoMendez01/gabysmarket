-- Listar todos los registros por Compañia
DELIMITER //

CREATE PROCEDURE SP_V_CUSTOMER_01(IN companyId INT(11))
BEGIN
    SELECT * FROM customers
    WHERE
        company_id = companyId
        AND is_active = 1;
END //

DELIMITER ;

-- Obtener registro por ID
DELIMITER //

CREATE PROCEDURE SP_V_CUSTOMER_02(IN customerId INT(11))
BEGIN
    SELECT * FROM customers
    WHERE
        id = customerId;
END //

DELIMITER ;

-- Eliminar Registro
DELIMITER //

CREATE PROCEDURE SP_D_CUSTOMER_01(IN customerId INT(11))
BEGIN
    UPDATE customers
    SET
        is_active = 0
    WHERE
        id = customerId;
END //

DELIMITER ;

-- Registrar nuevo registro
DELIMITER //

CREATE PROCEDURE SP_I_CUSTOMER_01(
    IN companyId INT(11),
    IN customerName VARCHAR(150),
    IN customerRuc VARCHAR(50),
    IN customerPhone VARCHAR(50),
    IN customerAddress VARCHAR(150),
    IN customerEmail VARCHAR(150)
)
BEGIN
    INSERT INTO customers
    (name, company_id, RUC, phone, address, email, created_at, is_active)
    VALUES
    (customerName, companyId, customerRuc, customerPhone, customerAddress, customerEmail, NOW(), 1);
END //

DELIMITER ;

-- Actualizar registro
DELIMITER //

CREATE PROCEDURE SP_U_CUSTOMER_01(
    IN customerId INT(11),
    IN customerName VARCHAR(150),
    IN companyId INT(11),
    IN customerRuc VARCHAR(150),
    IN customerPhone VARCHAR(150),
    IN customerAddress VARCHAR(150),
    IN customerEmail VARCHAR(100)
)
BEGIN
    UPDATE customers
    SET
        name = customerName,
        company_id = companyId,
        RUC = customerRuc,
        phone = customerPhone,
        address = customerAddress,
        email = customerEmail
    WHERE
        id = customerId;
END //

DELIMITER ;