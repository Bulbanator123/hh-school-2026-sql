SELECT area_id,
	ROUND(AVG(compensation_from)) as average_compensation_from, 
	ROUND(AVG(compensation_to)) AS average_compensation_to, 
	ROUND(AVG(
	case
	 when compensation_from is not null and compensation_to is not null then 
	  (compensation_from + compensation_to) / 2.0
	 when compensation_from is not null then compensation_from
	 when compensation_to is not null then compensation_to
	end)) AS average_compensation
FROM vacancies
GROUP BY area_id
ORDER BY area_id;

