--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.preis_aenderung_spr_zu
(
mandant_id
,preis_aend_grund_id
,spr_id
,preis_aend_grund_bez
)
SELECT
l.mandant_id
,l.preis_aend_grund_id
,m.spr_id
,'system generated' AS layoutbaustein_bez
FROM DBP_DATA.l_preis_aenderung l

INNER JOIN DBP_DATA.mandant_spr_zu m
ON (l.mandant_id = m.mandant_id OR m.mandant_id = 1)

WHERE (l.preis_aend_grund_id, l.mandant_id, spr_id) NOT IN
(
SELECT
preis_aend_grund_id
,mandant_id
,spr_id
FROM DBP_DATA.preis_aenderung_spr_zu
)
AND l.preis_aend_grund_id=0
;

