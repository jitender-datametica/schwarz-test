create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_LIST_WUP_ZU_PER_1 cluster by (mandant_id)(
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT_BIS DATE NOT NULL COMMENT 'Ende des Gültigkeitszeitraums',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	LIST_QUELLE_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine_1 Lookup-Tabelle existiert im DWH nicht.',
	STRUKTUR_ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel_1 ist. Falls es sich bei dem Artikel_1 nicht um einen strukturierten Artikel_1 handelt, ist die Artikel_1 ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine_1 kl_art_id rein!',
	BAUSTEIN_ID NUMBER(18,0) NOT NULL COMMENT 'ID eines Sortimentsbausteins',
	DAT_VON DATE NOT NULL COMMENT 'Datum wann ein Artikel_1 zum ersten Mal in einem Markt gelistet ist',
	LIST_SAP_ID NUMBER(38,0) NOT NULL COMMENT 'in SAP zusammen mit Markt / Artikel_1 / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	LIST_KOMPONENTE_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.',
	constraint PK_ART_LIST_WUP_ZU_PER primary key (ART_ID, WUP_ID, NB_ID, MANDANT_ID, LIST_QUELLE_ID, STRUKTUR_ART_ID, DAT_VON)
)COMMENT='TP2/7 AIS - Zuordnung Artikel_1 zu Listung, Baustein und Wup_1 - MULTISET. Enthält Informationen, aus welchen Listungsquellen Artikel_1 und Markt zugeordnet sind, d.h. welcher Artikel_1 in welchem Markt in den jeweiligen Bausteinen gelistet ist.'
;