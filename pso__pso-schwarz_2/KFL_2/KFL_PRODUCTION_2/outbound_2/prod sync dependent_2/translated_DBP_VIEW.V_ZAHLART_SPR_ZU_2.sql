CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zahlart_spr_zu_2 (system_id, mandant_id, zahlart_id, spr_id, zahlart_bez
, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 zahlart_id,
 spr_id,
 zahlart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.zahlart_spr_zu_2;