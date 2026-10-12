/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2022-12-16 Pawel Wieczorek         AP0133752 Article Hierarchy
#  1.1 2023-08-09 Pawel Wieczorek         AP0157806 Added PCWO_REASON_ID
#  1.2 2023-10-27 Pawel Wieczorek         AP0069622 Added ITEM_SID_ORG
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_agg_pch_store_item_ldpl_day
COMMENT = 'Lidlplus : Price change'
(
 aspect_id          COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
,client_id          COMMENT 'Identifier for client'
,dwh_cal_dt         COMMENT 'Data date'
,loc_sid            COMMENT 'Store ID'
,item_sid_org       COMMENT 'Item surrogate ID (uniquely across all countries/clients) - based on source table'
,item_sid           COMMENT 'Item surrogate ID (uniquely across all countries/clients)'
,currency_iso_cd    COMMENT 'ISO code for the currency of the client.'
,curr_tot_id        COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'
,pcwo_reason_id     COMMENT 'Unique ID of the write-off or Price change reason. Country-specific write-off reasons have ID>100.'
,price_change_val   COMMENT 'Price change value'
,load_id            COMMENT 'Load identifier'
,dwh_created        COMMENT 'Row insert time'
,dwh_updated        COMMENT 'Row update time'
,dwh_src_updated    COMMENT 'Row update time of t_agg_str_day_item_pch'
)
AS
SELECT
 aspect_id
,client_id
,dwh_cal_dt
,loc_sid
,item_sid_org
,item_sid
,currency_iso_cd
,curr_tot_id
,pcwo_reason_id
,price_change_val
,load_id
,dwh_created
,dwh_updated
,dwh_src_updated
FROM p_lew_mart_lidl_digital.v_agg_pch_store_item_ldpl_day 
;