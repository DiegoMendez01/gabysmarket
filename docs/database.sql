/*
CREATE DATABASE gabysmarket
*/

/*================ CREATE TABLES ================*/

-- gabysmarket.companies definition
CREATE TABLE IF NOT EXISTS companies
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1
);

-- gabysmarket.enterprises definition
CREATE TABLE IF NOT EXISTS enterprises
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `RUC` VARCHAR(50) DEFAULT NULL,
    `email` VARCHAR(150) DEFAULT NULL,
    `phone` VARCHAR(50) DEFAULT NULL,
    `address` VARCHAR(150) DEFAULT NULL,
    `company_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
    INDEX `idx_company_id` (`company_id`) USING BTREE
);

-- gabysmarket.branchs definition
CREATE TABLE IF NOT EXISTS branchs
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `enterprise_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`enterprise_id`) REFERENCES `enterprises` (`id`),
    INDEX `idx_enterprise_id` (`enterprise_id`) USING BTREE
);

-- gabysmarket.units definition
CREATE TABLE IF NOT EXISTS units
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`),
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
);

-- gabysmarket.documents definition
CREATE TABLE IF NOT EXISTS documents
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `type` VARCHAR(150) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1
);

-- gabysmarket.roles definition
CREATE TABLE IF NOT EXISTS roles
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`),
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
);

-- gabysmarket.roles definition
CREATE TABLE IF NOT EXISTS customers
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `RUC` VARCHAR(50) DEFAULT NULL,
    `phone` VARCHAR(50) DEFAULT NULL,
    `address` VARCHAR(150) DEFAULT NULL,
    `email` VARCHAR(150) DEFAULT NULL,
    `company_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
    INDEX `idx_company_id` (`company_id`) USING BTREE
);

-- gabysmarket.categories definition
CREATE TABLE IF NOT EXISTS categories
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`),
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
);

-- gabysmarket.suppliers definition
CREATE TABLE IF NOT EXISTS suppliers
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `RUC` VARCHAR(150) DEFAULT NULL,
    `phone` VARCHAR(50) DEFAULT NULL,
    `address` VARCHAR(150) DEFAULT NULL,
    `email` VARCHAR(150) DEFAULT NULL,
    `company_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
    INDEX `idx_company_id` (`company_id`) USING BTREE
);

-- gabysmarket.users definition
CREATE TABLE IF NOT EXISTS users
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `last_name` VARCHAR(150) DEFAULT NULL,
    `identification` VARCHAR(50) DEFAULT NULL,
    `phone` VARCHAR(50) DEFAULT NULL,
    `password_hash` VARCHAR(50) DEFAULT NULL,
    `email` VARCHAR(150) DEFAULT NULL,
    `image` LONGTEXT DEFAULT 'nodisponible.png',
    `role_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
    INDEX `idx_role_id` (`role_id`) USING BTREE
);

-- gabysmarket.currencies definition
CREATE TABLE IF NOT EXISTS currencies
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`),
    INDEX `idx_branch_id` (`branch_id`) USING BTREE
);

-- gabysmarket.payments definition
CREATE TABLE IF NOT EXISTS payments
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1
);

-- gabysmarket.products definition
CREATE TABLE IF NOT EXISTS products
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `description` LONGTEXT DEFAULT NULL,
    `purchase_price` DECIMAL(20, 2) DEFAULT NULL,
    `sale_price` DECIMAL(20, 2) DEFAULT NULL,
    `stock` INT(11) DEFAULT NULL,
    `sale_date` DATE DEFAULT NULL,
    `image` LONGTEXT DEFAULT 'nodisponible.png',
    `branch_id` INT(11) DEFAULT NULL,
    `category_id` INT(11) DEFAULT NULL,
    `unit_id` INT(11) DEFAULT NULL,
    `currency_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`),
    FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
    FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`),
    FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
    INDEX `idx_branch_id` (`branch_id`) USING BTREE,
    INDEX `idx_category_id` (`category_id`) USING BTREE,
    INDEX `idx_unit_id` (`unit_id`) USING BTREE,
    INDEX `idx_currency_id` (`currency_id`) USING BTREE
);

-- gabysmarket.sales definition
CREATE TABLE IF NOT EXISTS sales
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `customer_id` INT(11) DEFAULT NULL,
    `customer_ruc` VARCHAR(50) DEFAULT NULL,
    `customer_address` VARCHAR(150) DEFAULT NULL,
    `customer_email` VARCHAR(150) DEFAULT NULL,
    `subtotal` DECIMAL(20, 2) DEFAULT NULL,
    `iva` DECIMAL(20, 2) DEFAULT NULL,
    `total` DECIMAL(20, 2) DEFAULT NULL,
    `comment` VARCHAR(250) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
    `user_id` INT(11) DEFAULT NULL,
    `payment_id` INT(11) DEFAULT NULL,
    `currency_id` INT(11) DEFAULT NULL,
    `document_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`),
    FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
    FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
    INDEX `idx_branch_id` (`branch_id`) USING BTREE,
    INDEX `idx_user_id` (`user_id`) USING BTREE,
    INDEX `idx_payment_id` (`payment_id`) USING BTREE,
    INDEX `idx_currency_id` (`currency_id`) USING BTREE,
    INDEX `idx_document_id` (`document_id`) USING BTREE
);

-- gabysmarket.sale_details definition
CREATE TABLE IF NOT EXISTS sale_details
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `price` DECIMAL(20, 2) DEFAULT NULL,
    `quantity` INT(11) DEFAULT NULL,
    `total` DECIMAL(20, 2) DEFAULT NULL,
    `sale_id` INT(11) DEFAULT NULL,
    `product_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
    FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
    INDEX `idx_sale_id` (`sale_id`) USING BTREE,
    INDEX `idx_product_id` (`product_id`) USING BTREE
);

-- gabysmarket.menus definition
CREATE TABLE IF NOT EXISTS menus
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(150) DEFAULT NULL,
    `route` VARCHAR(250) DEFAULT NULL,
    `identification` VARCHAR(150) DEFAULT NULL,
    `group` VARCHAR(150) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1
);

-- gabysmarket.menu_roles definition
CREATE TABLE IF NOT EXISTS menu_roles
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `permission` CHAR(2) DEFAULT NULL,
    `menu_id` INT(11) DEFAULT NULL,
    `role_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`),
    FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
    INDEX `idx_menu_id` (`menu_id`) USING BTREE,
    INDEX `idx_role_id` (`role_id`) USING BTREE
);

-- gabysmarket.purchases definition
CREATE TABLE IF NOT EXISTS purchases
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `supplier_id` INT(11) DEFAULT NULL,
    `supplier_ruc` VARCHAR(150) DEFAULT NULL,
    `supplier_address` VARCHAR(150) DEFAULT NULL,
    `supplier_email` VARCHAR(150) DEFAULT NULL,
    `subtotal` DECIMAL(20, 2) DEFAULT NULL,
    `iva` DECIMAL(20, 2) DEFAULT NULL,
    `total` DECIMAL(20, 2) DEFAULT NULL,
    `comment` VARCHAR(250) DEFAULT NULL,
    `branch_id` INT(11) DEFAULT NULL,
    `user_id` INT(11) DEFAULT NULL,
    `payment_id` INT(11) DEFAULT NULL,
    `currency_id` INT(11) DEFAULT NULL,
    `document_id` INT(11) DEFAULT NULL,
    `status_purchase` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`),
    FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
    FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
    INDEX `idx_branch_id` (`branch_id`) USING BTREE,
    INDEX `idx_user_id` (`user_id`) USING BTREE,
    INDEX `idx_payment_id` (`payment_id`) USING BTREE,
    INDEX `idx_currency_id` (`currency_id`) USING BTREE,
    INDEX `idx_document_id` (`document_id`) USING BTREE
);

-- gabysmarket.purchase_details definition
CREATE TABLE IF NOT EXISTS purchase_details
(
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `price` DECIMAL(20, 2) DEFAULT NULL,
    `quantity` INT(11) DEFAULT NULL,
    `total` DECIMAL(20, 2) DEFAULT NULL,
    `purchase_id` INT(11) DEFAULT NULL,
    `product_id` INT(11) DEFAULT NULL,
    `created_at` DATETIME,
    `modified_at` TIMESTAMP,
    `is_active` TINYINT(2) DEFAULT 1,
    FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
    FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
    INDEX `idx_purchase_id` (`purchase_id`) USING BTREE,
    INDEX `idx_product_id` (`product_id`) USING BTREE
);