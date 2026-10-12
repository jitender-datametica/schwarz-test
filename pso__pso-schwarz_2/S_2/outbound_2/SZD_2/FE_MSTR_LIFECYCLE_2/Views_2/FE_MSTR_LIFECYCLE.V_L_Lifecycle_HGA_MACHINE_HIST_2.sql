CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_hga_machine_hist_2 AS SELECT hga_sid,
 store_sid,
 country_pol_cd,
 lob_cd,
 manufacturer_sid,
 serial_nr,
 store_nr,
 store_name
FROM szd_core.t_dim_hga_hist_2
WHERE dwh_valid_fg;