create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.LEERGUT_EINWEG_DAT_ABRECHNUNG_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	LEERGUTAUTOMAT_SCHLUESSEL_ID VARCHAR(30) NOT NULL COMMENT 'ID des Leergutautomaten. Eindeutig im Land_1',
	DATZEIT_VERARBEITUNG TIMESTAMP_NTZ(0) NOT NULL COMMENT 'Zeitstempel, wann die Daten bei ESB verarbeitet worden sind. In einigen Fällen werden die Daten eines Automaten an zwei verschiedenen Tagen im System verarbeitet, daher wurde diese Spalte als Primärschlüssel hinzugefügt.',
	DAT_RUECKNAHME DATE NOT NULL COMMENT 'Tag_1 der Rücknahme (Reportingdatum) ist der Tag_1, an dem der Kunde die Einwegflaschen im Automaten abgegeben hat.',
	EINWEG_TYP_KZ VARCHAR(1) NOT NULL COMMENT 'Kennzeichen für Eigen-Einwegpfand (E) oder Fremd-Einwegpfand (F). Eigen-Einwegpfand bezieht sich auf Einwegpfandflaschen, die von der von Kaufland stammen.',
	LEERGUTAUTOMAT_ID VARCHAR(30) NOT NULL COMMENT 'ID des Leergutautomaten. Eindeutig in der Filiale.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	MENGE_EINWEG NUMBER(38,0) NOT NULL COMMENT 'Menge der geschredderten Einwegpfandflaschen.',
	DAT_TAGESABSCHLUSS DATE NOT NULL COMMENT 'Tag_1 des Tagesabschlusses (Business date).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_LEERGUT_EINWEG_DAT_ABRECHNUNG primary key (MANDANT_ID, LEERGUTAUTOMAT_SCHLUESSEL_ID, DAT_RUECKNAHME, EINWEG_TYP_KZ, DATZEIT_VERARBEITUNG)
)COMMENT='Die Tabelle beinhaltet die Menge der geschredderten EINWEG Pfandflaschen. Sie betrifft nur Leergut Einweg. Daten kommen über ESB. Es werden immer die Daten geliefert, die \""gestern\"" verarbeitet worden sind. Inhalltlich sind das die Daten vom Vor-Vortag.'
;
