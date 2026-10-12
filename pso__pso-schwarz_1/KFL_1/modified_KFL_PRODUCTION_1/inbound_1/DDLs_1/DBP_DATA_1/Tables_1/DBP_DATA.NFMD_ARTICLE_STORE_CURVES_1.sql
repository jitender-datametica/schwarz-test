--==============================================================
-- Table: nfmd_article_store_curves_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_article_store_curves_1
   generated from Powerdesigner on Dienstag, 26. April 2022 19:48:34
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.NFMD_ARTICLE_STORE_CURVES_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   aktion_id                           VARCHAR(10)     NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   wg_id                               INTEGER    COMMENT 'Warengruppenid',
   kjwo_ww                             INTEGER    COMMENT 'Calendar_1 year-week when the promotion campaign started. Format JJJJWW',
   curve_week_nr                       INTEGER    NOT NULL COMMENT 'Week of the promotion (ex 2 - second week )',
   promo_start_dt                      DATE            COMMENT 'Date when the promotion campaign starts',
   selling_price_gross_local_val       NUMBER(29,5)    COMMENT 'semi additive - gross selling price of a single article in currency expressed in column WRG_ID',
   stock_initial_cnt                   INTEGER    COMMENT 'semi additive - stock amount(count)  at the beginning of campaign',
   weekly_sales_cnt                    INTEGER    COMMENT 'semi additive - total count of sold articles for this week',
   cumulated_sales_cnt                 INTEGER    COMMENT 'semi additive - total count of sold articles from the beginning of the promotion campaign till this week (Inclusive)',
   weekly_revenue_gross_local_val      NUMBER(29,5)    COMMENT 'additive - revenue generated for this week',
   weekly_sell_rate                    NUMBER(29,5)    COMMENT 'non additive - percentage of the stock sold this week of the campaign (as fraction 0.0 to 1.0)',
   weekly_price_rate                   NUMBER(29,5)    COMMENT 'non additive The ratio between original price and the price at which the item_1 is sold this week ( 0.0 to 1.0)',
   model_execution_tmsp                TIMESTAMP_NTZ   COMMENT 'timestamp when the AI model was executed',
   ai_model_id                         VARCHAR(50)     COMMENT 'Unique identifier of the AI model',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_NFMD_ARTICLE_STORE_CURVES PRIMARY KEY (mandant_id, aktion_id, art_id, wup_id, curve_week_nr) NOT ENFORCED
)  COMMENT = 'This table tracks the course of the article-market combination per week';
