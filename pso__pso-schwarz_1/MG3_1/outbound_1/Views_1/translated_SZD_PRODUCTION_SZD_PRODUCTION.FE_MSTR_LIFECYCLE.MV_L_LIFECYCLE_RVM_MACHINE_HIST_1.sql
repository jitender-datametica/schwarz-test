CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_l_lifecycle_rvm_machine_hist_1 (rvm_sid, energy_save_mode_fg,
in_store_seq, lob_name, store_sid, rvm_type_cd, manufacturer_name, manufacturer_sid, lob_cd, rvm_donation_start_dt,
country_pol_cd, serial_nr, store_nr, initial_installation_dt, conf_crate_fg, conf_refillable_fg, conf_non_refillable_fg
, rvm_sort_type_cd, rvm_orientation_cd, rvm_pack_type_cd, rvm_winding_cd, conf_back_sys_crate_fg, conf_back_sys_table_fg
, rvm_software_version_nr, rvm_software_last_update_dt, smr_software_version_nr, smr_software_last_update_dt,
rvm_active_id, inactive_dt, ts_inactive_dt) AS SELECT t_dim_rvm_hist.rvm_sid,
 t_dim_rvm_hist.energy_save_mode_fg,
 t_dim_rvm_hist.in_store_seq,
 t_dim_rvm_hist.lob_name,
 t_dim_rvm_hist.store_sid,
 t_dim_rvm_hist.rvm_type_cd,
 t_dim_rvm_hist.manufacturer_name,
 t_dim_rvm_hist.manufacturer_sid,
 t_dim_rvm_hist.lob_cd,
 t_dim_rvm_hist.rvm_donation_start_dt,
 t_dim_rvm_hist.country_pol_cd,
 t_dim_rvm_hist.serial_nr,
 t_dim_rvm_hist.store_nr,
 t_dim_rvm_hist.initial_installation_dt,
 t_dim_rvm_hist.conf_crate_fg,
 t_dim_rvm_hist.conf_refillable_fg,
 t_dim_rvm_hist.conf_non_refillable_fg,
 t_dim_rvm_hist.rvm_sort_type_cd,
 t_dim_rvm_hist.rvm_orientation_cd,
 t_dim_rvm_hist.rvm_pack_type_cd,
 t_dim_rvm_hist.rvm_winding_cd,
 t_dim_rvm_hist.conf_back_sys_crate_fg,
 t_dim_rvm_hist.conf_back_sys_table_fg,
 t_dim_rvm_hist.rvm_software_version_nr,
 t_dim_rvm_hist.rvm_software_last_update_dt,
 t_dim_rvm_hist.smr_software_version_nr,
 t_dim_rvm_hist.smr_software_last_update_dt,
 t_dim_rvm_hist.rvm_active_id,
 t_dim_rvm_hist.inactive_dt,
 tstab.inactive_dt AS ts_inactive_dt
FROM szd_production_core.t_dim_rvm_hist_1
 LEFT JOIN (SELECT v01.rvm_sid,
   v01.inactive_dt
  FROM szd_production_fe_mstr_lifecycle.ts_dim_rvm_deact_1 AS v01
   INNER JOIN (SELECT rvm_sid,
     MAX(inserted_tmsp) AS inserted_tmsp
    FROM szd_production_fe_mstr_lifecycle.ts_dim_rvm_deact_1
    GROUP BY rvm_sid) AS v02 ON v01.rvm_sid = v02.rvm_sid AND v01.inserted_tmsp = v02.inserted_tmsp) AS tstab ON
  t_dim_rvm_hist.rvm_sid = tstab.rvm_sid
WHERE CURRENT_TIMESTAMP() BETWEEN t_dim_rvm_hist.dwh_valid_from_tmsp AND t_dim_rvm_hist.dwh_valid_to_tmsp;