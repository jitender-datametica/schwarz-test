/*
 * Change Management
 * 2024-06-26: Union with EWM pick and main pick area information for the purpose of data integration of EWM data into WAMAS Detailbericht
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_pp_picking_main_area (client_id, wh_id_pp, picking_area_nr_pp,
picking_main_area_nr_pp, picking_main_area_desc_pp)
OPTIONS(DESCRIPTION = `UNION EWM PICK AND MAIN PICK AREA WITH WAMAS AREAS`) AS SELECT *
FROM (SELECT *
   FROM ldl_p_lew_mart_msi.v_itm_pp_picking_main_area
   UNION DISTINCT
   SELECT client_id,
    wh_id_pp,
    picking_area_nr_pp,
    picking_main_area_nr_pp,
    picking_main_area_desc_pp
   FROM ldl_p_lew_mart_lead.v_ref_pick_area_ewm)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), wh_id_pp, CAST(picking_area_nr_pp AS STRING)
    ORDER BY client_id IS NULL, client_id, wh_id_pp IS NULL, wh_id_pp, picking_area_nr_pp IS NULL, picking_area_nr_pp))
  = 1;