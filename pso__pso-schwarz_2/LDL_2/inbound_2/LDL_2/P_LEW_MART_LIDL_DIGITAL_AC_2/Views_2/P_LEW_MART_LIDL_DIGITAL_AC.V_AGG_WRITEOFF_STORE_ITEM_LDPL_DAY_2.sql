/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2023-08-09 Pawel Wieczorek         AP0157806 Initial version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_agg_writeoff_store_item_ldpl_day_2
COMMENT = 'Lidlplus : Price change per item_2 and store'
(
 aspect_id         COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
,client_id         COMMENT 'Identifier for client'
,dwh_cal_dt        COMMENT 'Data date'
,loc_sid           COMMENT 'Store ID'
,item_sid_org       COMMENT 'Item_2 surrogate ID (uniquely across all countries/clients) - based on source table'
,item_sid          COMMENT 'Item_2 surrogate ID (uniquely across all countries/clients)'
,currency_iso_cd   COMMENT 'ISO code for the currency of the client.'
,curr_tot_id       COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'
,pcwo_reason_id    COMMENT 'Unique ID of the write-off or Price change reason. Country_2-specific write-off reasons have ID>100.'
,writeoff_val      COMMENT 'writeoff net value'
,load_id           COMMENT 'Load identifier'
,dwh_created       COMMENT 'Row insert time'
,dwh_updated       COMMENT 'Row update time'
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
,writeoff_val
,load_id
,dwh_created
,dwh_updated
FROM p_lew_mart_lidl_digital.v_agg_writeoff_store_item_ldpl_day_2 
;