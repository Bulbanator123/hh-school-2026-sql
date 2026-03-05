INSERT INTO areas (name)
VALUES ('Алматы'),
('Астана'),
('Баку'),
('Бишкек'),
('Челябинск'),
('Гомель'),
('Гродно'),
('Казань'),
('Минск'),
('Москва'),
('Нижний Новгород'),
('Новосибирск'),
('Омск'),
('Самара'),
('Санкт Петербург'),
('Уфа');

-- лучше, наверное, было делать вложенные запросы, 
-- но раз я и так знаю количество регионов, то не страшно (особенно для тестовых данных)
INSERT INTO employers (name, area_id, description)
SELECT 
    CONCAT('Компания_', id),
    FLOOR(RANDOM()*16 + 1)::int,
    'Тестовое описание нанимателя'	
FROM generate_series(1,2000) AS id;


INSERT INTO specializations (name) 
VALUES ('Системный администратор'),
('Программист-разработчик'),
('Аналитик данных'),
('Инженер-конструктор'),
('Сварщик'),
('Электрик'),
('Менеджер по продажам'),
('Бухгалтер'),
('Маркетолог'),
('Водитель-экспедитор'),
('Повар'),
('Врач-терапевт'),
('Учитель'),
('Архитектор'),
('Юрист');


INSERT INTO vacancies
(employer_id, specialization_id, area_id, title, description,
 compensation_from, compensation_to, employment_type, address, schedule, published_at)
SELECT
    FLOOR(RANDOM()*2000 + 1)::int,
    FLOOR(RANDOM()*15 + 1)::int,
    FLOOR(RANDOM()*16 + 1)::int,
    CONCAT('Vacancy ', id),
    'Test vacancy description',
    (RANDOM()*100000 + 10000)::int,
    (RANDOM()*500000 + 30000)::int,
    'full-time',
    'Office address',
    '5/2',
    NOW() - (RANDOM()*1000)::int * INTERVAL '1 day'
FROM generate_series(1,30000) AS id;


-- дата примерно до 2008 года
INSERT INTO applicants (name, last_name, middle_name, area_id, birth_day, status)
SELECT
    CONCAT('Name_', id),
    CONCAT('Lastname_', id),
    CONCAT('Middlename_', id),
    FLOOR(RANDOM()*16 + 1)::int,
    DATE '1980-01-01' + (RANDOM()*10000)::int, 
    'active'
FROM generate_series(1,150000) AS id;


-- тут возможно немного лишняя логика с GREATEST, но она делает все анкеты от 18 лет
INSERT INTO resumes
(applicant_id, title, summary, area_id, specialization_id, salary, published_at)
SELECT
    id,
    CONCAT('Resume ', id),
    'Test resume description',
    FLOOR(RANDOM()*16 + 1)::int,
    FLOOR(RANDOM()*15 + 1)::int,
    (random()*400000 + 10000)::int,
    GREATEST(birth_day + INTERVAL '18 years', NOW() - INTERVAL '5 years') + 
    (RANDOM() * (NOW() - GREATEST(birth_day + INTERVAL '18 years', NOW() - INTERVAL '5 years')))
FROM applicants;


-- Чтобы у нас не было ошибки с primary key просто игнорируем повторяющиеся
INSERT INTO responses (vacancy_id, resume_id, status, responded_at)
select
    v.id,
    FLOOR(RANDOM()*150000 + 1)::int,
    'new',
    v.published_at + (random()*90)::int * INTERVAL '1 day'
FROM generate_series(1, 100000)
JOIN vacancies v ON v.id = FLOOR(RANDOM() * 30000 + 1)::int
ON CONFLICT DO NOTHING;


INSERT INTO key_skills (skill)
SELECT CONCAT('Умение_', id)
FROM generate_series(1,200) as id;


INSERT INTO vacancy_skills (vacancy_id, skill_id)
SELECT
    FLOOR(RANDOM()*30000 + 1)::int,
    FLOOR(RANDOM()*200 + 1)::int
FROM generate_series(1,150000)
ON CONFLICT DO NOTHING;


INSERT INTO resume_skills (resume_id, skill_id)
SELECT
    FLOOR(RANDOM()*150000 + 1)::int,
    FLOOR(RANDOM()*200 + 1)::int
FROM generate_series(1,400000)
ON CONFLICT DO NOTHING;


