CREATE OR REPLACE VIEW CORE_REL.V_CALENDAR_DAY_OF_WEEK
AS
SELECT
    row_number() over(order by 1) AS day_of_week
    ,decode(day_of_week,
    1, 'Montag',
    2, 'Dienstag',
    3, 'Mittwoch',
    4, 'Donnerstag',
    5, 'Freitag',
    6, 'Samstag',
    7, 'Sonntag') AS day_of_week_descr
    ,decode(day_of_week,
    1, 'Mo',
    2, 'Di',
    3, 'Mi',
    4, 'Do',
    5, 'Fr',
    6, 'Sa',
    7, 'So') AS day_of_week_descr_short
FROM TABLE (generator(rowcount => 7));