/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_EINKAUFSPREIS_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  06.03.2023    Bialek, Aleksander           filtering for UWg extended to cover also newly added UWGs (between 200 and 399), ADO: 448371, it4you:PRJ0015189
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_psa_einkaufspreis_2 (client_id, dat_adv, orig_item_nr, wh_id, dat_valid_from,
buyprice) AS SELECT ADV.client_id,
 ADV.dat_adv,
 I.orig_item_nr,
 ADV.wh_id,
 ADV.dat_valid_from,
  bp.price_buying * cur.exchange_rate AS buyprice
FROM (SELECT SUP.client_id,
   VLMK.src_wh_id AS wh_id,
   SUP.item_sid,
   SUP.dat_valid_from,
   SUP.dat_valid_until,
   SUP.curr_sid,
   SUP.price_buying
  FROM ldl_p_lew_bil_ac.v_itm_sup_wh_buying_price_2 AS SUP
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS VLMK ON SUP.wh_loc_sid = VLMK.loc_sid) AS bp
 INNER JOIN ldl_p_lew_bil_ac.v_adv_orig_item_advertising_2 AS ADV ON bp.client_id = ADV.client_id AND bp.wh_id = ADV.wh_id
     AND ADV.dat_adv BETWEEN bp.dat_valid_from AND bp.dat_valid_until
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis_2 AS I ON bp.client_id = I.client_id AND bp.item_sid = I.item_sid AND ADV.client_id
     = I.client_id AND ADV.orig_item_nr = I.orig_item_nr
 INNER JOIN (SELECT client_id,
   curr_sid_from,
   active_from_dt,
   active_to_dt,
   MAX(CASE
     WHEN exchange_rate < 0
     THEN exchange_rate * - 1
     ELSE exchange_rate
     END) AS exchange_rate
  FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_2
  WHERE curr_cd_to = 'EUR'
   AND deleted_fg = 0
  GROUP BY client_id,
   curr_sid_from,
   active_from_dt,
   active_to_dt) AS cur ON bp.client_id = cur.client_id AND bp.curr_sid = cur.curr_sid_from AND ADV.dat_adv BETWEEN cur
   .active_from_dt AND cur.active_to_dt
WHERE I.subitemgroup_id BETWEEN 100 AND 399
GROUP BY ADV.client_id,
 ADV.dat_adv,
 I.orig_item_nr,
 ADV.wh_id,
 ADV.dat_valid_from,
 buyprice;