CREATE OR REPLACE VIEW P_LEW_BIL_AC.v_store_day_item_price_change_1
(
  client_id                     COMMENT 'Client identifier'
, loc_sid_store                 COMMENT 'Store identifier'
, dwh_cal_dt                    COMMENT 'Record date'
, cy_day_seq                    COMMENT 'Day sequence number'
, day_of_week                   COMMENT 'Day of week'
, cy_month                      COMMENT 'Calendar_1 month'
, orig_item_nr                  COMMENT 'Item_1 number'
, item_sid                      COMMENT 'Item_1 identifier'
, pcwo_reason_id                COMMENT 'pcwo_reason_id'
, pcwo_reason_desc              COMMENT 'pcwo_reason_desc'
, pch_day_pricegroup_fg         COMMENT 'PV Tag_1 Preisschienen'
, discount_value_promodesigner  COMMENT 'Promowert vom PromoDesigner, local currency'
, discount_value_lidlplus       COMMENT 'Promowert vom LidlPlus, local currency'
, pch_baseline_fg               COMMENT 'Flag fuer Berechnung der Baseline (Tage mit signifikanter PV werden fuer Baselines dann ausgeschlossen)'
)
AS
SELECT
  pch.client_id            
, pch.loc_sid_store        
, pch.dwh_cal_dt           
, pch.cy_day_seq         
, pch.day_of_week          
, pch.cy_month             
, pch.orig_item_nr     
, pch.item_sid             
, pch.pcwo_reason_id  
, pch.pcwo_reason_desc
, pch.pch_day_pricegroup_fg       
, pch.discount_value_promodesigner
, pch.discount_value_lidlplus     
, pch.pch_baseline_fg             
FROM P_LEW_BIL.v_store_day_item_price_change_1 pch
;
