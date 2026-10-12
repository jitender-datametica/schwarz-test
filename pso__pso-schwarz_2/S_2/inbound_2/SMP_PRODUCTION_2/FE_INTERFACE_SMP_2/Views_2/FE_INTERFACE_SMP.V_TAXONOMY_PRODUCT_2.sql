create or replace view SMP_PRODUCTION.FE_INTERFACE_SMP.V_TAXONOMY_PRODUCT_2(
	RETAILER_ID,
	COUNTRY_2,
	GTIN,
	GTIN_NAME,
	LIST_ATTRIBUTES,
	LOAD_TIMESTAMP
) as
SELECT
   retailer_id
  ,country_id AS country_2
  ,gtin_id AS gtin
  ,(article_name) AS gtin_name
  ,taxonomy_attributes AS list_attributes
  ,load_timestamp
FROM fe_interface_smp.v_taxonomy_base_2
;
