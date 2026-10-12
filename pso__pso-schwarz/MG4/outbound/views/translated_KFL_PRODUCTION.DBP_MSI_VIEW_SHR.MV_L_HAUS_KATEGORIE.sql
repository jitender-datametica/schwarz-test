CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_haus_kategorie (mandant_id, haus_kategorie_id) AS SELECT *
FROM kfl_production_dbp_view.v_l_haus_kategorie AS v01;