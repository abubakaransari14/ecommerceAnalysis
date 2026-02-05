CREATE DATABASE Ecommerce_Pro_Analytics;
USE Ecommerce_Pro_Analytics;

-- 1. Locations (For Geographic Analysis)
CREATE TABLE Locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20)
);

-- 2. Users (With Marketing Source)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    gender VARCHAR(20),
    age INT,
    location_id INT,
    traffic_source VARCHAR(50), -- e.g., 'Google Ads', 'Organic', 'Instagram'
    registration_date DATETIME,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- 3. Products & Brands
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255),
    brand VARCHAR(100),
    category VARCHAR(100),
    cost_price DECIMAL(10, 2),  -- What WE paid (to calculate Profit)
    sale_price DECIMAL(10, 2),  -- What the CUSTOMER pays
    current_stock INT,
    warehouse_location VARCHAR(100),
    rating_avg DECIMAL(3, 2)
);

-- 4. Orders (The Fact Table)
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date DATETIME,
    status VARCHAR(50), -- Shipped, Returned, Cancelled, Processing
    shipping_limit_date DATETIME,
    delivery_date DATETIME,     -- To calculate "Shipping Speed"
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 5. Order_Items (Granular Sales)
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    final_sale_price DECIMAL(10, 2), -- Records price at moment of sale
    discount_amount DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 6. Customer_Reviews (For Sentiment Analysis later)
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    user_id INT,
    rating INT,
    review_text TEXT,
    review_date DATETIME,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

-- Add Category_ID to Products (if not already there)
ALTER TABLE Products ADD COLUMN category_id INT;
ALTER TABLE Products ADD FOREIGN KEY (category_id) REFERENCES Categories(category_id);