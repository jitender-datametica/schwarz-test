CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artkz_mutter_1 (mutter_art_id, mutter_art_bez, mandant_id, spr_id)
AS SELECT 0 AS mutter_art_id,
 '0' AS mutter_art_bez,
 1 AS mandant_id,
 22 AS spr_id
FROM kfl_production_dbp_view.v_tag_1
LIMIT 1;