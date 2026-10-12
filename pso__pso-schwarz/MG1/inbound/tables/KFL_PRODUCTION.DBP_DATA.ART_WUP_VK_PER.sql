create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_WUP_VK_PER cluster by (MANDANT_ID)(
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode\n            ',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen: 9999-12-31',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	VK_BRUTTO NUMBER(9,2) NOT NULL COMMENT 'Verkaufspreis brutto',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_VK_PER primary key (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT_VON)
)COMMENT='TP2_AIS - Verkaufspreise pro Markt. SAP-Quelle ist die Tabelle ZVKP'
;