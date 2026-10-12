CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_pit_itemgroup_international_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT IGI.client_id,
 IGI.item_grp_int_sid,
 IGI.src_itemgrp_int_cd,
 IGI.item_grp_int_name AS item_grp_int_descr_int,
 COALESCE(DSC.item_grp_int_descr, IGI.item_grp_int_name) AS item_grp_int_descr_loc
FROM ldl_p_lew_core_ac.v_itemgroup_international_1 AS IGI
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS CTR ON IGI.client_id = CTR.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_itemgroup_international_descr_1 AS DSC ON IGI.client_id = DSC.client_id AND IGI.item_grp_int_sid
     = DSC.item_grp_int_sid AND CTR.lang_sid = DSC.lang_sid
WHERE CAST(IGI.src_itemgrp_int_cd AS FLOAT64) <> 8
UNION ALL
SELECT country_sid,
 - 2,
 'TOT',
 'TOT',
 'TOT'
FROM ldl_p_lew_core_ac.v_country_1;