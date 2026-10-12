/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_APT_ITEM_DESC_2
#----------------------------------------------------------------------------
# History:
#  1.0  24.08.2020    Ulrich, Ross            First Version
#  1.1  04.11.2020    Ulrich, Ross            Add Qualify for process running on QUAL
#  1.2  11.01.2021    Ulrich, Ross            Add case for language_iso_cd
#  1.3  22.02.2021    Ulrich, Ross            Deliver only itemstatus_cd 4,5,6,7,8,9 and add filter for buying_list_type_id
#  1.4  22.02.2021    Ulrich, Ross            Add () language_iso_cd
#  1.5  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.6  17.03.2021    Guenes, Oguzhan              CloudMig FS - APT Nachfolgepatch 4 TD: Änderungen in SNFLK 
#                                                  https://jira.schwarz/browse/DDLE-1994
#  1.7  11.01.2021    Ulrich, Ross            Add case for language_iso_cd again
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_item_desc_2 (client_id, country_iso_cd, org_item_nr, valid_from,
case_size, language_iso_cd, item_descr, dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS
-- only language_id from county and international
 SELECT client_id,
 country_iso_cd,
 orig_item_nr AS org_item_nr,
 valid_from,
 COALESCE(case_size, 1) AS case_size,
  CASE
  WHEN language_id = 7
  THEN 'EU'
  ELSE language_iso_cd
  END AS language_iso_cd,
 item_descr,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 CAST(- 1 AS BIGNUMERIC) AS load_id,
 2 AS src_id
FROM ldl_p_lew_mart_cs.v_cs_item_descr_2
WHERE (client_id = language_id OR language_id = 7)
 AND (itemstatus_cd > 3 AND itemstatus_cd < 10)
 AND buying_list_type_id > 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), orig_item_nr, valid_from, CAST(COALESCE(case_size, 1) AS STRING)
      , CASE
       WHEN language_id = 7
       THEN 'EU'
       ELSE language_iso_cd
       END ORDER BY item_descr IS NULL DESC, item_descr DESC)) = 1 -- for running problems on QUAL
;