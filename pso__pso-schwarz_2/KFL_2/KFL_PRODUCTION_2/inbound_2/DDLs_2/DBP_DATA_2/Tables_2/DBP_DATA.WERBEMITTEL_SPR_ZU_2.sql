create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WERBEMITTEL_SPR_ZU_2 (
	WERBEMITTELKANAL_ID VARCHAR(4) NOT NULL DEFAULT '-1' COMMENT 'Werbemittel Art_2 ID - medium through which the advertisement is shown (paper, digital)',
	WERBEMITTEL_ID VARCHAR(2) NOT NULL COMMENT 'Werbemittel - on what item_2 the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Sprachschlüssel',
	WERBEMITTEL_BEZ VARCHAR(200) COMMENT 'Werbemittelbezeichnung',
	WERBEMITTEL_WFL_BEZ VARCHAR(200) COMMENT 'Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_2 Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_WERBEMITTEL_SPR_ZU primary key (SPR_ID, WERBEMITTEL_ID, WERBEMITTELKANAL_ID)
)COMMENT='Sprachzuordnungstabelle für die Werbemittelkanal- & Werbemittel-Kombination. Enthält sowohl die Bezeichnungen aus SAP, als auch die durch die Warenfluss-Nutzer (WFL) gesetzten Kurzbezeichnungen.\n             Werbemittelkanal und Werbemittel geben an, wo die Werbung stattfindet (z.B. Online, Prospekt,...)'
;
