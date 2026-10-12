/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_item_default_price
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* ELWIS (US, RS) besitzt keine Preisgruppen -> or null */
/* fuer obere logik relevant mit einstufung in preisgruppen */ -- To identify WAWI or ELWIS client

CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_item_default_price (client_id, country_iso_cd, org_item_nr,
valid_from_item, case_size, saleprice_gross1, saleprice_gross2, saleprice_gross3, currency_iso_code, dwh_updated,
dwh_created, dwh_load_id, load_id, src_id) AS SELECT IP.client_id,
 I.src_country_lidl_cd AS country_iso_cd,
 I.orig_item_nr AS org_item_nr,
 I.valid_from AS valid_from_item,
 I.case_size,
 CAST(MAX(CASE
    WHEN PG.position_article_sales_rep IS NULL OR PG.position_article_sales_rep = 1
    THEN IP.price_retail
    ELSE NULL
    END) AS NUMERIC) AS saleprice_gross1,
 CAST(MAX(CASE
    WHEN PG.position_article_sales_rep = 2
    THEN IP.price_retail
    ELSE NULL
    END) AS NUMERIC) AS saleprice_gross2,
 CAST(MAX(CASE
    WHEN PG.position_article_sales_rep = 3
    THEN IP.price_retail
    ELSE NULL
    END) AS NUMERIC) AS saleprice_gross3,
 C.currency_iso_cd AS currency_iso_code,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_updated,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_created,
 CAST(- 1 AS BIGNUMERIC) AS dwh_load_id,
 IP.load_id,
 1 AS src_id
FROM ldl_p_lew_core_ac.v_wawi_itm_price AS IP
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis AS I ON IP.client_id = I.client_id AND IP.item_sid = I.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_pricegrp AS PG ON IP.client_id = PG.client_id AND IP.pricegroup_id = PG.pricegroup_id
     AND CURRENT_DATE BETWEEN PG.dat_valid_from AND PG.dat_valid_until
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_currency_act AS C ON IP.client_id = C.client_id AND C.rate_currency_exchange =
   1
WHERE IP.item_sid > 0
 AND (I.itemstatus_cd > 3 AND I.itemstatus_cd < 10)
 AND I.buying_list_type_id > 0
 AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN IP.dat_valid_from AND IP.dat_valid_until
 AND IP.price_retail IS NOT NULL
GROUP BY IP.client_id,
 country_iso_cd,
 org_item_nr,
 valid_from_item,
 I.case_size,
 currency_iso_code,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 IP.load_id,
 src_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(IP.client_id AS STRING), org_item_nr, valid_from_item, CAST(I.case_size AS STRING)
      ORDER BY IP.load_id IS NULL, IP.load_id)) = 1
UNION DISTINCT
SELECT SCD.client_id,
 I.src_country_lidl_cd AS country_iso_cd,
 I.orig_item_nr AS org_item_nr,
 I.valid_from AS valid_from_item,
 I.case_size,
 ROUND(CAST(MAX(SCD.cond_val) AS NUMERIC), 4) AS saleprice_gross1,
 CAST(MAX(NULL) AS NUMERIC) AS saleprice_gross2,
 CAST(MAX(NULL) AS NUMERIC) AS saleprice_gross3,
 C.currency_iso_cd AS currency_iso_code,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_updated,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_created,
 CAST(- 1 AS BIGNUMERIC) AS dwh_load_id,
 CAST(- 1 AS BIGNUMERIC) AS load_id,
 2 AS src_id
FROM ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm AS SCD
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis AS I ON SCD.client_id = I.client_id AND SCD.item_sid = I.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_currency_act AS C ON SCD.client_id = C.client_id AND C.rate_currency_exchange =
   1
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS CMP ON SCD.client_id = CMP.client_id AND CMP.active_fg = 1
WHERE SCD.item_sid > 0
 AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN SCD.dwh_valid_from AND SCD.dwh_valid_to
 AND (I.itemstatus_cd > 3 AND I.itemstatus_cd < 10)
 AND I.buying_list_type_id > 0
 AND SCD.cond_val IS NOT NULL
GROUP BY SCD.client_id,
 country_iso_cd,
 org_item_nr,
 valid_from_item,
 I.case_size,
 currency_iso_code,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id;