--==============================================================
-- DBMS name:      Snowflake
-- Created on:     20.01.2022 15:53:08
--==============================================================


--==============================================================
-- View: V_LIL_MAIN_COMPETITOR
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for view: V_LIL_MAIN_COMPETITOR
*/ --------------------------------------------------------------------------------

CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_MAIN_COMPETITOR
(
   UKEY_ID
  ,RTL_ID
  ,CLIENT_ID
  ,USER_DESC
  ,VALID_FROM_TMSP
) AS
SELECT
   CAST(cd.key_field AS INTEGER) AS UKEY_ID
  ,MAX(CAST(CASE cd.SUB_CODE WHEN 'RTL_ID' THEN cd.val END AS INTEGER)) AS RTL_ID
  ,MAX(CAST(CASE cd.SUB_CODE WHEN 'CLIENT_ID' THEN cd.val END AS INTEGER)) AS CLIENT_ID
  ,MAX(CASE cd.SUB_CODE WHEN 'USER_DESC' THEN cd.val END) AS USER_DESC
  ,MAX(CAST(CASE cd.SUB_CODE WHEN 'VALID_FROM_TMSP' THEN cd.val END AS TIMESTAMP_LTZ(9))) AS VALID_FROM_TMSP
FROM P_LEW_PROCESS_MSTR_AC.V_LIL_CODE AS cd
WHERE cd.MAIN_CODE = 'MAIN_COMPETITOR'
  AND cd.SUB_CODE IN ('RTL_ID', 'CLIENT_ID', 'USER_DESC', 'VALID_FROM_TMSP', 'ACTIVE_FG')
GROUP BY UKEY_ID
HAVING MAX(CASE cd.SUB_CODE WHEN 'ACTIVE_FG' THEN cd.val END) = '1'
;
