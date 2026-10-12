-- Products from GS Upload for Lidl Stiftung


-- Products from GS Upload for OWIM


INSERT INTO szd_production_meta.t_product_key_2
(SELECT t4.max_sid + (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)),
  'CUSTOMS_PRODUCT',
  CURRENT_TIMESTAMP(),
  CAST('9999-12-31' AS TIMESTAMP),
  TRUE,
  LOWER(pd.product_number || '|' || pd.additional_cd || '|' || pd.customs_tariff_code_cd || '|' || pd.country_of_origin
   ) AS pd_product_number_pd_additional_cd_pd_customs_tariff_code_cd_pd_country_of_origin,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM (SELECT pd.dwh_src_1_tmsp,
    pd.dwh_src_file_name,
     CASE
     WHEN STRPOS(pd.product_number, '_') > 0
     THEN SUBSTR(pd.product_number, 1, STRPOS(pd.product_number, '_') - 1)
     ELSE pd.product_number
     END AS product_number,
     CASE
     WHEN STRPOS(pd.product_number, '_') > 0
     THEN SUBSTR(pd.product_number, STRPOS(pd.product_number, '_') + 1)
     ELSE ''
     END AS additional_cd,
    LPAD(SUBSTR(REPLACE(pd.customs_tariff_code_cd, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
    pd.country_of_origin,
    pd.consignor_stream_cd,
    pd.customs_product_type_cd,
    pd.alcoholic_beverage_tax_rate_cd,
    MAX(ab.alcohol_percentage) AS abv_pct,
    MIN(pd.product_name) AS product_name,
    MAX(pd.preferential_origin_fg) AS preferential_origin_fg,
    MAX(pd.quantity_in_uom) AS quantity_in_uom,
    SUM(CAST(pd.allocation_cnt AS FLOAT64)) AS allocation_cnt
   FROM (SELECT TRIM(CAST(article_number AS STRING)) AS product_number,
       article AS product_name,
       TRIM(CAST(customs_tariff_number AS STRING)) AS customs_tariff_code_cd,
       country_of_origin,
       'LST' AS consignor_stream_cd,
       'WWT' AS customs_product_type_cd,
       TRUE AS preferential_origin_fg,
       allocation AS allocation_cnt,
       tax_code AS alcoholic_beverage_tax_rate_cd,
       quantity_in_uom,
       dwh_src_1_tmsp,
       dwh_src_file_name
      FROM szd_production_etl.t_cache_list_2
      UNION ALL
      SELECT TRIM(CAST(article_number AS STRING)) AS product_number,
       article AS product_name,
       TRIM(CAST(customs_tariff_number AS STRING)) AS customs_tariff_code_cd,
       country_of_origin,
       'OWIM' AS consignor_stream_cd,
       'WWT' AS customs_product_type_cd,
       TRUE AS preferential_origin_fg,
       allocation AS allocation_cnt,
       tax_code AS alcoholic_beverage_tax_rate_cd,
       quantity_in_uom,
       dwh_src_1_tmsp,
       dwh_src_file_name
      FROM szd_production_etl.t_cache_owim_2) AS pd_2
    LEFT JOIN szd_production_etl.t_cache_abv_2 AS ab ON pd.product_number = ab.article_number
   GROUP BY pd.dwh_src_1_tmsp,
    pd.dwh_src_file_name,
    product_number,
    additional_cd,
    customs_tariff_code_cd,
    pd.country_of_origin,
    pd.consignor_stream_cd,
    pd.customs_product_type_cd,
    pd.alcoholic_beverage_tax_rate_cd) AS pd_2
  INNER JOIN (SELECT MAX(product_sid) AS max_sid
   FROM szd_production_meta.t_product_key_2) AS t4 ON TRUE
  LEFT JOIN szd_production_meta.t_product_key_2 AS p ON p.product_nat_key_nr = UPPER(pd.product_number || '|' || pd.additional_cd
          || '|' || pd.customs_tariff_code_cd || '|' || pd.country_of_origin)
 WHERE p.product_nat_key_nr IS NULL);