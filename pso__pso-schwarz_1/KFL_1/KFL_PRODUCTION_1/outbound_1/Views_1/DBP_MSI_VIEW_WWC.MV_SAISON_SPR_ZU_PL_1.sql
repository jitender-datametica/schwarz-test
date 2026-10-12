CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_saison_spr_zu_pl_1 (mandant_id, saiso, spr_id, saison_bez) AS
SELECT mandant_id,
 saison_id AS saiso,
 spr_id,
 saison_bez
FROM kfl_production_dbp_view.v_saison_spr_zu_1 AS V01
WHERE spr_id = 90;