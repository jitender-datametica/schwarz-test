create or replace TABLE SMP_PRODUCTION.INSIGHTS.T_ARTICLE_PROMOTION_1 (
	DIVISION_ID VARCHAR(100) COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) COMMENT 'Country_1 iso code',
	GTIN_ID VARCHAR(500) COMMENT 'gtin/article',
	GTIN_NAME VARCHAR(1000) COMMENT 'name of gtin/article',
	PROMOTION_ID VARCHAR(100) COMMENT 'identifier of promotion',
	START_DATE DATE COMMENT 'start date of the promotion',
	END_DATE DATE COMMENT 'end date of the promotion',
	DAYS NUMBER(10,0) COMMENT 'number of days of the promotion duration',
	CATEGORY VARCHAR(1000) COMMENT 'categorie of the gtin/article',
	CATEGORY_NAME VARCHAR(1000) COMMENT 'category name of the gtin/article'
);
