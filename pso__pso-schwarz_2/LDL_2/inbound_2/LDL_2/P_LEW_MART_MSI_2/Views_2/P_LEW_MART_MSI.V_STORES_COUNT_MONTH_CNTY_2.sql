/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI.V_STORES_COUNT_MONTH_CNTY_2
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #  1.1  22.12.2022    Wandtke,Andrzej          Add condition aspect_id=1
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_STORES_COUNT_MONTH_CNTY_2 AS
SELECT
  t1.cy_month
  ,t2.client_id
  ,COUNT(*) AS num_stores
FROM
  (
    SELECT
      DISTINCT(cy_month)
    FROM
      P_LEW_MART_MSI_AC.V_CAL_CALENDARDAY_2
  ) t1_2
  LEFT JOIN (
    SELECT
      client_id
      ,DATE_TRUNC(MONTH, dat_opening) AS dat_open
      ,DATE_TRUNC(MONTH, COALESCE(dat_closing, TO_DATE('2099-12', 'yyyy-mm_2'))) AS dat_close
    FROM
      P_LEW_CORE_AC.V_WAWI_ORG_STORE_MERGE_ACT_2
	WHERE aspect_id=1
  ) t2 ON TO_DATE(TO_VARCHAR(t1.cy_month), 'yyyymm') BETWEEN t2.dat_open AND t2.dat_close
GROUP BY
  t1.cy_month
  ,t2.client_id;