-- Запрос рабочий для наших данных, но мы тут не учитываем null от зарплат и 
-- у нас не отобразаться регионы без зарплаты
-- Однако нужно ли учитывать это, в задании не написано =/
SELECT area_id,
	ROUND(AVG(compensation_from)) as average_compensation_from, 
	ROUND(AVG(compensation_to)) AS average_compensation_to, 
	ROUND(AVG((compensation_from + compensation_to) / 2)) AS average_compensation
FROM vacancies
GROUP BY area_id
ORDER BY area_id;
