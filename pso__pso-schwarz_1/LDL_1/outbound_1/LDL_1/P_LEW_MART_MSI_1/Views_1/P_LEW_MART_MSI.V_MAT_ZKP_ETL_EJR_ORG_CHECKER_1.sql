/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_mat_zkp_etl_ejr_org_checker_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  15.02.2018    Michael Ueding           Persistierte Objekte auf v_mat_ Views umgestellt damit keine Abhängigkeit entsteht
#  1.3  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#  1.4  24.08.2021    Wandtke,Andrzej          AP0091650_ZKP_BTEQ - Tech tests of BTEQ : use TO_VARCHAR(ls.dat_formdate_... ::DATE, 'YYYYMMDD') instead of Cast((ls.dat_formdate_from::DATE) AS CHAR(8)) and Cast((ls.dat_formdate_until::DATE) AS CHAR(8))
#  1.5  27.03.2024    Wandtke,Andrzej          AP0216988 - Replace v_mat0_zkp_etl_ejr_statisticlist_1 by v_ejr_all_transact_follower_1: this should get the same information (active checkers)
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_org_checker_1 AS
-- The orig_store_nr is used twice  ,because the position of the subsequent fields must not be changed.

-- The store-desc can not be used anymore due to HTML-problems when displaying ""ß"".
 SELECT ls.client_id,
 ls.store_id,
 ls.orig_store_nr,
 tf.checker_id,
 MAX(ls.void_fg) AS void_fg,
 MAX(ls.deposit_fg) AS deposit_fg,
 MAX(ls.return_fg) AS return_fg,
 MAX(ls.aborted_suspended_fg) AS aborted_suspended_fg,
 MAX(ls.discount_fg) AS discount_fg,
 MAX(ls.other_fg) AS other_fg,
 MAX(FORMAT_DATE('%Y%m%d', DATE(ls.dat_formdate_from)) || '<@>' || 'fromdate<@>' || FORMAT_DATE('%Y%m%d', DATE(ls.dat_formdate_until
                                )) || '<@>' || 'untildate<@>' || TRIM(SUBSTR(CAST(CY.country_id AS STRING), 1, 39)) ||
                          '<@>' || CY.country_desc || '<@>' || 'country_1<@>' || TRIM(SUBSTR(CAST(ls.client_id AS STRING)
                        , 1, 10)) || '<@>' || C.client_desc || '<@>' || 'client<@>' || TRIM(SUBSTR(CAST(ls.wh_id AS STRING)
                   , 1, 10)) || '<@>' || W.wh_desc || '<@>' || 'wh<@>' || TRIM(SUBSTR(CAST(ls.store_id AS STRING), 1, 10
              )) || '<@>' || TRIM(SUBSTR(CAST(ls.orig_store_nr AS STRING), 1, 10)) || '<@>' || TRIM(SUBSTR(CAST(ls.orig_store_nr AS STRING)
          , 1, 10)) || '<@>' || 'store<@>' || TRIM(SUBSTR(CAST(tf.checker_id AS STRING), 1, 10)) || '<@>' ||
   'checker<@>') AS link_param
FROM (SELECT client_id,
   store_id,
   dat_formdate,
   checker_id,
   SUM(val_retail_ejr)
  FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1
  WHERE turnover_relevant_fg = 1
  GROUP BY client_id,
   store_id,
   dat_formdate,
   checker_id) AS tf
 INNER JOIN (SELECT REVSTR.client_id,
   REVSTR.wh_id,
   REVSTR.store_id,
   REVSTR.orig_store_nr,
   REVSTR.dat_formdate_from,
   REVSTR.dat_formdate_until,
   REVLOG.void_fg,
   REVLOG.deposit_fg,
   REVLOG.return_fg,
   REVLOG.aborted_suspended_fg,
   REVLOG.discount_fg,
   REVLOG.other_fg
  FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR
   INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_log_1 AS REVLOG ON REVSTR.client_id = REVLOG.client_id AND
      REVSTR.wh_id = REVLOG.wh_id AND (REVLOG.orig_store_nr IS NULL OR REVSTR.orig_store_nr = REVLOG.orig_store_nr)
  WHERE REVLOG.timestamp_delete IS NULL) AS ls ON tf.client_id = ls.client_id AND tf.store_id = ls.store_id AND tf.dat_formdate
     >= ls.dat_formdate_from AND tf.dat_formdate <= ls.dat_formdate_until
 INNER JOIN ldl_p_lew_mart_msi.v_ref_client_1 AS C ON ls.client_id = C.client_id
 INNER JOIN ldl_p_lew_mart_msi.v_ref_country_1 AS CY ON C.country_id = CY.country_id
 INNER JOIN ldl_p_lew_mart_msi.v_mat_org_wh_1 AS W ON ls.client_id = W.client_id AND ls.wh_id = W.wh_id
GROUP BY ls.client_id,
 ls.store_id,
 ls.orig_store_nr,
 tf.checker_id;