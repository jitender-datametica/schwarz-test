-- Andreas does not have this
 -- Andreas: name: wgi_desc_loc: Andreas does not have coalesce
 -- Andreas: name: wgi_cd

-- Andreas: name: wgi_sid
 -- Note! sid no longer
 -- Ok
 -- Andreas: name: wgi_desc_int

-- Odd! maybe used -client_id*100 - client_id or some other multiple of 100 so can see the client

-- Exclude 'PC und Zubehör'
 CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_itemgroup_international_1 (client_id,
item_grp_int_sid, item_grp_int_mstr_sid, src_itemgrp_int_cd, item_grp_int_descr_int, item_grp_int_descr_loc) AS SELECT
 IGI.client_id,
 IGI.item_grp_int_sid,
   IGI.item_grp_int_sid * 100 + IGI.client_id AS item_grp_int_mstr_sid,
 IGI.src_itemgrp_int_cd,
 IGI.item_grp_int_name AS item_grp_int_descr_int,
 COALESCE(DSC.item_grp_int_descr, IGI.item_grp_int_name) AS item_grp_int_descr_loc
FROM ldl_p_lew_core_ac.v_itemgroup_international_1 AS IGI
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS CTR ON IGI.client_id = CTR.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_itemgroup_international_descr_1 AS DSC ON IGI.client_id = DSC.client_id AND IGI.item_grp_int_sid
     = DSC.item_grp_int_sid AND CTR.lang_sid = DSC.lang_sid
WHERE IGI.client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit_onprem.t_pit_clients_1)
 AND ROUND(SAFE_CAST(IGI.src_itemgrp_int_cd AS BIGNUMERIC), 0) NOT IN (8, 80)
UNION ALL
SELECT client_id,
 - 2 AS item_grp_int_sid,
   - 2 * 100 + client_id AS item_grp_int_mstr_sid,
 'TOT' AS src_itemgrp_int_cd,
 'TOT' AS item_grp_int_descr_int,
 'TOT' AS item_grp_int_descr_loc
FROM (SELECT DISTINCT client_id
  FROM ldl_p_lew_mart_pit_onprem.t_pit_clients_1) AS Clients;