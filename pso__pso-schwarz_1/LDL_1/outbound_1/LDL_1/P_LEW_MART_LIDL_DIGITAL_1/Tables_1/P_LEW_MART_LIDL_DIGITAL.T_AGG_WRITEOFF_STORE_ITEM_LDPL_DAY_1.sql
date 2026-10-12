/*

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2023-03-13 Pawel Wieczorek         AP0157806 Booking reasons
#  1.1 2023-10-26 Pawel Wieczorek         AP0069622 Added ITEM_SID_ORG
#----------------------------------------------------------------------------

drop TABLE LDL.P_LEW_MART_LIDL_DIGITAL.T_AGG_WRITEOFF_STORE_ITEM_LDPL_DAY_1; 

*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_writeoff_store_item_ldpl_day_1 (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store ID'),
item_sid_org BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Item_1 surrogate ID (uniquely across all countries/clients) - based on source table'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item_1 surrogate ID (uniquely across all countries/clients)'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
pcwo_reason_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
writeoff_val NUMERIC(18,5) NOT NULL OPTIONS(description='writeoff net value'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (aspect_id, client_id, dwh_cal_dt, loc_sid, item_sid_org, curr_tot_id, pcwo_reason_id) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Lidlplus : Writeoff per item_1 and store');