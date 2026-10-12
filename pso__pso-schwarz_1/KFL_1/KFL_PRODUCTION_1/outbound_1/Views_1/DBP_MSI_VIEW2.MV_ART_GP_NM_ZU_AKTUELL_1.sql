CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_art_gp_nm_zu_aktuell_1 (art_id, akt_gp_id, gp_name, mandant_id,
anz_lief) AS SELECT V01.art_id,
 V01.gp_id AS akt_gp_id,
 V02.gp_name,
 V01.mandant_id,
 COUNT(V01.wup_id) AS anz_lief
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_gp_1 AS V02 ON V01.gp_id = V02.gp_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id = V03.wup_id AND V01
   .nb_id = V03.nb_id
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V01.mandant_id = 1
 AND V03.nb_id = 0
 AND CURRENT_DATE BETWEEN V03.dat_von AND V03.dat_bis
GROUP BY V01.mandant_id,
 V01.art_id,
 V01.gp_id,
 V02.gp_name
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V01.art_id AS STRING) ORDER BY anz_lief IS NULL, anz_lief)) = 1;