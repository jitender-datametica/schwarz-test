CREATE TABLE DATA.T_WAWI_CURRENCY_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_2 code',
    CLIENT_DESC VARCHAR(18) COMMENT 'Country_2 name',
    CURR_NAME VARCHAR(18) COMMENT 'Currency name',
    CURR_TICKER VARCHAR(18) COMMENT 'Currency ticker',
	CURR_SIGN VARCHAR(18) COMMENT 'Currency sign'
)COMMENT='WAWI - Country_2 and Currency Mapping'
;