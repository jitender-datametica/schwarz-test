create or replace view LDL_PRODUCTION.P_LEW_BIL_AC.V_ITM_PP_PICKING_MAIN_AREA_1(
	CLIENT_ID,
	WH_ID_PP,
	PICKING_AREA_NR_PP,
	PICKING_MAIN_AREA_NR_PP,
	PICKING_MAIN_AREA_DESC_PP
) as
   SELECT
       client_id,
   wh_id_pp,
   picking_area_nr_pp,
   picking_main_area_nr_pp,
   picking_main_area_desc_pp
  FROM p_lew_bil.v_itm_pp_picking_main_area_1
;
