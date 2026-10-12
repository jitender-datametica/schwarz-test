create or replace view SMP_PRODUCTION.FE_INTERFACE_SMP.V_PRODUCT_MAPPING(
	RETAILER_ID,
	COUNTRY,
	ARTICLE_ID,
	GTINS,
	MULTIPACK_ARTICLE_ID,
	MULTIPACK_QUANTITY,
	LOAD_TIMESTAMP
) as 
SELECT 
   retailer_id
  ,country_id AS country
  ,article_id
  ,ARRAY_AGG(DISTINCT(gtin_id)) AS gtins
  ,TO_VARCHAR(NULL) AS multipack_article_id
  ,TO_NUMBER(NULL)  AS multipack_quantity  
  ,load_timestamp
FROM fe_interface_smp.v_taxonomy_base

GROUP BY 1,2,3,7
;
