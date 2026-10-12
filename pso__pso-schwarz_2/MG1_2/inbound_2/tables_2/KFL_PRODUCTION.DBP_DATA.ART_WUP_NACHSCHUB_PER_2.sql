create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_WUP_NACHSCHUB_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT_VON DATE NOT NULL COMMENT 'Datum gültig ab -  im Format JJJJ-MM_2-TT',
	DAT_BIS DATE COMMENT 'Datum gültig bis - m Format JJJJ-MM_2-TT',
	MENGE_BESTAND_SOLL_MAX NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'Maximaler Sollbestand (PRWOG)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_NACHSCHUB_PER primary key (MANDANT_ID, ART_ID, WUP_ID, NB_ID, DAT_VON)
)COMMENT='LIS - Nachschub: Mengen pro Kunde/Artikel_2 (tagesaktuell) - SAP RET - Tabelle WRPL'
;