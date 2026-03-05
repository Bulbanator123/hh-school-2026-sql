-- индексы
-- я вычитал, что есть основные рекомендации
-- 1. когда мы используем join (нужно пройтись по двум таблицам, а это затратно по времени)
-- 2. даты (практически всегда используются для фильтрации)
-- 3. таблицы многие ко многим (часто попадает под первый пункт)

-- я предлагаю их разделить ещё на три ситуации для прода

-- 1-ое для соискателя, ему необходим быстрый поиск по тысячам вакансий,
-- также ему нужно искать их много и по фильтрам,
-- поэтому создадим индексы для вакансий, что ускорит работу поиска

-- специализация и регион основные фильтры (также нужны для join)
CREATE INDEX idx_vacancies_area_id ON vacancies(area_id);
CREATE INDEX idx_vacancies_specialization_id ON vacancies(specialization_id);
-- ищет актуальные вакансии
CREATE INDEX idx_vacancies_published_at ON vacancies(published_at);
-- для операций многие ко многим, которые понадобяться для быстрого поиска соискателю
CREATE INDEX idx_vacancy_skills_vacancy_id ON vacancy_skills(vacancy_id, skill_id);


-- 2-ое для работодателя, ему тоже нужен быстрый поиск его откликов
-- также обычно откликов обычно намного больше, чем остальных данных

-- собственно создаём индексы для фильтрации откликов (опять нужны для join)
CREATE INDEX idx_responses_vacancy_id ON responses(vacancy_id);
CREATE INDEX idx_responses_resume_id ON responses(resume_id);
-- и также не забываем о сортировки по актуальности 
CREATE INDEX idx_responses_responded_at ON responses(responded_at);
-- опять работодатель будеть видеть резюме и ему нужно, чтобы оно быстро прогрузилось (нужно для join)
CREATE INDEX idx_resumes_area_id ON resumes(area_id);
-- операция многие ко многим (помогает быстро видеть скиллы претендента)
CREATE INDEX idx_resume_skills_resume_id ON resume_skills(resume_id, skill_id);


-- 3-ье для аналитики внутри компании, её можно продавать, как минимум,
-- и в общем это полезно и помогает как-то находить ниши для улучшения
-- сервиса соискателям
-- тут по большей части всё важное, что осталось это время публикации
-- работодателю оно не требуется, как и соискателю
CREATE INDEX idx_resumes_published_at ON resumes(published_at);
