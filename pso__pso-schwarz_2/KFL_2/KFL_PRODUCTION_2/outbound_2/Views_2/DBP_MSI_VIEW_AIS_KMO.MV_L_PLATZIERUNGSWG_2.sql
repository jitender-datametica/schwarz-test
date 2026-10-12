CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_platzierungswg_2 (mandant_id, platzierungswg_id,
platzierungswg_nr) AS SELECT mandant_id,
 platzierungswg_id,
 platzierungswg_nr
FROM kfl_production_dbp_view.v_l_platzierungswg_2
WHERE mandant_id <> 1;