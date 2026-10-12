create or replace TABLE KFL_PRODUCTION.DBP_DATA.AKTION_ART_WUP_ZU_1 cluster by (MANDANT_ID)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	AKTION_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennung einer Aktion_1 aus der Quelle wale.aktnr.',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1-ID einschliesslich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
	BEWART_ID NUMBER(38,0) NOT NULL COMMENT 'Bewegungsart-ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter-WUP_1-ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	VK_AKTION_BRUTTO NUMBER(9,2) NOT NULL COMMENT 'Aktionsverkaufspreis brutto.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
	BEZUGSWEG_ID NUMBER(38,0) NOT NULL COMMENT 'Kennzeichnet, ob der Artikel_1 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1).',
	GRUND_SPERRUNG VARCHAR(1) COLLATE 'en-ci' COMMENT 'Kennzeichnet die Sperrung eines Artikels in der Aktion. Wertevorrat: A = Lieferschwierigkeiten, B = Beschaffung unklar, C = Artikel_1 schadhaft, D = sonstiges, X = gesperrt (nur in KMO).',
	DAT_SPERRUNG DATE COMMENT 'Datum, zu dem ein Artikel_1 gesperrt wurde.',
	AKTION_THEMA_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Aktionsthema aus der SAP Tabelle WAKP.',
	VK_VOR_AKTION_BRUTTO NUMBER(9,2) COMMENT 'Letzter Verkaufspreis vor der Aktion_1 - wird für alle Mandanten außer Mandant_1 1 gefüllt.',
	VOR_AKTION_WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Für Abweichung der Währung, wie z.B. Währungsumstellung Kroatien.',
	DAT_PREISAKTIVIERT DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum der Aktionspreisaktivierung.',
	GELOESCHT_SAP_FG NUMBER(38,0) COMMENT 'Flag: Aktionsartikel gelöscht in SAP.',
	DAT_GELOESCHT_SAP DATE COMMENT 'Datum der Löschung.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AKTION_ART_WUP_ZU primary key (MANDANT_ID, AKTION_ID, ART_ID, BEWART_ID, WUP_ID, NB_ID)
)COMMENT='AIS - Positionen der zentralen Aktionen. Zuordnung Artikel_1 Aktion_1 Filiale.'
;