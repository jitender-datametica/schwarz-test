CREATE TABLE DBP_DATA.FLW_ART_GP_KONDIT_WUP_ZU_PER_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	KONDITION_APPLIKATION_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Applikation aus SAP Quelle A017.KAPPL',
	KONDITIONSART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Konditionsart aus kschl',
	FLW_LIEF_ID INTEGER NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
	FLW_ART_ID INTEGER NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
	EINKAUFSORGANISATION_ID INTEGER NOT NULL COMMENT 'ID der Einkaufsorganisation aus ekorg',
	WERK_ID INTEGER NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
	EINKAUFS_INFOSATZ_TYP_ID INTEGER NOT NULL DEFAULT -1 COMMENT 'Typ des Einkaufsinfosatzes aus SAP Quelle A017.ESOKZ',
	KONDITION_ID INTEGER NOT NULL COMMENT 'Nummer der Kondition aus knumh',
	DAT_BIS DATE NOT NULL COMMENT 'Gültigkeitsende des Konditionssatzes aus SAP Quelle A017.DATBI',
	DAT_VON DATE  COMMENT 'Gültigkeitsbeginn des Konditionssatzes aus SAP Quelle A017.DATAB',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'FLW - Materialinfosatz (werksspezifisch) aus SAP P21 Tabelle A017_2';
