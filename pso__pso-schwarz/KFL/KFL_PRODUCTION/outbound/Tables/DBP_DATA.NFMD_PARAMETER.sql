--==============================================================
-- Table: nfmd_parameter
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_parameter
   generated from Powerdesigner on Dienstag, 4. Februar 2025 10:35:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nfmd_parameter (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant ID'),
dwh_created_tmsp DATETIME NOT NULL OPTIONS(description='timestamp when the record was created'),
discount_steps BIGNUMERIC(38,0) OPTIONS(description='gap between two discounts'),
min_discount_pct BIGNUMERIC(38,0) OPTIONS(description='minimum discount percent (0-100)'),
max_discount_pct BIGNUMERIC(38,0) OPTIONS(description='maximum discount percent (0-100)'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
min_price_gross_local_val BIGNUMERIC(38,5) OPTIONS(description='lowest possible gross price in local currency'),
no_touch_days_cnt BIGNUMERIC(38,0) OPTIONS(description='No Touch period (no change in price) in number of days.'),
min_days_btw_discounts_cnt BIGNUMERIC(38,0) OPTIONS(description='minimum number of days between two discounts'),
max_days_btw_discounts_cnt BIGNUMERIC(38,0) OPTIONS(description='maximum number of days between two discounts'),
discount_day_of_week STRING(255) OPTIONS(description='day of the week for the discount'),
validity_days_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of days for which the discounted price will be valid'),
price_ending_threshold BIGNUMERIC(38,0)
OPTIONS(description='if the modelprice is above this value, the model price is rounded'),
max_discount_for_max_price_pct BIGNUMERIC(38,0) OPTIONS(description='Max discount for price X ( in percent 0-100)'),
max_price_for_max_discount BIGNUMERIC(38,0) OPTIONS(description='Value X another max discount'),
discount_type_fg BIGNUMERIC(38,0)
OPTIONS(description='0 - Discount can be set in percent, 1 - discount can be set in currency.'),
promo_lifecycle_weeks_cnt BIGNUMERIC(38,0) OPTIONS(description='The target length of promotion in number of weeks'),
experiment_cohorts_cnt BIGNUMERIC(38,0) OPTIONS(description='how many cohorts does one experiment contains'),
experiments_for_manual_evaluation_cnt BIGNUMERIC(38,0)
OPTIONS(description='how many experiments are included in one manual evaluation cycle'),
success_write_off_threshold BIGNUMERIC(38,5)
OPTIONS(description='for a successful cohort, how much less write-off should the test group have against control group'),
success_cohorts_threshold BIGNUMERIC(38,0)
OPTIONS(description='for a successful experiment, how many cohorts should the test group outperform control group'),
export_day_of_week STRING(20)
OPTIONS(description='in which weekday is the data from Snowflake exported to be loaded in operational system'),
apply_price_rounding_fg BIGNUMERIC(38,0)
OPTIONS(description='Specifies if the prediction model should (or should not) apply rounding to prices'),
frontend_data_retention_period_weeks_cnt BIGNUMERIC(38,0)
OPTIONS(description='Specified for how many weeks we keep data in tables for frontend (NFMD_ART_PROMOTION, NFMD_ARTICLE_STORE_SCORECARD) so we can compare the results(effect) of past promotions with the current one.'),
second_discount_pct BIGNUMERIC(38,0)
OPTIONS(description='Percent by which the price is reduced for the second discount'),
second_discount_validity_wks_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of weeks for which the price after the second discount will be valid'),
second_discount_lifecycle_weeks_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of weeks after that the second discount is being calculated'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dwh_created_tmsp) NOT ENFORCED
)
OPTIONS(description='The parameter settings for the model that determines price reduction proposals. These settings are required both in the Fronted and in the AI model for calculating the KPIs');