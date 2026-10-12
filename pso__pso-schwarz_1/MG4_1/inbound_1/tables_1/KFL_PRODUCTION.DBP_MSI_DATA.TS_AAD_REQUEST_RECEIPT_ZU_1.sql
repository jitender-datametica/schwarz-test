create or replace TABLE KFL_PRODUCTION.DBP_MSI_DATA.TS_AAD_REQUEST_RECEIPT_ZU_1 (
	BON_ID VARCHAR(25) NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert.',
	BON_DAT DATE NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
	AAD_REQUEST_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the Request (Sequence)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_AAD_REQUEST_RECEIPT_ZU primary key (BON_ID, BON_DAT, WUP_ID, MANDANT_ID, AAD_REQUEST_ID)
)COMMENT='Contains the receipt associated to a request made in frontend'
;