CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tarifgebiet_spr_zu_2 (mandant_id, tarifgebiet_id, spr_id, tarifgebiet_bez
) AS SELECT mandant_id,
 tarifgebiet_id,
 spr_id,
 tarifgebiet_bez
FROM kfl_production_dbp_data.tarifgebiet_spr_zu_2;