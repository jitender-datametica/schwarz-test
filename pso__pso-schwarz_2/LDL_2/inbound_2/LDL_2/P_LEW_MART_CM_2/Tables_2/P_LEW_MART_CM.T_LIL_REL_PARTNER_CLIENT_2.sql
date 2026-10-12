CREATE TABLE P_LEW_MART_CM.T_LIL_REL_PARTNER_CLIENT_2(
	PARTNER_NAME		VARCHAR (100)		NOT NULL												COMMENT 'Partner name',
	CLIENT_ID			NUMBER (38,0)		NOT NULL												COMMENT 'Client identifier',
	CLIENT_LONG_DESC	VARCHAR (128)															COMMENT 'Client long description in German',
	CLIENT_LONG_DESC_EN VARCHAR (128)															COMMENT 'Client long description in English',
	PRIMARY KEY (PARTNER_NAME, CLIENT_ID)
)	COMMENT='Relational Table for Purchasers - Client, designed for Retail Panel'
;