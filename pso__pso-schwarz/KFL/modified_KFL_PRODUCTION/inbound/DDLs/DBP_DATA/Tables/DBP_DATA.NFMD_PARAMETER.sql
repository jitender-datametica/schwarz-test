--==============================================================
-- Table: nfmd_parameter
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_parameter
   generated from Powerdesigner on Dienstag, 4. Februar 2025 10:35:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.NFMD_PARAMETER (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant ID',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp when the record was created',
   discount_steps                      INTEGER     COMMENT 'gap between two discounts',
   min_discount_pct                    INTEGER     COMMENT 'minimum discount percent (0-100)',
   max_discount_pct                    INTEGER     COMMENT 'maximum discount percent (0-100)',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   min_price_gross_local_val           NUMBER(29,5)     COMMENT 'lowest possible gross price in local currency',
   no_touch_days_cnt                   INTEGER     COMMENT 'No Touch period (no change in price) in number of days.',
   min_days_btw_discounts_cnt          INTEGER     COMMENT 'minimum number of days between two discounts',
   max_days_btw_discounts_cnt          INTEGER     COMMENT 'maximum number of days between two discounts',
   discount_day_of_week                VARCHAR(255)     COMMENT 'day of the week for the discount',
   validity_days_cnt                   INTEGER     COMMENT 'Number of days for which the discounted price will be valid',
   price_ending_threshold              INTEGER     COMMENT 'if the modelprice is above this value, the model price is rounded',
   max_discount_for_max_price_pct      INTEGER     COMMENT 'Max discount for price X ( in percent 0-100)',
   max_price_for_max_discount          INTEGER     COMMENT 'Value X another max discount',
   discount_type_fg                    INTEGER     COMMENT '0 - Discount can be set in percent, 1 - discount can be set in currency.',
   promo_lifecycle_weeks_cnt           INTEGER     COMMENT 'The target length of promotion in number of weeks',
   experiment_cohorts_cnt              INTEGER     COMMENT 'how many cohorts does one experiment contains',
   experiments_for_manual_evaluation_cnt INTEGER     COMMENT 'how many experiments are included in one manual evaluation cycle',
   success_write_off_threshold         NUMBER(29,5)     COMMENT 'for a successful cohort, how much less write-off should the test group have against control group',
   success_cohorts_threshold           INTEGER     COMMENT 'for a successful experiment, how many cohorts should the test group outperform control group',
   export_day_of_week                  VARCHAR(20)      COMMENT 'in which weekday is the data from Snowflake exported to be loaded in operational system',
   apply_price_rounding_fg             INTEGER     COMMENT 'Specifies if the prediction model should (or should not) apply rounding to prices',
   frontend_data_retention_period_weeks_cnt INTEGER     COMMENT 'Specified for how many weeks we keep data in tables for frontend (NFMD_ART_PROMOTION, NFMD_ARTICLE_STORE_SCORECARD) so we can compare the results(effect) of past promotions with the current one.',
   second_discount_pct                 INTEGER     COMMENT 'Percent by which the price is reduced for the second discount',
   second_discount_validity_wks_cnt    INTEGER     COMMENT 'Number of weeks for which the price after the second discount will be valid',
   second_discount_lifecycle_weeks_cnt INTEGER     COMMENT 'Number of weeks after that the second discount is being calculated',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_NFMD_PARAMETER PRIMARY KEY (mandant_id, dwh_created_tmsp) NOT ENFORCED
)  COMMENT = 'The parameter settings for the model that determines price reduction proposals. These settings are required both in the Fronted and in the AI model for calculating the KPIs';
