create or replace TABLE KFL_PRODUCTION.DBP_DATA.COS_BONUSPUNKTE_2 (
	CRM_KONTO_ID VARCHAR(144) NOT NULL COMMENT 'Identifier of the LoyaltyAccounts table.',
	DAT_VERFALL_BONUSPUNKTE DATE NOT NULL COMMENT 'Date when the anz_bonuspunkte expires and gets deleted.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'KFL country_2 of the Loyalty Program.',
	ANZ_BONUSPUNKTE NUMBER(38,0) COMMENT 'Shows the actual total value of points on a loyalty account_2, what a customer got from one transaction.',
	DATZEIT_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Timestamp of when the record was last updated in the source system. It is used to monitor the correctness of the loading process by comparing what is in the DWH and in the source.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_COS_BONUSPUNKTE primary key (CRM_KONTO_ID, DAT_VERFALL_BONUSPUNKTE)
)COMMENT='Bonus points accumulated by Customer. A customer may have several bonuspoints accumulation(rows in table) with different expiry date (dat_verfall_bonuspunkte) '
;