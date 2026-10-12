create or replace view SMP_PRODUCTION.FE_INTERFACE_SMP.V_TAXONOMY_PRODUCT(
	RETAILER_ID,
	COUNTRY,
	GTIN,
	GTIN_NAME,
	LIST_ATTRIBUTES,
	LOAD_TIMESTAMP
) as
SELECT
   retailer_id
  ,country_id AS country
  ,gtin_id AS gtin
  ,(article_name) AS gtin_name
  ,taxonomy_attributes AS list_attributes
  ,load_timestamp
FROM fe_interface_smp.v_taxonomy_base
;
