CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artikel_eina_1 (mandant_id, art_id) AS SELECT mandant_id,
 art_id
FROM kfl_production_dbp_data.ek_infosatz_1
WHERE mandant_id > 1
 AND dat_bis = DATE '9999-12-31'
GROUP BY mandant_id,
 art_id
HAVING COUNT(DISTINCT ek_infosatz_id) = 1;