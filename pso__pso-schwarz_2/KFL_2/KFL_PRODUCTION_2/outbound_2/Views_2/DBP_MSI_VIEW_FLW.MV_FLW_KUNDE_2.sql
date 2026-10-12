CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flw_kunde_2 (mandant_id, wup_id, flw_kunde_id, kunde_nr,
kunde_name, frueh_spaet_kz, system_id, kunde_land, kunde_plz, kunde_ort) AS SELECT mandant_id,
 wup_id,
 flw_kunde_id,
 kunde_nr,
 kunde_name,
 frueh_spaet_kz,
 system_id,
 kunde_land,
 kunde_plz,
 kunde_ort
FROM kfl_production_dbp_view.v_flw_kunde_2;