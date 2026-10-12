CREATE TABLE DBP_SECURITY.SORTIMENT_USER_WG_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	USER_ID VARCHAR(120) NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT -  Sortimentstool - Security-Tabelle für die Zuordnung von Warengruppen zu Usern (was darf im Sortimentstool eingesehen werden) Pflege erfolgt über einen MSI-TS-Bericht'
;