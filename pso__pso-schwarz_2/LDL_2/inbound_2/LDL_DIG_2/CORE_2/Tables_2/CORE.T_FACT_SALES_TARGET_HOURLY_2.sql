CREATE TABLE CORE.T_FACT_SALES_TARGET_HOURLY_2 (
	WSHOP_CD VARCHAR(5) NOT NULL COMMENT 'The unique code for the Lidl webshop',
	TARGET_SALE_DT DATE NOT NULL COMMENT 'A date for which the target is set by headquarter',
	TARGET_SALE_HR TIME(6) NOT NULL COMMENT 'A time for which the target is set by headquarter ( distributed by ETL )',
	SHOP_CAT_LVL1_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (sk) for global shop category level 4',
	SHOP_CAT_LVL1_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the  global  shop category level 1 is known.',
	CURR_CD VARCHAR(5) COMMENT 'Currency in which target is set',
	TGT_REVENUE_NET_EUR_VAL NUMBER(38,5) COMMENT 'A target sales_2 amount for a level netto in euro',
	TGT_MARGIN_EUR_VAL NUMBER(38,5) COMMENT 'A target margin amount for a  level  in euro',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SHOP_CAT_LVL1_CD  NUMBER  COMMENT 'The code by which the shop category level 1 is known.',
   CONSTRAINT PK_T_FACT_SALES_TARGET_HOURLY PRIMARY KEY (WSHOP_CD, TARGET_SALE_DT, TARGET_SALE_HR, SHOP_CAT_LVL1_SID, SHOP_CAT_LVL1_NAME)
)COMMENT='An hourly target sales_2 amount  is set for every product sold in a Lidl webshop'
;