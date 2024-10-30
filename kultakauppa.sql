DROP TABLE IF EXISTS goldGrading;
DROP TABLE IF EXISTS jewelry;
DROP TABLE IF EXISTS diamondGrading;




CREATE TABLE goldGrading (
    id SERIAL PRIMARY KEY,
    karat_grade VARCHAR(10), 
    fineness INT, 
    color VARCHAR(50), 
    purity_percentage DECIMAL(4, 1) 
);


CREATE TABLE diamondGrading (
    id SERIAL PRIMARY KEY,
    carat_weight DECIMAL(3, 2), 
    cut_grade VARCHAR(50), 
    color_grade CHAR(1), 
    clarity_grade VARCHAR(10) 
);

CREATE TABLE jewelry (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50), 
    price DECIMAL(10, 2) NOT NULL,
    gold_grading_id INT,
    diamond_grading_id INT,
    description TEXT,
    FOREIGN KEY (gold_grading_id) REFERENCES GoldGrading(id),
    FOREIGN KEY (diamond_grading_id) REFERENCES DiamondGrading(id)
);


INSERT INTO goldgrading (karat_grade, fineness, color, purity_percentage) VALUES
('24K', 999, 'Yellow Gold', 99.9),
('22K', 916, 'Yellow Gold', 91.6),
('18K', 750, 'Rose Gold', 75.0),
('14K', 585, 'White Gold', 58.5),
('9K', 375, 'Green Gold', 37.5);

INSERT INTO diamondGrading (carat_weight, cut_grade, color_grade, clarity_grade) VALUES
(1.00, 'Excellent', 'D', 'IF'),
(0.75, 'Very Good', 'G', 'VVS1'),
(0.50, 'Good', 'H', 'VS2'),
(0.25, 'Fair', 'K', 'SI1'),
(1.20, 'Excellent', 'E', 'VVS1'),
(0.90, 'Very Good', 'F', 'VS1'),
(1.50, 'Good', 'D', 'IF'),
(0.85, 'Fair', 'G', 'SI1'),
(2.00, 'Excellent', 'H', 'VS2'),
(0.65, 'Very Good', 'I', 'VVS2'),
(1.75, 'Good', 'J', 'SI2'),
(1.10, 'Excellent', 'F', 'IF'),
(0.95, 'Fair', 'D', 'VVS1'),
(2.50, 'Excellent', 'G', 'VS1');

INSERT INTO jewelry (name, type, price, gold_grading_id, diamond_grading_id, description) VALUES
('Classic Gold Ring',           'Ring',     499.99,     1, NULL,    'A beautiful 24K yellow gold ring.'),
('Elegant Diamond Necklace',    'Necklace', 1200.50,    2, 1,       'A stunning necklace with a 1.00 ct diamond.'),
('Rose Gold Bracelet',          'Bracelet', 349.00,     3, NULL,    'A stylish 18K rose gold bracelet.'),
('White Gold Diamond Pendant',  'Pendant',  950.75,     4, 2,       'A 14K white gold pendant with a 0.75 ct diamond.'),
('Luxe Solitaire Ring',         'Ring',     850.75,     1, 1,       'A luxurious 24K gold ring with a solitaire diamond.'),
('Dazzling Stud Earrings',      'Earrings', 1150.99,    2, 3,       '18K gold earrings with flawless diamonds.'),
('Elegant Engagement Ring',     'Ring',     1450.00,    1, 4,       'Classic 24K gold engagement ring with a 1.2 ct diamond.'),
('White Gold Tennis Bracelet',  'Bracelet', 550.40,     4, NULL,    'An elegant 14K white gold bracelet.'),
('Charming Diamond Anklet',     'Anklet',   650.00,     3, 2,       '18K gold anklet with 0.90 ct diamond accents.'),
('Vintage Diamond Brooch',      'Brooch',   1275.60,    2, 5,       'A classic brooch with a 1.75 ct diamond.'),
('Classic Gold Chain',          'Chain',    299.99,     1, NULL,    'Solid 24K gold chain, timeless elegance.'),
('Graceful Diamond Pendant',    'Pendant',  870.80,     4, 6,       '14K white gold pendant with a sparkling 0.65 ct diamond.'),
('Diamond-Encrusted Watch',     'Watch',    2450.00,    2, 9,       'A watch with diamond details in 18K gold.'),
('Golden Love Locket',          'Pendant',  450.25,     1, NULL,    '24K gold locket, perfect for cherished memories.');

SELECT name, type, price
FROM Jewelry
WHERE gold_grading_id = (SELECT id FROM GoldGrading WHERE karat_grade = '24K');

SELECT type AS Jewelry_Type, COUNT(*) AS Number_of_Items
FROM jewelry
GROUP BY type;

SELECT name AS Jewelry_Name, type AS Jewelry_Type, price AS Price
FROM jewelry
ORDER BY price DESC LIMIT 1;

/*
INSERT INTO Jewelry (name, type, price, gold_grading_id, diamond_grading_id, description) VALUES
('Classic Gold Ring',           'Ring',     499.99,     1, NULL,    'A beautiful 24K yellow gold ring.'),
('Elegant Diamond Necklace',    'Necklace', 1200.50,    2, 1,       'A stunning necklace with a 1.00 ct diamond.'),
('Rose Gold Bracelet',          'Bracelet', 349.00,     3, NULL,    'A stylish 18K rose gold bracelet.'),
('White Gold Diamond Pendant',  'Pendant',  950.75,     4, 2,       'A 14K white gold pendant with a 0.75 ct diamond.');
('Luxe Solitaire Ring',         'Ring',     850.75,     1, 1,       'A luxurious 24K gold ring with a solitaire diamond.'),
('Dazzling Stud Earrings',      'Earrings', 1150.99,    2, 3,       '18K gold earrings with flawless diamonds.'),
('Elegant Engagement Ring',     'Ring',     1450.00,    1, 4,       'Classic 24K gold engagement ring with a 1.2 ct diamond.'),
('White Gold Tennis Bracelet',  'Bracelet', 550.40,     4, NULL,    'An elegant 14K white gold bracelet.'),
('Charming Diamond Anklet',     'Anklet',   650.00,     3, 2,       '18K gold anklet with 0.90 ct diamond accents.'),
('Vintage Diamond Brooch',      'Brooch',   1275.60,    2, 5,       'A classic brooch with a 1.75 ct diamond.'),
('Classic Gold Chain',          'Chain',    299.99,     1, NULL,    'Solid 24K gold chain, timeless elegance.'),
('Graceful Diamond Pendant',    'Pendant',  870.80,     4, 6,       '14K white gold pendant with a sparkling 0.65 ct diamond.'),
('Diamond-Encrusted Watch',     'Watch',    2450.00,    2, 9,       'A watch with diamond details in 18K gold.'),
('Golden Love Locket',          'Pendant',  450.25,     1, NULL,    '24K gold locket, perfect for cherished memories.');
*/