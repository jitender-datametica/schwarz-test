/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------

# $LastChangedBy: gueneso
# $LastChangedDate: 2021-03-17 
# 
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  20.08.2020    Ulrich, Ross            First Version
#  1.1  22.02.2021    Ulrich, Ross            Deliver only itemstatus_cd 4,5,6,7,8,9 and add filter for buying_list_type_id
#  1.2  05.03.2021    Ulrich, Ross            Change source from v_gen_item_hist to v_gen_item_asis (missing values)
#----------------------------------------------------------------------------
#  1.3  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.4  17.03.2021    Guenes, Oguzhan              CloudMig FS - APT Nachfolgepatch 4 TD: Änderungen in SNFLK 
#                                                  https://jira.schwarz/browse/DDLE-1994
#  1.5  07.04.2021    Guenes, Oguzhan              Fix for employee_name filter
#                                                  https://jira.schwarz/browse/DDLE-2047
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_buying_emp (client_id, country_iso_cd, buying_employee_skey,
buying_employee_name, dwh_updated, dwh_created, dwh_load_id, load_id, src_id)
OPTIONS(DESCRIPTION = `$Revision: 16786 $ GENERALIESIERTE VIEW; INPUT FÜR CS VIEWS; BEREICH ARTIKEL GESELLSCHFTS ZUORDNUNG`)
AS SELECT client_id,
 src_country_lidl_cd AS country_iso_cd,
 buyer_id AS buying_employee_skey,
 buying_employee_name,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id
FROM (SELECT DISTINCT client_id,
   src_country_lidl_cd,
    CASE
    WHEN CAST(buying_employee_name AS BIGNUMERIC) IS NOT NULL AND ROUND(CAST(buying_employee_name AS BIGNUMERIC)
        , 0) >= 0 AND buying_employee_name BETWEEN '0' AND '999999'
    THEN ROUND(CAST(buying_employee_name AS BIGNUMERIC), 0)
    ELSE buying_employee_skey
    END AS buyer_id,
   buying_employee_name,
   dwh_updated,
   dwh_created,
   dwh_load_id,
   - 1 AS load_id,
   0 AS src_id,
   valid_from
  FROM ldl_p_lew_mart_cs.v_gen_item_asis AS A
  WHERE item_sid > 0
   AND (itemstatus_cd > 3 AND itemstatus_cd < 10)
   AND buying_list_type_id > 0
   AND case_size_lago > 0
   AND buying_employee_name IS NOT NULL
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(buyer_id AS STRING) ORDER BY dwh_load_id
        IS NULL, dwh_load_id, valid_from IS NULL, valid_from)) = 1) AS t2;
