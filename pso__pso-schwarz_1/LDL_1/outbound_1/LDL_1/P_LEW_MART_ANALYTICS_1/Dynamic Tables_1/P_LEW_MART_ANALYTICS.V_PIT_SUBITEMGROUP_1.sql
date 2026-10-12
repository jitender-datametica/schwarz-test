CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_pit_subitemgroup_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT SIG.client_id,
 SIG.sub_item_grp_sid,
 SIG.src_subitemgrp_cd,
 SIG.sub_item_grp_name AS sub_item_grp_descr_int,
 COALESCE(DSC.sub_item_grp_descr, SIG.sub_item_grp_name) AS sub_item_grp_descr_loc
FROM ldl_p_lew_core_ac.v_subitemgroup_1 AS SIG
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS CTR ON SIG.client_id = CTR.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_subitemgroup_descr_1 AS DSC ON SIG.client_id = DSC.client_id AND SIG.sub_item_grp_sid = DSC
    .sub_item_grp_sid AND CTR.lang_sid = DSC.lang_sid
UNION ALL
SELECT country_sid,
 - 2,
 'TOT',
 'TOT',
 'TOT'
FROM ldl_p_lew_core_ac.v_country_1;
