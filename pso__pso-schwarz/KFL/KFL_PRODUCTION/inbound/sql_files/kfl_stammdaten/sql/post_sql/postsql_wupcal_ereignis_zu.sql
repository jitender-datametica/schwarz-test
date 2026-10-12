DELETE FROM DBP_DATA.wupcal_ereignis_zu
WHERE
(dat,wup_id,nb_id,mandant_id) IN
(
SELECT
l.dat
,w.wup_id
,w.nb_id
,w.mandant_id
FROM ${TEMP_TABLE} l
INNER JOIN DBP_DATA.wup w
ON  l.wup_id = w.haupt_wup_id
AND w.nb_id IN (2,7)
AND w.mandant_id = l.mandant_id
)
;

INSERT INTO DBP_DATA.wupcal_ereignis_zu
(	dat,
	wup_id,
	nb_id,
	mandant_id,
	ereignistyp_id,
	ereignis_id,
	offen
)

 SELECT 
	l.dat,
	w.wup_id,
	w.nb_id,
	w.mandant_id,
	l.ereignistyp_id,
	l.ereignis_id,
	l.offen
FROM ${TEMP_TABLE} l
INNER JOIN DBP_DATA.wup w
ON  l.wup_id = w.haupt_wup_id
AND w.nb_id IN (2,7)
AND w.mandant_id = l.mandant_id;

