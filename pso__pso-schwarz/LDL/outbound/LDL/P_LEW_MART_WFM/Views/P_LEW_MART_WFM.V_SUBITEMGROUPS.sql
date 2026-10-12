CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_subitemgroups AS SELECT C.country_iso_cd,
 A.subitemgroup_id,
 A.mainitemgroup_id,
 B.subitemgroup_sortterm,
 A.itemgroup_int_id,
 B.subitemgroup_desc,
 B.subitemgroup_short_desc,
 B.language_id
FROM ldl_p_lew_core_ac.v_wawi_itm_subitemgroup AS A
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_subitemgroup_desc AS B ON A.client_id = B.client_id AND A.subitemgroup_id = B.subitemgroup_id
     AND A.dat_rec_end = B.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country AS CC ON A.client_id = CC.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS C ON CC.country_id = C.country_id
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON A.client_id = MIG.client_id
WHERE CURRENT_DATE BETWEEN A.dat_rec_start AND A.dat_rec_end
 AND A.subitemgroup_id > 0
 AND A.itemgroup_int_id > 0
 AND (CURRENT_DATE < MIG.migration_dat_valid_from OR CURRENT_DATE > MIG.migration_dat_valid_to);