CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_subitemgroup_1 (client_id, sub_item_grp_sid, sub_item_grp_mstr_sid
, src_subitemgrp_cd, sub_item_grp_descr_int, sub_item_grp_descr_loc) AS SELECT SIG.client_id,
 SIG.sub_item_grp_sid,
   SIG.sub_item_grp_sid * 100 + SIG.client_id AS sub_item_grp_mstr_sid,
 SIG.src_subitemgrp_cd,
 SIG.sub_item_grp_name AS sub_item_grp_descr_int,
 COALESCE(DSC.sub_item_grp_descr, SIG.sub_item_grp_name) AS sub_item_grp_descr_loc
FROM ldl_p_lew_core_ac.v_subitemgroup_1 AS SIG
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS CTR ON SIG.client_id = CTR.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_subitemgroup_descr_1 AS DSC ON SIG.client_id = DSC.client_id AND SIG.sub_item_grp_sid = DSC
    .sub_item_grp_sid AND CTR.lang_sid = DSC.lang_sid
WHERE SIG.client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit_onprem.t_pit_clients_1)
UNION ALL
SELECT client_id,
 - 2 AS sub_item_grp_sid,
   - 2 * 100 + client_id AS sub_item_grp_mstr_sid,
 'TOT' AS src_subitemgrp_cd,
 'TOT' AS sub_item_grp_descr_int,
 'TOT' AS sub_item_grp_descr_loc
FROM (SELECT DISTINCT client_id
  FROM ldl_p_lew_mart_pit_onprem.t_pit_clients_1) AS Clients;