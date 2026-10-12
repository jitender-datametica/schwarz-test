/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_TIV_ITEM_STORE_DAY_COUNT_2
#----------------------------------------------------------------------------
# History:
#  --- ---------- ----------------------- --------------------------------
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT                                        
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_tiv_item_store_day_count_2 (dat_formdate
OPTIONS(description='DATUM DER INVENTURANFORDERUNG'), client_id OPTIONS(description='MIS CLIENT ID'), request_id
OPTIONS(description='ANFORDERUNGS ID'), loc_sid_wh OPTIONS(description='S-KEY DER LOCATION_2, HIER DER GESELLSCHAFT'),
move_to_store_id OPTIONS(description='S-KEY DER LOCATION_2, HIER DER FILIALE'), aspect_id
OPTIONS(description='GESELLSCHAFTSFORM (1 = BETRIEBS- 2 = VERTRIEBSGESELLSCHAFT)'), currency_iso_cd
OPTIONS(description='3 STELLIGER WÄHRUNGS-CODE'), curr_tot_id OPTIONS(description='INTERNER WÄHRUNGS-CODE'),
request_list_id OPTIONS(description='ANFORDERUNGS LITE ID'), inv_type_id OPTIONS(description='INVENTURTYP'),
stock_corr_req_status_id OPTIONS(description='STATUS_2 DER INVENTURANFORDERUNG'), item_sid
OPTIONS(description='S-KEY DER ARTIKEL_2'), cnt_reason_id OPTIONS(description='GRUND DER INVENTURANFORDERUNG'),
act_item_cnt OPTIONS(description='GEZÄHLTE MENGE'), calc_item_cnt OPTIONS(description='SOLLMENGE'), korrekturmenge
OPTIONS(description='KORREKTURMENGE'), price_retail_netto, korrekturwert, inv_cnt
OPTIONS(description='REPORTING-ZÄHLER')) AS SELECT dat_formdate,
 client_id,
 request_id,
 loc_sid_wh,
 move_to_store_id,
 aspect_id,
 currency_iso_cd,
 curr_tot_id,
 request_list_id,
 inv_type_id,
 stock_corr_req_status_id,
 item_sid,
 cnt_reason_id,
 act_item_cnt,
 soll_bestand AS calc_item_cnt,
 korrekturmenge,
 price_retail_netto,
 korrekturwert,
 inv_cnt
FROM ldl_p_lew_mart_lead.v_tiv_item_store_day_count_2;