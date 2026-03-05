-- на всякий случай был добавлен between,
-- так в первой версии скрипта 2, я генерировал отклики раньше вакансий
-- прикольно, мне пришлось сгенерировать ~400 тыс откликов с первой версией скрипта,
-- чтобы получить что-нибудь
select v.id, v.title
from vacancies v
join responses r on r.vacancy_id = v.id
-- where r.responded_at <= v.published_at + interval '7 days'
where r.responded_at between v.published_at and v.published_at + interval '7 days'
group by v.id
having count(*) > 5
order by v.id;
