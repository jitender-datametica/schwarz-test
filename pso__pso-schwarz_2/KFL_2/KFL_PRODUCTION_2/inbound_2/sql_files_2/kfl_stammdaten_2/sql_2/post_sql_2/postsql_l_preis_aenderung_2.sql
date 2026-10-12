--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.l_preis_aenderung_2
(
mandant_id
,preis_aend_grund_id
)
SELECT
dt.mandant_id
,0 AS preis_aend_grund_id
FROM (SELECT mandant_id FROM DBP_DATA.l_preis_aenderung_2 GROUP BY 1 ) dt

WHERE
 (dt.mandant_id,0)
NOT IN 
(SELECT
mandant_id
,preis_aend_grund_id
FROM DBP_DATA.l_preis_aenderung_2
WHERE preis_aend_grund_id = 0
);

