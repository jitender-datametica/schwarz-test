/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for v_source_sfo
#-------------------------------------------------------------------------------
# Describtion: Create View for v_source_sfo
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli	   	Initial version
#  1.1  2021-09-16 Aparna Rayanki	   	relavant source columns and filters are added
#  1.2  2021-09-29 Dirk Hering         	Use example role added, data types added, column order, formatting
#  1.3  2021-10-08 Dirk Hering         	New target names: sub_item_grp_src_cd
#  1.4	2022-01-19 Andreas Kurz			Reviewed and some corrections
#  2.0	2022-07-16 Nikolai Toknov  		Changing the script for DevOps
#  2.1  2022-07-18 Andreas Kurz			Reworked structure
#  2.2	2024-01-05 Andreas Kurz			Added some comments
#  2.3	2024-03-13 Andreas Kurz			Added structure based on WAWI Expert Input 
#											removed CROSS JOIN to VAT Code
#  2.4  2024-03-14 Andreas Kurz			Removed column PV_UWG_GROUP_FG because always 0 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT;
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_sfo
OPTIONS(DESCRIPTION = `SOURCE VIEW FOR SFO (PV) AND STOREFORM - KLEINBELEGE`) AS -- Version technical fields

-- AKU 2024-03-13 Conditions to identify WAWI PV Grund
 -- Abverkaufsbasierte PV aus LP/PD (NPPS)
 -- Bestands PV

-- Preisgebietsdifferenz (3)
 -- Open Question if ASP or ASP440
 -- Open Question if DAY or DAY850

-- Condition to detect WAWI PV-Grund - Note: needs to be verified by WAWI Expert
 -- 'Preisgebietsdifferenz'

-- 'Bestands PV'
 -- 'Abverkaufsbasierte PV aus LP/PD (NPPS)'
 -- , DAYEND_DT
 -- DESC TABLE P_LEW_CORE.T_STORE_FORM

-- SELECT *
 /* TESTING */ -- AND CLIENT_ID = 4
 -- AND DWH_CAL_DT = '2024-01-19'::DATE
 -- AND ITEM_SID = 5663088

-- AND LOC_SID_STORE = 17277
 /* TESTING */ -- AKU 2024-01-16 reduce nbr of touched rows
 -- 131	Rücksendung Filiale

-- 141	Korr. Rücksendung Filiale
 -- clustered by client_id and dwh_cal_dt
 -- PIT Country
 -- PIT Country
 SELECT CAST(client_id AS BIGNUMERIC)
 AS client_id,
 CAST(item_sid AS BIGNUMERIC) AS item_sid,
 CAST(loc_sid_store AS BIGNUMERIC) AS store_sid,
 DATE(dwh_cal_dt) AS day_dt,
 CAST(subitemgrp_cd AS STRING) AS sub_item_grp_src_cd,
 CAST(vat_id AS BIGNUMERIC) AS vat_id,
 CAST(wh_gross_price AS BIGNUMERIC) AS sfo_sales_price_old_gross,
 CAST(wh_net_price AS BIGNUMERIC) AS sfo_sales_price_old_net,
 CAST(new_gross_price AS BIGNUMERIC) AS sfo_sales_price_new_gross,
 CAST(new_net_price AS BIGNUMERIC) AS sfo_sales_price_new_net,
 CAST(org_gross_price AS BIGNUMERIC) AS sfo_org_gross_price,
 CAST(org_net_price AS BIGNUMERIC) AS sfo_org_net_price,
 CAST(store_gross_price AS BIGNUMERIC) AS sfo_store_gross_price,
 CAST(store_net_price AS BIGNUMERIC) AS sfo_store_net_price,
  store_gross_price * - 1.0 AS sfo_item_discount_gross_val,
  store_net_price * - 1.0 AS sfo_item_discount_net_val,
 CAST(total_qty AS BIGNUMERIC) AS total_qty,
 CAST(warehouse_sid AS BIGNUMERIC) AS warehouse_sid,
 CAST(act_price_grp_id AS BIGNUMERIC) AS act_price_grp_id,
 DATE('1900-01-01') AS valid_from_dt,
 DATE('9999-12-31') AS valid_to_dt,
 0 AS deleted_fg,
 dwh_created AS dwh_created_ts,
 dwh_updated AS dwh_updated_ts,
 CAST(moduser AS STRING) AS moduser,
 CAST(IF(moduser LIKE 'ASP%', 1, 0) AS BIGNUMERIC) AS asp_user_fg,
 CAST(IF(moduser LIKE 'DAY%', 1, 0) AS BIGNUMERIC) AS day_user_fg,
 CAST(IF(COALESCE(new_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC) AS new_gross_price_fg,
 CAST(IF(COALESCE(wh_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC) AS wh_gross_price_fg,
 CAST(IF(COALESCE(store_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC) AS store_gross_price_fg,
 CAST(IF(COALESCE(total_qty, - 1) > 0, 1, 0) AS BIGNUMERIC) AS total_qty_fg,
  CASE
  WHEN CAST(IF(moduser LIKE 'DAY%', 1, 0) AS BIGNUMERIC) = 1
  THEN 3
  WHEN CAST(IF(moduser LIKE 'ASP%', 1, 0) AS BIGNUMERIC) = 1 AND CAST(IF(COALESCE(new_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC)
     = 1 AND CAST(IF(COALESCE(wh_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC) = 1
  THEN 2
  WHEN CAST(IF(moduser LIKE 'ASP%', 1, 0) AS BIGNUMERIC) = 1 AND CAST(IF(COALESCE(new_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC)
     = 0 AND CAST(IF(COALESCE(wh_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC) = 1
  THEN 1
  ELSE - 1
  END AS wawi_pv_type_id,
  CASE
  WHEN CAST(IF(moduser LIKE 'DAY%', 1, 0) AS BIGNUMERIC) = 1
  THEN 'Preisgebietsdifferenz'
  WHEN CAST(IF(moduser LIKE 'ASP%', 1, 0) AS BIGNUMERIC) = 1 AND CAST(IF(COALESCE(new_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC)
     = 1 AND CAST(IF(COALESCE(wh_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC) = 1
  THEN 'Bestands PV'
  WHEN CAST(IF(moduser LIKE 'ASP%', 1, 0) AS BIGNUMERIC) = 1 AND CAST(IF(COALESCE(new_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC)
     = 0 AND CAST(IF(COALESCE(wh_gross_price, - 1) > 0, 1, 0) AS BIGNUMERIC) = 1
  THEN 'Abverkaufsbasierte PV aus LP/PD (NPPS)'
  ELSE 'n/A'
  END AS wawi_pv_type_descr
FROM (SELECT DISTINCT client_id,
   loc_sid_store,
   item_sid,
   loc_sid_wh AS warehouse_sid,
   dwh_cal_dt,
   subitemgrp_cd,
   dwh_created,
   dwh_updated,
   moduser,
   act_price_grp_id,
   new_price_grp_id,
   vat_id,
   PERCENTILE_CONT(wh_gross_price, 0.5) OVER (PARTITION BY client_id, loc_sid_store, item_sid, loc_sid_wh, dwh_cal_dt)
   AS wh_gross_price,
   PERCENTILE_CONT(wh_net_price, 0.5) OVER (PARTITION BY client_id, loc_sid_store, item_sid, loc_sid_wh, dwh_cal_dt) AS
   wh_net_price,
   PERCENTILE_CONT(new_gross_price, 0.5) OVER (PARTITION BY client_id, loc_sid_store, item_sid, loc_sid_wh, dwh_cal_dt)
   AS new_gross_price,
   PERCENTILE_CONT(new_net_price, 0.5) OVER (PARTITION BY client_id, loc_sid_store, item_sid, loc_sid_wh, dwh_cal_dt) AS
   new_net_price,
   PERCENTILE_CONT(org_gross_price, 0.5) OVER (PARTITION BY client_id, loc_sid_store, item_sid, loc_sid_wh, dwh_cal_dt)
   AS org_gross_price,
   PERCENTILE_CONT(org_net_price, 0.5) OVER (PARTITION BY client_id, loc_sid_store, item_sid, loc_sid_wh, dwh_cal_dt) AS
   org_net_price,
   PERCENTILE_CONT(store_gross_price, 0.5) OVER (PARTITION BY client_id, loc_sid_store, item_sid, loc_sid_wh, dwh_cal_dt
      ) AS store_gross_price,
   PERCENTILE_CONT(store_net_price, 0.5) OVER (PARTITION BY client_id, loc_sid_store, item_sid, loc_sid_wh, dwh_cal_dt)
   AS store_net_price,
   total_qty
  FROM ldl_p_lew_core.t_store_form
  WHERE dwh_cal_dt >= DATE('2019-01-01')
   AND dwh_cal_dt <= CURRENT_DATE
    /* --> PV
					190 Korr. Gesellschafts-PV
					134 Filial-PV
					144 Korr. Filial-PV
					180 Gesellschafts-PV */
   AND sfo_type_id IN (130, 131, 132, 133, 135, 138, 139, 140, 141, 142, 143, 145, 148, 149, 151, 161, 144, 134, 180,
     190)
   AND sfo_type_id IN (134, 144, 180, 190)
   AND pcwo_reason_id IN (41)
   /* 41	Werbe-PV Only
					42	Dauerhafte Preisaenderung
					43	Restantenverwertung (PV) Sortiment */
   AND (sfo_type_id NOT IN (131, 141) OR SAFE_CAST(subitemgrp_cd AS BIGNUMERIC) IS NULL OR NOT SAFE_CAST(subitemgrp_cd
        AS BIGNUMERIC) BETWEEN 100 AND 399 AND SAFE_CAST(subitemgrp_cd AS BIGNUMERIC) NOT IN (75, 76))) AS sfof
WHERE client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id);


--SELECT * FROM LDL.P_LEW_MART_PIT.V_SOURCE_SFO WHERE TRUE AND CLIENT_ID = 23 AND STORE_SID = 11080 AND DAY_DT = '2023-12-16'::DATE AND ITEM_SID in (3893584) LIMIT 10
--SELECT * FROM LDL.P_LEW_MART_PIT.V_SOURCE_SFO WHERE TRUE AND CLIENT_ID = 23 AND DAY_DT = '2023-11-20'::DATE AND STORE_SID = 17065 AND ITEM_SID IN (1007780, 5294139) LIMIT 10;