/*
 * Change Management
 * 2024-06-26: Union with EWM pick and main pick area information for the purpose of data integration of EWM data into WAMAS Detailbericht
 */
CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_PP_PICKING_MAIN_AREA_2(
    CLIENT_ID
   ,WH_ID_PP
   ,PICKING_AREA_NR_PP
   ,PICKING_MAIN_AREA_NR_PP
   ,PICKING_MAIN_AREA_DESC_PP
) COMMENT = 'Union EWM pick and main pick area with WAMAS areas'
AS 
SELECT 
    client_id
    ,wh_id_pp
    ,picking_area_nr_pp
    ,picking_main_area_nr_pp
    ,picking_main_area_desc_pp
FROM (
SELECT 
    client_id
   ,wh_id_pp
   ,picking_area_nr_pp
   ,picking_main_area_nr_pp
   ,picking_main_area_desc_pp
FROM p_lew_mart_msi.v_itm_pp_picking_main_area_2
UNION
SELECT 
    client_id
   ,wh_id_pp
   ,picking_area_nr_pp
   ,picking_main_area_nr_pp
   ,picking_main_area_desc_pp
FROM p_lew_mart_lead.v_ref_pick_area_ewm_2)
QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id, wh_id_pp, picking_area_nr_pp ORDER BY client_id, wh_id_pp, picking_area_nr_pp ) = 1
;