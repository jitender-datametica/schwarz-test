create or replace TABLE KFL_PRODUCTION.DBP_DATA.FLW_PRUEF_LOS_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
	PRUEFLOS_ID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige Prüflosnummer aus prueflos',
	BEST_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'Belegnummer des Einkaufsbelegs aus ebeln',
	BEST_BELEG_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Belegposition des Einkaufsbelegs aus ebelp',
	WERK_ID NUMBER(38,0) NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
	FLW_ART_ID NUMBER(38,0) NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
	HERKUNFT NUMBER(38,0) NOT NULL COMMENT 'Stelle im Produktionsprozess, an der das Prüflos entnommen wurde aus herkunft. Keine Lookup-Tabelle vorhanden',
	FLW_LIEF_ID NUMBER(38,0) NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
	PRUEFART_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Die Prüfart ist z.Bsp 01 = Eingangsprüfung beim WE zur Bestellung aus art_2',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_FLW_PRUEF_LOS primary key (MANDANT_ID, PRUEFLOS_ID)
)COMMENT='FLW - Prüflossatz aus der Quelltabelle qals'
;