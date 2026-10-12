CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_besch_faktura AS SELECT faktura_beleg_id,
 mandant_id,
 dat_faktura,
 dat_erstellung,
 fakturaart_id,
 flw_vw_id,
 system_id,
 flw_kunde_id,
 faktura_status_kz,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_besch_faktura;