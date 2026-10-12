CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wupcal_ereignis_zu_cross_1 (dat, wup_id, nb_id, mandant_id,
ereignistyp_id, ereignis_id, offen) AS (SELECT V01.dat,
  V03.wup_id,
  V03.nb_id,
  V03.mandant_id,
  V03.ereignistyp_id,
  V03.ereignis_id,
  V03.offen
 FROM kfl_production_dbp_view.v_tag_1 AS V01
  INNER JOIN kfl_production_dbp_view.v_wupcal_ereignis_zu_1 AS V03 ON V01.dat = V03.dat AND V01.akt_mo BETWEEN - 2 AND 0
 UNION DISTINCT
 SELECT V01.dat,
  V01.wup_id,
  V01.nb_id,
  V01.mandant_id,
  100 AS ereignistyp_id,
  - 1 AS ereignis_id,
  COALESCE(V01.offen, 0) AS offen
 FROM kfl_production_dbp_view.v_wupcal_1 AS V01
  INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V01.dat = V02.dat AND V02.akt_mo BETWEEN - 2 AND 0
 WHERE (V01.dat, V01.wup_id, V01.mandant_id) NOT IN (SELECT (V03.dat, V03.wup_id, V03.mandant_id)
    FROM kfl_production_dbp_view.v_wupcal_ereignis_zu_1 AS V03
     INNER JOIN kfl_production_dbp_view.v_tag_1 AS V04 ON V03.dat = V04.dat AND V04.akt_mo BETWEEN - 2 AND 0 AND V03.ereignistyp_id
        = 100))
UNION DISTINCT
SELECT V01.dat,
 V01.wup_id,
 V01.nb_id,
 V01.mandant_id,
 101 AS ereignistyp_id,
 - 1 AS ereignis_id,
 COALESCE(V01.offen, 0) AS offen
FROM kfl_production_dbp_view.v_wupcal_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V01.dat = V02.dat AND V02.akt_mo BETWEEN - 2 AND 0
WHERE (V01.dat, V01.wup_id, V01.mandant_id) NOT IN (SELECT (V03.dat, V03.wup_id, V03.mandant_id)
   FROM kfl_production_dbp_view.v_wupcal_ereignis_zu_1 AS V03
    INNER JOIN kfl_production_dbp_view.v_tag_1 AS V040 ON V03.dat = V040.dat AND V040.akt_mo BETWEEN - 2 AND 0 AND V03.ereignistyp_id
       = 101);