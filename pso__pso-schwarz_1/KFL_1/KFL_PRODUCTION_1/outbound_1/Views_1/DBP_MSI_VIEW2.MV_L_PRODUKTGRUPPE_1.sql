CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_produktgruppe_1 (mandant_id, produktgruppe_id, platzierungswg_id
) AS SELECT mandant_id,
 produktgruppe_id,
 platzierungswg_id
FROM kfl_production_dbp_view.v_l_produktgruppe_1
WHERE mandant_id = 1;