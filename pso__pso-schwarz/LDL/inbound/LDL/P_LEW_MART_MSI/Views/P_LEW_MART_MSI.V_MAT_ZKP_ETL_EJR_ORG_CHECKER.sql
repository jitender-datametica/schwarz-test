/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_mat_zkp_etl_ejr_org_checker
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  15.02.2018    Michael Ueding           Persistierte Objekte auf v_mat_ Views umgestellt damit keine Abhängigkeit entsteht
#  1.3  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#  1.4  24.08.2021    Wandtke,Andrzej          AP0091650_ZKP_BTEQ - Tech tests of BTEQ : use TO_VARCHAR(ls.dat_formdate_... ::DATE, 'YYYYMMDD') instead of Cast((ls.dat_formdate_from::DATE) AS CHAR(8)) and Cast((ls.dat_formdate_until::DATE) AS CHAR(8))
#  1.5  27.03.2024    Wandtke,Andrzej          AP0216988 - Replace v_mat0_zkp_etl_ejr_statisticlist by v_ejr_all_transact_follower: this should get the same information (active checkers)
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_ORG_CHECKER AS
SELECT
   ls.client_id
  ,ls.store_id
  ,ls.orig_store_nr
  ,tf.checker_id AS checker_id
  ,MAX(ls.void_fg) AS void_fg
  ,MAX(ls.deposit_fg) AS deposit_fg
  ,MAX(ls.return_fg) AS return_fg
  ,MAX(ls.aborted_suspended_fg) AS aborted_suspended_fg
  ,MAX(ls.discount_fg) AS discount_fg
  ,MAX(ls.other_fg) AS other_fg
  ,CAST(MAX(	
   TO_VARCHAR(ls.dat_formdate_from::DATE, 'YYYYMMDD')  || '<@>' || 'fromdate<@>' ||	
   TO_VARCHAR(ls.dat_formdate_until::DATE, 'YYYYMMDD') || '<@>' || 'untildate<@>' ||	
   TRIM(cy.country_id) || '<@>' || cy.country_desc || '<@>' || 'country<@>' ||	
   TRIM(ls.client_id) || '<@>' || c.client_desc || '<@>' || 'client<@>' ||	
   TRIM(ls.wh_id) || '<@>' || w.wh_desc || '<@>' || 'wh<@>' ||	
   -- The orig_store_nr is used twice  ,because the position of the subsequent fields must not be changed.	
   -- The store-desc can not be used anymore due to HTML-problems when displaying ""ß"".	
   TRIM(ls.store_id) || '<@>' || TRIM(ls.orig_store_nr) || '<@>' || TRIM(ls.orig_store_nr) || '<@>' || 'store<@>' ||	
   TRIM(tf.checker_id) || '<@>' || 'checker<@>'	) AS VARCHAR(1000)) AS link_param	
FROM (SELECT client_id, store_id, dat_formdate, checker_id, SUM(val_retail_ejr)
      FROM p_lew_mart_msi.v_ejr_all_transact_follower
      WHERE turnover_relevant_fg = 1
      GROUP BY client_id, store_id, dat_formdate, checker_id
     ) AS tf
INNER JOIN	
   (	
     SELECT
      revstr.client_id
	 ,revstr.wh_id
	 ,revstr.store_id
	 ,revstr.orig_store_nr
	 ,revstr.dat_formdate_from
	 ,revstr.dat_formdate_until
	 ,revlog.void_fg
	 ,revlog.deposit_fg
	 ,revlog.return_fg
	 ,revlog.aborted_suspended_fg
	 ,revlog.discount_fg
	 ,revlog.other_fg	
     FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr	
     INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_log revlog	
     ON revstr.client_id = revlog.client_id	
     AND revstr.wh_id = revlog.wh_id	
     AND (revstr.orig_store_nr = revlog.orig_store_nr OR (revlog.orig_store_nr IS NULL))	
     WHERE revlog.timestamp_delete IS NULL
   ) ls
ON tf.client_id = ls.client_id	
AND tf.store_id = ls.store_id	
AND tf.dat_formdate >= ls.dat_formdate_from	
AND tf.dat_formdate <= ls.dat_formdate_until	
INNER JOIN p_lew_mart_msi.v_ref_client c	
ON ls.client_id = c.client_id	
INNER JOIN p_lew_mart_msi.v_ref_country cy	
ON c.country_id = cy.country_id	
INNER JOIN p_lew_mart_msi.v_mat_org_wh w	
ON w.client_id = ls.client_id	
AND w.wh_id = ls.wh_id	
GROUP BY	
  ls.client_id	
 ,ls.store_id	
 ,ls.orig_store_nr	
 ,tf.checker_id	
;