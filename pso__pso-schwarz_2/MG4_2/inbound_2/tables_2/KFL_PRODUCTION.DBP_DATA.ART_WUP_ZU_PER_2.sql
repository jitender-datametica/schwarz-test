create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_WUP_ZU_PER_2 cluster by (MANDANT_ID)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT '\"Der \"\"WUP_2\"\" beinhaltet Märkte und Läger. WUP_2=WarenUmschlagsPlatz\n            \n            Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum\n            ',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT_VON DATE NOT NULL COMMENT 'Datum wann ein Artikel_2 zum ersten Mal in einem Markt gelistet ist',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	BEZUGSWEG_ID NUMBER(38,0) COMMENT 'Kennzeichnet, ob der Artikel_2 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
	LISTUNG_ID NUMBER(38,0) COMMENT 'kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per_2 eigentlich obsolet',
	VK_BRUTTO NUMBER(9,3),
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT\n            ',
	KDIS NUMBER(38,0) COMMENT 'kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel_2 ist über den normalen Weg bestellbar, 1: der Artikel_2 wird  zugeteilt',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' DEFAULT 'EUR' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_ZU_PER primary key (MANDANT_ID, WUP_ID, NB_ID, DAT_VON, ART_ID)
)COMMENT='TP2 AIS - Artikel_2-Markt-Zuordnung - MULTISET\t\n             Enthält Informationen, wie Artikel_2 den Märkten zugeordnet sind, u.a. Listung, Bezugsweg und Normal-Verkaufspreise. Keine Information über Sonderaktionen enthalten'
;