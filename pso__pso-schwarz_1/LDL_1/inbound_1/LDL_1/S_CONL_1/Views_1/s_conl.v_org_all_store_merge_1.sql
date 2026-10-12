CREATE OR REPLACE VIEW s_conl.v_org_all_store_merge_1
AS
/*
#DescStart#
#$Revision: 9128 $, $LastChangedBy: aarnold $
#SubjectAreas#: Organisationsstruktur
#DescEnd#
*/
SELECT
osm.aspect_id,
osm.client_id,
osm.move_to_st_loc_sid            AS move_to_store_id,
osm.move_store_desc,
wh.src_wh_id                      AS wh_id,
wh2.src_wh_id                     AS wh_id_exp,
osm.sales_manager_id,
osm.dat_closing_ovis,
osm.dat_opening_ovis,
osm.mis_store_active_fg,
osm.dat_opening,
osm.dat_closing,
osm.orig_store_nr,
osm.dat_calc_start_py,
osm.dat_calc_end_py,
osm.objectstatus_id,
osm.dat_calc_start_ppy,
osm.move_fg,
osm.street,
osm.zipcode,
osm.city,
osm.phone,
osm.longitude,
osm.latitude
FROM p_lew_core_ac.v_wawi_org_all_store_merge_act_1 osm

INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
ON osm.wh_loc_sid = wh.loc_sid_wh
AND osm.client_id = wh.client_id
AND wh.dwh_actual_fg = 1

INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh2
ON osm.wh_loc_sid_exp = wh2.loc_sid_wh
AND osm.client_id = wh2.client_id
AND wh2.dwh_actual_fg = 1
WHERE osm.client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping_1 WHERE lower(user_name) = lower(current_user))

UNION ALL
/* Dummy_1 store added at country_1 level for aspect 1, 2*/
SELECT
wawi_dummy.aspect_id,
wawi_dummy.client_id,
st.loc_sid_store AS move_to_store_id,
wawi_dummy.move_store_desc,
wawi_dummy.wh_id,
wawi_dummy.wh_id_exp,
wawi_dummy.sales_manager_id,
wawi_dummy.dat_closing_ovis,
wawi_dummy.dat_opening_ovis,
wawi_dummy.mis_store_active_fg,
wawi_dummy.dat_opening,
wawi_dummy.dat_closing,
wawi_dummy.orig_store_nr,
wawi_dummy.dat_calc_start_py,
wawi_dummy.dat_calc_end_py,
wawi_dummy.objectstatus_id,
wawi_dummy.dat_calc_start_ppy,
wawi_dummy.move_fg,
wawi_dummy.street,
wawi_dummy.zipcode,
wawi_dummy.city,
wawi_dummy.phone,
wawi_dummy.longitude,
wawi_dummy.latitude
FROM
(SELECT
multiply.row_no                                AS aspect_id,
clnt.client_id                                 AS client_id,
-1 * clnt.client_id                           AS move_to_store_id,
'#'|| TRIM( cntr.country_iso_cd)
AS move_store_desc,
-1 * clnt.client_id                            AS wh_id,
-1 * clnt.client_id                            AS wh_id_exp,
-1 * clnt.client_id                            AS sales_manager_id,
Cast(NULL AS DATE)                             AS dat_closing_ovis,
Cast(NULL AS DATE)                             AS dat_opening_ovis,
1                                              AS mis_store_active_fg,
Cast(NULL AS DATE)                             AS dat_opening,
Cast(NULL AS DATE)                             AS dat_closing,
-1 * clnt.client_id                            AS orig_store_nr,
Cast(NULL AS DATE)                             AS dat_calc_start_py,
Cast(NULL AS DATE)                             AS dat_calc_end_py,
NULL                                           AS objectstatus_id,
Cast(NULL AS DATE)                             AS dat_calc_start_ppy,
0                                              AS move_fg,
Cast(NULL AS VARCHAR(70))                      AS street,
Cast(NULL AS VARCHAR(15))                      AS zipcode,
Cast(NULL AS VARCHAR(50))                      AS city,
Cast(NULL AS VARCHAR(50))                      AS phone,
Cast(NULL AS DECIMAL(9,6))                     AS longitude,
Cast(NULL AS DECIMAL(9,6))                     AS latitude
FROM p_lew_core_ac.v_wawi_ref_client_country_1            AS clnt

INNER JOIN p_lew_core_ac.v_wawi_ref_country_1             AS cntr
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
) AS wawi_dummy
INNER JOIN p_lew_bil_ac.v_store_1 AS st
ON wawi_dummy.client_id = st.client_id
AND wawi_dummy.move_to_store_id = st.src_store_id
AND st.dwh_actual_fg = 1
WHERE wawi_dummy.client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping_1 WHERE lower(user_name) = lower(current_user));

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_sales_manager_merge_act_1", "p_lew_core_ac.v_location_1", "p_lew_core_ac.v_wawi_ref_client_country_1", "p_lew_core_ac.v_wawi_ref_country_1" ***/

