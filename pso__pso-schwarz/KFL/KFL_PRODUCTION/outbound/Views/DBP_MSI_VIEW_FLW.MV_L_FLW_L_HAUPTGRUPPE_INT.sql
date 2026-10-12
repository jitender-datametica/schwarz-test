CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_hauptgruppe_int AS SELECT hauptgruppe_id AS
 hauptgruppe_int_id
FROM kfl_production_dbp_view.v_flw_hauptgruppe
WHERE mandant_id = 2;