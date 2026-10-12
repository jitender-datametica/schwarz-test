CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_ladungstraeger_preis_faktor_2 (mandant_id, art_id, vk_brutto) AS
SELECT mandant_id,
 art_id,
 MAX(vk_brutto) AS vk_brutto
FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_2 AS V01
WHERE dat_bis = DATE '9999-12-31'
 AND art_id / 100 IN (9840018, 9840133, 9840042, 9840059, 9802554)
 AND (mandant_id = 1 AND preistyp_id = 0 AND pm_id IN (1, 10) AND vw_id IN (1, 2, 3) OR mandant_id <> 1 AND preistyp_id
       = 0 AND pm_id IN (1, 10) AND vw_id IN (10, 90))
GROUP BY mandant_id,
 art_id;