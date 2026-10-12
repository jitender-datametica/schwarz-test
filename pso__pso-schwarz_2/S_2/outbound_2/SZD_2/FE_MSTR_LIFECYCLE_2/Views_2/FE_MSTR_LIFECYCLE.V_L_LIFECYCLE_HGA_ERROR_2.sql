CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_hga_error_2 (hga_error_cd, hga_error_grp_sid, manufacturer_sid
, hga_error_descr, hga_error_descr_de, hga_error_descr_ch, hga_error_descr_en, hga_error_descr_cz, hga_error_descr_lt,
hga_error_descr_sk, hga_error_descr_si, hga_error_descr_ro) AS SELECT hga_error_cd,
 hga_error_grp_sid,
 manufacturer_sid,
 hga_error_descr,
 hga_error_descr_de,
 hga_error_descr_de AS hga_error_descr_ch,
 hga_error_descr_en,
 hga_error_descr_en AS hga_error_descr_cz,
 hga_error_descr_en AS hga_error_descr_lt,
 hga_error_descr_en AS hga_error_descr_sk,
 hga_error_descr_en AS hga_error_descr_si,
 hga_error_descr_en AS hga_error_descr_ro
FROM szd_core.t_dim_hga_error_2;