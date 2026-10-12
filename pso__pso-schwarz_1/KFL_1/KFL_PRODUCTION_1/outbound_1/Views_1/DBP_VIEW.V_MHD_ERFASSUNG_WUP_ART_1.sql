CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mhd_erfassung_wup_art_1 AS SELECT mandant_id,
 wup_id,
 dat_erfassung,
 dat_mhd,
 art_id,
 art_anz,
 basismenge_einh_id,
 mhd_erfassung_pruef_fg,
 listung_fg,
 dat_erstellung,
 dat_aenderung
FROM kfl_production_dbp_data.mhd_erfassung_wup_art_1;