create or replace view SMP_PRODUCTION.INSIGHTS.V_PEXA_AUDIENCE_1(
	DIVISION_ID,
	COUNTRY_ID,
	AUDIENCE_CATEGORY,
	AUDIENCE_NAME,
	AUDIENCE_TYPE,
	AUDIENCE_ID,
	UNIVERSE_ID
) as 
SELECT 
   division_id
  ,country_id
  ,INITCAP(REPLACE(universe_category, '-', ' ')) AS audience_category  
  ,INITCAP(REPLACE(universe_name, '-', ' ')) AS audience_name 
  ,universe_type_id AS audience_type
  ,universe_id_opt AS audience_id
  ,universe_id 
FROM core_rel.t_universe_1  
WHERE source_system_id = 'PEXA'
;
