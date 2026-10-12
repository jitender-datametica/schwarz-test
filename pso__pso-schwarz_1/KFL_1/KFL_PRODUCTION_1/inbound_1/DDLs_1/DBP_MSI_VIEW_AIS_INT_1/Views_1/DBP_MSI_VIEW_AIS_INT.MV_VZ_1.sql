CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_VZ_1
-- union between views mv_vz_1 for DE and KMO
(
mandant_id
,vz_id
,nb_id
,vz_bez
)
AS SELECT
v01.mandant_id
,v01.wup_id
,v01.nb_id
,CASE WHEN v01.wup_id=-1 THEN 'ZENTRAL GENERELL'
WHEN v01.wup_id=-2 THEN 'DEZENTRAL' ELSE wup_standort
END AS wup_standort
FROM dbp_view.v_wup_1 v01
LEFT OUTER JOIN
(SELECT
v01.mandant_id
,  v01.vz_wup_id
,  v01.wup_plz
,  CASE
WHEN v01.wup_plz <20000 OR v01.vz_wup_id=6907 THEN '1'
WHEN v01.wup_plz BETWEEN 20000 AND 59999 THEN '3' ELSE '2'
END AS zu_id
,  v02.wup_id
,  v02.nb_id
FROM
(
SELECT
v01.mandant_id
,  v01.vz_wup_id
,  v01.wup_plz
,  CASE WHEN v01.wup_plz <20000 OR v01.vz_wup_id=6907 THEN '1'
WHEN v01.wup_plz BETWEEN 20000 AND 59999 THEN '3' ELSE '2'
END AS zu_id
FROM dbp_view.v_wup_1 v01
WHERE vz_wup_id = wup_id AND v01.wup_typ_id = 2 AND v01.nb_id = -111 AND v01.mandant_id = 1
) v01

LEFT OUTER JOIN dbp_view.v_wup_1 v02
ON v01.vz_wup_id=v02.vz_wup_id AND v01.mandant_id = v02.mandant_id) v02
ON
v01.vz_wup_id=v02.wup_id
WHERE wup_typ_id IN (-1,2)
AND v01.mandant_id = 1
AND v01.wup_id IN (6902, 6903, 6905, 6906, 6907, 6908, 6909)

UNION ALL

 SELECT v01.mandant_id
, v01.wup_id AS vz_id
, v01.nb_id
, v01.wup_standort AS vz_bez

FROM dbp_view.v_wup_1 AS v01

--WHERE ((v01.mandant_id = 2 AND v01.verkaufsorganisation_id = '1000') 
--  OR (v01.mandant_id = 3 AND v01.verkaufsorganisation_id = '1060')
--  OR (v01.mandant_id = 5 AND v01.verkaufsorganisation_id = '1020')
--  OR (v01.mandant_id = 6 AND v01.verkaufsorganisation_id = '1030')
--  OR (v01.mandant_id = 7 AND v01.verkaufsorganisation_id = '1070')
--  OR (v01.mandant_id = 8 AND v01.verkaufsorganisation_id = '1090'))
WHERE v01.nb_id = -111
AND ((v01.mandant_id = 2 AND v01.wup_id IN (9200, 9300)) 
  OR (v01.mandant_id = 3 AND v01.wup_id IN (9110, 9140, 9160, 9180, 9460, 9760))
  OR (v01.mandant_id = 5 AND v01.wup_id IN (9020, 9120))
  OR (v01.mandant_id = 6 AND v01.wup_id IN (9030, 9130))
  OR (v01.mandant_id = 7 AND v01.wup_id IN (6100, 6200, 9100, 9200))
  OR (v01.mandant_id = 8 AND v01.wup_id IN (6100)));