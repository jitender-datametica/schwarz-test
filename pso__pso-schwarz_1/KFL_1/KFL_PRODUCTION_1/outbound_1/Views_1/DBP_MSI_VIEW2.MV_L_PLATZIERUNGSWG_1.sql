CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_platzierungswg_1 (mandant_id, platzierungswg_id,
platzierungswg_nr) AS SELECT mandant_id,
 platzierungswg_id,
 platzierungswg_nr
FROM kfl_production_dbp_view.v_l_platzierungswg_1
WHERE mandant_id = 1;