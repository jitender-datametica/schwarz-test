create or replace view SMP_PRODUCTION.FE_INTERFACE_SMP.V_TAXONOMY_BASE(
	DIVISION_ID,
	COUNTRY_ID,
	GTIN_ID,
	ARTICLE_ID,
	ARTICLE_PARENT_ID,
	ARTICLE_NAME,
	DAY_START_DT,
	DAY_END_DT,
	TAXONOMY_ATTRIBUTES,
	RETAILER_ID,
	LOAD_TIMESTAMP
) as 
SELECT 
   division_id
  ,country_id
  ,gtin_id
  ,article_id
  ,article_parent_id
  ,article_name
  ,day_start_dt
  ,day_end_dt
  ,taxonomy_attributes
  ,retailer_id
  ,load_timestamp
FROM 
(
    SELECT 
     b.division_id 
    ,b.country_id 
    ,b.gtin_id
    ,COALESCE(b.article_parent_id, b.article_id) AS article_id
    ,b.article_parent_id
    ,COALESCE(b.article_name, b.article_name_country) AS article_name 
    ,MIN(b.day_start_dt) OVER (PARTITION BY b.division_id, b.country_id, b.gtin_id) AS day_start_dt
    ,MAX(b.day_end_dt) OVER (PARTITION BY b.division_id, b.country_id, b.gtin_id) AS day_end_dt 
    ,b.taxonomy_attributes
    ,b.retailer_id
    ,COUNT(DISTINCT(b.gtin_id)) OVER (PARTITION BY b.retailer_id, b.country_id, COALESCE(b.article_parent_id, b.article_id)) AS anz
    ,MAX(load_timestamp) OVER (PARTITION BY b.retailer_id, b.country_id) AS load_timestamp
  FROM 
  (
    SELECT * FROM fe_interface_smp.t_smp_taxonomy_base
    UNION ALL
    SELECT * FROM etl_process.t_smp_taxonomy_base_exception 
    WHERE (division_id, country_id, gtin_id) NOT IN 
    (
      SELECT 
        division_id, country_id, gtin_id
      FROM fe_interface_smp.t_smp_taxonomy_base
    )    
  ) b 
) a 

QUALIFY ROW_NUMBER() OVER (PARTITION BY retailer_id, country_id, gtin_id ORDER BY anz, article_id, article_name, taxonomy_attributes DESC ) = 1;
