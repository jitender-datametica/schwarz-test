CREATE TABLE CORE.T_DIM_PRODUCT_PURCHASE_ORGANISATION_TYPE_1 (
	PROD_PURCH_ORG_TYPE_CD VARCHAR(5) NOT NULL COMMENT 'The code for the country_1 / Lidl organization which is responsible for the purchasing (negotiation).',
	PROD_PURCH_ORG_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for  the country_1 / Lidl organization which is responsible for the purchasing in group language (German).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_PRODUCT_PURCHASE_ORGANISATION_TYPE PRIMARY KEY (PROD_PURCH_ORG_TYPE_CD)
)COMMENT='This minor dimension defines the country_1 / Lidl organization which is responsible for the purchasing (negotiation). For NF it is normally “LDI” (former purchasing in LDI) and “INT” (Stiftung).'
;