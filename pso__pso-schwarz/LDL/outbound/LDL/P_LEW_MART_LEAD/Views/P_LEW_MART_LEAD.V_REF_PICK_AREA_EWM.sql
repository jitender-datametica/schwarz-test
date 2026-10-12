/*
 * This View is part of the solution for the problem that certain EWM data is not shown in WAMAS Detailbericht for the pick area, which is not
 * maintained in the p_lew_core.t_ref_pick_area_descr and p_lew_core.t_ref_pick_main_area. In this View, the EWM pick and main pick area are 
 * concluded in order to union with WAMAS pick and main pick area for the data integration between WAMAS and EWM
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_pick_area_ewm (client_id, language_id, picking_area_desc_pp,
picking_area_nr_pp, picking_main_area_nr_pp, picking_main_area_desc_pp, wh_id_pp)
OPTIONS(DESCRIPTION = `SOLUTION TO UNION THIS VIEW WITH PICK AND MAIN PICK AREA VIEW OF WAMAS`) AS
/* to get all EWM countries */ SELECT ewm.client_id,
 ewm.language_id,
 UA.pick_area_descr AS picking_area_desc_pp,
 UA.pick_area_nr AS picking_area_nr_pp,
 UA.pick_main_area_nr AS picking_main_area_nr_pp,
 MA.pick_main_area_descr AS picking_main_area_desc_pp,
 ewm.wh_id_pp
FROM (SELECT EWM.client_id,
   23 AS language_id,
   WH.src_wh_id AS wh_id_pp
  FROM ldl_p_lew_core_ac.v_warehouse_pick_item_task AS EWM
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON EWM.client_id = WH.client_id AND EWM.wh_loc_sid = WH.loc_sid_wh AND
      (WH.active_fg <> 0) AND CURRENT_DATE BETWEEN WH.dwh_valid_from AND WH.dwh_valid_to
  GROUP BY EWM.client_id,
   language_id,
   wh_id_pp
  ORDER BY 1 NULLS LAST,
   2 NULLS LAST,
   3 NULLS LAST) AS ewm
 INNER JOIN (ldl_p_lew_core_ac.v_ref_uniform_pick_area AS UA INNER JOIN ldl_p_lew_core_ac.v_ref_pick_main_area AS MA ON
   UA.pick_main_area_nr = MA.pick_main_area_nr) ON TRUE;