--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.art_vw_erst_we;


INSERT INTO DBP_DATA.art_vw_erst_we
SELECT 
art_id,
--- Workaround 2011.03.13 --- David Bandeira
COALESCE(vw_id,-1),
mandant_id,
MIN(dat_erst_we)
,localtimestamp
,localtimestamp
FROM

(SELECT 
 v02.art_id
,vw_id
,v02.mandant_id
,min(v01.dat_faktura) as dat_erst_we
FROM DBP_DATA.besch_faktura v01

INNER JOIN DBP_DATA.besch_faktura_det v02
ON v01.faktura_beleg_id=v02.faktura_beleg_id

INNER JOIN DBP_DATA.wup v03
ON COALESCE(try_cast(v01.auftraggeber_id AS INTEGER),-1) = v03.wup_id
AND v03.mandant_id=1
AND v03.nb_id=0

WHERE v01.auftraggeber_id Between '0000001000' AND  '0000009999'
GROUP BY 1,2,3

UNION

SELECT 
 v01.art_id
,vw_id
,v01.mandant_id
,min(v01.dat_faktura) as dat_erst_we
FROM DBP_DATA.besch_faktura_medata v01

INNER JOIN DBP_DATA.wup v02
ON faktura_markt = v02.wup_id
AND v02.mandant_id = 1 
AND v02.nb_id=0

GROUP BY 1,2,3


UNION

SELECT 
 art_id
,vw_id
,v01.mandant_id
,min(dat) as dat_erst_we
FROM DBP_DATA.bsch_rech_det v01

--INNER JOIN DBP_DATA.bsch_rech v02
--ON
--v01.bsch_id=v02.bsch_id

INNER JOIN DBP_DATA.wup v03
ON v01.wup_id=v03.wup_id

WHERE v01.nb_id=0
GROUP BY 1,2,3)a
GROUP BY 1,2,3
;

