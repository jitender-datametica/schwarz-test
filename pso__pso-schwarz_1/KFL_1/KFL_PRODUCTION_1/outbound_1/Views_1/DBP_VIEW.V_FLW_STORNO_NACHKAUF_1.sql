CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_storno_nachkauf_1 AS SELECT flw_art_id,
 werk_id,
 dat,
 storno_fg,
 mandant_id,
 menge_kg_wunsch,
 menge_kg_ist,
 menge_bstmg_wunsch,
 menge_bstmg_ist,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_storno_nachkauf_1;