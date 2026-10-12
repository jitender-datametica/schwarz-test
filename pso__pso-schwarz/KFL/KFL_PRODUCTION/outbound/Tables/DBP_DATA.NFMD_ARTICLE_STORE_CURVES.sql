--==============================================================
-- Table: nfmd_article_store_curves
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_article_store_curves
   generated from Powerdesigner on Dienstag, 26. April 2022 19:48:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nfmd_article_store_curves (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Unique identifier of the NFMD campaign'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
wg_id BIGNUMERIC(38,0) OPTIONS(description='Warengruppenid'),
kjwo_ww BIGNUMERIC(38,0) OPTIONS(description='Calendar year-week when the promotion campaign started. Format JJJJWW'),
curve_week_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Week of the promotion (ex 2 - second week )'),
promo_start_dt DATE OPTIONS(description='Date when the promotion campaign starts'),
selling_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='semi additive - gross selling price of a single article in currency expressed in column WRG_ID'),
stock_initial_cnt BIGNUMERIC(38,0)
OPTIONS(description='semi additive - stock amount(count)  at the beginning of campaign'),
weekly_sales_cnt BIGNUMERIC(38,0) OPTIONS(description='semi additive - total count of sold articles for this week'),
cumulated_sales_cnt BIGNUMERIC(38,0)
OPTIONS(description='semi additive - total count of sold articles from the beginning of the promotion campaign till this week (Inclusive)'),
weekly_revenue_gross_local_val BIGNUMERIC(38,5) OPTIONS(description='additive - revenue generated for this week'),
weekly_sell_rate BIGNUMERIC(38,5)
OPTIONS(description='non additive - percentage of the stock sold this week of the campaign (as fraction 0.0 to 1.0)'),
weekly_price_rate BIGNUMERIC(38,5)
OPTIONS(description='non additive The ratio between original price and the price at which the item is sold this week ( 0.0 to 1.0)'),
model_execution_tmsp DATETIME OPTIONS(description='timestamp when the AI model was executed'),
ai_model_id STRING(50) OPTIONS(description='Unique identifier of the AI model'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, aktion_id, art_id, wup_id, curve_week_nr) NOT ENFORCED
) OPTIONS(description='This table tracks the course of the article-market combination per week');