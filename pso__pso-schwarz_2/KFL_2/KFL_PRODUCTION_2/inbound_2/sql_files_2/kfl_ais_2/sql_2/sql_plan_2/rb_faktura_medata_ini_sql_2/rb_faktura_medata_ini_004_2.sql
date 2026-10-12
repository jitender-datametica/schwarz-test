--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
INSERT INTO DBP_ETL.rb_faktura_medata_date_2
(
gjmo
,kjmo
,dat_von
,dat_bis
)

SELECT
gjmo
,kjmo
,min(dat) dat_von
,max(dat) dat_bis

FROM
DBP_DATA.tag_2

WHERE

dat < CURRENT_DATE

AND
(
kj = EXTRACT(YEAR FROM CURRENT_DATE)
OR
(
kj =EXTRACT(YEAR FROM CURRENT_DATE)-1
AND
1 =EXTRACT(MONTH FROM CURRENT_DATE)
)
)
GROUP BY 1,2
;

