CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_subkategorie_1_spr_zu_bg_1 (subkategorie_1_id, spr_id,
subkategorie_1_bez) AS SELECT subkategorie_1_id,
 spr_id,
 MAX(subkategorie_1_bez) AS subkategorie_1_bez
FROM kfl_production_dbp_view.v_subkategorie_1_spr_zu_1
WHERE spr_id = 18
GROUP BY subkategorie_1_id,
 spr_id;