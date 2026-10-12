/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_BUYING_EMP_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item_buying_emp_1 (client_id, country_iso_cd, buying_employee_skey,
buying_employee_name, orig_item_nr, case_size, last_refresh) AS SELECT client_id,
 src_country_lidl_cd AS country_iso_cd,
 buying_employee_skey,
  CASE
  WHEN MAX(buying_employee_name) = '-1'
  THEN NULL
  ELSE MAX(buying_employee_name)
  END AS buying_employee_name,
 orig_item_nr,
 case_size,
 CURRENT_TIMESTAMP() AS last_refresh
FROM ldl_p_lew_mart_cs.v_gen_item_asis_1 AS I
WHERE orig_item_nr > 0
GROUP BY client_id,
 country_iso_cd,
 buying_employee_skey,
 orig_item_nr,
 case_size;