-- даты как было противно обрабатывать, так и осталось
-- хотя бы функции удобные есть
-- 
-- FM для красивого вывода (без лишних пробелов)
-- и можно использовать DATE_TRUNC для полного формата
SELECT 
(
    SELECT TO_CHAR(published_at, 'FMMonth YYYY') 
    FROM vacancies
    GROUP BY TO_CHAR(published_at, 'FMMonth YYYY')
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS month_with_max_vacancies,
	
(
    SELECT TO_CHAR(published_at, 'FMMonth YYYY') 
    FROM resumes
    GROUP BY TO_CHAR(published_at, 'FMMonth YYYY')
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS month_with_max_resumes;
