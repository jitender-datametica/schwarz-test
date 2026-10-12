CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_fur_1 AS SELECT mandant_id,
 flw_art_id,
 flw_kunde_id,
 dat,
 system_id,
 menge_sicherheit,
 menge_plan,
 dat_erstellung,
 einh_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_fur_1;