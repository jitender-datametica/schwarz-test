create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_DIM_DISTRIBUTION_CHANNEL_1 (
	DIST_CHANNEL_CD VARCHAR(5) NOT NULL COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
	DIST_CHANNEL_TYPE_CD VARCHAR(5) COMMENT 'A  type of distribution channel ( Webshop for LD Webshop , IC for Intercompany)',
	DIST_COUNTRY_CD VARCHAR(5) COMMENT 'The unique code for a country_1 according to ISO-3166 Alpha-2. E.g. \""DE\"" for Germany or \""FR\"" for France',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	WSHOP_CD VARCHAR(5) COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. Filed only for channels related to Lidl Webshops',
	constraint PK_T_DIM_DISTRIBUTION_CHANNEL primary key (DIST_CHANNEL_CD)
)COMMENT='The dimension that dedcribes distribution channels used for goods sales_1 - through Lidl Digital Webshops , Kaufland intercompany sales_1 , or through third pardy platforms ( to be added in the future ).\n             Source : manual input'
;