CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_saison_1 (mandant_id, saiso) AS SELECT mandant_id,
 saison_id AS saiso
FROM kfl_production_dbp_view.v_l_saison_1 AS V01;