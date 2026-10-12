CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_funktion_wup_zu_2 AS SELECT mandant_id,
 wup_id,
 ma_id,
 ma_funktion_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ma_funktion_wup_zu_2;