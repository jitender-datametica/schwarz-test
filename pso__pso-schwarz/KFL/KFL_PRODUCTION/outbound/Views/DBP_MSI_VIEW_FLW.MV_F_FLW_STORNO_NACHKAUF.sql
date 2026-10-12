CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_storno_nachkauf (mandant_id, in_art_id, werk_id, dat,
storno_fg, menge_kg_wunsch, menge_kg_ist, menge_bstmg_wunsch, menge_bstmg_ist) AS SELECT mandant_id,
 flw_art_id AS in_art_id,
 werk_id,
 dat,
 storno_fg,
 menge_kg_wunsch,
 menge_kg_ist,
 menge_bstmg_wunsch,
 menge_bstmg_ist
FROM kfl_production_dbp_view.v_flw_storno_nachkauf AS V01;