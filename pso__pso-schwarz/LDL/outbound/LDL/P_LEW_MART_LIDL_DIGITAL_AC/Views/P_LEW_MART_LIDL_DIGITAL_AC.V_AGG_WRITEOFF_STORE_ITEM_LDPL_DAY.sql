/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2023-08-09 Pawel Wieczorek         AP0157806 Initial version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_writeoff_store_item_ldpl_day (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), dwh_cal_dt OPTIONS(description='Data date'), loc_sid
OPTIONS(description='Store ID'), item_sid_org
OPTIONS(description='Item surrogate ID (uniquely across all countries/clients) - based on source table'), item_sid
OPTIONS(description='Item surrogate ID (uniquely across all countries/clients)'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'), pcwo_reason_id
OPTIONS(description='Unique ID of the write-off or Price change reason. Country-specific write-off reasons have ID>100.'),
writeoff_val OPTIONS(description='writeoff net value'), load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : PRICE CHANGE PER ITEM AND STORE`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_agg_writeoff_store_item_ldpl_day;