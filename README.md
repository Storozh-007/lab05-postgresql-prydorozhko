# Lab 05 – PostgreSQL/pgAdmin (Denys Prydorozhko)

## Files
- `lab05.sql` — повний сценарій: створення/скидання БД, наповнення, усі запити, categories, процедура, тригер.

## Як запускати
1) Створи БД: у postgres `CREATE DATABASE financial_database_prydorozhko;`  
2) Відкрий Query Tool (або psql) у цій БД.  
3) Виконай `lab05.sql` блоками зверху вниз:
   - Блок “1) Скидання до базового стану” (створює таблиці + дані).
   - Далі окремо запускати запити з розділу “2) Запити з завдання”.
   - Потім розділ “3) Додаткова таблиця categories + вибірки”.
   - Нарешті “4) Stored procedure + trigger” та перевірочні SELECT/INSERT.

## Чекліст відповідності завданню
- [x] Скидання/відновлення даних перед змінами (DROP + CREATE + INSERT у блоці 1).  
- [x] Простi вибірки транзакцій за рахунком (3 SQL).  
- [x] Сортування за датою та сумою (2 SQL).  
- [x] INNER JOIN: користувачі, рахунки, сума транзакцій.  
- [x] LEFT JOIN: тільки рахунки без транзакцій.  
- [x] CROSS JOIN: 12 комбінацій користувачі × транзакції.  
- [x] FULL OUTER JOIN: accounts ⟷ transactions.  
- [x] Агрегати SUM/AVG/COUNT з GROUP BY (3 SQL).  
- [x] UPDATE балансу за типом + перевірочний SELECT.  
- [x] UPDATE з JOIN для активних користувачів + перевірка.  
- [x] DELETE старих транзакцій (>60 днів) + перевірка.  
- [x] DELETE транзакцій по рахунках з від’ємним балансом + перевірка.  
- [x] Рахунок з максимальною сумою транзакцій (без поля balance).  
- [x] Користувачі з сумою транзакцій > 200.  
- [x] Нова таблиця `categories`, заповнення 10 значеннями, зв’язок з `transactions`.  
- [x] Вибірка транзакцій із категоріями (JOIN).  
- [x] Корельований підзапит: категорії з сумою транзакцій > 100.  
- [x] Stored procedure `calculate_balance_proc` + приклад виклику.  
- [x] Trigger `balance_trigger` (function `update_balance`) + перевірка вставкою.  

## Підказки для звіту
- Типи даних: `VARCHAR` (імена/описи), `DECIMAL` (точні суми), `DATE` (фільтри/сортування за часом), `BOOLEAN` (стани користувачів).  
- Приклад аналітики: `SELECT account_type, AVG(balance) FROM accounts GROUP BY account_type;`  
- Скріншоти: після виконання блоків відкрий таблиці через `View/Edit Data -> All Rows` та зафіксуй результати ключових запитів (JOIN, агрегати, категорії, процедура/тригер).

## Якщо потрібна перевірка тригера
1) `SELECT balance FROM accounts WHERE id = 1;`  
2) `INSERT INTO transactions (account_id, amount, type, description) VALUES (1, 200.00, 'credit', 'Новий дохід');`  
3) `SELECT balance FROM accounts WHERE id = 1;` — має зрости на 200.
