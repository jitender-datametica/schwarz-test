/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_MWST_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  06.03.2023    Bialek, Aleksander           filtering for UWg extended to cover also newly added UWGs (between 200 and 399), ADO: 448371, it4you:PRJ0015189
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_PSA_MWST_1
(
  client_id
, dat_adv
, orig_item_nr
, wh_id
, dat_valid_from
, mwst
)
AS
   SELECT
     adv.client_id
   , adv.dat_adv
   , i.orig_item_nr
   , adv.wh_id
   , i.valid_from          AS dat_valid_from
   , vat.pct_vat           AS mwst
   FROM p_lew_mart_cs.v_gen_vat_hist_1 vat
   INNER JOIN p_lew_mart_cs.v_gen_item_asis_1 i
   ON vat.client_id = i.client_id
   AND vat.vat_id = i.vat_id
   INNER JOIN p_lew_bil_ac.v_adv_orig_item_advertising_1 adv
   ON i.client_id = adv.client_id
   /*AND i.dat_valid_from = adv.dat_valid_from*/
   AND i.orig_item_nr = adv.orig_item_nr
   AND adv.dat_adv BETWEEN vat.dat_rec_start AND vat.dat_rec_end

   WHERE i.subitemgroup_id BETWEEN 100 AND 399
   AND vat.vat_id >= 0
   AND vat.language_id = 7

   GROUP BY 1,2,3,4,5,6
;