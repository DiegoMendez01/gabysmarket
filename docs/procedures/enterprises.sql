DELIMITER //

-- Listar todos los registros
CREATE PROCEDURE SP_V_ENTERPRISE_01(
    IN enterpriseId INT(11)
)
BEGIN
    SELECT * FROM enterprises
    WHERE
        id = enterpriseId
    AND is_active = 1;
END //

-- Obtener registro por ID
CREATE PROCEDURE SP_V_ENTERPRISE_02(
    IN enterpriseId INT(11)
)
BEGIN
    SELECT * FROM enterprises
    WHERE
    id = enterpriseId;
END //

-- Eliminar Registro
CREATE PROCEDURE SP_D_ENTERPRISE_01(
    IN enterpriseId INT(11)
)
BEGIN
    UPDATE enterprises
    SET
        is_active = 0
    WHERE
        id = enterpriseId;
END //

-- Registrar nuevo registro
CREATE PROCEDURE SP_I_ENTERPRISE_01(
    IN companyId INT(11),
    IN enterpriseName VARCHAR(150),
    IN enterpriseRuc VARCHAR(50)
)
BEGIN
    INSERT INTO TM_EMPRESA
        (company_id, name, RUC, created_at)
    VALUES
        (companyId, enterpriseName, enterpriseRuc, NOW());
END //

-- Actualizar registro
CREATE PROCEDURE SP_U_ENTERPRISE_01(
    IN enterpriseId INT(11),
    IN companyId INT(11),
    IN enterpriseName VARCHAR(150),
    IN enterpriseRuc VARCHAR(50)
)
BEGIN
    UPDATE TM_EMPRESA
    SET
        company_id = companyId,
        name = enterpriseName,
        RUC = enterpriseRuc
    WHERE
        id = enterpriseId;
END //

DELIMITER ;