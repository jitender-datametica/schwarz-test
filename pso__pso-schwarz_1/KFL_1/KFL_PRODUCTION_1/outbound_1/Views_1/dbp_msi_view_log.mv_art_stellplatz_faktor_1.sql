CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_art_stellplatz_faktor_1 AS SELECT V01.mandant_id,
 V01.art_id,
 COALESCE(V02.stellplatz_faktor, 0) AS vol
FROM kfl_production_dbp_view.v_art_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_view_log.ts_art_stellplatz_faktor_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id
    = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
      AND V03.arthiertyp_id = 2 AND V03.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_wg_filter_zu_1 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.wg_id = V04.wg_id
  AND V04.wg_filter_id = 4
WHERE V01.dat_bis = DATE '9999-12-31';