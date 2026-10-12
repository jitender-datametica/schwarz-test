CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_haus_kategorie_spr_zu_2 (mandant_id, haus_kategorie_id, spr_id,
haus_kategorie_bez) AS SELECT *
FROM kfl_production_dbp_view.v_haus_kategorie_spr_zu_2 AS v01
WHERE spr_id = 22;