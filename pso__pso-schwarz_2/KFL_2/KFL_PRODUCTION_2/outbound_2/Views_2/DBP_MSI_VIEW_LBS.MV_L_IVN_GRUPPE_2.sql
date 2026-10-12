CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_l_ivn_gruppe_2 (mandant_id, ivn_gruppe_id, ivn_gruppe_bez) AS
SELECT mandant_id,
 ivn_gruppe_id,
 ivn_gruppe_bez
FROM kfl_production_dbp_view.v_l_ivn_gruppe_2;