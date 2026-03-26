# Результати запитів - Лабораторна робота 5
# Придорожко Денис Ігорович, група 491

---

## Структура таблиці users

```sql
\d users
```

```
 id | name | type | nullable | default
----+------+------+---------+--------
 1  | id | integer | not null | nextval('users_id_seq'::regclass)
 2  | name | varchar(100) | not null | 
 3  | email | varchar(100) | not null | 
 4  | registration_date | date | | current_date
 5  | is_active | boolean | | true
 PK: id
 UNIQUE: email
 FK: -
```

---

## Структура таблиці accounts

```sql
\d accounts
```

```
 id | name | type | nullable | default
----+------+------+---------+--------
 1  | id | integer | not null | nextval('accounts_id_seq'::regclass)
 2  | user_id | integer | | 
 3  | account_number | varchar(20) | not null | 
 4  | balance | numeric(15,2) | | 0.00
 5  | account_type | varchar(20) | | 
 PK: id
 UNIQUE: account_number
 FK: user_id -> users(id)
 CHECK: account_type IN ('checking', 'savings', 'credit')
```

---

## Структура таблиці transactions

```sql
\d transactions
```

```
 id | name | type | nullable | default
----+------+------+---------+--------
 1  | id | integer | not null | nextval('transactions_id_seq'::regclass)
 2  | account_id | integer | | 
 3  | amount | numeric(10,2) | not null | 
 4  | type | varchar(10) | | 
 5  | description | varchar(200) | | 
 6  | transaction_date | date | | current_date
 7  | category_id | integer | | 
 PK: id
 FK: account_id -> accounts(id)
 CHECK: type IN ('debit', 'credit')
 TRIGGER: balance_trigger
```

---

## Дані таблиці users

```sql
SELECT * FROM users;
```

```
 id |       name        |            email            | registration_date | is_active 
----+-------------------+-----------------------------+-------------------+-----------
  1 | Іван Петренко     | ivan.petrenko@email.com     | 2024-01-15        | t
  2 | Марія Коваленко   | maria.kovalenko@email.com   | 2024-02-20        | t
  3 | Олег Сидоренко    | oleg.sydorenko@email.com    | 2024-03-10        | t
  4 | Анна Шевченко     | anna.shevchenko@email.com   | 2024-04-05        | t
  5 | Віктор Бондаренко | viktor.bondarenko@email.com | 2024-05-12        | t
  6 | Ольга Гриценко    | olga.gritsenko@email.com    | 2024-06-18        | t
  7 | Дмитро Кравченко  | dmytro.kravchenko@email.com | 2024-07-22        | t
  8 | Софія Литвиненко  | sofia.lytvynenko@email.com  | 2024-08-14        | t
  9 | Андрій Мороз      | andriy.moroz@email.com      | 2024-09-08        | f
 10 | Denys Prydorozhko | denys.prydorozhko@email.com | 2024-10-01        | t
(10 rows)
```

---

## Дані таблиці accounts

```sql
SELECT * FROM accounts ORDER BY id;
```

```
 id | user_id | account_number |  balance  | account_type 
----+---------+----------------+-----------+--------------
  1 |       1 | ACC001         |  1850.50 | checking
  2 |       1 | ACC002         |  6050.00 | savings
  3 |       1 | ACC003         |  2550.00 | credit
  4 |       2 | ACC004         |   850.75 | checking
  5 |       2 | ACC005         |  2250.00 | savings
  6 |       3 | ACC006         |  3550.25 | checking
  7 |       3 | ACC007         |  2850.00 | credit
  8 |       4 | ACC008         |  1950.00 | savings
  9 |       5 | ACC009         |  2250.00 | credit
 10 |       5 | ACC010         |  5550.75 | savings
 11 |       5 | ACC011         |   650.00 | checking
 12 |       6 | ACC012         |  2450.25 | savings
 13 |       6 | ACC013         |  1000.50 | checking
 14 |       7 | ACC014         |  3150.00 | credit
 15 |       7 | ACC015         |  1750.75 | savings
 16 |       7 | ACC016         |  1650.00 | checking
 17 |       8 | ACC017         |  3050.50 | credit
 18 |       8 | ACC018         |  2100.25 | savings
 19 |       9 | ACC019         |  5200.00 | checking
 20 |      10 | ACC020         |  7950.50 | savings
 21 |      10 | ACC021         |   900.00 | checking
 22 |       1 | ACC022         |  2950.75 | savings
 23 |       2 | ACC023         |  3350.00 | credit
 24 |       3 | ACC024         |  1200.50 | checking
 25 |       4 | ACC025         |  6750.25 | savings
 26 |       5 | ACC026         |   450.00 | credit
 27 |       6 | ACC027         |  2150.00 | checking
 28 |       7 | ACC028         |  4650.75 | savings
 29 |       8 | ACC029         |  1300.00 | credit
 30 |       9 | ACC030         |  6100.50 | checking
(30 rows)
```

---

## Дані таблиці categories

```sql
SELECT * FROM categories;
```

```
 id |      name       
----+-----------------
  1 | Покупки
  2 | Зарплата
  3 | Оплата рахунків
  4 | Транспорт
  5 | Розваги
  6 | Їжа
  7 | Іпотека
  8 | Бонус
  9 | Інвестиція
 10 | Повернення
(10 rows)
```

---

## INNER JOIN результат

```sql
SELECT u.name, a.account_number, SUM(t.amount) AS total
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name, a.account_number;
```

```
       name        | account_number | total  
-------------------+----------------+--------
 Denys Prydorozhko | ACC020         | 500.00
 Іван Петренко     | ACC001         | 300.00
(2 rows)
```

---

## LEFT JOIN - рахунки без транзакцій

```sql
SELECT COUNT(*) as accounts_without_transactions
FROM accounts a
LEFT JOIN transactions t ON a.id = t.account_id
WHERE t.id IS NULL;
```

```
 accounts_without_transactions 
-------------------------------
                            28
```

---

## Агрегатні функції

```sql
SELECT account_type, COUNT(*), SUM(balance), AVG(balance)::numeric(10,2)
FROM accounts GROUP BY account_type;
```

```
 account_type | count |   sum    |   avg   
--------------+-------+----------+---------
 credit       |     8 | 18950.50 | 2368.81
 savings      |    11 | 44104.25 | 4009.48
 checking     |    11 | 25103.00 | 2282.09
(3 rows)
```

---

## Stored Procedure

```sql
CALL calculate_balance_proc(1, NULL);
```

```
 balance 
--------
 300.00
```

---

## Trigger перевірка

```sql
SELECT balance FROM accounts WHERE id = 20;
INSERT INTO transactions (account_id, amount, type, description) 
VALUES (20, 300, 'credit', 'Test trigger');
SELECT balance FROM accounts WHERE id = 20;
```

```
 balance 
--------
 7650.50   <- до INSERT

INSERT 0 1

 balance 
--------
 7950.50   <- після INSERT (+300)
```

---

## Баланси користувачів

```sql
SELECT u.name, SUM(a.balance) as total
FROM users u
JOIN accounts a ON u.id = a.user_id
GROUP BY u.name
ORDER BY total DESC;
```

```
       name        |  total   
-------------------+----------
 Іван Петренко     | 13401.25
 Андрій Мороз      | 11300.50
 Дмитро Кравченко  | 11201.50
 Віктор Бондаренко |  8900.75
 Denys Prydorozhko |  8850.50
 Анна Шевченко     |  8700.25
 Олег Сидоренко    |  7600.75
 Марія Коваленко   |  6450.75
 Софія Литвиненко  |  6450.75
 Ольга Гриценко    |  5600.75
(10 rows)
```

---

## Підсумок

| Таблиця | Записів |
|---------|---------|
| users | 10 |
| accounts | 30 |
| transactions | 3 |
| categories | 10 |
| **Всього** | **53** |
