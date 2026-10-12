CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_saison_2 (mandant_id, saison_id) AS SELECT mandant_id,
 saison_id
FROM kfl_production_dbp_view.v_l_saison_2 AS V01;