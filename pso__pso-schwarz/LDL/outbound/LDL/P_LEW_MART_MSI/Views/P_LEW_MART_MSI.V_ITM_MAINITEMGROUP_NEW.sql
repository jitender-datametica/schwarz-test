CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_mainitemgroup_new AS SELECT MIG.mainitemgroup_id,
 MAX(MIG.mainitemgroup_desc) AS mainitemgroup_desc,
 MAX(MIG.mainitemgroup_short_desc) AS mainitemgroup_short_desc,
 MIG.mainitemgroup_sortterm,
 MIG.language_id
FROM ldl_p_lew_core_ac.v_wawi_itm_mainitemgroup AS MIG
 INNER JOIN ldl_p_lew_mart_msi.v_ref_user_language AS LG ON LOWER(SESSION_USER()) = LOWER(LG.db_user) AND MIG.language_id
    = LG.language_id
WHERE CURRENT_DATE BETWEEN MIG.dat_rec_start AND MIG.dat_rec_end
GROUP BY MIG.mainitemgroup_id,
 MIG.mainitemgroup_sortterm,
 MIG.language_id;