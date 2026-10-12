CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_saison (mandant_id, saison_id, saison_bez) AS SELECT mandant_id,
 saison_id,
 saison_bez
FROM kfl_production_dbp_view.v_saison_spr_zu AS V01
WHERE mandant_id = 1
 AND spr_id = 22;