/*1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия,
город и пол), которые не старше 20 лет.
2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите
ранжированный список пользователей, указав имя и фамилию пользователя, количество
отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным
количеством сообщений) . (используйте DENSE_RANK)
3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления
(created_at) и найдите разницу дат отправления между соседними сообщениями, получившегося
списка. (используйте LEAD или LAG)
*/
-- 1 
CREATE OR REPLACE VIEW users_20 AS
(SELECT firstname, lastname, profiles.gender, profiles.hometown FROM users 
JOIN profiles ON id = user_id WHERE birthday>'2003-09-07');
SELECT *
FROM users_20;

-- 2
SELECT firstname, lastname, users.id,  COUNT(messages.from_user_id) AS mess, 
DENSE_RANK() OVER (ORDER BY COUNT(messages.from_user_id)) AS DE_Rank
FROM users
LEFT JOIN messages ON users.id = from_user_id
JOIN profiles ON users.id = user_id
GROUP BY users.id;
