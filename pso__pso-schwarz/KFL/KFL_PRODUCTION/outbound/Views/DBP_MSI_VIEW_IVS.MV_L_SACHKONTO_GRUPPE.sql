CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_sachkonto_gruppe AS SELECT sachkonto_gruppe_id,
 sachkonto_gruppe_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_ivs_l_sachkonto_gruppe
WHERE spr_id = 22;