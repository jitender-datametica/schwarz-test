CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_funktion_spr_zu_1 AS SELECT mandant_id,
 ma_funktion_id,
 spr_id,
 ma_funktion_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ma_funktion_spr_zu_1;