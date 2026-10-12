CREATE TABLE DBP_DATA.CRM_L_KUNDENPROGRAMM_2 (
	CRM_KUNDENPROGRAMM_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID des Loyaltypogramms/Kundenkartenprogramms. Ein Konto_2 (crm_l_konto.crm_konto_id) ist stets einem Kundenprogramm zugeordnet.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='EK-KUN - MSDynamicsCRM - Daten der Entität \"Loyaltyprogram\" (Kundenkartenprogramm)'
;