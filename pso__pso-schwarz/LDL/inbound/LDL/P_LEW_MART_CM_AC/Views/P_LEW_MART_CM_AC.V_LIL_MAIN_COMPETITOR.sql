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

CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_MAIN_COMPETITOR
(
   UKEY_ID
  ,RTL_ID
  ,CLIENT_ID
  ,USER_DESC
  ,VALID_FROM_TMSP
) AS
SELECT
   UKEY_ID
  ,RTL_ID
  ,CLIENT_ID
  ,USER_DESC
  ,VALID_FROM_TMSP
FROM P_LEW_MART_CM.V_LIL_MAIN_COMPETITOR
;
