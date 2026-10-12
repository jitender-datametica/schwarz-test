/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_item_remainterms_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_item_remainterms_1
(
  client_id
, country_iso_cd
, item_nr_nat
, valid_from
, case_size
, dat_rec_start
, dat_rec_end
, remain_period_cd_wh
, remain_term_value_wh
, remain_period_cd_store
, remain_term_value_store
, remain_period_cd_customer
, remain_term_value_customer
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
, src_id
)
AS
   SELECT
   erg.client_id,
   erg.country_iso_cd,
   erg.item_nr_nat,
   erg.valid_from,
   erg.case_size,
   erg.dat_rec_start,
   erg.dat_rec_end,
   erg.remain_period_cd_wh,
   erg.remain_term_value_wh,
   erg.remain_period_cd_store,
   erg.remain_term_value_store,
   erg.remain_period_cd_customer,
   erg.remain_term_value_customer,
   erg.dwh_updated,
   erg.dwh_created,
   erg.dwh_load_id,
   erg.load_id,
   erg.src_id
   FROM
   (SELECT
   f.client_id,
   TRIM(f.country_iso_cd)    AS country_iso_cd,
   f.item_no_nat             AS item_nr_nat,
   MIN(f.valid_from_item)    AS valid_from,
   coalesce(f.case_size, 1)  AS case_size,
   MIN(f.dat_rec_start)      AS dat_rec_start,
   f.dat_rec_end,
   f.remain_period_cd_wh,
   f.remain_term_value_wh,
   f.remain_period_cd_store,
   f.remain_term_value_store,
   f.remain_period_cd_customer,
   f.remain_term_value_customer,
   f.dwh_updated,
   f.dwh_created,
   f.dwh_load_id,
   f.load_id,
   f.src_id
   FROM
   (SELECT
   n.client_id,
   n.item_id,
   n.country_iso_cd,
   n.item_no_nat,
   n.valid_from_item,
   n.case_size,
   n.dat_rec_start,
   n.dat_rec_end,
   n.remain_period_cd_wh,
   n.remain_term_value_wh  --renorm duration from day to specific unit_1
   ,
   n.remain_period_cd_store,
   n.remain_term_value_store  --renorm duration from day to specific unit_1
   ,
   n.remain_period_cd_customer,
   n.remain_term_value_customer --renorm duration from day to specific unit_1
   ,
   n.dwh_updated,
   n.dwh_created,
   n.dwh_load_id,
   n.load_id,
   n.src_id
   FROM
   (SELECT
   a.client_id,
   a.item_sid                AS item_id,
   a.country_iso_cd          AS country_iso_cd,
   a.orig_item_nr            AS item_no_nat,
   a.valid_from              AS valid_from_item,
   a.case_size,
   a.valid_from              AS dat_rec_start,
   a.valid_until             AS dat_rec_end,
   k.shelflife_short_desc    AS remain_period_cd_wh,
   a.dur_shelflife_day_wh/(
                CASE
                    WHEN k.factor_period IS NULL OR k.factor_period<1
                    THEN 1
                    ELSE k.factor_period
                    END) AS remain_term_value_wh  --renorm duration from day to specific unit_1
   ,
   l.shelflife_short_desc AS remain_period_cd_store,
   a.dur_shelflife_day_store/(
                CASE
                    WHEN l.factor_period IS NULL OR l.factor_period<1
                    THEN 1
                    ELSE l.factor_period
                    END) AS remain_term_value_store  --renorm duration from day to specific unit_1
   ,
   m.shelflife_short_desc AS remain_period_cd_customer,
   a.dur_shelflife_day_cust/(
                CASE
                    WHEN m.factor_period IS NULL OR m.factor_period<1
                    THEN 1
                    ELSE m.factor_period
                END) AS remain_term_value_customer --renorm duration from day to specific unit_1
   ,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id,
   a.load_id,
   a.src_id
   FROM (SELECT
   i.client_id,
   i.src_country_lidl_cd AS country_iso_cd,
   i.item_sid,
   i.orig_item_nr,
   i.case_size,
   i.valid_from,
   i.valid_until,
   sl.dur_shelflife_day_wh,
   sl.dur_shelflife_day_store,
   sl.dur_shelflife_day_cust,
   CASE
                        WHEN sl.dur_shelflife_day_wh >-1 AND sl.period_id_shelflife_wh = -1
                        THEN 1
                        ELSE period_id_shelflife_wh
                        END period_id_shelflife_wh --recover original fitting period_id
   ,
   CASE
                        WHEN sl.dur_shelflife_day_store >-1 AND sl.period_id_shelflife_store = -1
                        THEN 1
                        ELSE sl.period_id_shelflife_store
                        END period_id_shelflife_store --recover original fitting period_id
   ,
   CASE
                        WHEN sl.dur_shelflife_day_cust >-1 AND sl.period_id_shelflife_cust = -1
                        THEN 1
                        ELSE sl.period_id_shelflife_cust
                        END period_id_shelflife_cust --recover original fitting period_id
   ,
   i.dwh_updated                 AS dwh_updated,
   i.dwh_created                 AS dwh_created,
   i.dwh_load_id                 AS dwh_load_id,
   CAST(-1 AS INTEGER)           AS load_id,
   2                             AS src_id
   FROM p_lew_mart_cs.v_gen_item_asis_1 i
   INNER JOIN p_lew_bil_ac.v_item_shelflife_1 sl
   ON i.client_id = sl.client_id
   AND i.item_sid = sl.item_sid
   WHERE i.itemstatus_cd > 3
    AND i.itemstatus_cd < 10
    AND i.buying_list_type_id IS NOT NULL
    AND i.buying_list_type_id > 0
) a
   INNER JOIN p_lew_mart_cs.v_gen_apt_shelflive_1 k
   ON   k.shelflife_mis_id = a.period_id_shelflife_wh
   AND k.client_id = a.client_id
   AND a.valid_until BETWEEN k.dat_rec_start AND k.dat_rec_end
   AND k.language_id = 7
   INNER JOIN p_lew_mart_cs.v_gen_apt_shelflive_1 l
   ON   l.shelflife_mis_id = a.period_id_shelflife_store
   AND l.client_id = a.client_id
   AND a.valid_until BETWEEN l.dat_rec_start AND l.dat_rec_end
   AND l.language_id = 7
   INNER JOIN p_lew_mart_cs.v_gen_apt_shelflive_1 m
   ON   m.shelflife_mis_id = a.period_id_shelflife_cust
   AND m.client_id = a.client_id
   AND a.valid_until BETWEEN m.dat_rec_start AND m.dat_rec_end
   AND m.language_id = 7
   WHERE  CURRENT_DATE BETWEEN a.valid_from AND a.valid_until
       AND  a.item_sid > 0
       AND  a.dur_shelflife_day_wh IS NOT NULL
       AND  a.dur_shelflife_day_store IS NOT NULL
       AND  a.dur_shelflife_day_cust IS NOT NULL
       AND  a.period_id_shelflife_wh IS NOT NULL
       AND  a.period_id_shelflife_store IS NOT NULL
       AND  a.period_id_shelflife_cust IS NOT NULL
) n
) f
GROUP BY 1,2,3,5,7,8,9,10,11,12,13,14,15,16,17,18
) erg
   QUALIFY ROW_NUMBER () OVER (PARTITION BY erg.client_id, erg.item_nr_nat, erg.valid_from, erg.case_size ORDER BY erg.remain_term_value_wh DESC NULLS LAST, erg.remain_term_value_store DESC NULLS LAST, erg.remain_term_value_customer DESC NULLS LAST, erg.remain_period_cd_wh DESC NULLS LAST) = 1
   ;


