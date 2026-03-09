-- тут только 1 вопрос возник: как нам правильно называть ячейки таблиц
-- пытаться называть их полным именем area_name, например, или, как я, - name
-- если элемент относиться к самой таблице?

-- если забуду в мм написать, все запросы тестировал с помощью 
-- dbeaver + postgress из докера с последнего слайда
DROP TABLE IF EXISTS areas CASCADE;
CREATE TABLE IF NOT EXISTS areas
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS employers CASCADE;
CREATE TABLE IF NOT EXISTS employers
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	area_id INTEGER NOT NULL REFERENCES areas (id),
    description TEXT
);

DROP TABLE IF EXISTS specializations CASCADE;
CREATE TABLE IF NOT EXISTS specializations
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS vacancies CASCADE;
CREATE TABLE IF NOT EXISTS vacancies
(
	id SERIAL PRIMARY KEY,
	employer_id INTEGER NOT NULL REFERENCES employers (id),
	specialization_id INTEGER NOT NULL REFERENCES specializations (id),
	area_id INTEGER NOT NULL REFERENCES areas (id),
	title VARCHAR(255) NOT NULL,
	description TEXT,
	compensation_from INTEGER,
	compensation_to INTEGER,
	employment_type VARCHAR(255),
	address VARCHAR(255),
	schedule VARCHAR(255),
	published_at DATE NOT NULL DEFAULT NOW()
);

DROP TABLE IF EXISTS applicants CASCADE;
CREATE TABLE IF NOT EXISTS applicants
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	middle_name VARCHAR(100),
	area_id INTEGER NOT NULL REFERENCES areas (id),
	birth_day  DATE,
	status VARCHAR(100)
);

DROP TABLE IF EXISTS resumes CASCADE;
CREATE TABLE IF NOT EXISTS resumes
(
	id SERIAL PRIMARY KEY,
	applicant_id INTEGER NOT NULL REFERENCES applicants(id),
	title VARCHAR(255) NOT NULL,
	summary TEXT,
	area_id INTEGER NOT NULL REFERENCES areas (id),
	specialization_id INTEGER NOT NULL REFERENCES specializations (id),
	salary INTEGER,
	published_at DATE NOT NULL DEFAULT NOW(),
	is_visible BOOLEAN DEFAULT true
);

DROP TABLE IF EXISTS responses CASCADE;
CREATE TABLE IF NOT EXISTS responses
(
	vacancy_id INTEGER NOT NULL REFERENCES vacancies (id),
	resume_id INTEGER NOT NULL REFERENCES resumes (id),
	PRIMARY KEY (vacancy_id, resume_id),
	status VARCHAR(100),
	responded_at DATE NOT NULL DEFAULT NOW()
);

DROP TABLE IF EXISTS key_skills CASCADE;
CREATE TABLE IF NOT EXISTS key_skills
(
	id SERIAL PRIMARY KEY,
	skill VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS vacancy_skills CASCADE;
CREATE TABLE IF NOT EXISTS vacancy_skills
(
    vacancy_id INTEGER NOT NULL REFERENCES vacancies(id),
    skill_id INTEGER NOT NULL REFERENCES key_skills(id),
    PRIMARY KEY (vacancy_id, skill_id)
);

DROP TABLE IF EXISTS resume_skills CASCADE;
CREATE TABLE IF NOT EXISTS resume_skills
(
    resume_id INTEGER NOT NULL REFERENCES resumes(id),
    skill_id INTEGER NOT NULL REFERENCES key_skills(id),
    PRIMARY KEY (resume_id, skill_id)
);

