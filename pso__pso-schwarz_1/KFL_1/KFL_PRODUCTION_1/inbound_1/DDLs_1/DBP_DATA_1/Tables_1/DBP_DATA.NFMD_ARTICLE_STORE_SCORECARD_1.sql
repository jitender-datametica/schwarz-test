--==============================================================
-- Table: nfmd_article_store_scorecard_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_article_store_scorecard_1
   generated from Powerdesigner on Montag, 3. Februar 2025 14:10:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.NFMD_ARTICLE_STORE_SCORECARD_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   discount_type_name                  VARCHAR(50)      NOT NULL DEFAULT 'nfmd' COMMENT 'Describes the discount type for this article in the given store and promotion campaing. "nfmd" - is the defatult, initial discount. "second_discount" means the price of the product has been reduced for a second time in the same promotion.',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   wg_id                               NUMBER(38,0)     COMMENT 'Warengruppenid',
   kjwo_ww                             NUMBER(38,0)     COMMENT 'Calendar_1 year-week when the promotion campaign started. Format JJJJWW',
   promo_start_dt                      DATE             COMMENT 'Date when the promotion campaign starts',
   selling_price_gross_local_val       NUMBER(38,5)     COMMENT 'semi additive - gross selling price of a single article in currency expressed in column WRG_ID',
   promo_stores_cnt                    NUMBER(38,0)     COMMENT 'semi additive - Number (count) of stores where the promotion is active',
   parameter_config                    VARCHAR(500)     COMMENT 'Not in use. Populated always with PARAM_A',
   cluster_config                      VARCHAR(500)     COMMENT 'Not in use. Populated always with CLUSTER_A',
   promo_week_sell_rate                NUMBER(38,5)     COMMENT 'non additive - percentage of the stock sold in the first week of the campaign  ( 0.0 to 1.0)',
   model_price_gross_local_val         NUMBER(38,5)     COMMENT 'non additive - gross retail price recommended by the AI model (in local currency)',
   sales_promo_week_cnt                NUMBER(38,0)     COMMENT 'semi additive - sales_1 in the first campaign week',
   model_discount_opt_rate             NUMBER(38,5)     COMMENT 'non additive - Discount percent recommended by the AI model as fraction of 1 (ex 0.70)',
   sales_total_cnt                     NUMBER(38,0)     COMMENT 'semi additive - total number of articles sold',
   stock_initial_cnt                   NUMBER(38,0)     COMMENT 'semi additive - stock count  at the beginning of campaign',
   current_discount_rate               NUMBER(38,5)     COMMENT 'non additive - current discount  as fraction of 1 (ex. -0,10)',
   current_week_nr                     NUMBER(38,0)     COMMENT 'current week of the promotion ( ex 2 - second week of promotion)',
   current_sell_rate                   NUMBER(38,5)     COMMENT 'non additive - percentage of the stock that is currently sold (as fraction of 1)',
   remaining_weeks_cnt                 NUMBER(38,0)     COMMENT 'non additive - how many weeks are left of the promotion',
   remaining_stock_cnt                 NUMBER(38,0)     COMMENT 'semi additive - stock count currently remaining',
   total_revenue_gross_local_val       NUMBER(38,5)     COMMENT 'additive - total revenue amount of the prmotion to date (since start till this week inclusive)',
   revenue_last_week_gross_local_val   NUMBER(38,5)     COMMENT 'additive -  revenue amount for this promotion in the last week ',
   model_execution_tmsp                TIMESTAMP_NTZ(9) COMMENT 'timestamp when the AI model was executed',
   ai_model_id                         VARCHAR(50)      COMMENT 'Unique identifier of the AI model',
   curve_type_cd                       NUMBER(38,0)     COMMENT 'Type of model curve for this Store and Article',
   rule_created_dt                     DATE             COMMENT 'creation date of the rule matrix for this Store and Article',
   is_in_experiment_fg                 NUMBER(38,0)     COMMENT 'Flag indicating if this an experiment',
   experiment_group_cd                 VARCHAR(10)      COMMENT 'For A/B testing this shows if this is the "A" group or the "B" group',
   experiment_stores_cnt               NUMBER(38,0)     COMMENT 'semi additive - Number of stores which are part of this experiment',
   display_art_id                      NUMBER(38,0)     COMMENT 'Artikelnummer des Display-Artikels (the display component ID if an article is display article )',
   rule_decision_record                VARCHAR(100)     COMMENT 'the four dimentions of a rule matrix concatenated as a string (curve_type_cd, hwg_id, price_class_cd, sell_wk34_from_wk3_rate)',
   sell_ratio_wk12                     NUMBER(38,5)     COMMENT 'non additive. sell ratio - all items sold in week 1 and 2 relative to the initial stock count',
   sell_ratio_wk123                    NUMBER(38,5)     COMMENT 'non additive. sell ratio - all items sold in week 1, 2 and 3 relative to the initial stock count',
   orig_promo_start_dt                 DATE             COMMENT '"Standart" Promotion cycle is 6,7 or 8 days long.
            In cases when have promotions that are 2,3,4 or 5 days long we say they have "Short" Promotion Cycle.
            If a "Short" promotion cycle completely fits into a 6,7,8-day time interval of a single standart promotion,  then we expand the interval of the short promotion and overwrite the Start and End date.
            This is done so we can associate this "Short" promotion cycle with a single "Standart" promotion cycle.
            Still we need to keep the original dates also. So in this column we have the originial Start Date (of the non-standart promotion cycle)',
   orig_promo_end_dt                   DATE             COMMENT '"Standart" Promotion cycle is 6,7 or 8 days long.
            In cases when have promotions that are 2,3,4 or 5 days long we say they have "Short" Promotion Cycle.
            If a "Short" promotion cycle completely fits into a 6,7,8-day time interval of a single standart promotion,  then we expand the interval of the short promotion and overwrite the Start and End date.
            This is done so we can associate this "Short" promotion cycle with a single "Standart" promotion cycle.
            Still we need to keep the original dates also. So in this column we have the originial End  Date (of the non-standart promotion cycle)',
   orig_promo_cycle_type_name          VARCHAR(50)      COMMENT '"Standart" Promotion cycle is 6,7 or 8 days long.
            In cases when have promotions that are 2,3,4 or 5 days long we say they have "Short" Promotion Cycle.
            If a "Short" promotion cycle completely fits into a 6,7,8-day time interval of a single standart promotion,  then we expand the interval of the short promotion and overwrite the Start and End date.
            This is done so we can associate this "Short" promotion cycle with a single "Standart" promotion cycle.
            Still we need to keep the original cycle type of the promotion (Short, Custom ...). This field keeps the original value of the promotion cycle type',
   second_discount_start_dt            DATE             COMMENT 'For products that have their price reduced for a second time in the same campaing, this is the date on which the second dicount takes effect.',
   second_discount_end_dt              DATE             COMMENT 'For products that have their price reduced for a second time in the same campaing, this is the date on which the second dicount expires.',
   discount_base_gross_local_val       NUMBER(38,5)     COMMENT 'Base gross price for second discount calculation in currency expressed in column WRG_ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_NFMD_ARTICLE_STORE_SCORECARD PRIMARY KEY (mandant_id, aktion_id, art_id, wup_id, discount_type_name) NOT ENFORCED
)  COMMENT = 'The table contains discount suggestions for each article-market combination, for a promotion campaign. . Data is retained for certain number of  weeks controlled by a patameter in NFMD_PARAMETER_1 table. After that older data is removed';
