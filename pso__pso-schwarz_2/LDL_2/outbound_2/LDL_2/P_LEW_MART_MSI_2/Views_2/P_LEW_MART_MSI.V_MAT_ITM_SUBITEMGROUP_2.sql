CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_itm_subitemgroup_2 AS SELECT subitemgroup_id,
 MAX(mainitemgroup_id) AS mainitemgroup_id,
 MAX(itemgroup_int_id) AS itemgroup_int_id,
 - 1 AS statisticgroup_id
FROM (SELECT *
  FROM (SELECT DISTINCT ROUND(SAFE_CAST(S.src_subitemgrp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
     COALESCE(H.main_item_grp_cd, '-1') AS mainitemgroup_id,
     ROUND(SAFE_CAST(H.item_grp_int_cd AS BIGNUMERIC), 0) AS itemgroup_int_id,
     COUNT(*) OVER (PARTITION BY S.src_subitemgrp_cd, COALESCE(H.main_item_grp_cd, ''), H.item_grp_int_cd RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_zuordnungen
    FROM ldl_p_lew_core_ac.v_subitemgroup_2 AS S
     INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_2 AS H ON S.client_id = H.client_id AND S.sub_item_grp_sid = H.sub_item_grp_sid
       
    WHERE CURRENT_DATE BETWEEN H.dwh_valid_from AND H.dwh_valid_to) AS az
  QUALIFY anz_zuordnungen = (MAX(anz_zuordnungen) OVER (PARTITION BY CAST(subitemgroup_id AS STRING), mainitemgroup_id, CAST(itemgroup_int_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS max_az
GROUP BY subitemgroup_id;