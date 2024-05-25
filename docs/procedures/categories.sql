-- Listar todos los registros por Sucursal
DELIMITER //

CREATE PROCEDURE SP_V_CATEGORY_01(IN branchId INT(11))
BEGIN
    SELECT 
        id,
        branch_id,
        name,
        DATE_FORMAT(created_at, '%d/%m/%Y') AS created_at,
        is_active
    FROM 
        categories  
    WHERE  
        branch_id = branchId AND is_active = 1;
END //

DELIMITER ;

-- Obtener registro por ID
DELIMITER //

CREATE PROCEDURE SP_V_CATEGORY_02(IN categoryId INT(11))
BEGIN
    SELECT * FROM categories
    WHERE
        id = categoryId;
END //

DELIMITER ;

-- Eliminar Registro
DELIMITER //

CREATE PROCEDURE SP_D_CATEGORIA_01(IN categoryId INT(11))
BEGIN
    UPDATE categories
    SET
        is_active = 0
    WHERE
        id = categoryId;
END //

DELIMITER ;

-- Registrar nuevo registro
DELIMITER //

CREATE PROCEDURE SP_I_CATEGORIA_01(IN branchId INT(11), IN categoryName VARCHAR(150))
BEGIN
    INSERT INTO categories
    (branch_id, name, created_at, is_active)
    VALUES
    (branchId, categoryName, NOW(), 1);
END //

DELIMITER ;

-- Actualizar registro
DELIMITER //

CREATE PROCEDURE SP_U_CATEGORIA_01(IN categoryId INT(11), IN branchId INT(11), IN categoryName VARCHAR(150))
BEGIN
    UPDATE categories
    SET
        branch_id = branchId,
        name = categoryName
    WHERE
        id = categoryId;
END //

DELIMITER ;