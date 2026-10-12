create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WERBEFLAECHENABSCHNITT_SPR_ZU (
	WERBEFLAECHENABSCHNITT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Werbeflächenabschnitts',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	WERBEFLAECHENABSCHNITT_NAME VARCHAR(100) COMMENT 'Bezeichnung des Werbeflächenabschnitts',
	WERBEFLAECHENABSCHNITT_WFL_BEZ VARCHAR(200) COMMENT 'Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine Bezeichnung für bestimmt Werbeflächenabschnitt definieren kann, welche im Frontend angezeigt wird.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_WERBEFLAECHENABSCHNITT_SPR_ZU primary key (WERBEFLAECHENABSCHNITT_ID, SPR_ID)
)COMMENT='Sprachzuordnungstabelle für den Werbeflächenabschnitt. Aus ZPMR_WBM_ABSBEZ(SAP P11). Enthält sowohl die Werbeflächenabschnitts-Bezeichnungen aus SAP, als auch die durch die Warenfluss-Nutzer (WFL) gesetzten Kurzbezeichnungen.\n             Der Werbeflächenabschnitt gibt an, in welchem Abschnitt eines Bereichs das Angebot abgebildet ist (z.B. TOPLEFT1 = oben links auf der Seite im Prospekt).'
;
