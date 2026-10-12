CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_ptm_premiumtype_2 (client_id, wh_loc_sid, premiumtype_id,
premiumtype_short_desc, premiumtype_desc, premiumtype_cd, sap_cd, export_to_sap_fg, dat_dayend, load_id) AS SELECT
 client_id,
 wh_loc_sid,
 premiumtype_id,
 premiumtype_short_desc,
 premiumtype_desc,
 premiumtype_cd,
 sap_cd,
 export_to_sap_fg,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_ptm_premiumtype_2;