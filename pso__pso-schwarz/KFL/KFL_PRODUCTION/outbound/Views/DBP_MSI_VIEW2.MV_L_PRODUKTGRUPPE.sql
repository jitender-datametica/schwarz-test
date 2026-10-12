CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_produktgruppe (mandant_id, produktgruppe_id, platzierungswg_id
) AS SELECT mandant_id,
 produktgruppe_id,
 platzierungswg_id
FROM kfl_production_dbp_view.v_l_produktgruppe
WHERE mandant_id = 1;