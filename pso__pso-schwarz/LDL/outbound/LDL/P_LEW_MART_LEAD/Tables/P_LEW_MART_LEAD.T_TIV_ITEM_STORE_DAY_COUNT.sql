/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_TIV_ITEM_STORE_DAY_COUNT 
#----------------------------------------------------------------------------
# History:
#  --- ---------- ----------------------- --------------------------------
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT                                        
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_tiv_item_store_day_count (
requested_cnt_dt DATE NOT NULL OPTIONS(description='DATUM DER INVENTURANFORDERUNG'),
client_id INTEGER NOT NULL OPTIONS(description='MIS CLIENT ID'),
request_id INTEGER NOT NULL OPTIONS(description='ANFORDERUNGS ID'),
loc_sid_wh INTEGER NOT NULL OPTIONS(description='S-KEY DER LOCATION, HIER DER GESELLSCHAFT'),
move_to_store_id INTEGER NOT NULL OPTIONS(description='S-KEY DER LOCATION, HIER DER FILIALE'),
aspect_id INTEGER NOT NULL OPTIONS(description='GESELLSCHAFTSFORM (1 = BETRIEBS- 2 = VERTRIEBSGESELLSCHAFT)'),
currency_iso_cd STRING COLLATE 'und:ci' OPTIONS(description='3 STELLIGER WÄHRUNGS-CODE'),
curr_tot_id STRING COLLATE 'und:ci' OPTIONS(description='INTERNER WÄHRUNGS-CODE'),
request_list_id INTEGER OPTIONS(description='ANFORDERUNGS LITE ID'),
inv_type_id INTEGER OPTIONS(description='INVENTURTYP'),
stock_corr_req_status_id INTEGER OPTIONS(description='STATUS DER INVENTURANFORDERUNG'),
item_sid INTEGER NOT NULL OPTIONS(description='S-KEY DER ARTIKEL'),
cnt_reason_id INTEGER OPTIONS(description='GRUND DER INVENTURANFORDERUNG'),
act_item_cnt INTEGER OPTIONS(description='GEZÄHLTE MENGE'),
soll_bestand INTEGER OPTIONS(description='SOLLMENGE'),
korrekturmenge INTEGER OPTIONS(description='KORREKTURMENGE'),
price_retail_netto NUMERIC(18,4),
korrekturwert NUMERIC(18,4),
inv_cnt INTEGER OPTIONS(description='REPORTING-ZÄHLER')
) OPTIONS(description='TEILINVENTUREN');