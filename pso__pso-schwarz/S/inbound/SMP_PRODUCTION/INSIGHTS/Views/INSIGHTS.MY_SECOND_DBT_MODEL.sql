create or replace view SMP_PRODUCTION.INSIGHTS.MY_SECOND_DBT_MODEL(
	CAMPAIGN_NAME,
	COUNTRY_ID,
	DATE_UPDATED
) as (
    -- Use the `ref` function to select from other models

select *
from SMP_PRODUCTION.INSIGHTS.my_first_dbt_model
where campaign_name = 'dooh1'
  )
/* {"app": "dbt", "dbt_version": "1.10.16", "profile_name": "project_x", "target_name": "dev", "node_id": "model.project_x.my_second_dbt_model"} */;
