/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_NAN_2
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_SOURCE_NAN_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Andreas Kurz     Initial Version
#  1.1	2022-07-11 Prasanna Ranjan	Added SUB_ITEM_GRP_SID & ITEM_GRP_INT_SID
#  1.2  2022-06-21 Andreas Kurz		Added DAT_VALID_FROM_MIGRATED_FG, changed DAT_VALID_FROM in cas of Ex-Elvis Country_2
#										Added section / case of Ex-Elvis and WAWI items
#  1.3	2023-07-07 Andreas Kurz		Added Brand_name and Brand_type CD (Marke / Eigenmarke)
#  1.4  2023-07-28 Nikolai Toknov	resolving the conflict between main branch and release branch
#  1.5	2024-09-23 Nikolai Toknov	Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/
/*
USE ROLE            R_LDL_D_PIT_ETL;
USE WAREHOUSE       WH_LDL_D_PIT_ETL_S;
USE DATABASE        LDL_PRODUCTION_CLONE_PIT_QS;
USE SCHEMA          P_LEW_MART_PIT_2;

---------------------------------------------------------------------
0.  CREATE VIEW in V_SOURCE_NAN_2
	Used for sourcing the Lookup Table DIM_NAN
	DROP VIEW LDL.P_LEW_MART_PIT.V_SOURCE_NAN_2 
------------------------------------------------------------------------
*/




-- item_2 information
 -- Geburtsdatum
 -- Give Exelvis countries SAP item_2 periority over identical Wawi items

-- QUALIFY _SOURCE = _MIN_SOURCE
 CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_nan_2
OPTIONS(DESCRIPTION = `SOURCE VIEW FOR ORIG ITEM_2 NR (NAN)`) AS
-- , MAX (fin._SOURCE) OVER (PARTITION BY fin.ORIG_ITEM_MSTR_NR ORDER BY NULL)									AS _MAX_SOURCE

-- , itm.ITEM_SID::INTEGER                                                             AS ITEM_SID
 -- Geburtsdatum

-- item_2 information
 -- ALWAYS 1
 -- additional item_2 hierarchy_2 CROSS JOIN fields
 -- AS-WAS assignment

-- AS-IS assignment
 -- technical versioning
 -- orig_item_nr / NAN only information
 -- item_2 Union all

-- Orig Item_nr from ex Elvis countries
 -- ----------------------------------------

-- PIT Country_2 Ex Elvis Countries SAP Items
 -- ----------------------------------------

-- Default Value -1000 per client
 -- Geburtsdatum, if empty --> Migration Date
 -- Added new Indicator

-- item_2 information
 -- ----------------------------------------
 -- PIT Country_2 Ex Elvis Countries SAP Items

-- ----------------------------------------
 -- SAP Item_2

-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

-- ----------------------------------------
 -- PIT Country_2 Ex Elvis Countries WAWI Items

-- ----------------------------------------
 -- Geburtsdatum, if empty --> Migration Date
 -- Added new Indicator

-- item_2 information
 -- retrieve ITEM_NAME for latest item_sid of orig_item_nr
 -- Default Value -1000 per client

-- Geburtsdatum, if empty --> Migration Date
 -- Added new Indicator
 -- ----------------------------------------

-- PIT Country_2 Ex Elvis Countries SAP Items
 -- ----------------------------------------

-- AND itm.ORIG_ITEM_NR 	IN (204749,359716,367808)
 -- AND itm.CLIENT_ID		= 1

-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

-- ----------------------------------------
 -- Orig Item_nr from PIT Country_2 WAWI countries WAWI Items

-- ----------------------------------------
 -- Geburtsdatum, if empty --> Migration Date

-- retrieve ITEM_NAME for latest item_sid of orig_item_nr
 -- Default Value -1000 per client

-- Geburtsdatum, if empty --> Migration Date
 -- Added new Indicator
 -- PIT Country_2 Wawi Countries

-- Item_2 history information
 -- LIMIT 100
 -- PIT Country_2
 -- technical versioning
 -- PIT Country_2

-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

-- PIT Country_2
 SELECT client_id,
 country_descr,
 country_iso_cd,
 ctr_ex_elvis_country_fg,
 orig_item_nr,
 orig_item_mstr_nr,
 case_size,
 dat_valid_from,
 item_name,
 item_descr,
 item_int_descr,
 main_item_fg -- ALWAYS 1
 -- additional item_2 hierarchy_2 CROSS JOIN fields
 -- AS-WAS assignment
,
 item_fam_grp_sid_src,
 sub_item_grp_sid_src,
 item_grp_int_sid_src -- AS-IS assignment
,
 item_fam_grp_sid,
 sub_item_grp_sid,
 item_grp_int_sid,
 brand_sid -- AKU 2023-07-07
,
 brand_name,
 brand_type_cd,
 scd_key_md -- technical versioning
,
 valid_from_dt,
 valid_to_dt,
 deleted_fg,
 dwh_updated_ts,
 `_source`,
 MIN(`_source`) OVER (PARTITION BY CAST(orig_item_mstr_nr AS STRING) ORDER BY NULL IS NULL, NULL RANGE BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS `_min_source`
FROM (SELECT CAST(itm.client_id AS BIGNUMERIC) AS client_id,
   cl.country_descr,
   cl.country_iso_cd,
   cl.ctr_ex_elvis_country_fg,
   itm.orig_item_nr,
   itm.orig_item_mstr_nr,
   itm.case_size,
   DATE(itm.dat_valid_from) AS dat_valid_from,
   itm.item_name,
   itm.item_descr,
   itm.item_int_descr,
   itm.main_item_fg,
   COALESCE(t57.item_fam_grp_sid, - 1000) AS item_fam_grp_sid_src,
   COALESCE(ifg_hist.sub_item_grp_sid, - 1000) AS sub_item_grp_sid_src,
   COALESCE(isg_hist.item_grp_int_sid, - 1000) AS item_grp_int_sid_src,
   LAST_VALUE(t57.item_fam_grp_sid) OVER (PARTITION BY CAST(itm.orig_item_mstr_nr AS STRING), CAST(itm.orig_item_nr AS STRING)
      , itm.dat_valid_from ORDER BY t57.dwh_valid_to IS NULL, t57.dwh_valid_to RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS item_fam_grp_sid,
   LAST_VALUE(ifg_hist.sub_item_grp_sid) OVER (PARTITION BY CAST(itm.orig_item_mstr_nr AS STRING), CAST(itm.orig_item_nr AS STRING)
      , itm.dat_valid_from ORDER BY ifg_hist.dwh_valid_to IS NULL, ifg_hist.dwh_valid_to RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sub_item_grp_sid,
   LAST_VALUE(isg_hist.item_grp_int_sid) OVER (PARTITION BY CAST(itm.orig_item_mstr_nr AS STRING), CAST(itm.orig_item_nr AS STRING)
      , itm.dat_valid_from ORDER BY isg_hist.dwh_valid_to IS NULL, isg_hist.dwh_valid_to RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS item_grp_int_sid,
   COALESCE(t57.brand_sid, - 1000) AS brand_sid,
   br.brand_name,
   w_itm.brand_type_cd,
   TO_HEX(MD5(itm.item_name || itm.item_descr || itm.item_int_descr || COALESCE(CAST(LAST_VALUE(t57.item_fam_grp_sid) OVER (PARTITION BY CAST(itm.orig_item_mstr_nr AS STRING)
, CAST(itm.orig_item_nr AS STRING), itm.dat_valid_from ORDER BY t57.dwh_valid_to IS NULL, 
t57.dwh_valid_to RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING), '') || COALESCE(CAST(LAST_VALUE(ifg_hist.sub_item_grp_sid) OVER (PARTITION BY CAST(itm.orig_item_mstr_nr AS STRING)
               , CAST(itm.orig_item_nr AS STRING), itm.dat_valid_from ORDER BY ifg_hist.dwh_valid_to IS NULL, ifg_hist.dwh_valid_to
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING), '') || COALESCE(CAST(LAST_VALUE(isg_hist.item_grp_int_sid) OVER (PARTITION BY CAST(itm.orig_item_mstr_nr AS STRING)
              , CAST(itm.orig_item_nr AS STRING), itm.dat_valid_from ORDER BY isg_hist.dwh_valid_to IS NULL, isg_hist.dwh_valid_to
              RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING), '') || COALESCE(CAST(t57.brand_sid AS STRING)
         , '') || COALESCE(CAST(br.brand_name AS STRING), '') || COALESCE(CAST(w_itm.brand_type_cd AS STRING), ''))) AS
   scd_key_md,
   DATE(COALESCE(t57.dwh_valid_from, DATE('1900-01-01'))) AS valid_from_dt,
   DATE(ldl_p_lew_mart_pit.f_cleanvalidtodate(t57.dwh_valid_to)) AS valid_to_dt,
   CAST(t57.deleted_fg AS BIGNUMERIC) AS deleted_fg,
   t57.dwh_updated AS dwh_updated_ts,
   itm.`_source`
  FROM (SELECT ITM.client_id,
      ITM.item_sid,
      ITM.src_orig_item_nr,
      ITM.config_item_cd,
      ITM.src_matnr -- , REGEXP_REPLACE(itm.SRC_MATNR, '(_|[A-z])','') 											AS _SRC_MATNR
,
      ITM.src_matnr AS `_src_matnr`,
      ITM.log_var_cd,
      ITM.config_item_cd AS config_item_cd0,
      1 AS main_item_fg,
      COALESCE(ROUND(SAFE_CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.src_matnr AS BIGNUMERIC), 0), - 1000) AS orig_item_nr,
      CAST(ROUND(SAFE_CAST(ITM.src_case_size AS BIGNUMERIC), 0) AS BIGNUMERIC) AS case_size,
      COALESCE(ITM.src_dat_valid_from, DATE_ADD(cl.ctr_ex_elvis_country_migration_date_to, INTERVAL 1 DAY)) AS
      dat_valid_from,
      IF(DATE(ITM.src_dat_valid_from) IS NULL, 1, 0) AS dat_valid_from_migrated_fg,
      CAST(COALESCE(ITM.item_name, itmd_i.item_descr, itmd_l.item_descr, 'n/A') AS STRING) AS item_name,
      CAST(COALESCE(itmd_l.item_descr, ITM.item_name, itmd_i.item_descr, 'n/A') AS STRING) AS item_descr,
      CAST(COALESCE(itmd_i.item_descr, itmd_l.item_descr, ITM.item_name, 'n/A') AS STRING) AS item_int_descr,
      IF(SAFE_CAST(COALESCE(ROUND(SAFE_CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.config_item_cd
            AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.src_matnr AS BIGNUMERIC), 0), - 1000) as BIGNUMERIC) < 0, SAFE_CAST(COALESCE(ROUND(SAFE_CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC), 0), 
            ROUND(SAFE_CAST(ITM
             .src_matnr AS BIGNUMERIC), 0), - 1000) as BIGNUMERIC) * 100 - ITM.client_id, SAFE_CAST(COALESCE(ROUND(SAFE_CAST(ITM
             .src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM
             .src_matnr AS BIGNUMERIC), 0), - 1000) as BIGNUMERIC) * 100 + ITM.client_id) AS orig_item_mstr_nr,
      ITM.dwh_updated,
      1 AS `_source`
     FROM ldl_p_lew_core.t_item_2 AS ITM
      INNER JOIN (SELECT DISTINCT client_id,
        country_orig_descr,
        country_int_descr,
        country_nat_descr,
        country_descr,
        country_iso_cd,
        lang_sid,
        curr_sid,
        curr_cd,
        exchange_rate_to_eur,
        valid_from_dt,
        ctr_ex_elvis_country_fg,
        ctr_ex_elvis_country_migration_date_from,
        ctr_ex_elvis_country_migration_date_to,
        ctr_adv_week_start_weekday_id
       FROM ldl_p_lew_mart_pit.t_dim_client_2
       WHERE pit_country_fg = 1
        AND ctr_ex_elvis_country_fg = 1
        AND deleted_fg = 0
        AND reject_fg = 0
        AND current_fg = 1) AS cl ON ITM.client_id = cl.client_id -- Get local item_2 describtion

      LEFT JOIN (SELECT client_id,
        lang_sid,
        item_sid,
        item_descr
       FROM ldl_p_lew_core.t_item_descr_2
       WHERE TRIM(lang_cd) <> '@' /* country_sid = 7 */
         -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY dwh_updated
             IS NULL DESC, dwh_updated DESC)) = 1) AS itmd_l ON ITM.client_id = itmd_l.client_id AND ITM.item_sid =
          itmd_l.item_sid AND cl.lang_sid = itmd_l.lang_sid AND cl.client_id = itmd_l.client_id
        -- Get International item_2 describtion

      LEFT JOIN (SELECT client_id,
        lang_sid,
        item_sid,
        item_descr
       FROM ldl_p_lew_core.t_item_descr_2
       WHERE TRIM(lang_cd) = '@' /* country_sid = 7 */
         -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY dwh_updated
             IS NULL DESC, dwh_updated DESC)) = 1) AS itmd_i ON ITM.client_id = itmd_i.client_id AND ITM.item_sid =
          itmd_i.item_sid AND cl.lang_sid = itmd_i.lang_sid AND cl.client_id = itmd_i.client_id
     WHERE COALESCE(ROUND(SAFE_CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.config_item_cd AS
          BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.src_matnr AS BIGNUMERIC), 0), - 1000) > 0
      AND ITM.client_id = cl.client_id
      AND (ITM.log_var_cd IS NULL OR ITM.log_var_cd = '1')
      AND ITM.config_item_cd IS NULL
      AND ITM.src_matnr NOT LIKE '@%'
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ITM.client_id AS STRING), CAST(COALESCE(ROUND(ROUND(SAFE_CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0), 0), ROUND(ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC), 0), 0), ROUND(ROUND(SAFE_CAST(ITM.src_matnr AS BIGNUMERIC), 0), 0), - 1000) AS STRING
            ), COALESCE(ITM.src_dat_valid_from, DATE_ADD(cl.ctr_ex_elvis_country_migration_date_to, INTERVAL 1 DAY))
         ORDER BY ITM.dwh_updated IS NULL DESC, ITM.dwh_updated DESC)) = 1
     UNION ALL
     SELECT t18.client_id,
      t18.item_sid,
      t18.src_orig_item_nr,
      t18.config_item_cd,
      t18.src_matnr -- , REGEXP_REPLACE(itm.SRC_MATNR, '(_|[A-z])','') 											AS _SRC_MATNR
,
      t18.src_matnr AS `_src_matnr`,
      t18.log_var_cd,
      t18.config_item_cd AS config_item_cd0,
      1 AS main_item_fg,
      t18.orig_item_nr,
      t18.case_size,
      t18.dat_valid_from,
      t18.dat_valid_from_migrated_fg,
      CAST(COALESCE(t18.item_name, itmd_i.item_descr, itmd_l.item_descr, 'n/A') AS STRING) AS item_name,
      CAST(COALESCE(itmd_l.item_descr, t18.item_name, itmd_i.item_descr, 'n/A') AS STRING) AS item_descr,
      CAST(COALESCE(itmd_i.item_descr, itmd_l.item_descr, t18.item_name, 'n/A') AS STRING) AS item_int_descr,
      IF(t18.orig_item_nr < 0, t18.orig_item_nr * 100 - t18.client_id, t18.orig_item_nr * 100 + t18.client_id) AS
      orig_item_mstr_nr,
      t18.dwh_updated,
      2 AS `_source`
     FROM (SELECT client_id,
        item_sid,
        src_orig_item_nr,
        config_item_cd,
        src_matnr,
        REGEXP_REPLACE(src_matnr, '(_|[A-z])', '') AS `_src_matnr`,
        log_var_cd,
        IF(LOWER(TRIM(item_name)) LIKE 'mainitem%', 1, 0) AS main_item_fg,
        COALESCE(ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(config_item_cd AS BIGNUMERIC), 0)
         , ROUND(SAFE_CAST(REGEXP_REPLACE(src_matnr, '(_|[A-z])', '') AS BIGNUMERIC), 0), - 1000) AS orig_item_nr,
        CAST(ROUND(SAFE_CAST(src_case_size AS BIGNUMERIC), 0) AS BIGNUMERIC) AS case_size,
        COALESCE(src_dat_valid_from, DATE('8888-12-31')) AS dat_valid_from,
        IF(DATE(src_dat_valid_from) IS NULL, 1, 0) AS dat_valid_from_migrated_fg,
        item_name,
        dwh_updated
       FROM ldl_p_lew_core.t_item_2 AS ITM
       WHERE COALESCE(ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(config_item_cd AS BIGNUMERIC
            ), 0), ROUND(SAFE_CAST(REGEXP_REPLACE(src_matnr, '(_|[A-z])', '') AS BIGNUMERIC), 0), - 1000) > 0
        AND client_id IN (SELECT client_id
          FROM ldl_p_lew_mart_pit.t_dim_client_2
          WHERE pit_country_fg = 1
           AND ctr_ex_elvis_country_fg = 1
           AND deleted_fg = 0
           AND reject_fg = 0
           AND current_fg = 1
          GROUP BY client_id)
        AND IF(LOWER(TRIM(item_name)) LIKE 'mainitem%', 1, 0) = 0 -- Take first ITEM_SID and the lastest record

       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(COALESCE(ROUND(ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0), 0), ROUND(ROUND(SAFE_CAST(config_item_cd AS BIGNUMERIC), 0), 0), ROUND(ROUND(SAFE_CAST(REGEXP_REPLACE(src_matnr, '(_|[A-z])', '') AS BIGNUMERIC), 0), 0
                ), - 1000) AS STRING), COALESCE(src_dat_valid_from, DATE('8888-12-31')) ORDER BY item_sid IS NULL,
             item_sid, dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS t18
      INNER JOIN (SELECT DISTINCT client_id,
        country_orig_descr,
        country_int_descr,
        country_nat_descr,
        country_descr,
        country_iso_cd,
        lang_sid,
        curr_sid,
        curr_cd,
        exchange_rate_to_eur,
        valid_from_dt,
        ctr_ex_elvis_country_fg,
        ctr_ex_elvis_country_migration_date_from,
        ctr_ex_elvis_country_migration_date_to,
        ctr_adv_week_start_weekday_id
       FROM ldl_p_lew_mart_pit.t_dim_client_2
       WHERE pit_country_fg = 1
        AND ctr_ex_elvis_country_fg = 1
        AND deleted_fg = 0
        AND reject_fg = 0
        AND current_fg = 1) AS cl ON t18.client_id = cl.client_id -- Get local item_2 describtion

      LEFT JOIN (SELECT client_id,
        lang_sid,
        item_sid,
        item_descr
       FROM ldl_p_lew_core.t_item_descr_2
       WHERE TRIM(lang_cd) <> '@' /* country_sid = 7 */
         -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY dwh_updated
             IS NULL DESC, dwh_updated DESC)) = 1) AS itmd_l ON t18.client_id = itmd_l.client_id AND t18.item_sid =
          itmd_l.item_sid AND cl.lang_sid = itmd_l.lang_sid AND cl.client_id = itmd_l.client_id
        -- Get International item_2 describtion

      LEFT JOIN (SELECT client_id,
        lang_sid,
        item_sid,
        item_descr
       FROM ldl_p_lew_core.t_item_descr_2
       WHERE TRIM(lang_cd) = '@' /* country_sid = 7 */
         -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY dwh_updated
             IS NULL DESC, dwh_updated DESC)) = 1) AS itmd_i ON t18.client_id = itmd_i.client_id AND t18.item_sid =
          itmd_i.item_sid AND cl.lang_sid = itmd_i.lang_sid AND cl.client_id = itmd_i.client_id
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(t18.client_id AS STRING), CAST(t18.orig_item_nr AS STRING), t18.dat_valid_from
           ORDER BY t18.dwh_updated IS NULL DESC, t18.dwh_updated DESC)) = 1
     UNION ALL
     SELECT t37.client_id,
      t37.item_sid,
      t37.src_orig_item_nr,
      t37.config_item_cd,
      t37.src_matnr,
      t37.`_src_matnr`,
      t37.log_var_cd,
      t37.config_item_cd AS config_item_cd0,
      1 AS main_item_fg,
      t37.orig_item_nr,
      CAST(NULL AS BIGNUMERIC) AS case_size,
      t37.dat_valid_from,
      t37.dat_valid_from_migrated_fg,
      CAST(COALESCE(t37.item_name, itmd_i.item_descr, itmd_l.item_descr, 'n/A') AS STRING) AS item_name,
      CAST(COALESCE(itmd_l.item_descr, t37.item_name, itmd_i.item_descr, 'n/A') AS STRING) AS item_descr,
      CAST(COALESCE(itmd_i.item_descr, itmd_l.item_descr, t37.item_name, 'n/A') AS STRING) AS item_int_descr,
      IF(t37.orig_item_nr < 0, t37.orig_item_nr * 100 - t37.client_id, t37.orig_item_nr * 100 + t37.client_id) AS
      orig_item_mstr_nr,
      t37.dwh_updated,
      0 AS `_source`
     FROM (SELECT client_id,
        item_sid,
        src_orig_item_nr,
        config_item_cd,
        src_matnr,
        REGEXP_REPLACE(src_matnr, '(_|[A-z])', '') AS `_src_matnr`,
        log_var_cd,
        IF(LOWER(TRIM(item_name)) LIKE 'mainitem%', 1, 0) AS main_item_fg,
        COALESCE(ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(config_item_cd AS BIGNUMERIC), 0)
         , ROUND(SAFE_CAST(REGEXP_REPLACE(src_matnr, '(_|[A-z])', '') AS BIGNUMERIC), 0), - 1000) AS orig_item_nr,
        CAST(ROUND(SAFE_CAST(src_case_size AS BIGNUMERIC), 0) AS BIGNUMERIC) AS case_size,
        COALESCE(src_dat_valid_from, DATE('8888-12-31')) AS dat_valid_from,
        IF(DATE(src_dat_valid_from) IS NULL, 1, 0) AS dat_valid_from_migrated_fg,
        item_name,
        dwh_updated
       FROM ldl_p_lew_core.t_item_2 AS ITM
       WHERE COALESCE(ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(config_item_cd AS BIGNUMERIC
            ), 0), ROUND(SAFE_CAST(REGEXP_REPLACE(src_matnr, '(_|[A-z])', '') AS BIGNUMERIC), 0), - 1000) > 0
        AND client_id IN (SELECT client_id
          FROM ldl_p_lew_mart_pit.t_dim_client_2
          WHERE pit_country_fg = 1
           AND ctr_ex_elvis_country_fg = 0
           AND deleted_fg = 0
           AND reject_fg = 0
           AND current_fg = 1
          GROUP BY client_id)
        AND IF(LOWER(TRIM(item_name)) LIKE 'mainitem%', 1, 0) = 0 -- Take first ITEM_SID and the lastest record

       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(COALESCE(ROUND(ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0), 0), ROUND(ROUND(SAFE_CAST(config_item_cd AS BIGNUMERIC), 0), 0), ROUND(ROUND(SAFE_CAST(REGEXP_REPLACE(src_matnr, '(_|[A-z])', '') AS BIGNUMERIC), 0), 0
                ), - 1000) AS STRING), COALESCE(src_dat_valid_from, DATE('8888-12-31')) ORDER BY item_sid IS NULL,
             item_sid, dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS t37
      INNER JOIN (SELECT DISTINCT client_id,
        country_orig_descr,
        country_int_descr,
        country_nat_descr,
        country_descr,
        country_iso_cd,
        lang_sid,
        curr_sid,
        curr_cd,
        exchange_rate_to_eur,
        valid_from_dt,
        ctr_ex_elvis_country_fg,
        ctr_ex_elvis_country_migration_date_from,
        ctr_ex_elvis_country_migration_date_to,
        ctr_adv_week_start_weekday_id
       FROM ldl_p_lew_mart_pit.t_dim_client_2
       WHERE pit_country_fg = 1
        AND ctr_ex_elvis_country_fg = 0
        AND deleted_fg = 0
        AND reject_fg = 0
        AND current_fg = 1) AS cl ON t37.client_id = cl.client_id -- Get local item_2 describtion

      LEFT JOIN (SELECT client_id,
        lang_sid,
        item_sid,
        item_descr
       FROM ldl_p_lew_core.t_item_descr_2
       WHERE TRIM(lang_cd) <> '@' /* country_sid = 7 */
         -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY dwh_updated
             IS NULL DESC, dwh_updated DESC)) = 1) AS itmd_l ON t37.client_id = itmd_l.client_id AND t37.item_sid =
          itmd_l.item_sid AND cl.lang_sid = itmd_l.lang_sid AND cl.client_id = itmd_l.client_id
        -- Get International item_2 describtion

      LEFT JOIN (SELECT client_id,
        lang_sid,
        item_sid,
        item_descr
       FROM ldl_p_lew_core.t_item_descr_2
       WHERE TRIM(lang_cd) = '@' /* country_sid = 7 */
         -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY dwh_updated
             IS NULL DESC, dwh_updated DESC)) = 1) AS itmd_i ON t37.client_id = itmd_i.client_id AND t37.item_sid =
          itmd_i.item_sid AND cl.lang_sid = itmd_i.lang_sid AND cl.client_id = itmd_i.client_id
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(t37.client_id AS STRING), CAST(t37.orig_item_nr AS STRING), t37.dat_valid_from
           ORDER BY t37.dwh_updated IS NULL DESC, t37.dwh_updated DESC)) = 1) AS itm
   INNER JOIN (SELECT client_id,
     item_sid,
     item_fam_grp_sid,
     brand_sid,
     dwh_valid_from,
     dwh_valid_to,
     dwh_updated,
     deleted_fg
    FROM ldl_p_lew_core.t_item_hist_2
    WHERE client_id IN (SELECT client_id
       FROM ldl_p_lew_mart_pit.t_dim_client_2
       WHERE pit_country_fg = 1
        AND deleted_fg = 0
        AND reject_fg = 0
        AND current_fg = 1
       GROUP BY client_id)
     AND item_fam_grp_sid > 0
      -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), dwh_valid_from ORDER BY dwh_updated IS NULL DESC
          , dwh_updated DESC)) = 1) AS t57 ON itm.client_id = t57.client_id AND itm.item_sid = t57.item_sid
     -- WAWI Item_2 -- to retrieve Buyinglist_type

   LEFT JOIN (SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
     CAST(item_sid AS BIGNUMERIC) AS item_sid,
     DATE(COALESCE(DATE(dat_valid_from), DATE('8888-12-31'))) AS dat_valid_from,
     CAST(buying_list_type_id AS BIGNUMERIC) AS `_buying_list_type_id`,
     ldl_p_lew_mart_pit.f_getbrandtypecd(CAST(buying_list_type_id AS INT64)) AS brand_type_cd,
     CAST(COALESCE(buying_list_type_desc, 'N/A') AS STRING) AS buying_list_type_descr,
     DATE(COALESCE(dat_rec_start, DATE('1900-01-01'))) AS valid_from_dt,
     DATE(ldl_p_lew_mart_pit.f_cleanvalidtodate(dat_rec_end)) AS valid_to_dt
    FROM ldl_p_lew_core.t_wawi_itm_item_2
    WHERE client_id IN (SELECT client_id
       FROM ldl_p_lew_mart_pit.t_dim_client_2
       WHERE pit_country_fg = 1
        AND deleted_fg = 0
        AND reject_fg = 0
        AND current_fg = 1
       GROUP BY client_id)
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(CAST(client_id AS BIGNUMERIC) AS STRING), CAST(CAST(item_sid AS BIGNUMERIC)
           AS STRING), dat_rec_start ORDER BY DATE(COALESCE(DATE(dat_valid_from), DATE('8888-12-31'))) IS NULL DESC,
          DATE(COALESCE(DATE(dat_valid_from), DATE('8888-12-31'))) DESC)) = 1) AS w_itm ON t57.client_id = w_itm.client_id
      AND t57.item_sid -- Brand_2 Info
 = w_itm.item_sid
   LEFT JOIN (SELECT client_id,
     brand_sid,
     src_brand_cd,
     brand_name,
     brand_type_cd
    FROM ldl_p_lew_core.t_brand_2
    WHERE client_id IN (SELECT client_id
       FROM ldl_p_lew_mart_pit.t_dim_client_2
       WHERE pit_country_fg = 1
        AND deleted_fg = 0
        AND reject_fg = 0
        AND current_fg = 1
       GROUP BY client_id)) AS br ON t57.client_id = br.client_id AND t57.brand_sid = br.brand_sid
     -- Sub item_2 grp information

   LEFT JOIN (SELECT DISTINCT client_id,
     sub_item_grp_sid,
     item_fam_grp_sid,
     dwh_valid_from,
     dwh_valid_to
    FROM ldl_p_lew_core.t_item_familygroup_hist_2
    WHERE sub_item_grp_sid > 0
     AND item_fam_grp_sid > 0
      -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_fam_grp_sid AS STRING), dwh_valid_from
          ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS ifg_hist ON t57.client_id = ifg_hist.client_id
     AND t57.item_fam_grp_sid = ifg_hist.item_fam_grp_sid AND t57.dwh_valid_from BETWEEN ifg_hist.dwh_valid_from AND
     ifg_hist.dwh_valid_to -- Item_2 grp INTEGER information

   LEFT JOIN (SELECT DISTINCT client_id,
     sub_item_grp_sid,
     item_grp_int_sid,
     dwh_valid_from,
     dwh_valid_to
    FROM ldl_p_lew_core.t_subitemgroup_hist_2
    WHERE sub_item_grp_sid > 0
     AND item_grp_int_sid > 0
      -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(sub_item_grp_sid AS STRING), dwh_valid_from
          ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS isg_hist ON ifg_hist.client_id = isg_hist.client_id
       AND ifg_hist.sub_item_grp_sid = isg_hist.sub_item_grp_sid AND ifg_hist.dwh_valid_from BETWEEN isg_hist.dwh_valid_from
     AND isg_hist.dwh_valid_to -- Country_2 Information

   INNER JOIN (SELECT DISTINCT client_id,
     country_orig_descr,
     country_int_descr,
     country_nat_descr,
     country_descr,
     country_iso_cd,
     lang_sid,
     curr_sid,
     curr_cd,
     exchange_rate_to_eur,
     valid_from_dt,
     ctr_ex_elvis_country_fg,
     ctr_ex_elvis_country_migration_date_from,
     ctr_ex_elvis_country_migration_date_to,
     ctr_adv_week_start_weekday_id
    FROM ldl_p_lew_mart_pit.t_dim_client_2
    WHERE pit_country_fg = 1
     AND deleted_fg = 0
     AND reject_fg = 0
     AND current_fg = 1) AS cl ON itm.client_id = cl.client_id
  WHERE itm.main_item_fg = 1 -- AND itm.ORIG_ITEM_NR 	= 204088
 -- AND itm.CLIENT_ID 		= 1

  GROUP BY client_id,
   cl.country_descr,
   cl.country_iso_cd,
   cl.ctr_ex_elvis_country_fg,
   itm.orig_item_nr,
   itm.orig_item_mstr_nr,
   itm.case_size,
   itm.dat_valid_from,
   itm.item_name,
   itm.item_descr,
   itm.item_int_descr,
   itm.main_item_fg,
   item_fam_grp_sid_src,
   sub_item_grp_sid_src,
   item_grp_int_sid_src,
   t57.item_fam_grp_sid,
   t57.dwh_valid_to,
   isg_hist.dwh_valid_to,
   ifg_hist.dwh_valid_to,
  ifg_hist.sub_item_grp_sid,
  isg_hist.item_grp_int_sid,
   t57.brand_sid,
   br.brand_name,
   w_itm.brand_type_cd,
  --  scd_key_md,
   valid_from_dt,
   valid_to_dt,
   deleted_fg,
   dwh_updated_ts,
   itm.`_source`) AS t85
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(orig_item_nr AS STRING), dat_valid_from,
      valid_from_dt, CAST(deleted_fg AS STRING) ORDER BY NULL IS NULL, NULL)) = 1;





--SELECT * FROM LDL.P_LEW_MART_PIT.V_SOURCE_NAN_2 WHERE TRUE AND CLIENT_ID = 1 AND ORIG_ITEM_NR 	IN (204749,359716,367808)
--SELECT * FROM LDL.P_LEW_MART_PIT.V_SOURCE_NAN_2 WHERE TRUE AND CLIENT_ID = 1 AND ORIG_ITEM_NR 	= 204749
--SELECT * FROM LDL.P_LEW_MART_PIT.V_SOURCE_NAN_2 WHERE TRUE AND CLIENT_ID = 10 AND ORIG_ITEM_NR =5716037
--SELECT * FROM LDL.P_LEW_MART_PIT.V_SOURCE_NAN_2 WHERE TRUE AND CLIENT_ID = 1 AND ORIG_ITEM_NR = 204406 AND DAT_VALID_FROM = '2019-10-25'::DATE LIMIT 100
--SELECT * FROM LDL.P_LEW_MART_PIT.V_SOURCE_NAN_2 WHERE ORIG_ITEM_NR IN (214309) AND CLIENT_ID = 1
--SELECT * FROM LDL.P_LEW_MART_PIT.V_SOURCE_NAN_2 WHERE ORIG_ITEM_NR IN (1254) AND DAT_VALID_FROM = '2008-11-20'::DATE AND CLIENT_ID = 1 LIMIT 100
--SELECT * FROM LDL.P_LEW_MART_PIT.V_SOURCE_NAN_2 WHERE TRUE AND CLIENT_ID = 1 AND ORIG_ITEM_NR = -1000 AND DAT_VALID_FROM = '2019-10-25'::DATE;