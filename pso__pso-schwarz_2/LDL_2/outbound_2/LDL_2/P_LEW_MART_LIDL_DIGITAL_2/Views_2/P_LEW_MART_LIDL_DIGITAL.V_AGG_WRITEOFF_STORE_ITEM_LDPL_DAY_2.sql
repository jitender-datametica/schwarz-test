/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2023-08-09 Pawel Wieczorek         AP0157806 Initial version
#  1.1 2023-10-27 Pawel Wieczorek         AP0069622 Added ITEM_SID_ORG
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_writeoff_store_item_ldpl_day_2 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), dwh_cal_dt OPTIONS(description='Data date'), loc_sid
OPTIONS(description='Store ID'), item_sid_org
OPTIONS(description='Item_2 surrogate ID (uniquely across all countries/clients) - based on source table'), item_sid
OPTIONS(description='Item_2 surrogate ID (uniquely across all countries/clients)'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'), pcwo_reason_id
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_2-specific write-off reasons have ID>100.'),
writeoff_val OPTIONS(description='writeoff net value'), load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : PRICE CHANGE PER ITEM_2 AND STORE`) AS SELECT aspect_id,
 client_id,
 dwh_cal_dt,
 loc_sid,
 item_sid_org,
 item_sid,
 currency_iso_cd,
 curr_tot_id,
 pcwo_reason_id,
 writeoff_val,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_writeoff_store_item_ldpl_day_2;