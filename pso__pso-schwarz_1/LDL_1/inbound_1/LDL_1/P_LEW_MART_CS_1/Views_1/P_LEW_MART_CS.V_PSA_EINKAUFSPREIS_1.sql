/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_EINKAUFSPREIS_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  06.03.2023    Bialek, Aleksander           filtering for UWg extended to cover also newly added UWGs (between 200 and 399), ADO: 448371, it4you:PRJ0015189
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_PSA_EINKAUFSPREIS_1
(
  client_id
, dat_adv
, orig_item_nr
, wh_id
, dat_valid_from
, buyprice
)
AS
   SELECT
     adv.client_id
   , adv.dat_adv
   , i.orig_item_nr
   , adv.wh_id
   , adv.dat_valid_from
   , bp.price_buying * cur.exchange_rate AS buyprice
   FROM (
	SELECT
     sup.client_id
   , vlmk.src_wh_id AS wh_id
   , sup.item_sid
   , sup.dat_valid_from
   , sup.dat_valid_until
   , sup.curr_sid
   , sup.price_buying
   FROM p_lew_bil_ac.v_itm_sup_wh_buying_price_1 sup
   INNER JOIN p_lew_core_ac.v_location_1 AS vlmk
   ON vlmk.loc_sid = sup.wh_loc_sid
   ) bp
   INNER JOIN p_lew_bil_ac.v_adv_orig_item_advertising_1 adv
   ON bp.client_id = adv.client_id
   AND bp.wh_id = adv.wh_id
   AND adv.dat_adv BETWEEN bp.dat_valid_from AND bp.dat_valid_until
   INNER JOIN p_lew_mart_cs.v_gen_item_asis_1 i
   ON bp.client_id = i.client_id
   AND bp.item_sid = i.item_sid
   AND adv.client_id = i.client_id
   AND adv.orig_item_nr = i.orig_item_nr
   INNER JOIN (SELECT
     client_id
   , curr_sid_from
   , active_from_dt
   , active_to_dt
   , MAX(CASE WHEN exchange_rate < 0
                      THEN exchange_rate * (-1)
                      ELSE exchange_rate
                    END) AS exchange_rate
   FROM p_lew_core_ac.v_exchange_rate_known_hist_1
              WHERE curr_cd_to = 'EUR'
              AND deleted_fg = 0
              GROUP BY 1,2,3,4
              ) cur
   ON bp.client_id = cur.client_id
   AND bp.curr_sid = cur.curr_sid_from
   AND adv.dat_adv BETWEEN cur.active_from_dt AND cur.active_to_dt

   WHERE i.subitemgroup_id BETWEEN 100 AND 399

   GROUP BY 1,2,3,4,5,6
;