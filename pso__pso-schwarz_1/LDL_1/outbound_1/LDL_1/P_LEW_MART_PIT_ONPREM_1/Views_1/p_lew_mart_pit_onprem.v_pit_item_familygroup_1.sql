CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_item_familygroup_1 AS SELECT client_id,
 item_fam_grp_sid,
 src_familygrp_cd AS item_fam_grp_descr
FROM ldl_p_lew_core_ac.v_item_familygroup_1
UNION ALL
SELECT country_sid,
 - 2 AS dm__operand1,
 'TOT' AS dm__operand2
FROM ldl_p_lew_core_ac.v_country_1;