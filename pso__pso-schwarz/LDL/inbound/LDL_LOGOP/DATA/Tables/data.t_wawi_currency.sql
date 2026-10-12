CREATE TABLE DATA.T_WAWI_CURRENCY (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country code',
    CLIENT_DESC VARCHAR(18) COMMENT 'Country name',
    CURR_NAME VARCHAR(18) COMMENT 'Currency name',
    CURR_TICKER VARCHAR(18) COMMENT 'Currency ticker',
	CURR_SIGN VARCHAR(18) COMMENT 'Currency sign'
)COMMENT='WAWI - Country and Currency Mapping'
;