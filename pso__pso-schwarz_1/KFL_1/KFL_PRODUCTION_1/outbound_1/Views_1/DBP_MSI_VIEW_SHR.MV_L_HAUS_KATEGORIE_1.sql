CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_haus_kategorie_1 (mandant_id, haus_kategorie_id) AS SELECT
 mandant_id,
 haus_kategorie_id
FROM kfl_production_dbp_view.v_l_haus_kategorie_1 AS V01;