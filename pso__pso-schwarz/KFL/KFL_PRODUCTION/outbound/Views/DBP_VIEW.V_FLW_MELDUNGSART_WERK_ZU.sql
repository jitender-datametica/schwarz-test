CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_meldungsart_werk_zu AS SELECT werk_id,
 meldungsart_id,
 mandant_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_meldungsart_werk_zu;