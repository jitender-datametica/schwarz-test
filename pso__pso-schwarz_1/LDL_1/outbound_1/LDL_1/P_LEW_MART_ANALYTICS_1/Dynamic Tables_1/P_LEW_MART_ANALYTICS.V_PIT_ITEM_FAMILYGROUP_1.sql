CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_pit_item_familygroup_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT client_id,
 item_fam_grp_sid,
 src_familygrp_cd AS item_fam_grp_descr
FROM ldl_p_lew_core_ac.v_item_familygroup_1
UNION ALL
SELECT country_sid,
 - 2,
 'TOT'
FROM ldl_p_lew_core_ac.v_country_1;