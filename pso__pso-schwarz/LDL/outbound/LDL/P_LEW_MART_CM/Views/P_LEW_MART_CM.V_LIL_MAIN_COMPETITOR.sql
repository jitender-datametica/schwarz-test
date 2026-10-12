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


CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_main_competitor (ukey_id, rtl_id, client_id, user_desc, valid_from_tmsp)
AS SELECT ROUND(CAST(key_field AS BIGNUMERIC), 0) AS ukey_id,
 MAX(ROUND(CAST(CASE
     WHEN sub_code = 'RTL_ID'
     THEN val
     ELSE NULL
     END AS BIGNUMERIC), 0)) AS rtl_id,
 MAX(ROUND(CAST(CASE
     WHEN sub_code = 'CLIENT_ID'
     THEN val
     ELSE NULL
     END AS BIGNUMERIC), 0)) AS client_id,
 MAX(CASE
   WHEN sub_code = 'USER_DESC'
   THEN val
   ELSE NULL
   END) AS user_desc,
 MAX(CAST(CASE
    WHEN sub_code = 'VALID_FROM_TMSP'
    THEN val
    ELSE NULL
    END AS TIMESTAMP)) AS valid_from_tmsp
FROM ldl_p_lew_process_mstr_ac.v_lil_code AS CD
WHERE main_code = 'MAIN_COMPETITOR'
 AND sub_code IN ('RTL_ID', 'CLIENT_ID', 'USER_DESC', 'VALID_FROM_TMSP', 'ACTIVE_FG')
GROUP BY ukey_id
HAVING MAX(CASE
   WHEN sub_code = 'ACTIVE_FG'
   THEN val
   ELSE NULL
   END) = '1';