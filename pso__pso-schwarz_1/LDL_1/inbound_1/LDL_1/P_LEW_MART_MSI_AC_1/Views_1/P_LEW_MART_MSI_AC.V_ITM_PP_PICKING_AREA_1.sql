/*
 * Change Management
 * 2024-06-26: Union with EWM pick area View for data integration in WAMAS Detailbericht
 */
CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_PP_PICKING_AREA_1(
	CLIENT_ID,
	LANGUAGE_ID,
	PICKING_AREA_DESC_PP,
	PICKING_AREA_NR_PP,
	WH_ID_PP
) COMMENT = 'Union of EWM and WAMAS Pick Area'
AS
SELECT 
    client_id
   ,language_id
   ,picking_area_desc_pp
   ,picking_area_nr_pp
   ,wh_id_pp
FROM (
SELECT 
    client_id
   ,language_id
   ,picking_area_desc_pp
   ,picking_area_nr_pp
   ,wh_id_pp
FROM p_lew_mart_msi.v_itm_pp_picking_area_1
UNION ALL 
SELECT
    client_id
   ,language_id
   ,picking_area_desc_pp
   ,picking_area_nr_pp
   ,wh_id_pp
FROM p_lew_mart_lead.v_ref_pick_area_ewm_1)
QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id, wh_id_pp, picking_area_nr_pp ORDER BY client_id, wh_id_pp,picking_area_nr_pp) = 1
-- this condition ensures that for those records which were not in the wamas pick area table, they will be filled with records from the uniform table
;