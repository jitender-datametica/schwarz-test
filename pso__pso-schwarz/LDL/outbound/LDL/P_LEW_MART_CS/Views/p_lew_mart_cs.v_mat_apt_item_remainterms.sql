/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_item_remainterms
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_item_remainterms (client_id, country_iso_cd, item_nr_nat, valid_from
, case_size, dat_rec_start, dat_rec_end, remain_period_cd_wh, remain_term_value_wh, remain_period_cd_store,
remain_term_value_store, remain_period_cd_customer, remain_term_value_customer, dwh_updated, dwh_created, dwh_load_id,
load_id, src_id) AS -- renorm duration from day to specific unit
 -- renorm duration from day to specific unit

-- renorm duration from day to specific unit
 -- renorm duration from day to specific unit

-- renorm duration from day to specific unit
 -- renorm duration from day to specific unit

-- recover original fitting period_id
 -- recover original fitting period_id
 -- recover original fitting period_id

SELECT a.client_id,
 TRIM(a.country_iso_cd) AS country_iso_cd,
 a.orig_item_nr AS item_nr_nat,
 MIN(a.valid_from) AS valid_from,
 COALESCE(a.case_size, 1) AS case_size,
 MIN(a.valid_from) AS dat_rec_start,
 a.valid_until AS dat_rec_end,
 K.shelflife_short_desc AS remain_period_cd_wh,
  a.dur_shelflife_day_wh / CASE
   WHEN K.factor_period IS NULL OR K.factor_period < 1
   THEN 1
   ELSE K.factor_period
   END AS remain_term_value_wh,
 L.shelflife_short_desc AS remain_period_cd_store,
  a.dur_shelflife_day_store / CASE
   WHEN L.factor_period IS NULL OR L.factor_period < 1
   THEN 1
   ELSE L.factor_period
   END AS remain_term_value_store,
 M.shelflife_short_desc AS remain_period_cd_customer,
  a.dur_shelflife_day_cust / CASE
   WHEN M.factor_period IS NULL OR M.factor_period < 1
   THEN 1
   ELSE M.factor_period
   END AS remain_term_value_customer,
 a.dwh_updated,
 a.dwh_created,
 a.dwh_load_id,
 a.load_id,
 a.src_id
FROM (SELECT I.client_id,
   I.src_country_lidl_cd AS country_iso_cd,
   I.item_sid,
   I.orig_item_nr,
   I.case_size,
   I.valid_from,
   I.valid_until,
   SL.dur_shelflife_day_wh,
   SL.dur_shelflife_day_store,
   SL.dur_shelflife_day_cust,
    CASE
    WHEN SL.dur_shelflife_day_wh > - 1 AND SL.period_id_shelflife_wh = - 1
    THEN 1
    ELSE SL.period_id_shelflife_wh
    END AS period_id_shelflife_wh,
    CASE
    WHEN SL.dur_shelflife_day_store > - 1 AND SL.period_id_shelflife_store = - 1
    THEN 1
    ELSE SL.period_id_shelflife_store
    END AS period_id_shelflife_store,
    CASE
    WHEN SL.dur_shelflife_day_cust > - 1 AND SL.period_id_shelflife_cust = - 1
    THEN 1
    ELSE SL.period_id_shelflife_cust
    END AS period_id_shelflife_cust,
   I.dwh_updated,
   I.dwh_created,
   I.dwh_load_id,
   CAST(- 1 AS BIGNUMERIC) AS load_id,
   2 AS src_id
  FROM ldl_p_lew_mart_cs.v_gen_item_asis AS I
   INNER JOIN ldl_p_lew_bil_ac.v_item_shelflife AS SL ON I.client_id = SL.client_id AND I.item_sid = SL.item_sid
  WHERE I.itemstatus_cd > 3
   AND I.itemstatus_cd < 10
   AND I.buying_list_type_id > 0) AS a
 INNER JOIN ldl_p_lew_mart_cs.v_gen_apt_shelflive AS K ON a.period_id_shelflife_wh = K.shelflife_mis_id AND a.client_id
     = K.client_id AND a.valid_until BETWEEN K.dat_rec_start AND K.dat_rec_end AND K.language_id = 7
 INNER JOIN ldl_p_lew_mart_cs.v_gen_apt_shelflive AS L ON a.period_id_shelflife_store = L.shelflife_mis_id AND a.client_id
      = L.client_id AND a.valid_until BETWEEN L.dat_rec_start AND L.dat_rec_end AND L.language_id = 7
 INNER JOIN ldl_p_lew_mart_cs.v_gen_apt_shelflive AS M ON a.period_id_shelflife_cust = M.shelflife_mis_id AND a.client_id
      = M.client_id AND a.valid_until BETWEEN M.dat_rec_start AND M.dat_rec_end AND M.language_id = 7
WHERE CURRENT_DATE BETWEEN a.valid_from AND a.valid_until
 AND a.item_sid > 0
 AND a.dur_shelflife_day_wh IS NOT NULL
 AND a.dur_shelflife_day_store IS NOT NULL
 AND a.dur_shelflife_day_cust IS NOT NULL
 AND a.period_id_shelflife_wh IS NOT NULL
 AND a.period_id_shelflife_store IS NOT NULL
 AND a.period_id_shelflife_cust IS NOT NULL
GROUP BY a.client_id,
 country_iso_cd,
 item_nr_nat,
 case_size,
 dat_rec_end,
 remain_period_cd_wh,
 remain_term_value_wh,
 remain_period_cd_store,
 remain_term_value_store,
 remain_period_cd_customer,
 remain_term_value_customer,
 a.dwh_updated,
 a.dwh_created,
 a.dwh_load_id,
 a.load_id,
 a.src_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(a.client_id AS STRING), item_nr_nat, valid_from, CAST(case_size AS STRING)
      ORDER BY remain_term_value_wh IS NULL, remain_term_value_wh, remain_term_value_store IS NULL,
      remain_term_value_store, remain_term_value_customer IS NULL, remain_term_value_customer, remain_period_cd_wh
      IS NULL, remain_period_cd_wh)) = 1;