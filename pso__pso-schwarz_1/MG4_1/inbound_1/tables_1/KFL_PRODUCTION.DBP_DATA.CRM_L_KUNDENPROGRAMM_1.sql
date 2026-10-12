create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_L_KUNDENPROGRAMM_1 (
	CRM_KUNDENPROGRAMM_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID des Loyaltypogramms/Kundenkartenprogramms. Ein Konto_1 (crm_l_konto.crm_konto_id) ist stets einem Kundenprogramm zugeordnet.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='EK-KUN - MSDynamicsCRM - Daten der Entität \"Loyaltyprogram\" (Kundenkartenprogramm)'
;