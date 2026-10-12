CREATE TABLE DBP_DATA.CRM_L_KONTO_2 (
	CRM_KONTO_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID des Loyaltyaccounts/Bonuskontos. Ist im PK wegen Relation zu crm_l_kundenkarte_2',
	CRM_KUNDE_ID VARCHAR(144) COMMENT 'CRM-interne ID des Kunden',
	CRM_KONTO_TYP_ID NUMBER(38,0),
	CRM_KUNDENPROGRAMM_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID des Loyaltypogramms/Kundenkartenprogramms. Ein Konto_2 (crm_l_konto_tmp.crm_konto_id) ist stets einem Kundenprogramm zugeordnet.',
	ZEIT_VON TIMESTAMP_NTZ(9) COMMENT 'Anfang des Kartengültigkeitsintervalls',
	ZEIT_BIS TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Ende des Kartengültigkeitsintervalls - wird immer befüllt',
	GELOESCHT_FG NUMBER(38,0) NOT NULL COMMENT 'Löschflag einer Kundenkarte (1 gelöscht, 0 nicht gelöscht) - wird immer befüllt',
	CRM_KONTO_NR NUMBER(38,0) COMMENT 'Nummer des Loyaltyaccounts/Bonuskontos',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Lookup für das Kundenkonto - \"Arvato_Loyaltyaccount_2\" (1:1 Beziehung). Ein Kunde (crm_kunde.kunde_id) kann Stand 05.03.19 an einem Loyaltyprogramm teilnehmen und hat daher einen Loyaltyaccount/ein Bonuskonto'
;