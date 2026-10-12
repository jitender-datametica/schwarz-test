CREATE OR REPLACE VIEW s_conl.v_org_account_manager_merge
AS
/*
#DescStart#
#$Revision: 6244 $, $LastChangedBy: hwieber $
#SubjectAreas#: Organisationsstruktur
#DescEnd#
*/
SELECT
oamm.aspect_id,
oamm.client_id,
b.src_wh_id  AS wh_id,
oamm.account_manager_id,
oamm.account_manager_name
FROM p_lew_core_ac.v_wawi_org_account_manager_mrg_act oamm
INNER JOIN p_lew_core_ac.v_location b
ON oamm.client_id = b.client_id
AND oamm.wh_loc_sid = b.loc_sid
AND b.wh_store_mark = 'B'  -- Filialen

WHERE oamm.client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user))

UNION ALL

/* Adding country level dummy records for aspect id 1 and 2*/
SELECT
multiply.row_no                                  AS aspect_id,
client_id                                        AS client_id,
-1*client_id                                     AS wh_id,
-1*client_id                                     AS account_manager_id,
'#'|| TRIM( cntr.country_iso_cd)
AS account_manager_name
FROM p_lew_core_ac.v_wawi_ref_client_country              AS clnt

INNER JOIN p_lew_core_ac.v_wawi_ref_country               AS cntr
ON clnt.country_id = cntr.country_id

CROSS JOIN (SELECT
1 AS row_no
FROM (SELECT
1 AS one) SUB1
UNION ALL
SELECT
2 AS row_no
FROM (SELECT
1 AS two) SUB2
) AS multiply
WHERE cntr.dashboard_relevant_fg = 1
	and client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user));

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_all_store_merge_act", "p_lew_bil_ac.v_warehouse", "p_lew_bil_ac.v_store", "p_lew_core_ac.v_wawi_ref_client_country", "p_lew_core_ac.v_wawi_ref_country" ***/

