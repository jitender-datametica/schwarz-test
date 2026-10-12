CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_abdeckung_1 AS SELECT abdeckung_id,
 amx_system_id,
 pruefung_id,
 berechneter_wert,
 manueller_wert,
 business_process_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_abdeckung_1;