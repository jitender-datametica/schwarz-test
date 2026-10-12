create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_DIM_WEBSHOP (
	WSHOP_CD VARCHAR(5) NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
	WSHOP_NAME_DE VARCHAR(250) NOT NULL COMMENT 'The name for the Lidl webshop, where an order can be placed by a customer',
	WSHOP_NAME_EN VARCHAR(250) COMMENT 'The name for the Lidl webshop, where an order can be placed by a customer in English.',
	WSHOP_DISPLAY_ORDER_NR NUMBER(38,0) COMMENT 'The number indicates in which order the webshop will appear in front end ',
	COUNTRY_CD VARCHAR(5) COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. DE for Germany or FR for France',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_T_DIM_WEBSHOP primary key (WSHOP_CD)
)COMMENT='There is one webshop per each country where Lidl webshop operates. The gobal weshop has a code ''INT'''
;