CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_gp_nm_zu_aktuell (mandant_id, art_id, akt_gp_id,
gp_name, anz_lief) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.gp_id AS akt_gp_id,
 V02.gp_name,
 COUNT(*) AS anz_lief
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per AS V01
 INNER JOIN kfl_production_dbp_view.v_gp AS V02 ON V01.gp_id = V02.gp_id AND V01.mandant_id = V02.mandant_id
WHERE V01.dat_bis = PARSE_DATE('%F', '9999-12-31')
 AND V01.gp_id <> - 1
 AND V01.mandant_id <> 1
GROUP BY V01.mandant_id,
 V01.art_id,
 akt_gp_id,
 V02.gp_name
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.art_id AS STRING) ORDER BY anz_lief
      IS NULL, anz_lief)) = 1;