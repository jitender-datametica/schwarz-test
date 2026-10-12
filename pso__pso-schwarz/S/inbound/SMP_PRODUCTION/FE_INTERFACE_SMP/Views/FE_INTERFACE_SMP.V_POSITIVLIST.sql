create or replace view SMP_PRODUCTION.FE_INTERFACE_SMP.V_POSITIVLIST(
	RETAILER_ID,
	COUNTRY,
	GTIN,
	START_DATE,
	END_DATE,
	LOAD_TIMESTAMP
) as 
SELECT 
   retailer_id
  ,country_id AS country
  ,gtin_id AS gtin
  ,day_start_dt AS start_date 
  ,GREATEST(day_end_dt, DATEADD(DAY, 56, CURRENT_DATE)) AS end_date
  ,load_timestamp
FROM fe_interface_smp.v_taxonomy_base
;
