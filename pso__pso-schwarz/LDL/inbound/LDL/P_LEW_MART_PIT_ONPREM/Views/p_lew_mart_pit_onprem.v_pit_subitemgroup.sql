CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_SUBITEMGROUP
 (
client_id
,sub_item_grp_sid
,sub_item_grp_mstr_sid
,src_subitemgrp_cd
,sub_item_grp_descr_int
,sub_item_grp_descr_loc
 )
AS
SELECT
sig.client_id AS client_id  --  Ok
,sig.sub_item_grp_sid  AS sub_item_grp_sid --  Andreas: name: uwg_sid  +  restricted with inner join on history AND other tables
,( ( sig.sub_item_grp_sid * 100::INTEGER ) +  sig.client_id ) AS sub_item_grp_mstr_sid  --  Andreas does not have this
,sig.src_subitemgrp_cd AS src_subitemgrp_cd --  Andreas: name: uwg_cd + plus other restrictive joins
,sig.sub_item_grp_name AS sub_item_grp_descr_int --  Andreas: name: uwg_desc_int
,Coalesce ( dsc.sub_item_grp_descr, sig.sub_item_grp_name )AS sub_item_grp_descr_loc --  Andreas does not have this

FROM p_lew_core_ac.v_subitemgroup AS sig
INNER JOIN p_lew_core_ac.v_country AS ctr
ON  sig.client_id = ctr.country_sid
LEFT JOIN p_lew_core_ac.v_subitemgroup_descr AS dsc
ON  sig.client_id  = dsc.client_id
AND sig.sub_item_grp_sid = dsc.sub_item_grp_sid
AND ctr.lang_sid= dsc.lang_sid

WHERE sig.client_id IN  (SELECT
client_id
FROM p_lew_mart_pit_onprem.t_pit_clients )

UNION ALL
SELECT
Clients.client_id  AS client_id
,-2::INTEGER  AS sub_item_grp_sid --  Andreas: name: uwg_sid  +  restricted with inner join on history AND other tables
,((-2::INTEGER * 100::INTEGER ) +  Clients.client_id )  AS sub_item_grp_mstr_sid  --  Andreas does not have this
,'TOT'  AS src_subitemgrp_cd --  Andreas: name: uwg_cd + plus other restrictive joins
,'TOT'  AS sub_item_grp_descr_int --  Andreas: name: uwg_desc_int
,'TOT'  AS sub_item_grp_descr_loc --  Andreas does not have this

FROM(SELECT DISTINCT client_id
FROM p_lew_mart_pit_onprem.t_pit_clients ) AS Clients;