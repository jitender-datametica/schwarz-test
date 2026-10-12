/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_ITEM_ITEM_1
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_SOURCE_ITEM_ITEM_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli  Initial version
#  1.1  2021-09-07 Mike Davis       Refinement
#  1.2  2021-09-17 Mike Davis       Formatting
#  1.3  2021-09-29 Dirk Hering      Use example role added, data types added, column order, formatting
#  1.4  2021-10-08 Dirk Hering      Added casts to INTEGER for orig_item_nr, case_size; try_to_number for case_size
#  1.5  2021-10-12 Dirk Hering      Deduplication from source (Qualify Row Number = 1); itmh.dwh_updated
#  1.6  2022-02-03 Mike Davis       Change orig_item_nr to NUMBER(38,0), case_size to NUMBER(38,5)
#  1.7  2022-03-17 Andreas Kurz		Changed ORIG_ITEM_NR (NAN)
#  1.8  2022-06-17 Andreas Kurz		Reowrked entire view
#  1.9  2022-06-21 Andreas Kurz		Added DAT_VALID_FROM_MIGRATED_FG, changed DAT_VALID_FROM in cas of Ex-Elvis Country_1
#										Added section / case of Ex-Elvis and WAWI items
#  2.2	2022-07-22 Nikolai Toknov  	Changing the script for DevOps
#  2.3	2023-04-26 Nikolai Toknov	Use ITEM_FAM_GRP_SID as AS-IS. WA. The target solution requires changes in architecture and joining at the T_A_*-level
#  2.4	2024-09-23 Nikolai Toknov	Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/



-- , ITEM_FAM_GRP_SID
 -- NToknov change 2.3 Use ITEM_FAM_GRP_SID as AS-IS (not as-was)

CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_item_item_1
OPTIONS(DESCRIPTION = `SOURCE VIEW FOR CORE ITEM_1 (ITEM_1 SID / ITEM_1 VARIANT)`) AS
-- , itms.ITEM_STATUS_CD::STRING																	AS ITEM_STATUS_CD
 -- , itms.ITEM_STATUS_FG::INTEGER AS ITEM_STATUS_FG

-- , itms.DAT_REC_START																			AS ITEM_STATUS_START_DT

-- , itms.DAT_REC_END																				AS ITEM_STATUS_END_DT
 -- business item_1 keys
 -- Note:

-- without this Coalesce there are many more Null (-1) orig_item_nr

-- at some stage we will have to check that the existing active items were properly converted to wawi at the wawi transition date

-- , try_to_number(COALESCE(itm.src_orig_item_nr, itm.config_item_cd, itm.src_matnr), 38, 0)    AS orig_item_nr
 -- 

-- @check there is no -1 in the data (not checked yet)
 -- Geburtsdatum

-- Indicator / Flag to show if Geburtsdatum is artifical
 -- item_1 information
 -- Wawi Countries with Wawi items

-- Ex-Elvis Countries with SAP items
 -- SAP Item_1
 -- Ex-Elvis Countries with WAWI items

-- additional item_1 hierarchy_1 CROSS JOIN fields
 -- technical versioning
 -- Geburtsdatum, if empty --> Migration Date

-- Exclude negative NANs and Item_1 Sids
 -- PIT Country_1

-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

-- Item_1 history information
 -- LIMIT 100
 -- PIT Country_1

-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
 SELECT CAST(itm.client_id AS BIGNUMERIC)
 AS client_id,
 cl.country_descr,
 cl.country_iso_cd,
 cl.ctr_ex_elvis_country_fg,
 CAST(itm.item_sid AS BIGNUMERIC) AS item_sid,
 itm.orig_item_nr,
 IF(itm.orig_item_nr < 0, itm.orig_item_nr * 100 - itm.client_id, itm.orig_item_nr * 100 + itm.client_id) AS
 orig_item_mstr_nr,
 itm.case_size,
 COALESCE(DATE(itm.src_dat_valid_from), DATE_ADD(cl.ctr_ex_elvis_country_migration_date_to, INTERVAL 1 DAY)) AS
 dat_valid_from,
 IF(DATE(itm.src_dat_valid_from) IS NULL, 1, 0) AS dat_valid_from_migrated_fg,
 CAST(COALESCE(itm.item_name, itmd_i.item_descr, itmd_l.item_descr, 'n/A') AS STRING) AS item_name,
 CAST(COALESCE(itmd_l.item_descr, itm.item_name, itmd_i.item_descr, 'n/A') AS STRING) AS item_descr,
 CAST(COALESCE(itmd_i.item_descr, itmd_l.item_descr, itm.item_name, 'n/A') AS STRING) AS item_int_descr,
 IF(TRUE AND cl.ctr_ex_elvis_country_fg = 0 AND LOWER(TRIM(itm.item_name)) LIKE 'mainitem%' OR TRUE AND cl.ctr_ex_elvis_country_fg
           = 1 AND (itm.log_var_cd = '1' OR itm.log_var_cd IS NULL) AND itm.src_matnr IS NOT NULL AND itm.src_matnr
       NOT LIKE '@%' AND itm.config_item_cd IS NULL OR TRUE AND cl.ctr_ex_elvis_country_fg = 1 AND LOWER(TRIM(itm.item_name
       )) LIKE 'mainitem%', 1, 0) AS main_item_fg,
 COALESCE(itmh.item_fam_grp_sid, - 1000) AS item_fam_grp_sid,
 COALESCE(itmh.brand_sid, - 1000) AS brand_sid,
 DATE(COALESCE(itmh.dwh_valid_from, DATE('1900-01-01'))) AS valid_from_dt,
 DATE(ldl_p_lew_mart_pit.f_cleanvalidtodate(itmh.dwh_valid_to)) AS valid_to_dt,
 CAST(itmh.deleted_fg AS BIGNUMERIC) AS deleted_fg,
 itmh.dwh_updated AS dwh_updated_ts
FROM (SELECT client_id,
   item_sid,
   src_orig_item_nr,
   config_item_cd,
   src_matnr,
   log_var_cd
   -- , COALESCE(TRY_TO_NUMBER(itm.SRC_ORIG_ITEM_NR), TRY_TO_NUMBER(itm.CONFIG_ITEM_CD), TRY_TO_NUMBER(REGEXP_REPLACE(itm.SRC_MATNR, '(_|[A-z])','') ),-1000)::NUMBER(38,0)

   ,
   COALESCE(ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(config_item_cd AS BIGNUMERIC), 0),
    ROUND(SAFE_CAST(src_matnr AS BIGNUMERIC), 0), - 1000) AS orig_item_nr,
   CAST(ROUND(SAFE_CAST(src_case_size AS BIGNUMERIC), 0) AS BIGNUMERIC) AS case_size,
   src_dat_valid_from,
   item_name
  FROM ldl_p_lew_core.t_item_1 AS ITM
  WHERE COALESCE(ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(config_item_cd AS BIGNUMERIC), 0)
     , ROUND(SAFE_CAST(src_matnr AS BIGNUMERIC), 0), - 1000) > 0
   AND item_sid > 0
   AND client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client_1
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC
      )) = 1) AS itm
 INNER JOIN (SELECT client_id,
   item_sid,
   LAST_VALUE(item_fam_grp_sid) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING) ORDER BY
      dwh_valid_to IS NULL, dwh_valid_to RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS item_fam_grp_sid
   ,
   brand_sid,
   dwh_valid_from,
   dwh_valid_to,
   dwh_updated,
   deleted_fg
  FROM ldl_p_lew_core.t_item_hist_1
  WHERE client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client_1
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), dwh_valid_from ORDER BY dwh_updated IS NULL DESC,
        dwh_updated DESC)) = 1) AS itmh ON itm.client_id = itmh.client_id AND itm.item_sid = itmh.item_sid
   /* -- Retrieving Item_1 Status_1 --> ACTIVE vs_1 INACTIVE
    -- on aggregation level country_1
    LEFT JOIN
	(
		SELECT 
			  CLIENT_ID
			, ITEM_SID
			, CASE_SIZE_DEC 																													AS CASE_SIZE
			, MIN(iff(ITEM_STATUS BETWEEN 6 AND 11,'ACTIVE', 'INACTTIVE')) 		OVER (PARTITION BY CLIENT_ID, ITEM_SID ORDER BY NULL)	 		AS ITEM_STATUS_CD
			, MIN(iff(ITEM_STATUS BETWEEN 6 AND 11,0::INTEGER , 1::INTEGER )) 	OVER (PARTITION BY CLIENT_ID, ITEM_SID ORDER BY NULL) 			AS ITEM_STATUS_FG		
			, MIN(DAT_REC_START) OVER (PARTITION BY CLIENT_ID, ITEM_SID ORDER BY NULL) 															AS DAT_REC_START
			, MAX(DAT_REC_END)   OVER (PARTITION BY CLIENT_ID, ITEM_SID ORDER BY NULL) 															AS DAT_REC_END		
		--SELECT *
		FROM LDL.P_LEW_CORE.T_WAWI_ITM_ITEM_WH_1 
		WHERE TRUE 	
			AND DIR_DELETE_FG 		= 0
			--AND ITEM_SID IN ( 33819, 1514139, 1591828 )
			--AND ITEM_SID IN (920025)
			AND MIN_ORDERUNIT 		IS NOT NULL
			AND CASE_SIZE_DEC 		IS NOT NULL
		QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, ITEM_SID ORDER BY TIMESTAMP_STATUS_UPDATED DESC) = 1 
		
	) itms
	ON TRUE
		AND itms.CLIENT_ID 	= itm.CLIENT_ID
		AND itms.ITEM_SID	= itm.ITEM_SID
		AND itms.CASE_SIZE	= itm.CASE_SIZE 
		--AND itms.DAT_REC_START	BETWEEN itmh.DWH_VALID_TO AND itmh.DWH_VALID_FROM
		--AND itms.DAT_REC_END		BETWEEN itmh.DWH_VALID_TO AND itmh.DWH_VALID_FROM */
   -- Country_1 Information

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
  FROM ldl_p_lew_mart_pit.t_dim_client_1
  WHERE pit_country_fg = 1
   AND deleted_fg = 0
   AND reject_fg = 0
   AND current_fg = 1) AS cl ON itm.client_id = cl.client_id AND itmh.client_id = cl.client_id
   -- Get local item_1 describtion

 LEFT JOIN (SELECT client_id,
   lang_sid,
   item_sid,
   item_descr
  FROM ldl_p_lew_core.t_item_descr_1
  WHERE TRIM(lang_cd) <> '@' /* country_sid = 7 */
    -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY dwh_updated
        IS NULL DESC, dwh_updated DESC)) = 1) AS itmd_l ON itm.client_id = itmd_l.client_id AND itm.item_sid = itmd_l.item_sid
      AND cl.lang_sid = itmd_l.lang_sid AND cl.client_id = itmd_l.client_id -- Get International item_1 describtion

 LEFT JOIN (SELECT client_id,
   lang_sid,
   item_sid,
   item_descr
  FROM ldl_p_lew_core.t_item_descr_1
  WHERE TRIM(lang_cd) = '@' /* country_sid = 7 */
    -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)

  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING), CAST(lang_sid AS STRING) ORDER BY dwh_updated
        IS NULL DESC, dwh_updated DESC)) = 1) AS itmd_i ON itm.client_id = itmd_i.client_id AND itm.item_sid = itmd_i.item_sid
      AND cl.lang_sid = itmd_i.lang_sid AND cl.client_id = itmd_i.client_id;
