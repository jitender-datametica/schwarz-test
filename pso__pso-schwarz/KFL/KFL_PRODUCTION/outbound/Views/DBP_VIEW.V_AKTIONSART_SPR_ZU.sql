CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aktionsart_spr_zu AS SELECT aktionsart_id,
 mandant_id,
 spr_id,
 aktionsart_bez
FROM kfl_production_dbp_data.aktionsart_spr_zu;