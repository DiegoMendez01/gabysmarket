-- Insertar nueva compra
DELIMITER //

CREATE PROCEDURE SP_I_PURCHASE_01(IN branchId INT(11), IN userId INT(11))
BEGIN
    INSERT INTO purchases 
        (branch_id, user_id, status_purchase)
    VALUES
        (branchId, userId, 2);

    SELECT LAST_INSERT_ID() AS id;
END //

DELIMITER ;

-- Insertar detalle de compra
DELIMITER //

CREATE PROCEDURE SP_I_PURCHASE_02(
    IN purchaseId INT(11),
    IN productId INT(11),
    IN purchasePrice DECIMAL(18, 2),
    IN purchaseQuantity INT(11)
)
BEGIN
    INSERT INTO purchase_details
        (purchase_id, product_id, price, quantity, total, created_at, is_active)
    VALUES
        (purchaseId, productId, purchasePrice, purchaseQuantity, purchasePrice * purchaseQuantity, NOW(), 1);
END //

DELIMITER ;

-- Listar detalles de compra por ID de compra
DELIMITER //

CREATE PROCEDURE SP_V_PURCHASE_01(IN purchaseId INT(11))
BEGIN
    SELECT
        pd.id,
        c.name AS nameCategory,
        pr.name AS nameProduct,
        u.name AS nameUnit,
        pd.price,
        pd.quantity,
        pd.total,
        pd.purchase_id,
        pd.product_id
    FROM
        purchase_details AS pd
    INNER JOIN products AS pr ON pd.product_id = pr.id
    INNER JOIN categories AS c ON pr.category_id = c.id
    INNER JOIN units AS u ON pr.unit_id = u.id
    WHERE
        pd.purchase_id = purchaseId
        AND pd.is_active = 1;
END //

DELIMITER ;

-- Eliminar detalle de compra
DELIMITER //

CREATE PROCEDURE SP_D_PURCHASE_01(IN purchaseDetailId INT(11))
BEGIN
    UPDATE purchase_details
    SET
        is_active = 0
    WHERE
        id = purchaseDetailId;
END //

DELIMITER ;

-- Actualizar totales de compra
DELIMITER //

CREATE PROCEDURE SP_U_PURCHASE_01(IN purchaseId INT(11))
BEGIN
    UPDATE purchases
    SET
        subtotal = (SELECT SUM(total) FROM purchase_details WHERE purchase_id = purchaseId AND is_active = 1),
        iva = (SELECT SUM(total) FROM purchase_details WHERE purchase_id = purchaseId AND is_active = 1) * 0.19,
        total = (SELECT SUM(total) FROM purchase_details WHERE purchase_id = purchaseId AND is_active = 1) * 1.19
    WHERE
        id = purchaseId;
    
    SELECT 
        subtotal,
        iva,
        total 
    FROM 
        purchases
    WHERE
        id = purchaseId;
END //

DELIMITER ;

-- Listar compras por ID de sucursal
DELIMITER //

CREATE PROCEDURE SP_V_PURCHASE_02(IN purchaseId INT(11))
BEGIN
    SELECT
        p.id, 
        p.branch_id, 
        p.payment_id, 
        p.supplier_id, 
        p.RUC AS rucPurchase, 
        p.address, 
        p.email, 
        p.subtotal, 
        p.iva, 
        p.total, 
        p.comment, 
        p.user_id, 
        p.currency_id, 
        p.created_at, 
        p.status_purchase, 
        b.name AS nameBranch, 
        ep.name AS nameEnterprise, 
        ep.RUC AS rucEnterprise, 
        ep.email, 
        ep.phone, 
        ep.address,
        c.name AS nameCompany, 
        u.email AS emailUser, 
        u.name AS nameUser, 
        u.last_name, 
        u.identification, 
        u.phone AS phoneUser, 
        r.name AS nameRol, 
        py.name AS namePayment, 
        cr.name as nameCurrency,
        sp.name AS nameSupplier
    FROM            
        purchases AS p 
    INNER JOIN branchs AS b ON p.branch_id = b.id 
    INNER JOIN enterprises AS ep ON b.enterprise_id = ep.id 
    INNER JOIN companies AS c ON ep.company_id = c.id 
    INNER JOIN users AS u ON p.user_id = u.id 
    INNER JOIN roles AS r ON u.role_id = r.id 
    INNER JOIN payments AS py ON p.payment_id = py.id 
    INNER JOIN currencies AS cr ON p.currency_id = cr.id 
    INNER JOIN suppliers AS sp ON p.supplier_id = sp.id
    WHERE  
        p.id = purchaseId;
END //

DELIMITER ;

-- Actualizar compra y detalles relacionados
DELIMITER //

CREATE PROCEDURE SP_U_PURCHASE_03(
    IN purchaseId INT, 
    IN paymentId INT, 
    IN supplierId INT, 
    IN supplierRuc VARCHAR(150), 
    IN supplierAddress VARCHAR(150), 
    IN supplierEmail VARCHAR(150), 
    IN purchaseComment VARCHAR(250), 
    IN currencyId INT
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE purchaseDetailId INT;

    -- Declaración del cursor
    DECLARE CUR CURSOR FOR SELECT id FROM purchase_details WHERE purchase_id = purchaseId;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Actualizar la tabla de compras
    UPDATE purchases  
    SET  
        payment_id = paymentId,  
        supplier_id = supplierId,  
        RUC = supplierRuc,  
        address = supplierAddress,  
        email = supplierEmail,  
        comment = purchaseComment,  
        currency_id = currencyId,  
        created_at = NOW(),  
        status_purchase = 1
    WHERE  
        id = purchaseId;

    -- Abrir el cursor
    OPEN CUR;

    -- Bucle para leer el cursor
    read_loop: LOOP
        FETCH CUR INTO purchaseDetailId;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Actualizar el stock del producto
        UPDATE products
        SET stock = stock + (SELECT quantity FROM purchase_details WHERE id = purchaseDetailId)
        WHERE id = (SELECT product_id FROM purchase_details WHERE id = purchaseDetailId);
    END LOOP;

    -- Cerrar el cursor
    CLOSE CUR;
END //

DELIMITER ;

-- Listar todas las compras por Sucursal
DELIMITER //

CREATE PROCEDURE SP_V_PURCHASE_03(IN branchId INT)
BEGIN
    SELECT
        p.id,   
        p.branch_id,   
        p.payment_id,   
        p.supplier_id,   
        p.supplier_ruc,   
        p.supplier_address,   
        p.supplier_email,   
        p.subtotal,   
        p.iva,   
        p.total,   
        p.comment,   
        p.user_id,   
        p.currency_id,   
        p.created_at,   
        p.status_purchase,   
        b.name AS nameBranch,   
        ep.name AS nameEnterprise,   
        ep.RUC AS rucEnterprise,   
        ep.email AS emailEnterprise,   
        ep.phone AS phoneEnterprise,   
        ep.address AS addressEnterprise,
        c.name AS nameCompany,   
        u.email AS emailUser,   
        u.name AS nameUser,   
        u.last_name,   
        u.identification,   
        u.phone AS phoneUser,   
        r.name AS nameRol,   
        py.name AS namePayment,   
        cr.name AS nameCurrency,  
        sp.name AS nameSupplier  
    FROM              
        purchases AS p
    INNER JOIN branchs AS b ON p.branch_id = b.id 
    INNER JOIN enterprises AS ep ON b.enterprise_id = ep.id 
    INNER JOIN companies AS c ON ep.company_id = c.id 
    INNER JOIN users AS u ON p.user_id = u.id 
    INNER JOIN roles AS r ON u.role_id = r.id 
    INNER JOIN payments AS py ON p.payment_id = py.id 
    INNER JOIN currencies AS cr ON p.currency_id= TM_MONEDA.MON_ID 
    INNER JOIN suppliers AS sp ON p.supplier_id = sp.id
    WHERE  
        p.status_purchase = 1  
        AND p.branch_id = branchId AND p.is_active = 1
END //

DELIMITER ;