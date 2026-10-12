--==============================================================
-- Table: aktion_art_wup_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_art_wup_zu
   generated from Powerdesigner on Montag, 31. Oktober 2022 14:06:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktion_art_wup_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Quelle wale.aktnr.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel-ID einschliesslich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart-ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter-WUP-ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
vk_aktion_brutto NUMERIC(9,2) NOT NULL OPTIONS(description='Aktionsverkaufspreis brutto.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
bezugsweg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1).'),
grund_sperrung STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichnet die Sperrung eines Artikels in der Aktion. Wertevorrat: A = Lieferschwierigkeiten, B = Beschaffung unklar, C = Artikel schadhaft, D = sonstiges, X = gesperrt (nur in KMO).'),
dat_sperrung DATE OPTIONS(description='Datum, zu dem ein Artikel gesperrt wurde.'),
aktion_thema_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Aktionsthema aus der SAP Tabelle WAKP.'),
vk_vor_aktion_brutto NUMERIC(9,2)
OPTIONS(description='Letzter Verkaufspreis vor der Aktion - wird für alle Mandanten außer Mandant 1 gefüllt.'),
vor_aktion_wrg_id STRING(3)
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Für Abweichung der Währung, wie z.B. Währungsumstellung Kroatien.'),
dat_preisaktiviert DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Datum der Aktionspreisaktivierung.'),
geloescht_sap_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Aktionsartikel gelöscht in SAP.'),
dat_geloescht_sap DATE OPTIONS(description='Datum der Löschung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, bewart_id, wup_id, nb_id) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='AIS - Positionen der zentralen Aktionen. Zuordnung Artikel Aktion Filiale.');