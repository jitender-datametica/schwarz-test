/*
 * This View is part of the solution for the problem that certain EWM data is not shown in WAMAS Detailbericht for the pick area, which is not
 * maintained in the p_lew_core.t_ref_pick_area_descr_2 and p_lew_core.t_ref_pick_main_area. In this View, the EWM pick and main pick area are 
 * concluded in order to union with WAMAS pick and main pick area for the data integration between WAMAS and EWM
 */
CREATE OR REPLACE VIEW p_lew_mart_lead.v_ref_pick_area_ewm_2(
	CLIENT_ID
   ,LANGUAGE_ID
   ,PICKING_AREA_DESC_PP
   ,PICKING_AREA_NR_PP
   ,PICKING_MAIN_AREA_NR_PP
   ,PICKING_MAIN_AREA_DESC_PP
   ,WH_ID_PP
) COMMENT = 'Solution to union this view with pick and main pick area view of wamas'
AS 
SELECT 
     ewm.client_id
    ,ewm.language_id
    ,ua.pick_area_descr AS picking_area_desc_pp
    ,ua.pick_area_nr AS picking_area_nr_pp
    ,ua.pick_main_area_nr AS picking_main_area_nr_pp
    ,ma.pick_main_area_descr AS picking_main_area_desc_pp
    ,wh_id_pp
FROM (
SELECT 
     ewm.client_id
    ,23 AS language_id
    ,wh.src_wh_id AS wh_id_pp
FROM p_lew_core_ac.v_warehouse_pick_item_task_2 ewm /*to get all EWM countries*/
INNER JOIN p_lew_bil_ac.v_warehouse_2 wh
ON ewm.client_id = wh.client_id
AND ewm.wh_loc_sid = wh.loc_sid_wh
AND wh.active_fg = TRUE
AND CURRENT_DATE BETWEEN wh.dwh_valid_from AND wh.dwh_valid_to
GROUP BY 1,2,3
ORDER BY 1,2,3) ewm
INNER JOIN p_lew_core_ac.v_ref_uniform_pick_area_2 ua  
INNER JOIN p_lew_core_ac.v_ref_pick_main_area_2 ma
ON ua.pick_main_area_nr = ma.pick_main_area_nr
;