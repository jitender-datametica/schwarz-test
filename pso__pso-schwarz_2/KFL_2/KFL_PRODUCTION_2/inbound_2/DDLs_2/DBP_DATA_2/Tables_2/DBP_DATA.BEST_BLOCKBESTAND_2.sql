create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BEST_BLOCKBESTAND_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	BEST_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'Belegnummer des Einkaufsbelegs',
	BEST_BELEG_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Positionsnummer des Einkaufsbelegs',
	PROZESS_ID NUMBER(38,0) NOT NULL COMMENT 'Prozessschlüssel',
	WUP_ID NUMBER(38,0) COMMENT 'Der \""WUP_2\"" beinhaltet Märkte und Läger. WUP_2=WarenUmschlagsPlatz. Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) COMMENT 'Nebenbetrieb. Im bisherigen System die 4 Stelle der Marktnummer',
	ART_ID NUMBER(38,0) COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	MENGE_BLOCK NUMBER(13,3) COMMENT 'Gesperrter Bestand',
	MENGE_BLOCK_WE NUMBER(13,3) COMMENT 'WE-Sperrbestand in Bestell-ME',
	DAT_BEST_BELEG DATE COMMENT 'Datum des Bestellbelegs',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BEST_BLOCKBESTAND primary key (MANDANT_ID, BEST_BELEG_ID, BEST_BELEG_POS_ID, PROZESS_ID)
)COMMENT='Contains block stocks at the order item_2 level from ZEK_BLOCKBEST_PO'
;
