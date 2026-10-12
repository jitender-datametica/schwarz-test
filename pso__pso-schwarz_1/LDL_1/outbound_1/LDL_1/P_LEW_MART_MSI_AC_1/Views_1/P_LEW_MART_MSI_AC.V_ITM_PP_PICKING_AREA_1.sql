/*
 * Change Management
 * 2024-06-26: Union with EWM pick area View for data integration in WAMAS Detailbericht
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_pp_picking_area_1 (client_id, language_id, picking_area_desc_pp,
picking_area_nr_pp, wh_id_pp) OPTIONS(DESCRIPTION = `UNION OF EWM AND WAMAS PICK AREA`) AS SELECT *
FROM (SELECT *
   FROM ldl_p_lew_mart_msi.v_itm_pp_picking_area_1
   UNION ALL
   SELECT client_id,
    language_id,
    picking_area_desc_pp,
    picking_area_nr_pp,
    wh_id_pp
   FROM ldl_p_lew_mart_lead.v_ref_pick_area_ewm_1)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), wh_id_pp, CAST(picking_area_nr_pp AS STRING)
    ORDER BY client_id IS NULL, client_id, wh_id_pp IS NULL, wh_id_pp, picking_area_nr_pp IS NULL, picking_area_nr_pp))
  = 1
  -- this condition ensures that for those records which were not in the wamas pick area table, they will be filled with records from the uniform table
;