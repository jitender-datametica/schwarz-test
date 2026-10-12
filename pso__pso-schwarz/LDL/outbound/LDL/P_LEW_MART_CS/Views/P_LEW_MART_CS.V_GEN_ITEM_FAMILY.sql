/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_gen_item_family
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.2  23.09.2021    Ross, Ulrich                 change where in eLWIS part and v_client_migration_per in WAWI part added
#  1.3  23.09.2021    Ross, Ulrich                 change table v_sap_migration_client to v_client_migration_per in WAWI part added
#  1.4  28.09.2021    Ross, Ulrich                 Change where clause item_fam_grp_descr_long to item_fam_grp_descr to fix missing valus for US
#  1.5  14.12.2021    Ao, Lin                      Change Regex used to calculate item_family_cd for US articles
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_item_family (
  client_id, 
  src_country_lidl_cd, 
  item_familygroup_id,
  language_id, 
  language_iso_cd, 
  dat_rec_start, 
  dat_rec_end, 
  subitemgroup_id, 
  itemfamily_cd, 
  desc_short, 
  desc_long,
  dwh_updated, 
  dwh_created, 
  dwh_load_id, 
  load_id, 
  src_id
) AS 
SELECT 
  dt_a.client_id,
  T.src_country_lidl_cd,
  dt_a.item_familygroup_id,
  dt_a.language_id,
  dt_a.language_iso_cd,
  dt_a.dat_rec_start,
  dt_a.dat_rec_end,
  dt_a.subitemgroup_id,
  dt_a.itemfamily_cd,
  dt_a.desc_short,
  dt_a.desc_long,
  dt_a.dwh_updated,
  dt_a.dwh_created,
  dt_a.dwh_load_id,
  dt_a.load_id,
  dt_a.src_id
FROM (
  SELECT 
    A.client_id,
    A.item_fam_grp_sid AS item_familygroup_id,
    COALESCE(C.language_id, -1) AS language_id,
    COALESCE(C.language_iso_cd, 'NA') AS language_iso_cd,
    B.dwh_valid_from AS dat_rec_start,
    DATE '9999-12-31' AS dat_rec_end,
    ROUND(CAST(B.sub_item_grp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
    ROUND(
      CAST(
        REGEXP_REPLACE(
          COLLATE(A.item_fam_grp_descr, ''), 
          r'(?i)^[0-9-]+\.([0-9-]+).*', 
          r'\1'
        ) AS BIGNUMERIC
      ), 0
    ) AS itemfamily_cd,
    A.item_fam_grp_descr AS desc_short,
    A.item_fam_grp_descr AS desc_long,
    A.dwh_updated,
    A.dwh_created,
    A.dwh_load_id,
    CAST(-1 AS BIGNUMERIC) AS load_id,
    2 AS src_id
  FROM ldl_p_lew_core_ac.v_item_familygroup_descr AS A
  INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS B 
    ON A.client_id = B.client_id 
    AND A.item_fam_grp_sid = B.item_fam_grp_sid
    AND CURRENT_DATE() BETWEEN B.dwh_valid_from AND B.dwh_valid_to
  INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras AS C 
    ON A.lang_cd = C.sap_lang_cd 
    AND (C.sap_lang_cd = '@' OR A.client_id = C.language_id)
  INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS CMP 
    ON A.client_id = CMP.client_id 
    AND CMP.active_fg = 1
  WHERE A.item_fam_grp_descr IS NOT NULL
  
  UNION DISTINCT
  
  SELECT 
    A.client_id,
    A.item_familygroup_id,
    COALESCE(A.language_id, -1) AS language_id,
    COALESCE(C.language_iso_cd, 'NA') AS language_iso_cd,
    A.dat_rec_start,
    A.dat_rec_end,
    A.subitemgroup_id,
    A.family_cd AS itemfamily_cd,
    A.item_family_short_desc AS desc_short,
    A.item_family_desc AS desc_long,
    CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_updated,
    CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_created,
    CAST(-1 AS BIGNUMERIC) AS dwh_load_id,
    A.load_id,
    1 AS src_id
  FROM ldl_p_lew_core_ac.v_wawi_itm_familygroup AS A
  INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras AS C 
    ON A.language_id = C.language_id 
    AND (C.sap_lang_cd = '@' OR A.client_id = C.language_id)
  WHERE A.dat_rec_end > DATE_ADD(CURRENT_DATE(), INTERVAL 1000 DAY)
    AND A.item_familygroup_id > 0
    AND NOT EXISTS (
      SELECT 1
      FROM ldl_p_lew_core_ac.v_item_familygroup_descr AS FAM
      INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS CMP 
        ON FAM.client_id = CMP.client_id 
        AND CMP.active_fg = 1
      WHERE FAM.item_fam_grp_descr IS NOT NULL
        AND FAM.client_id = A.client_id
        AND FAM.item_fam_grp_sid = A.item_familygroup_id
    )
) AS dt_a
INNER JOIN ldl_p_lew_core_ac.v_client AS C0 
  ON dt_a.client_id = C0.client_id
INNER JOIN ldl_p_lew_core_ac.v_country AS T 
  ON C0.country_sid = T.country_sid;
