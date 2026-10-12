create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_KUNDENPROGRAMM_SPR_ZU_2 (
	CRM_KUNDENPROGRAMM_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID des Loyaltypogramms/Kundenkartenprogramms. Ein Konto_2 (crm_l_konto.crm_konto_id) ist stets einem Kundenprogramm zugeordnet.',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_KUNDENPROGRAMM_BEZ VARCHAR(120) COMMENT 'Bezeichnung des Loyaltypogramms/Kundenkartenprogramms',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Sprachtabelle für die Entität \"Arvato_Loyaltyaccount_2\" (Konto_2) aus MS Dynamics CRM'
;