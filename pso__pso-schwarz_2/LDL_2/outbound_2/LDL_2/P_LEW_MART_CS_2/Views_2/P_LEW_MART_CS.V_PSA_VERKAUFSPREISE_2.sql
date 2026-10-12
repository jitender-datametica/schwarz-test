/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_VERKAUFSPREISE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  06.03.2023    Bialek, Aleksander           filtering for UWg extended to cover also newly added UWGs (between 200 and 399), ADO: 448371, it4you:PRJ0015189                                              
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_psa_verkaufspreise_2 (client_id, adv_dt, orig_item_nr, wh_id, dat_valid_from,
saleprice, saleprice_country) AS SELECT ADV.client_id,
 ADV.dat_adv AS adv_dt,
 I.orig_item_nr,
 ADV.wh_id,
 ADV.dat_valid_from,
 IPW.price_retail_eur AS saleprice,
 IPW.price_retail AS saleprice_country
FROM ldl_p_lew_mart_cs.v_psa_itm_price_wh_2 AS IPW
 INNER JOIN ldl_p_lew_bil_ac.v_adv_orig_item_advertising_2 AS ADV ON IPW.client_id = ADV.client_id AND IPW.wh_id = ADV.wh_id
   
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON IPW.calendar_dt = CAL.cal_dt
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis_2 AS I ON IPW.client_id = I.client_id AND IPW.item_id = I.item_sid AND ADV.client_id
     = I.client_id /* AND adv.dat_valid_from = i.dat_valid_from */ AND ADV.orig_item_nr = I.orig_item_nr
WHERE IPW.calendar_dt = ADV.dat_adv
 AND I.subitemgroup_id BETWEEN 100 AND 399;