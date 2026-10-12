/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_VERKAUFSPREISE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  06.03.2023    Bialek, Aleksander           filtering for UWg extended to cover also newly added UWGs (between 200 and 399), ADO: 448371, it4you:PRJ0015189                                              
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_PSA_VERKAUFSPREISE_1
(
  client_id
, adv_dt
, orig_item_nr
, wh_id
, dat_valid_from
, saleprice
, saleprice_country
)
AS
   SELECT
     adv.client_id
   , adv.dat_adv               AS adv_dt
   , i.orig_item_nr
   , adv.wh_id
   , adv.dat_valid_from
   , ipw.price_retail_eur      AS saleprice
   , ipw.price_retail          AS saleprice_country
   FROM p_lew_mart_cs.v_psa_itm_price_wh_1 ipw
   INNER JOIN p_lew_bil_ac.v_adv_orig_item_advertising_1 adv
   ON ipw.client_id = adv.client_id
   AND ipw.wh_id = adv.wh_id
   INNER JOIN p_lew_core_ac.v_cal_calendarday_1 cal
   ON ipw.calendar_dt = cal.cal_dt
   INNER JOIN p_lew_mart_cs.v_gen_item_asis_1 i
   ON ipw.client_id = i.client_id
   AND ipw.item_id = i.item_sid
   AND adv.client_id = i.client_id
   /*AND adv.dat_valid_from = i.dat_valid_from*/
   AND adv.orig_item_nr = i.orig_item_nr

   WHERE ipw.calendar_dt = adv.dat_adv
   AND i.subitemgroup_id BETWEEN 100 AND 399
;