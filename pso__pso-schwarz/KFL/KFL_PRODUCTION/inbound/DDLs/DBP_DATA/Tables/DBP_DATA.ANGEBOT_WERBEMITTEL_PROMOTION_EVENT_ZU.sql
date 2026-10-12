create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ANGEBOT_NR VARCHAR(50) NOT NULL COMMENT 'Numerische oder Alphanumerische Nummer des Angebots',
	WERBEMITTEL_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Werbemittels',
	WERBEMITTELKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Werbemittelkanals',
	PROMOTION_EVENT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Promotion Events.',
	WERBEFLAECHENABSCHNITT_NAME VARCHAR(100) NOT NULL COMMENT 'Name des Werbeflaechenabschnitts.',
	WERBEMITTEL_BEZ VARCHAR(200) COMMENT 'Bezeichnung des Werbemittels',
	WERBEMITTELKANAL_BEZ VARCHAR(200) COMMENT 'Bezeichnung des Werbemittelkanals.',
	WERBETHEMA_ID NUMBER(38,0) COMMENT 'ID des Werbethemas',
	WERBETHEMA_BEZ VARCHAR(200) NOT NULL COMMENT 'Bezeichnung des Werbethemas',
	WERBEFLAECHENTHEMA_CD VARCHAR(50) COMMENT 'Code des Werbeflaechenthemas',
	WERBEFLAECHENTHEMA_BEZ VARCHAR(200) NOT NULL COMMENT 'Bezeichnung des Werbeflaechenthemas',
	WERBEPOSITION_NR NUMBER(38,0) COMMENT 'Nummer der Position des Angebots innerhalb des Werbeflachenabschnitts.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU primary key (MANDANT_ID, ANGEBOT_NR, WERBEMITTEL_ID, WERBEMITTELKANAL_ID, PROMOTION_EVENT_ID, WERBEFLAECHENABSCHNITT_NAME)
)COMMENT='Zuordnungstabelle zwischen einem Angebot, dem Werbemittel und Event. Beinhaltet Informationen wo Angebote eines Events beworben werden. Die Tabelle wird zusätzlich zur promotion event Tabelle benötigt, da es auch Angebote ohne Event geben kann, die Informationen zum Werbemittel, Werbethema, etc. beinhalten. '
;
