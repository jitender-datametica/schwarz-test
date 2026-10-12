create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.L_WERBEFLAECHENTHEMA_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	WERBEMITTELKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Werbemittelkanals',
	WERBEMITTEL_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Werbemittels',
	WERBEFLAECHENTHEMA_CD VARCHAR(50) NOT NULL COMMENT 'Code des Werbeflaechenthemas',
	WERBEFLAECHENTHEMA_BEZ VARCHAR(200) COMMENT 'Bezeichnung des Werbeflaechenthemas',
	WERBEFLAECHENTHEMA_WFL_BEZ VARCHAR(200) COMMENT 'Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_1 Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird. ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	WERBEFLAECHENTHEMA_AVQ_PRIO_NR NUMBER(38,0) COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenthemen bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenthemen mit der gleichen ID werden zusammengefasst.',
	constraint PK_L_WERBEFLAECHENTHEMA primary key (MANDANT_ID, WERBEMITTELKANAL_ID, WERBEMITTEL_ID, WERBEFLAECHENTHEMA_CD)
)COMMENT='Lookup-Tabelle für die Werbeflächenthemen. Aus ZPMR_FKUERZEL (SAP P11). Enthält sowohl die Werbeflächenthemen-Bezeichnung aus SAP, als auch die durch die Warenfluss-Nutzer (WFL) gesetzten Kurzbezeichnungen sowie Bezeichnungen zur Priorisierung der Abverkaufsquote (AVQ).\n             Das Werbeflächenthema gibt an, in welchem Bereich das Angebot_1 abgebildet ist (z.B. PANO01 = auf der ersten Panoseite im Prospekt).'
;
