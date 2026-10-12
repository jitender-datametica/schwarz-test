create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_GUTSCHEIN_2 (
	CRM_GUTSCHEIN_ID VARCHAR(36) NOT NULL COLLATE 'en-ci' COMMENT 'Gutschein_2 ID (GUID) aus CRM.',
	CRM_VORGANG_ID VARCHAR(36) COLLATE 'en-ci' COMMENT 'Vorgang ID (GUID) aus CRM.',
	CRM_GUTSCHEIN_GRUND_ID NUMBER(38,0) COMMENT 'Grund der Gutscheinausgabe ID.',
	GUTSCHEIN_NUMMER VARCHAR(100) COLLATE 'en-ci' COMMENT 'Gutscheinnummer.',
	KOSTENSTELLE_ID VARCHAR(100) COLLATE 'en-ci' COMMENT 'Kostenstelle.',
	GUTSCHEIN_WERT NUMBER(10,2) NOT NULL COMMENT 'Gutscheinwert.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	MANDANT_ID NUMBER(38,0) COMMENT 'Mandant_2 im DWH.',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
	constraint PK_CRM_GUTSCHEIN primary key (CRM_GUTSCHEIN_ID)
)COMMENT='KMR - Gutscheindaten aus der CRM Entität kl_voucher - MS Dynamics CRM'
;