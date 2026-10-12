CREATE OR REPLACE TABLE smp_production_insights.t_campaign_registration_dooh_hist_1 (
campaign_name STRING(16777216) OPTIONS(description='Campaign name'),
campaign_start_date DATE OPTIONS(description='Start date of the campaign'),
campaign_end_date DATE OPTIONS(description='End date of the campaign'),
division_id STRING(16777216) OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(16777216) OPTIONS(description='Country_1 iso code'),
product_list STRING(16777216) OPTIONS(description='List of promoted articles/gtins'),
test_store_list STRING(16777216) OPTIONS(description='List of stores of the test_1 group'),
control_store_list STRING(16777216) OPTIONS(description='List of stores of the test_1 group (optional)'),
budget_spend FLOAT64 OPTIONS(description='Value budget spend (cummulated)'),
active_fg INTEGER OPTIONS(description='Flag active/inactive (1/0)'),
date_updated DATETIME OPTIONS(description='timestamp_ntz(9) last updated'),
archived_at DATETIME OPTIONS(description='timestamp_ntz(9) of archiving')
) OPTIONS(description='DOOH campaign definition - history/archiv from T_CAMPAIGN_REGISTRATION_DOOH_1 ');