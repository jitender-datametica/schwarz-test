create or replace view SMP_PRODUCTION.FE_INTERFACE_SMP.V_PRODUCT_MAPPING_1(
	RETAILER_ID,
	COUNTRY_1,
	ARTICLE_ID,
	GTINS,
	MULTIPACK_ARTICLE_ID,
	MULTIPACK_QUANTITY,
	LOAD_TIMESTAMP
) as 
SELECT 
   retailer_id
  ,country_id AS country_1
  ,article_id
  ,ARRAY_AGG(DISTINCT(gtin_id)) AS gtins
  ,TO_VARCHAR(NULL) AS multipack_article_id
  ,TO_NUMBER(NULL)  AS multipack_quantity  
  ,load_timestamp
FROM fe_interface_smp.v_taxonomy_base_1

GROUP BY 1,2,3,7
;
