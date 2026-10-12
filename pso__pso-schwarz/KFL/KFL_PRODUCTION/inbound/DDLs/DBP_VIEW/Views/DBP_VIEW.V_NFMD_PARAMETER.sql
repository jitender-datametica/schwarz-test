CREATE OR REPLACE VIEW DBP_VIEW.V_NFMD_PARAMETER (
   mandant_id                               COMMENT 'Mandant ID'
  ,dwh_created_tmsp                         COMMENT 'timestamp when the record was created'
  ,discount_steps                           COMMENT 'gap between two discounts'
  ,min_discount_pct                         COMMENT 'minimum discount percent (0-100)'
  ,max_discount_pct                         COMMENT 'maximum discount percent (0-100)'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,min_price_gross_local_val                COMMENT 'lowest possible gross price in local currency'
  ,no_touch_days_cnt                        COMMENT 'No Touch period (no change in price) in number of days.'
  ,min_days_btw_discounts_cnt               COMMENT 'minimum number of days between two discounts'
  ,max_days_btw_discounts_cnt               COMMENT 'maximum number of days between two discounts'
  ,discount_day_of_week                     COMMENT 'day of the week for the discount'
  ,validity_days_cnt                        COMMENT 'Number of days for which the discounted price will be valid'
  ,price_ending_threshold                   COMMENT 'if the modelprice is above this value, the model price is rounded'
  ,max_discount_for_max_price_pct           COMMENT 'Max discount for price X ( in percent 0-100)'
  ,max_price_for_max_discount               COMMENT 'Value X another max discount'
  ,discount_type_fg                         COMMENT '0 - Discount can be set in percent, 1 - discount can be set in currency.'
  ,promo_lifecycle_weeks_cnt                COMMENT 'The target length of promotion in number of weeks'
  ,experiment_cohorts_cnt                   COMMENT 'how many cohorts does one experiment contains'
  ,experiments_for_manual_evaluation_cnt    COMMENT 'how many experiments are included in one manual evaluation cycle'
  ,success_write_off_threshold              COMMENT 'for a successful cohort, how much less write-off should the test group have against control group'
  ,success_cohorts_threshold                COMMENT 'for a successful experiment, how many cohorts should the test group outperform control group'
  ,export_day_of_week                       COMMENT 'in which weekday is the data from Snowflake exported to be loaded in operational system'
  ,apply_price_rounding_fg                  COMMENT 'Specifies if the prediction model should (or should not) apply rounding to prices'
  ,frontend_data_retention_period_weeks_cnt COMMENT 'Specified for how many weeks we keep data in tables for frontend (NFMD_ART_PROMOTION, NFMD_ARTICLE_STORE_SCORECARD) so we can compare the results(effect) of past promotions with the current one.'
  ,second_discount_pct                      COMMENT 'Percent by which the price is reduced for the second discount'
  ,second_discount_validity_wks_cnt         COMMENT 'Number of weeks for which the price after the second discount will be valid'
  ,second_discount_lifecycle_weeks_cnt      COMMENT 'Number of weeks after that the second discount is being calculated'
)
COMMENT = 'The parameter settings for the model that determines price reduction proposals. These settings are required both in the Fronted and in the AI model for calculating the KPIs'
 AS 
    SELECT 
        mandant_id,
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

FROM DBP_DATA.NFMD_PARAMETER ;