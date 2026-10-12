CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cpr_projektart_spr_zu AS SELECT projektart_id,
 spr_id,
 projektart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cpr_projektart_spr_zu;