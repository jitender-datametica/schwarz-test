create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ART_WUP_ZU_PER_1 cluster by (MANDANT_ID)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT '\""Der \""\""WUP_1\""\"" beinhaltet Märkte und Läger. WUP_1=WarenUmschlagsPlatz\n            \n            Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum\n            ',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT_VON DATE NOT NULL COMMENT 'Datum wann ein Artikel_1 zum ersten Mal in einem Markt gelistet ist',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	BEZUGSWEG_ID NUMBER(38,0) COMMENT 'Kennzeichnet, ob der Artikel_1 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
	LISTUNG_ID NUMBER(38,0) COMMENT 'kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per_1 eigentlich obsolet',
	VK_BRUTTO NUMBER(9,3),
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT\n            ',
	KDIS NUMBER(38,0) COMMENT 'kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel_1 ist über den normalen Weg bestellbar, 1: der Artikel_1 wird  zugeteilt',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' DEFAULT 'EUR' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_ZU_PER primary key (MANDANT_ID, WUP_ID, NB_ID, DAT_VON, ART_ID)
)COMMENT='TP2 AIS - Artikel_1-Markt-Zuordnung - MULTISET\t\n             Enthält Informationen, wie Artikel_1 den Märkten zugeordnet sind, u.a. Listung, Bezugsweg und Normal-Verkaufspreise. Keine Information über Sonderaktionen enthalten'
;
