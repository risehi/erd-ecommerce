CREATE TABLE site_user (
    id INT PRIMARY KEY,
    email VARCHAR(255),
    password VARCHAR(255),
    phone_no VARCHAR(20),
    metadata VARCHAR(255)
);

CREATE TABLE address (
    id INT PRIMARY KEY,
    unit INT,
    line1 VARCHAR(255),
    line2 VARCHAR(255),
    postal_code VARCHAR(20),
    city VARCHAR(100),
    region VARCHAR(100),
    metadata VARCHAR(255)
);

CREATE TABLE user_address (
    id INT PRIMARY KEY,
    address_id INT,
    user_id INT,
    is_default BOOLEAN,
    metadata VARCHAR(255),
    FOREIGN KEY (address_id) REFERENCES address(id),
    FOREIGN KEY (user_id) REFERENCES site_user(id)
);

CREATE TABLE shipping_address (
    id INT PRIMARY KEY,
    address_id INT,
    user_id INT,
    is_default BOOLEAN,
    metadata VARCHAR(255),
    FOREIGN KEY (address_id) REFERENCES address(id),
    FOREIGN KEY (user_id) REFERENCES site_user(id)
);

CREATE TABLE payment_method (
    id INT PRIMARY KEY,
    provider VARCHAR(255),
    account_no VARCHAR(50),
    metadata VARCHAR(255)
);

CREATE TABLE user_payment_method (
    id INT PRIMARY KEY,
    user_id INT,
    payment_type_id INT,
    is_default BOOLEAN,
    metadata VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES site_user(id),
    FOREIGN KEY (payment_type_id) REFERENCES payment_method(id)
);

CREATE TABLE product_category (
    id INT PRIMARY KEY,
    parent_category_id INT,
    category_name VARCHAR(255),
    metadata VARCHAR(255),
    FOREIGN KEY (parent_category_id) REFERENCES product_category(id)
);

CREATE TABLE product (
    id INT PRIMARY KEY,
    category_id INT,
    name VARCHAR(255),
    description TEXT,
    image VARCHAR(255),
    metadata VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

CREATE TABLE product_variant (
    id INT PRIMARY KEY,
    category_id INT,
    metadata VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

CREATE TABLE inventory (
    id INT PRIMARY KEY,
    quantity INT,
    metadata VARCHAR(255)
);

CREATE TABLE product_item (
    id INT PRIMARY KEY,
    inventory_id INT,
    product_id INT,
    sku INT,
    price DECIMAL(10, 2),
    image VARCHAR(255),
    metadata VARCHAR(255),
    FOREIGN KEY (inventory_id) REFERENCES inventory(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE shopping_cart (
    id INT PRIMARY KEY,
    user_id INT,
    product_item_id INT,
    total DECIMAL(10, 2),
    metadata VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES site_user(id),
    FOREIGN KEY (product_item_id) REFERENCES product_item(id)
);

CREATE TABLE shop_order (
    id INT PRIMARY KEY,
    user_id INT,
    shopping_cart_id INT,
    payment_method_id INT,
    shipping_address_id INT,
    order_total DECIMAL(10, 2),
    shipping_method VARCHAR(100),
    status VARCHAR(100),
    metadata VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES site_user(id),
    FOREIGN KEY (shopping_cart_id) REFERENCES shopping_cart(id),
    FOREIGN KEY (payment_method_id) REFERENCES user_payment_method(id),
    FOREIGN KEY (shipping_address_id) REFERENCES shipping_address(id)
);
