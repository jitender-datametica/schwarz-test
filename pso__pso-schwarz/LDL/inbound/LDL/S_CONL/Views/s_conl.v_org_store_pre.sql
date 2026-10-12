CREATE OR REPLACE VIEW s_conl.v_org_store_pre
AS
/*
#DescStart#
#$Revision: 9129 $, $LastChangedBy: aarnold $
#SubjectAreas#: Organisationsstruktur
#DescEnd#
*/
SELECT
s.st_loc_sid AS store_id,
s.client_id,
s.country_cd,
s.dat_opening,
s.dat_real_opening,
s.dat_closing,
s.dat_valid_from,
s.region_cd,
s.object_nr,
s.licence_nr,
s.pst_lang_cd,
s.mde_print_cd,
s.closed_fg,
s.mde_lang_cd,
s.ord_unit_valid_store_cd,
s.test_store_fg,
s.transfer_fg,
s.store_desc,
s.orig_store_nr,
wh.src_wh_id AS wh_id,
s.cnt_open_days,
s.qty_min_dflt,
s.dat_calc_start_py,
s.dat_calc_end_py,
s.dat_calc_start_ppy,
s.dat_opening_ovis,
s.dat_closing_ovis,
s.objectstatus_id,
s.mis_store_active_fg,
sr.move_to_st_loc_sid AS move_to_store_id,
sr.move_fg
FROM p_lew_core_ac.v_wawi_org_store_act  AS s

INNER JOIN p_lew_core_ac.v_wawi_org_all_store_reloc_act AS sr
ON  sr.client_id = s.client_id
AND sr.st_loc_sid = s.st_loc_sid

INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON s.wh_loc_sid = wh.loc_sid_wh
AND s.client_id = wh.client_id
AND wh.dwh_actual_fg = 1

WHERE s.test_store_fg = 0
AND Current_Date >= s.dat_opening
and s.client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user))


UNION ALL

/* Dummy store added at country level */
SELECT
st.loc_sid_store                    AS store_id,
wawi_dummy.client_id,
wawi_dummy.country_cd,
wawi_dummy.dat_opening,
wawi_dummy.dat_real_opening,
wawi_dummy.dat_closing,
wawi_dummy.dat_valid_from,
wawi_dummy.region_cd,
wawi_dummy.object_nr,
wawi_dummy.licence_nr,
wawi_dummy.pst_lang_cd,
wawi_dummy.mde_print_cd,
wawi_dummy.closed_fg,
wawi_dummy.mde_lang_cd,
wawi_dummy.ord_unit_valid_store_cd,
wawi_dummy.test_store_fg,
wawi_dummy.transfer_fg,
wawi_dummy.store_desc,
wawi_dummy.orig_store_nr,
wawi_dummy.wh_id,
wawi_dummy.cnt_open_days,
wawi_dummy.qty_min_dflt,
wawi_dummy.dat_calc_start_py,
wawi_dummy.dat_calc_end_py,
wawi_dummy.dat_calc_start_ppy,
wawi_dummy.dat_opening_ovis,
wawi_dummy.dat_closing_ovis,
wawi_dummy.objectstatus_id,
wawi_dummy.mis_store_active_fg,
st_move_to.loc_sid_store                    AS move_to_store_id,
wawi_dummy.move_fg
FROM
(SELECT
-1 * clnt.client_id                            AS store_id,
clnt.client_id                                 AS client_id,
cntr.country_iso_cd                            AS country_cd,
Cast(NULL AS DATE)                             AS dat_opening,
Cast(NULL AS DATE)                             AS dat_real_opening,
Cast(NULL AS DATE)                             AS dat_closing,
Cast(NULL AS DATE)                             AS dat_valid_from,
NULL                                             AS region_cd,
Cast(NULL  AS VARCHAR(5)          )            AS object_nr,
Cast(NULL  AS VARCHAR(10)         )            AS licence_nr,
NULL                                           AS pst_lang_cd,
NULL                                           AS mde_print_cd,
0                                              AS closed_fg,
NULL                                           AS mde_lang_cd,
Cast(NULL  AS VARCHAR(5)          )            AS ord_unit_valid_store_cd,
0                                              AS test_store_fg,
0                                              AS transfer_fg,
'#'|| TRIM( cntr.country_iso_cd)
AS store_desc,
-1 * clnt.client_id                            AS orig_store_nr,
-1 * clnt.client_id                            AS wh_id,
NULL                                           AS cnt_open_days,
Cast(NULL  AS CHAR(1)          )               AS qty_min_dflt,
Cast(NULL AS DATE)                             AS dat_calc_start_py,
Cast(NULL AS DATE)                             AS dat_calc_end_py,
Cast(NULL AS DATE)                             AS dat_calc_start_ppy,
Cast(NULL AS DATE)                             AS dat_opening_ovis,
Cast(NULL AS DATE)                             AS dat_closing_ovis,
NULL                                           AS objectstatus_id,
1                                              AS mis_store_active_fg,
-1 * clnt.client_id                            AS move_to_store_id,
0                                              AS move_fg
FROM p_lew_core_ac.v_wawi_ref_client_country            AS clnt

INNER JOIN p_lew_core_ac.v_wawi_ref_country             AS cntr
ON clnt.country_id = cntr.country_id

WHERE cntr.dashboard_relevant_fg = 1
and clnt.client_id IN
(SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user))
) AS wawi_dummy
-- Auflösung Store
INNER JOIN p_lew_bil_ac.v_store AS st
ON wawi_dummy.client_id = st.client_id
AND wawi_dummy.store_id = st.src_store_id
AND st.dwh_actual_fg = 1
-- Auflösung Store Move To
INNER JOIN p_lew_bil_ac.v_store AS st_move_to
ON wawi_dummy.client_id = st_move_to.client_id
AND wawi_dummy.move_to_store_id = st_move_to.src_store_id
AND st_move_to.dwh_actual_fg = 1;

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_wh_merge_act", "p_lew_bil_ac.v_warehouse", "p_lew_core_ac.v_wawi_ref_client_country", "p_lew_core_ac.v_wawi_ref_country" ***/

