CREATE OR REPLACE VIEW kfl_production_dbp_view.v_nfmd_parameter_2 (mandant_id OPTIONS(description='Mandant_2 ID'),
dwh_created_tmsp OPTIONS(description='timestamp when the record was created'), discount_steps
OPTIONS(description='gap between two discounts'), min_discount_pct
OPTIONS(description='minimum discount percent (0-100)'), max_discount_pct
OPTIONS(description='maximum discount percent (0-100)'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), min_price_gross_local_val
OPTIONS(description='lowest possible gross price in local currency'), no_touch_days_cnt
OPTIONS(description='No Touch period (no change in price) in number of days.'), min_days_btw_discounts_cnt
OPTIONS(description='minimum number of days between two discounts'), max_days_btw_discounts_cnt
OPTIONS(description='maximum number of days between two discounts'), discount_day_of_week
OPTIONS(description='day of the week for the discount'), validity_days_cnt
OPTIONS(description='Number of days for which the discounted price will be valid'), price_ending_threshold
OPTIONS(description='if the modelprice is above this value, the model price is rounded'), max_discount_for_max_price_pct
OPTIONS(description='Max discount for price X ( in percent 0-100)'), max_price_for_max_discount
OPTIONS(description='Value X another max discount'), discount_type_fg
OPTIONS(description='0 - Discount can be set in percent, 1 - discount can be set in currency.'),
promo_lifecycle_weeks_cnt OPTIONS(description='The target length of promotion in number of weeks'),
experiment_cohorts_cnt OPTIONS(description='how many cohorts does one experiment contains'),
experiments_for_manual_evaluation_cnt
OPTIONS(description='how many experiments are included in one manual evaluation cycle'), success_write_off_threshold
OPTIONS(description='for a successful cohort, how much less write-off should the test_2 group have against control group'),
success_cohorts_threshold
OPTIONS(description='for a successful experiment, how many cohorts should the test_2 group outperform control group'),
export_day_of_week
OPTIONS(description='in which weekday is the data from Snowflake exported to be loaded in operational system'),
apply_price_rounding_fg
OPTIONS(description='Specifies if the prediction model should (or should not) apply rounding to prices'),
frontend_data_retention_period_weeks_cnt
OPTIONS(description='Specified for how many weeks we keep data in tables for frontend (NFMD_ART_PROMOTION_2, NFMD_ARTICLE_STORE_SCORECARD_2) so we can compare the results(effect) of past promotions with the current one.'),
second_discount_pct OPTIONS(description='Percent by which the price is reduced for the second discount'),
second_discount_validity_wks_cnt
OPTIONS(description='Number of weeks for which the price after the second discount will be valid'),
second_discount_lifecycle_weeks_cnt
OPTIONS(description='Number of weeks after that the second discount is being calculated'))
OPTIONS(DESCRIPTION = `THE PARAMETER SETTINGS FOR THE MODEL THAT DETERMINES PRICE REDUCTION PROPOSALS. THESE SETTINGS ARE REQUIRED BOTH IN THE FRONTED AND IN THE AI MODEL FOR CALCULATING THE KPIS`)
AS SELECT mandant_id,
 dwh_created_tmsp,
 discount_steps,
 min_discount_pct,
 max_discount_pct,
 wrg_id,
 min_price_gross_local_val,
 no_touch_days_cnt,
 min_days_btw_discounts_cnt,
 max_days_btw_discounts_cnt,
 discount_day_of_week,
 validity_days_cnt,
 price_ending_threshold,
 max_discount_for_max_price_pct,
 max_price_for_max_discount,
 discount_type_fg,
 promo_lifecycle_weeks_cnt,
 experiment_cohorts_cnt,
 experiments_for_manual_evaluation_cnt,
 success_write_off_threshold,
 success_cohorts_threshold,
 export_day_of_week,
 apply_price_rounding_fg,
 frontend_data_retention_period_weeks_cnt,
 second_discount_pct,
 second_discount_validity_wks_cnt,
 second_discount_lifecycle_weeks_cnt
FROM kfl_production_dbp_data.nfmd_parameter_2;