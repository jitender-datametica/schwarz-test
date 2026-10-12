create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_KONTO_BONUSPUNKTE_ZU_1 (
	CRM_KONTO_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID des Loyaltyaccounts/Bonuskontos. Ist im PK wegen Relation zu crm_l_kundenkarte_1',
	ANZ_EINLOESBARE_BONUSPUNKTE NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl einlösbarer Bonuspunkte',
	ANZ_EINGELOESTE_BONUSPUNKTE NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl eingelöster Bonuspunkte',
	ANZ_VERFALLENE_BONUSPUNKTE NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl verfallener/abgelaufener  Bonuspunkte',
	ANZ_BALD_VERFALLENDE_BONUSPUNKTE NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl bald verfallende/ablaufende Bonuspunkte',
	DAT_VERFALL_BONUSPUNKTE DATE DEFAULT (9999 - 12) - 31 COMMENT 'Datum zu dem die nächsten Bonuspunkte verfallen/ablaufen werden',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Enthält Daten der Entität \"Loyaltyaccount\" (Konto_1) aus MS Dynamics CRM rund um das Thema Bonuspunkte'
;