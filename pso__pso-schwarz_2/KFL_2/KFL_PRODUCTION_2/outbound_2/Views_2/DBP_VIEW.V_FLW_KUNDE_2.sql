CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kunde_2 AS SELECT flw_kunde_id,
 mandant_id,
 kunde_nr,
 kunde_name,
 system_id,
 frueh_spaet_kz,
 wup_id,
 kunde_land,
 kunde_plz,
 kunde_ort,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kunde_2;