CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_auftragart_1 (mandant_id, tms_auftragsart_id,
tms_auftragsart_bez) AS SELECT mandant_id,
 tms_auftragsart_id,
 tms_auftragsart_bez
FROM kfl_production_dbp_view.v_l_tms_auftragsart_1;