CREATE TABLE DBP_DATA.CRM_L_KUNDENPROGRAMM (
	CRM_KUNDENPROGRAMM_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID des Loyaltypogramms/Kundenkartenprogramms. Ein Konto (crm_l_konto.crm_konto_id) ist stets einem Kundenprogramm zugeordnet.',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='EK-KUN - MSDynamicsCRM - Daten der Entität \"Loyaltyprogram\" (Kundenkartenprogramm)'
;