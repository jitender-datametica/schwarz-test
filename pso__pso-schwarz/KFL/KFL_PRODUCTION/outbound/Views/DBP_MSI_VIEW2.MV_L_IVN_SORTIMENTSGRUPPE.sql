CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_ivn_sortimentsgruppe (mandant_id, ivn_sortimentsgruppe_id,
ivn_sortimentsgruppe_bez) AS SELECT mandant_id,
 ivn_sortimentsgruppe_id,
 ivn_sortimentsgruppe_bez
FROM kfl_production_dbp_view.v_l_ivn_sortimentsgruppe
WHERE mandant_id = 1;