CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_geschlecht_spr_zu_2 AS SELECT mandant_id,
 geschlecht_id,
 spr_id,
 geschlecht_bez,
 anrede_bez
FROM kfl_production_dbp_data.ma_geschlecht_spr_zu_2;