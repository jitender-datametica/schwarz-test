create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.UDF_PROGNOSE cluster by (
     MANDANT_ID,
     DAT_PROGNOSELAUF,
     DAT 
)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
	DIAGNOSE_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Diagnoseidentifikator (Regelwerk für die Prognose).',
	DAT_PROGNOSELAUF DATE NOT NULL COMMENT 'Datum des Prognoselaufs (ENTRY_DATE).',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT.',
	PROGNOSE_HORIZONT NUMBER(38,0) NOT NULL COMMENT 'Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von QUANTITY_01 - bis QUANTITY_80 waren gefüllt).',
	MENGE_PROGNOSE_AF NUMBER(13,3) DEFAULT 0 COMMENT 'Aktionsfreier Bedarf in Basismengeneinheit.',
	MENGE_PROGNOSE_SA NUMBER(13,3) DEFAULT 0 COMMENT 'Werbebedarf in Basismengeneinheit.',
	MENGE_PROGNOSE_GESTEUERT NUMBER(13,3) DEFAULT 0 COMMENT 'Manuell gesteuerte Prognose in Basismengeneinheit.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	PROGNOSE_TRENNUNG_CD VARCHAR(3) COMMENT 'Eindeutige Kennzeichnung der übergeordneten Trennung der Prognosen auf Markt/Artikel/Tag-Ebene. Sie dient der Unterscheidung zwischen ungesteuerten und gesteuerten Prognosen, die aus PMR-Daten ermittelt und während der Beladung angereichert werden. Mögliche Werte sind AF (Aktionsfrei), SA (Sonderaktion) oder BBY (Bonusbuy/K-Card). Dies ist relevant, da zukünftig die Prognosetrennung nicht mehr über Angebots-IDs in SAP erfolgt, sondern über diese Attribut-Logik im DWH abgebildet wird.',
	PROGNOSE_FEINGLIEDERUNG_ID NUMBER(38,0) COMMENT 'Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel/Tag-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:\n            -1= nicht definiert\n            1= Nur Prospekt\n            2= Prospekt + K-Card\n            3= KDN-only\n            4= KDP-only\n            5= BBY KMO\n            6= Prospekt + BBY KMO',
	constraint PK_UDF_PROGNOSE primary key (MANDANT_ID, WUP_ID, NB_ID, ART_ID, DIAGNOSE_ID, DAT_PROGNOSELAUF, DAT)
)COMMENT='SCM - Prognosewerte aus SAP UDF - Transparente Tabelle ZUDF_TS_DWH.\n             Die Tabelle UDF_PROGNOSE enthält die durch das SAP-Quellsystem UDF berechneten Abverkaufsprognosen aller prognoserelevanten Artikel-Markt-Tag-Kombinationen.\n             Die Prognoserelevanz definiert sich dabei über bestimmte Stammdaten-Konstellationen (wie z.B. Dispomerkmal und Postenkennzeichen).\n             Die Prognosen werden mit jedem Prognoselauf (dat_prognoselauf) neu berechnet und stehen für einen Gültigkeitstag (dat) dadurch mehrfach zur Verfügung – hierbei wird stets der Wert für den aktuellsten Gültigkeitstag (dat) für die Ermittlung der Autodispo-Bestellmengen verwendet. Die Prognosen liegen sowohl für den aktionsfreien Bedarf (menge_prognose_af) als auch für den Werbebedarf (menge_prognose_sa) sowie inklusive manueller Prognosesteuerungen (menge_prognose_gesteuert) vor.'
;
