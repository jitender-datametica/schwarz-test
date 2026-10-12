CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_subkategorie_2_spr_zu_pl_1 (mandant_id, subkategorie_2_id,
spr_id, subkategorie_2_bez) AS SELECT MIN(mandant_id) AS mandant_id,
 subkategorie_2_id,
 spr_id,
 MAX(subkategorie_2_bez) AS subkategorie_2_bez
FROM kfl_production_dbp_view.v_subkategorie_2_spr_zu_1
WHERE spr_id = 90
GROUP BY subkategorie_2_id,
 spr_id;