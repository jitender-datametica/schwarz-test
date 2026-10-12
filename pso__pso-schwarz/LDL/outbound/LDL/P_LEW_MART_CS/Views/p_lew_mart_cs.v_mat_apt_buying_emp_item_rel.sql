/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_buying_emp_item_rel
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2020    Ulrich, Ross            First Version
#  1.1  22.02.2021    Ulrich, Ross            Deliver only itemstatus_cd 4,5,6,7,8,9 and add filter for buying_list_type_id
#  1.2  05.03.2021    Ulrich, Ross            Add view v_lew_mart_cs.v_gen_item_asis as leading view
#  1.3  15.03.2021    Guenes, Oguzhan              Transfer to Snowflake.
#                                                  https://jirasis.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.4  17.03.2021    Guenes, Oguzhan              CloudMig FS - APT Nachfolgepatch 4 TD: Änderungen in SNFLK 
#                                                  https://jirasis.schwarz/browse/DDLE-1994
#  1.5  07.04.2021    Guenes, Oguzhan              Fix for employee_name filter
#                                                  https://jira.schwarz/browse/DDLE-2047
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_buying_emp_item_rel (client_id, country_iso_cd, org_item_nr,
valid_from, valid_to, case_size, dat_rec_start, dat_rec_end, buying_employee_skey, dwh_updated, dwh_created, dwh_load_id
, load_id, src_id)
OPTIONS(DESCRIPTION = `$Revision: 16786 $ GENERALIESIERTE VIEW; INPUT FÜR CS VIEWS; BEREICH ARTIKEL GESELLSCHFTS ZUORDNUNG;`)
AS SELECT client_id,
 src_country_lidl_cd AS country_iso_cd,
 orig_item_nr AS org_item_nr,
 valid_from,
 valid_until AS valid_to,
 COALESCE(case_size, 1) AS case_size,
 valid_from AS dat_rec_start,
 valid_until AS dat_rec_end,
  CASE
  WHEN SAFE_CAST(buying_employee_name AS BIGNUMERIC) IS NOT NULL AND ROUND(CAST(buying_employee_name AS BIGNUMERIC)
      , 0) >= 0 AND buying_employee_name BETWEEN '0' AND '99999'
  THEN ROUND(CAST(buying_employee_name AS BIGNUMERIC), 0)
  ELSE buying_employee_skey
  END AS buying_employee_skey,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 - 1 AS load_id,
 0 AS src_id
FROM ldl_p_lew_mart_cs.v_gen_item_asis AS ASIS
WHERE CURRENT_DATE BETWEEN valid_from AND valid_until
 AND (itemstatus_cd > 3 AND itemstatus_cd < 10)
 AND buying_list_type_id > 0
 AND case_size_lago > 0
GROUP BY client_id,
 country_iso_cd,
 org_item_nr,
 valid_from,
 valid_to,
 ASIS.case_size,
 buying_employee_name,
 ASIS.buying_employee_skey,
 dwh_updated,
 dwh_created,
 dwh_load_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), org_item_nr, valid_from, CAST(case_size AS STRING),
      buying_employee_name, CAST(buying_employee_skey AS STRING) ORDER BY dwh_load_id IS NULL, dwh_load_id)) = 1;
