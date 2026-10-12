CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagernummer_tms (mandant_id, ewm_fg, tms_gp_id,
tms_gp_id_anzeige, tms_gp_typ_cd, tms_gp_lfd_nr, tms_gp_name, tms_gp_altnv_name, tms_gp_strasse, tms_gp_ort_name,
tms_gp_plz, tms_land_cd, sperr_fg, sammelbeleg_id, tms_standorttyp_id, dat_wanko_von, lagernummer_bez,
lagernummer_bez_de, lagernummer_bez_cz, lagernummer_bez_sk, lagernummer_bez_hr, lagernummer_bez_pl, lagernummer_bez_ro,
lagernummer_bez_bg) AS SELECT *
FROM kfl_production_dbp_msi_view_log.mv_dt_lagernummer_tms;