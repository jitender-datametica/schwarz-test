create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.NFMD_ARTICLE_STORE_CURVES_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	AKTION_ID VARCHAR(10) NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	WG_ID NUMBER(38,0) COMMENT 'Warengruppenid',
	KJWO_WW NUMBER(38,0) COMMENT 'Calendar_2 year-week when the promotion campaign started. Format JJJJWW',
	CURVE_WEEK_NR NUMBER(38,0) NOT NULL COMMENT 'Week of the promotion (ex 2 - second week )',
	PROMO_START_DT DATE COMMENT 'Date when the promotion campaign starts',
	SELLING_PRICE_GROSS_LOCAL_VAL NUMBER(38,5) COMMENT 'semi additive - gross selling price of a single article in currency expressed in column WRG_ID',
	STOCK_INITIAL_CNT NUMBER(38,0) COMMENT 'semi additive - stock amount(count)  at the beginning of campaign',
	WEEKLY_SALES_CNT NUMBER(38,0) COMMENT 'semi additive - total count of sold articles for this week',
	CUMULATED_SALES_CNT NUMBER(38,0) COMMENT 'semi additive - total count of sold articles from the beginning of the promotion campaign till this week (Inclusive)',
	WEEKLY_REVENUE_GROSS_LOCAL_VAL NUMBER(38,5) COMMENT 'additive - revenue generated for this week',
	WEEKLY_SELL_RATE NUMBER(38,5) COMMENT 'non additive - percentage of the stock sold this week of the campaign (as fraction 0.0 to 1.0)',
	WEEKLY_PRICE_RATE NUMBER(38,5) COMMENT 'non additive The ratio between original price and the price at which the item_2 is sold this week ( 0.0 to 1.0)',
	MODEL_EXECUTION_TMSP TIMESTAMP_NTZ(9) COMMENT 'timestamp when the AI model was executed',
	AI_MODEL_ID VARCHAR(50) COMMENT 'Unique identifier of the AI model',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_NFMD_ARTICLE_STORE_CURVES primary key (MANDANT_ID, AKTION_ID, ART_ID, WUP_ID, CURVE_WEEK_NR)
)COMMENT='This table tracks the course of the article-market combination per week'
;
