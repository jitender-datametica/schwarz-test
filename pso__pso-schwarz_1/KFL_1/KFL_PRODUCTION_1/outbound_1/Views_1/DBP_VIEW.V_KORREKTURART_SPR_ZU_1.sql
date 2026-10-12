CREATE OR REPLACE VIEW kfl_production_dbp_view.v_korrekturart_spr_zu_1 AS SELECT system_id,
 mandant_id,
 spr_id,
 korrekturart_id,
 korrekturart_bez
FROM kfl_production_dbp_data.korrekturart_spr_zu_1;