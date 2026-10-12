CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_rohertrag_plan_ist AS SELECT flw_art_id,
 buchungsperiode_id,
 krk_id,
 plan_fg,
 werk_id,
 gj,
 mandant_id,
 wrg_id,
 rohertrag_betrag,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_rohertrag_plan_ist;