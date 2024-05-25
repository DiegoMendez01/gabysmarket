-- Listar todos los registros
DELIMITER //

CREATE PROCEDURE SP_V_COMPANY_01()
BEGIN
    SELECT * FROM companies
    WHERE
        is_active = 1;
END //

DELIMITER ;

-- Obtener registro por ID
DELIMITER //

CREATE PROCEDURE SP_V_COMPANY_02(IN companyId INT(11))
BEGIN
    SELECT * FROM companies
    WHERE
        id = companyId;
END //

DELIMITER ;

-- Eliminar Registro
DELIMITER //

CREATE PROCEDURE SP_D_COMPANY_01(IN companyId INT(11))
BEGIN
    UPDATE companies
    SET
        is_active = 0
    WHERE
        id = companyId;
END //

DELIMITER ;

-- Registrar nuevo registro
DELIMITER //

CREATE PROCEDURE SP_I_COMPANY_01(IN companyName VARCHAR(150))
BEGIN
    INSERT INTO companies
    (name, created_at, is_active)
    VALUES
    (companyName, NOW(), 1);
END //

DELIMITER ;

-- Actualizar registro
DELIMITER //

CREATE PROCEDURE SP_U_COMPANY_01(
    IN companyId INT(11),
    IN companyName VARCHAR(150)
)
BEGIN
    UPDATE companies
    SET
        name = companyName
    WHERE
        id = companyId;
END //

DELIMITER ;