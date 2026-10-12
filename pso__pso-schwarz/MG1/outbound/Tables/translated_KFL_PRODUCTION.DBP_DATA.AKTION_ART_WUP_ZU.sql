DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.AKTION_ART_WUP_ZU;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.AKTION_ART_WUP_ZU (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
AKTION_ID STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Quelle wale.aktnr.'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel-ID einschliesslich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
BEWART_ID INTEGER NOT NULL
OPTIONS(description='Bewegungsart-ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter-WUP-ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
VK_AKTION_BRUTTO NUMERIC(9,2) NOT NULL OPTIONS(description='Aktionsverkaufspreis brutto.'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
BEZUGSWEG_ID INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1).'),
GRUND_SPERRUNG STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichnet die Sperrung eines Artikels in der Aktion. Wertevorrat: A = Lieferschwierigkeiten, B = Beschaffung unklar, C = Artikel schadhaft, D = sonstiges, X = gesperrt (nur in KMO).'),
DAT_SPERRUNG DATE OPTIONS(description='Datum, zu dem ein Artikel gesperrt wurde.'),
AKTION_THEMA_ID STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Aktionsthema aus der SAP Tabelle WAKP.'),
VK_VOR_AKTION_BRUTTO NUMERIC(9,2)
OPTIONS(description='Letzter Verkaufspreis vor der Aktion - wird für alle Mandanten außer Mandant 1 gefüllt.'),
VOR_AKTION_WRG_ID STRING(3)
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Für Abweichung der Währung, wie z.B. Währungsumstellung Kroatien.'),
DAT_PREISAKTIVIERT DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Datum der Aktionspreisaktivierung.'),
GELOESCHT_SAP_FG INTEGER OPTIONS(description='Flag: Aktionsartikel gelöscht in SAP.'),
DAT_GELOESCHT_SAP DATE OPTIONS(description='Datum der Löschung.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID, BEWART_ID, WUP_ID, NB_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID
OPTIONS(description='AIS - Positionen der zentralen Aktionen. Zuordnung Artikel Aktion Filiale.');