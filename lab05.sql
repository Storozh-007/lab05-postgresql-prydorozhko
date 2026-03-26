-- База даних: financial_database_prydorozhko
-- Придорожко Денис Ігорович, група 491

DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    account_number VARCHAR(20) UNIQUE NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    account_type VARCHAR(20) CHECK (account_type IN ('checking', 'savings', 'credit'))
);

CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    account_id INTEGER REFERENCES accounts(id),
    amount DECIMAL(10,2) NOT NULL,
    type VARCHAR(10) CHECK (type IN ('debit', 'credit')),
    description VARCHAR(200),
    transaction_date DATE DEFAULT CURRENT_DATE,
    category_id INTEGER
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

ALTER TABLE transactions ADD COLUMN IF NOT EXISTS category_id INTEGER REFERENCES categories(id);

INSERT INTO users (name, email, registration_date, is_active) VALUES
('Іван Петренко','ivan.petrenko@email.com','2024-01-15',TRUE),
('Марія Коваленко','maria.kovalenko@email.com','2024-02-20',TRUE),
('Олег Сидоренко','oleg.sydorenko@email.com','2024-03-10',TRUE),
('Анна Шевченко','anna.shevchenko@email.com','2024-04-05',TRUE),
('Віктор Бондаренко','viktor.bondarenko@email.com','2024-05-12',TRUE),
('Ольга Гриценко','olga.gritsenko@email.com','2024-06-18',TRUE),
('Дмитро Кравченко','dmytro.kravchenko@email.com','2024-07-22',TRUE),
('Софія Литвиненко','sofia.lytvynenko@email.com','2024-08-14',TRUE),
('Андрій Мороз','andriy.moroz@email.com','2024-09-08',FALSE),
('Denys Prydorozhko','denys.prydorozhko@email.com','2024-10-01',TRUE);

INSERT INTO accounts (user_id, account_number, balance, account_type) VALUES
(1,'ACC001',1500.50,'checking'),(1,'ACC002',5000.00,'savings'),(1,'ACC003',2500.00,'credit'),
(2,'ACC004',800.75,'checking'),(2,'ACC005',1200.00,'savings'),
(3,'ACC006',3500.25,'checking'),(3,'ACC007',2800.00,'credit'),
(4,'ACC008',900.00,'savings'),
(5,'ACC009',2200.00,'credit'),(5,'ACC010',4500.75,'savings'),(5,'ACC011',600.00,'checking'),
(6,'ACC012',1400.25,'savings'),(6,'ACC013',950.50,'checking'),
(7,'ACC014',3100.00,'credit'),(7,'ACC015',700.75,'savings'),(7,'ACC016',1600.00,'checking'),
(8,'ACC017',3000.50,'credit'),(8,'ACC018',1050.25,'savings'),
(9,'ACC019',5200.00,'checking'),
(10,'ACC020',6100.50,'savings'),(10,'ACC021',850.00,'checking'),
(1,'ACC022',1900.75,'savings'),(2,'ACC023',3300.00,'credit'),
(3,'ACC024',1150.50,'checking'),(4,'ACC025',5700.25,'savings'),
(5,'ACC026',400.00,'credit'),(6,'ACC027',2100.00,'checking'),
(7,'ACC028',3600.75,'savings'),(8,'ACC029',1250.00,'credit'),
(9,'ACC030',6100.50,'checking');

INSERT INTO transactions (account_id, amount, type, description, transaction_date) VALUES
(1,100.00,'debit','Покупка продуктів','2024-09-01'),(1,500.00,'credit','Зарплата','2024-09-05'),
(2,200.00,'debit','Оплата рахунків','2024-09-10'),
(3,150.00,'debit','Транспорт','2024-09-20'),
(5,250.00,'debit','Розваги','2024-10-01'),(5,300.00,'credit','Відсотки','2024-10-02'),
(9,400.00,'debit','Іпотека','2024-10-10'),(9,600.00,'credit','Дохід','2024-10-15'),
(9,80.00,'debit','Їжа','2024-10-20'),(9,150.00,'credit','Бонус','2024-10-25'),
(9,200.00,'debit','Книги','2024-10-30'),
(10,75.00,'debit','Кава','2024-09-02'),(10,350.00,'credit','Інвестиція','2024-09-16'),
(10,100.00,'debit','Кіно','2024-09-21'),
(11,120.00,'debit','Техніка','2024-10-21'),
(14,90.00,'debit','Одяг','2024-10-01'),(14,300.00,'credit','Повернення','2024-10-06'),
(15,110.00,'debit','Спорт','2024-10-11'),(15,350.00,'credit','Дохід','2024-10-16'),
(15,70.00,'debit','Кіно','2024-10-21'),
(17,130.00,'debit','Подорож','2024-10-01'),(17,450.00,'credit','Інвестиція','2024-10-06'),
(17,95.00,'debit','Книги','2024-10-11'),(17,320.00,'credit','Продаж','2024-10-16'),
(20,140.00,'debit','Розваги','2024-10-21'),(20,480.00,'credit','Відсотки','2024-10-26'),
(22,105.00,'debit','Транспорт','2024-10-01'),(22,340.00,'credit','Фріланс','2024-10-06'),
(22,160.00,'debit','Їжа','2024-10-11'),
(25,85.00,'debit','Кава','2024-10-21'),(25,280.00,'credit','Повернення','2024-10-26'),
(27,125.00,'debit','Одяг','2024-10-01'),(27,460.00,'credit','Зарплата','2024-10-06'),
(27,145.00,'debit','Спорт','2024-10-11'),
(29,165.00,'debit','Кіно','2024-10-21'),(29,600.00,'credit','Інвестиція','2024-10-26'),
(30,185.00,'debit','Подорож','2024-10-01'),(30,620.00,'credit','Продаж','2024-10-06'),
(30,205.00,'debit','Розваги','2024-10-11'),
(1,225.00,'debit','Транспорт','2024-10-21'),
(2,245.00,'debit','Їжа','2024-10-01'),
(3,265.00,'debit','Книги','2024-10-11'),
(5,285.00,'debit','Кава','2024-10-21'),
(7,305.00,'debit','Одяг','2024-10-01'),
(10,325.00,'debit','Спорт','2024-10-11'),
(14,345.00,'debit','Кіно','2024-10-21'),
(15,365.00,'debit','Подорож','2024-10-01'),
(17,385.00,'debit','Розваги','2024-10-11'),
(20,405.00,'debit','Транспорт','2024-10-21'),
(22,425.00,'credit','Дохід','2024-10-26');

INSERT INTO categories (name) VALUES
('Покупки'),('Зарплата'),('Оплата рахунків'),('Транспорт'),('Розваги'),
('Їжа'),('Іпотека'),('Бонус'),('Інвестиція'),('Повернення');

UPDATE transactions SET category_id = CASE
    WHEN description ILIKE '%зарплат%' THEN (SELECT id FROM categories WHERE name='Зарплата')
    WHEN description ILIKE '%іпотек%' THEN (SELECT id FROM categories WHERE name='Іпотека')
    WHEN description ILIKE '%бонус%' THEN (SELECT id FROM categories WHERE name='Бонус')
    WHEN description ILIKE '%інвест%' THEN (SELECT id FROM categories WHERE name='Інвестиція')
    WHEN description ILIKE '%повернен%' THEN (SELECT id FROM categories WHERE name='Повернення')
    WHEN description ILIKE '%їж%' OR description ILIKE '%кава%' THEN (SELECT id FROM categories WHERE name='Їжа')
    WHEN description ILIKE '%транспорт%' THEN (SELECT id FROM categories WHERE name='Транспорт')
    WHEN description ILIKE '%оплата рахунків%' THEN (SELECT id FROM categories WHERE name='Оплата рахунків')
    WHEN description ILIKE '%покуп%' THEN (SELECT id FROM categories WHERE name='Покупки')
    ELSE (SELECT id FROM categories WHERE name='Розваги')
END;

SELECT * FROM transactions WHERE account_id = 1;
SELECT * FROM transactions WHERE account_id = 9 ORDER BY transaction_date DESC;
SELECT * FROM transactions WHERE account_id = 20 AND type = 'credit';

SELECT * FROM transactions ORDER BY transaction_date DESC;
SELECT * FROM transactions ORDER BY amount DESC, transaction_date;

SELECT u.name, a.account_number, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name, a.account_number;

SELECT u.name, a.account_number
FROM users u
LEFT JOIN accounts a ON u.id = a.user_id
LEFT JOIN transactions t ON a.id = t.account_id
WHERE t.id IS NULL;

SELECT u.name, t.description, t.amount
FROM users u
CROSS JOIN transactions t
LIMIT 12;

SELECT a.account_number, t.id AS transaction_id, t.amount
FROM accounts a
FULL OUTER JOIN transactions t ON a.id = t.account_id;

SELECT account_type, SUM(balance) AS sum_balance FROM accounts GROUP BY account_type;
SELECT account_type, AVG(balance) AS avg_balance FROM accounts GROUP BY account_type;
SELECT type, COUNT(*) AS txn_count, SUM(amount) AS sum_amount FROM transactions GROUP BY type;

UPDATE accounts SET balance = balance + 1000 WHERE account_type = 'savings';
SELECT account_number, balance FROM accounts WHERE account_type = 'savings';

UPDATE accounts a SET balance = a.balance + 50
FROM users u
WHERE a.user_id = u.id AND u.is_active = TRUE;
SELECT a.account_number, a.balance
FROM accounts a JOIN users u ON a.user_id = u.id
WHERE u.is_active = TRUE;

DELETE FROM transactions WHERE transaction_date < CURRENT_DATE - INTERVAL '60 days';
SELECT * FROM transactions WHERE transaction_date < CURRENT_DATE - INTERVAL '60 days';

DELETE FROM transactions USING accounts
WHERE transactions.account_id = accounts.id AND accounts.balance < 0;
SELECT a.account_number, a.balance FROM accounts a WHERE a.balance < 0;

SELECT a.account_number, SUM(t.amount) AS total_amount
FROM accounts a JOIN transactions t ON a.id = t.account_id
GROUP BY a.account_number
ORDER BY total_amount DESC
LIMIT 1;

SELECT u.name, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name
HAVING SUM(t.amount) > 200;

SELECT t.id, a.account_number, t.amount, t.type, c.name AS category, t.description, t.transaction_date
FROM transactions t
JOIN accounts a ON t.account_id = a.id
LEFT JOIN categories c ON t.category_id = c.id
ORDER BY t.id;

SELECT c.id, c.name
FROM categories c
WHERE (SELECT COALESCE(SUM(t.amount),0) FROM transactions t WHERE t.category_id = c.id) > 100;

CREATE OR REPLACE PROCEDURE calculate_balance_proc(p_account_id INT, OUT balance DECIMAL)
LANGUAGE plpgsql AS $$
BEGIN
    SELECT COALESCE(SUM(CASE WHEN type='credit' THEN amount ELSE -amount END),0)
    INTO balance
    FROM transactions t
    WHERE t.account_id = p_account_id;
END;
$$;

CALL calculate_balance_proc(1, NULL);

CREATE OR REPLACE FUNCTION update_balance() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE accounts
        SET balance = balance + (CASE WHEN NEW.type='credit' THEN NEW.amount ELSE -NEW.amount END)
        WHERE id = NEW.account_id;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE accounts
        SET balance = balance
            - (CASE WHEN OLD.type='credit' THEN OLD.amount ELSE -OLD.amount END)
            + (CASE WHEN NEW.type='credit' THEN NEW.amount ELSE -NEW.amount END)
        WHERE id = NEW.account_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE accounts
        SET balance = balance - (CASE WHEN OLD.type='credit' THEN OLD.amount ELSE -OLD.amount END)
        WHERE id = OLD.account_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS balance_trigger ON transactions;
CREATE TRIGGER balance_trigger
AFTER INSERT OR UPDATE OR DELETE ON transactions
FOR EACH ROW EXECUTE FUNCTION update_balance();

SELECT balance FROM accounts WHERE id = 1;
INSERT INTO transactions (account_id, amount, type, description) VALUES (1, 200.00, 'credit', 'Новий дохід');
SELECT balance FROM accounts WHERE id = 1;
