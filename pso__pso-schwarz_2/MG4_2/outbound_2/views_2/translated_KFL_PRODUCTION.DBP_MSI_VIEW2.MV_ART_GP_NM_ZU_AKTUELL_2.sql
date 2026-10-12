CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_art_gp_nm_zu_aktuell_2 (art_id, akt_gp_id, gp_name, mandant_id,
anz_lief) AS SELECT v01.art_id,
 v01.gp_id AS akt_gp_id,
 v02.gp_name,
 v01.mandant_id,
 COUNT(v01.wup_id) AS anz_lief
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_gp_2 AS v02 ON v01.gp_id = v02.gp_id AND v01.mandant_id = v02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS v03 ON v01.mandant_id = v03.mandant_id AND v01.wup_id = v03.wup_id AND v01
   .nb_id = v03.nb_id
WHERE v01.dat_bis = DATE '9999-12-31'
 AND v01.mandant_id = 1
 AND v03.nb_id = 0
 AND CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
GROUP BY v01.mandant_id,
 v01.art_id,
 v01.gp_id,
 v02.gp_name
QUALIFY (ROW_NUMBER() OVER (PARTITION BY v01.art_id ORDER BY anz_lief IS NULL, anz_lief)) = 1;