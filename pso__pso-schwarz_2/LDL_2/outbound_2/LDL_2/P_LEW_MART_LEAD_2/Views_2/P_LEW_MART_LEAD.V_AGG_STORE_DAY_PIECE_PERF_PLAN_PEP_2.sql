/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.v_agg_store_day_piece_perf_plan_pep_2
#----------------------------------------------------------------------------
# History:
#  1.0  2021-06-28    Marcin Malec          Initial
#  1.1  2022-11-10    Marcin Malec          Stuckleistung 2, AP0152203, added column sales_pieces_pep_extrapol
#  1.2  2022-11-24    Marcin Malec          Adding sales_pieces_total_pep for Filiale Cockpit
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_store_day_piece_perf_plan_pep_2 (client_id
OPTIONS(description='Client identifier'), loc_sid_store OPTIONS(description='Store identifier'), move_to_store_id
OPTIONS(description='move_to Store identifier'), wh_id OPTIONS(description='Warehouse identifier'), dwh_cal_dt
OPTIONS(description='Record date'), cy_month OPTIONS(description='Calendar_2 year month'), currency_iso_cd
OPTIONS(description='Currency code'), avg_price_pep OPTIONS(description='Average price based on last 3 months'),
sales_pieces_3_m OPTIONS(description='Sales_2 pieces from last 3 months'), sales_pieces_pep
OPTIONS(description='Sales_2 pieces based on pep turnover'), sales_pieces_total_pep
OPTIONS(description='Sales_2 pieces total based on pep turnover'), sales_pieces_pep_extrapol
OPTIONS(description='Sales_2 pieces extrapolated, based on pep turnover'), val_rtl_net_3_m
OPTIONS(description='Turnover based on last 3 months')) OPTIONS(DESCRIPTION = `STUCKLEISTUNG PLAN PEP VALUES FOR MART`)
AS SELECT PLAN.client_id,
 PLAN.loc_sid_store,
 O.move_to_store_id,
 O.wh_id,
 PLAN.dwh_cal_dt,
 C.cy_month,
 PLAN.currency_iso_cd,
 PLAN.avg_price_pep,
 PLAN.sales_pieces_3_m,
 PLAN.sales_pieces_pep,
 PLAN.sales_pieces_total_pep,
 PLAN.sales_pieces_pep_extrapol,
 PLAN.val_rtl_net_3_m
FROM ldl_p_lew_bil_ac.v_agg_store_day_piece_perf_plan_pep_2 AS PLAN
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_2 AS O ON PLAN.client_id = O.client_id AND PLAN.loc_sid_store = O.store_id
   
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS C ON PLAN.dwh_cal_dt = C.cal_dt
WHERE O.aspect_id = 2;