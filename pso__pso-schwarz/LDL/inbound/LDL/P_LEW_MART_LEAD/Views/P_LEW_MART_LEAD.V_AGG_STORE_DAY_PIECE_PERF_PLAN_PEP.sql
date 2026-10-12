/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.v_agg_store_day_piece_perf_plan_pep
#----------------------------------------------------------------------------
# History:
#  1.0  2021-06-28    Marcin Malec          Initial
#  1.1  2022-11-10    Marcin Malec          Stuckleistung 2, AP0152203, added column sales_pieces_pep_extrapol
#  1.2  2022-11-24    Marcin Malec          Adding sales_pieces_total_pep for Filiale Cockpit
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_agg_store_day_piece_perf_plan_pep COMMENT = 'Stuckleistung plan pep values for mart'
(
  client_id                COMMENT 'Client identifier'                   
, loc_sid_store            COMMENT 'Store identifier'                    
, move_to_store_id         COMMENT 'move_to Store identifier'                    
, wh_id                    COMMENT 'Warehouse identifier'                
, dwh_cal_dt               COMMENT 'Record date'                         
, cy_month                 COMMENT 'Calendar year month'                 
, currency_iso_cd          COMMENT 'Currency code'                       
, avg_price_pep            COMMENT 'Average price based on last 3 months'
, sales_pieces_3_m         COMMENT 'Sales pieces from last 3 months'     
, sales_pieces_pep         COMMENT 'Sales pieces based on pep turnover'  
, sales_pieces_total_pep   COMMENT 'Sales pieces total based on pep turnover'
, sales_pieces_pep_extrapol COMMENT 'Sales pieces extrapolated, based on pep turnover'
, val_rtl_net_3_m          COMMENT 'Turnover based on last 3 months'     
) 
AS
SELECT
  plan.client_id       
, plan.loc_sid_store   
, o.move_to_store_id
, o.wh_id
, plan.dwh_cal_dt      
, c.cy_month    
, plan.currency_iso_cd 
, plan.avg_price_pep   
, plan.sales_pieces_3_m
, plan.sales_pieces_pep
, plan.sales_pieces_total_pep
, plan.sales_pieces_pep_extrapol
, plan.val_rtl_net_3_m
FROM P_LEW_BIL_AC.v_agg_store_day_piece_perf_plan_pep plan

INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge AS o
ON  plan.client_id     = o.client_id
AND plan.loc_sid_store = o.store_id

INNER JOIN P_LEW_CORE_AC.v_cal_calendarday AS c
ON plan.dwh_cal_dt = c.cal_dt

WHERE o.aspect_id = 2
;


