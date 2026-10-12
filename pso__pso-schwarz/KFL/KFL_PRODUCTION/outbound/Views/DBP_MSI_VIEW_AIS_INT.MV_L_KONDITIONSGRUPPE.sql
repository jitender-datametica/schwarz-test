CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_konditionsgruppe (mandant_id, konditionsgruppe_id) AS
SELECT mandant_id,
 konditionsgruppe_id
FROM kfl_production_dbp_view.v_l_konditionsgruppe
WHERE mandant_id = 1;