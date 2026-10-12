CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kostenart_spr_zu_2 AS SELECT kostenart_id,
 spr_id,
 mandant_id,
 krk_id,
 system_id,
 kostenart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.kostenart_spr_zu_2;