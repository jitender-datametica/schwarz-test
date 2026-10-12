/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.v_agg_store_day_piece_perf_plan_pep
#----------------------------------------------------------------------------
# History:
#  1.0  2021-06-28    Marcin Malec          Initial
#  1.1  2022-11-10    Marcin Malec          Stuckleistung 2, AP0152203, added column sales_pieces_pep_extrapol
#  1.2  2022-11-24    Marcin Malec          Adding sales_pieces_total_pep for Filiale Cockpit
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL_AC.v_agg_store_day_piece_perf_plan_pep COMMENT = 'Stuckleistung plan pep values'
(                                                                       
  client_id                COMMENT 'Client identifier'                     
, loc_sid_store            COMMENT 'Store identifier'                      
, dwh_cal_dt               COMMENT 'Record date'                           
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
  client_id       
, loc_sid_store   
, dwh_cal_dt      
, currency_iso_cd 
, avg_price_pep   
, sales_pieces_3_m
, sales_pieces_pep
, sales_pieces_total_pep
, sales_pieces_pep_extrapol
, val_rtl_net_3_m
FROM P_LEW_BIL.v_agg_store_day_piece_perf_plan_pep
;
