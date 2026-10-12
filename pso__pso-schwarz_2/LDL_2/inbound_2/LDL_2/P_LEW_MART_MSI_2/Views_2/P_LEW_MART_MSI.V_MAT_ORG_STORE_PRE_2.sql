CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ORG_STORE_PRE_2 
( store_id	
, client_id	
, country_cd	
, dat_opening	
, dat_real_opening	
, dat_closing	
, dat_valid_from	
, region_cd	
, object_nr	
, licence_nr	
, pst_lang_cd	
, mde_print_cd	
, closed_fg	
, mde_lang_cd	
, ord_unit_valid_store_cd
, test_store_fg	
, transfer_fg	
, store_desc	
, orig_store_nr	
, wh_id	
, cnt_open_days	
, qty_min_dflt	
, dat_calc_start_py	
, dat_calc_end_py	
, dat_calc_start_ppy	
, dat_calc_end_ppy
, dat_opening_ovis	
, dat_closing_ovis	
, dat_opening_ovis_move
, dat_closing_ovis_move
, objectstatus_id	
, mis_store_active_fg	
, move_to_store_id
, move_fg	
) AS	
SELECT	
   s.st_loc_sid AS store_id	
 , s.client_id	
 , s.country_cd	
 , s.dat_opening	
 , s.dat_real_opening	
 , s.dat_closing	
 , s.dat_valid_from	
 , s.region_cd	
 , s.object_nr	
 , s.licence_nr	
 , s.pst_lang_cd	
 , s.mde_print_cd	
 , s.closed_fg	
 , s.mde_lang_cd	
 , s.ord_unit_valid_store_cd	
 , s.test_store_fg	
 , s.transfer_fg	
 , s.store_desc	
 , s.orig_store_nr	
 , wh.src_wh_id AS wh_id	
 , s.cnt_open_days	
 , s.qty_min_dflt	
 , s.dat_calc_start_py	
 , s.dat_calc_end_py	
 , s.dat_calc_start_ppy	
 , s.dat_calc_end_ppy
 , s.dat_opening_ovis	
 , s.dat_closing_ovis	
 , MIN(s.dat_opening_ovis) OVER (PARTITION BY s.client_id, sr.move_to_st_loc_sid) AS dat_opening_ovis_move
 , MAX(CASE WHEN s.dat_closing_ovis IS NULL THEN '9999-12-31' ELSE s.dat_closing_ovis END) OVER (PARTITION BY s.client_id, sr.move_to_st_loc_sid) AS dat_closing_ovis_move
 , s.objectstatus_id	
 , s.mis_store_active_fg	
 , sr.move_to_st_loc_sid AS move_to_store_id	
 , sr.move_fg	
	
FROM p_lew_core_ac.v_wawi_org_store_act_2  AS s	
INNER JOIN p_lew_core_ac.v_wawi_org_all_store_reloc_act_2 AS sr	
ON  sr.client_id = s.client_id	
AND sr.st_loc_sid = s.st_loc_sid	
INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh	
ON s.wh_loc_sid = wh.loc_sid_wh	
AND s.client_id = wh.client_id	
AND wh.dwh_actual_fg = 1	

WHERE s.test_store_fg = 0	
AND Current_Date >= s.dat_opening	


UNION ALL	

/* Dummy_2 store added at country_2 level */	
SELECT	
   st.loc_sid_store                    AS store_id	
 , wawi_dummy.client_id	
 , wawi_dummy.country_cd	
 , wawi_dummy.dat_opening	
 , wawi_dummy.dat_real_opening	
 , wawi_dummy.dat_closing	
 , wawi_dummy.dat_valid_from	
 , wawi_dummy.region_cd	
 , wawi_dummy.object_nr	
 , wawi_dummy.licence_nr	
 , wawi_dummy.pst_lang_cd	
 , wawi_dummy.mde_print_cd	
 , wawi_dummy.closed_fg	
 , wawi_dummy.mde_lang_cd	
 , wawi_dummy.ord_unit_valid_store_cd	
 , wawi_dummy.test_store_fg	
 , wawi_dummy.transfer_fg	
 , wawi_dummy.store_desc	
 , wawi_dummy.orig_store_nr	
 , wawi_dummy.wh_id	
 , wawi_dummy.cnt_open_days	
 , wawi_dummy.qty_min_dflt	
 , wawi_dummy.dat_calc_start_py	
 , wawi_dummy.dat_calc_end_py	
 , wawi_dummy.dat_calc_start_ppy	
 , wawi_dummy.dat_calc_end_ppy	
 , wawi_dummy.dat_opening_ovis	
 , wawi_dummy.dat_closing_ovis	
 , wawi_dummy.dat_opening_ovis_move 
 , wawi_dummy.dat_closing_ovis_move 
 , wawi_dummy.objectstatus_id	
 , wawi_dummy.mis_store_active_fg	
 , st_move_to.loc_sid_store                    AS move_to_store_id	
 , wawi_dummy.move_fg	
FROM	
  (SELECT	
     -1 * clnt.client_id                                   AS store_id	
   , clnt.client_id                                        AS client_id	
   , cntr.country_iso_cd                                   AS country_cd	
   , CAST(NULL AS DATE)                                    AS dat_opening	
   , CAST(NULL AS DATE)                                    AS dat_real_opening	
   , CAST(NULL AS DATE)                                    AS dat_closing	
   , CAST(NULL AS DATE)                                    AS dat_valid_from	
   , NULL                                                  AS region_cd	
   , CAST(NULL  AS VARCHAR(5)          )                   AS object_nr	
   , CAST(NULL  AS VARCHAR(10)         )                   AS licence_nr	
   , NULL                                                  AS pst_lang_cd	
   , NULL                                                  AS mde_print_cd	
   , 0                                                     AS closed_fg	
   , NULL                                                  AS mde_lang_cd	
   , CAST(NULL  AS VARCHAR(5)          )                   AS ord_unit_valid_store_cd	
   , 0                                                     AS test_store_fg	
   , 0                                                     AS transfer_fg	
   , CAST('#'|| TRIM( cntr.country_iso_cd) AS VARCHAR(50)) AS store_desc	
   , -1 * clnt.client_id                                   AS orig_store_nr	
   , -1 * clnt.client_id                                   AS wh_id	
   , NULL                                                  AS cnt_open_days	
   , CAST(NULL  AS CHAR(1)          )                      AS qty_min_dflt	
   , CAST(NULL AS DATE)                                    AS dat_calc_start_py	
   , CAST(NULL AS DATE)                                    AS dat_calc_end_py	
   , CAST(NULL AS DATE)                                    AS dat_calc_start_ppy	
   , CAST(NULL AS DATE)                                    AS dat_calc_end_ppy
   , CAST(NULL AS DATE)                                    AS dat_opening_ovis	
   , CAST(NULL AS DATE)                                    AS dat_closing_ovis	
   , CAST(NULL AS DATE)                                    AS dat_opening_ovis_move	
   , CAST(NULL AS DATE)                                    AS dat_closing_ovis_move	
   , NULL                                                  AS objectstatus_id	
   , 1                                                     AS mis_store_active_fg	
   , -1 * clnt.client_id                                   AS move_to_store_id	
   , 0                                                     AS move_fg	
	
  FROM p_lew_core_ac.v_wawi_ref_client_country_2            AS clnt	
  INNER JOIN p_lew_core_ac.v_wawi_ref_country_2             AS cntr	
  ON clnt.country_id = cntr.country_id	
  
  WHERE cntr.dashboard_relevant_fg = 1	
  ) AS wawi_dummy	
  
INNER JOIN p_lew_bil_ac.v_store_2 AS st	
ON wawi_dummy.client_id = st.client_id	
AND wawi_dummy.store_id = st.src_store_id	
AND st.dwh_actual_fg = 1	
INNER JOIN p_lew_bil_ac.v_store_2 AS st_move_to	
ON wawi_dummy.client_id = st_move_to.client_id	
AND wawi_dummy.move_to_store_id = st_move_to.src_store_id	
AND st_move_to.dwh_actual_fg = 1	
;