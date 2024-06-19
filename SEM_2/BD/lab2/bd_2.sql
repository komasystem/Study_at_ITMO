SELECT "Н_ЛЮДИ"."ИМЯ", "Н_ВЕДОМОСТИ"."ДАТА"
FROM "Н_ВЕДОМОСТИ"
    RIGHT JOIN "Н_ЛЮДИ" ON "Н_ВЕДОМОСТИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД"
WHERE "Н_ЛЮДИ"."ИД" < 152862
AND "Н_ВЕДОМОСТИ"."ДАТА" < '2010-06-18';



SELECT "Н_ЛЮДИ"."ИМЯ", "Н_ВЕДОМОСТИ"."ЧЛВК_ИД", "Н_СЕССИЯ"."ЧЛВК_ИД"
FROM "Н_ЛЮДИ"
         JOIN "Н_ВЕДОМОСТИ" ON "Н_ВЕДОМОСТИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД"
         JOIN "Н_СЕССИЯ" ON "Н_СЕССИЯ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД"
WHERE "Н_ЛЮДИ"."ОТЧЕСТВО" > 'Георгиевич'
  AND "Н_ВЕДОМОСТИ"."ИД" = 39921
  AND "Н_СЕССИЯ"."ДАТА" = '2004-01-17';





SELECT COUNT(*) FROM Н_ЛЮДИ JOIN "Н_УЧЕНИКИ" ON "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД"
JOIN Н_ПЛАНЫ ON "Н_УЧЕНИКИ"."ПЛАН_ИД" = "Н_ПЛАНЫ"."ИД"
JOIN Н_ОТДЕЛЫ ON  Н_ПЛАНЫ.ОТД_ИД =  Н_ОТДЕЛЫ.ИД
WHERE ИНН is NULL AND Н_ОТДЕЛЫ.КОРОТКОЕ_ИМЯ = 'КТиУ';




SELECT "Н_УЧЕНИКИ"."ГРУППА", AVG(CAST("Н_ВЕДОМОСТИ"."ОЦЕНКА" AS INTEGER))
FROM "Н_УЧЕНИКИ"
JOIN "Н_ВЕДОМОСТИ" ON "Н_ВЕДОМОСТИ"."ЧЛВК_ИД" = "Н_УЧЕНИКИ"."ЧЛВК_ИД"
WHERE "Н_ВЕДОМОСТИ"."ОЦЕНКА" ~ '^[0-9]+$' 
GROUP BY "Н_УЧЕНИКИ"."ГРУППА"
HAVING AVG(CAST("Н_ВЕДОМОСТИ"."ОЦЕНКА" AS INTEGER)) < 
    (SELECT MAX(CAST("Н_ВЕДОМОСТИ"."ОЦЕНКА" AS INTEGER)) 
     FROM "Н_УЧЕНИКИ"
     JOIN "Н_ВЕДОМОСТИ" ON "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ВЕДОМОСТИ"."ЧЛВК_ИД"
     WHERE "Н_УЧЕНИКИ"."ГРУППА" = '1101' 
     AND "Н_ВЕДОМОСТИ"."ОЦЕНКА" ~ '^[0-9]+$'
    );



SELECT "ГРУППЫ_ВТ_2011"."ГРУППА", "ГРУППЫ_ВТ_2011"."КОЛИЧЕСТВО"
FROM (SELECT "Н_УЧЕНИКИ"."ГРУППА", count("Н_УЧЕНИКИ"."ИД") AS "КОЛИЧЕСТВО"
      FROM "Н_УЧЕНИКИ"
               JOIN "Н_ПЛАНЫ"
                    ON "Н_УЧЕНИКИ"."ПЛАН_ИД" = "Н_ПЛАНЫ"."ИД"
                        AND "Н_ПЛАНЫ"."УЧЕБНЫЙ_ГОД" = '2010/2011'
               JOIN "Н_ОТДЕЛЫ"
                    ON "Н_ОТДЕЛЫ"."ИД" = "Н_ПЛАНЫ"."ОТД_ИД"
                        AND "Н_ОТДЕЛЫ"."КОРОТКОЕ_ИМЯ" = 'ВТ'
      GROUP BY "Н_УЧЕНИКИ"."ГРУППА") AS "ГРУППЫ_ВТ_2011"
WHERE "ГРУППЫ_ВТ_2011"."КОЛИЧЕСТВО" < 5;





SELECT УЧЕНИКИ."ГРУППА",
       УЧЕНИКИ."ИД",
       "Н_ЛЮДИ"."ФАМИЛИЯ",
       "Н_ЛЮДИ"."ИМЯ",
       "Н_ЛЮДИ"."ОТЧЕСТВО",
       УЧЕНИКИ."П_ПРКОК_ИД"
FROM "Н_УЧЕНИКИ" AS УЧЕНИКИ
         JOIN "Н_ЛЮДИ" ON "Н_ЛЮДИ"."ИД" = УЧЕНИКИ."ЧЛВК_ИД"
         JOIN "Н_ПЛАНЫ" ON УЧЕНИКИ."ПЛАН_ИД" = "Н_ПЛАНЫ"."ИД"
         JOIN "Н_ФОРМЫ_ОБУЧЕНИЯ" ON "Н_ПЛАНЫ"."ФО_ИД" = "Н_ФОРМЫ_ОБУЧЕНИЯ"."ИД"
    AND ("Н_ФОРМЫ_ОБУЧЕНИЯ"."НАИМЕНОВАНИЕ" = 'Очная')
   WHERE DATE("УЧЕНИКИ"."НАЧАЛО") > '2012-09-01';





SELECT surname."ФАМИЛИЯ", surname."ИМЯ", surname."ИД" AS "ID_1", b."ИД" AS "ID_2"
FROM "Н_ЛЮДИ" as surname
JOIN "Н_ЛЮДИ" as b ON surname."ФАМИЛИЯ" = b."ФАМИЛИЯ" AND surname."ИД" <> b."ИД"
ORDER BY surname."ФАМИЛИЯ", surname."ИМЯ";
