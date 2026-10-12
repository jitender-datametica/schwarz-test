CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.PMR_ANGEBOT_ART_WUP_ZU_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
ANGEBOT_ID INTEGER NOT NULL OPTIONS(description='Aus TableName wbs_werbeaenderungen_2 Offer/Angebot.'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
VERKAUFSORGANISATION_ID STRING(4) NOT NULL
OPTIONS(description='Organisatorische Einheit, die fuer den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
DAT_VON DATE OPTIONS(description='YYYY-MM_2-DD // Aktion_2 gueltig (von).'),
DAT_BIS DATE OPTIONS(description='YYYY-MM_2-DD // Aktion_2 gueltig (bis).'),
PREIS_AKTION NUMERIC(9,2) OPTIONS(description='Aktions-Verkaufspreis (Brutto).'),
PREIS_NORMAL NUMERIC(9,2) OPTIONS(description='Normal-Verkaufspreis (Brutto).'),
PREIS_NACHLASS_PERC NUMERIC(9,2) OPTIONS(description='Preisnachlass in %.'),
BESTAND_BME NUMERIC(18,3) OPTIONS(description='Marktbestand in BME.'),
MINDESTMENGE_BME NUMERIC(18,3) OPTIONS(description='Mindestmenge in BME.'),
MAXIMALMENGE_BME NUMERIC(18,3) OPTIONS(description='Maximalmenge in BME.'),
NIS_FG INTEGER OPTIONS(description='Flag: Sonstige Aenderung.'),
AKTION_ID STRING(20) OPTIONS(description='Aktionsnummer.'),
MASTERBONUS_FG INTEGER OPTIONS(description='Flag: Masterbonus.'),
GONDELKOPF_FG INTEGER OPTIONS(description='Flag: Gondelkopf.'),
TOPARTIKEL_FG INTEGER OPTIONS(description='Flag: Topartikel.'),
PMR_WERBETHEMA_ID STRING(6) OPTIONS(description='Werbethema ID.'),
PMR_WERBETHEMA_BESCHREIBUNG STRING(50) OPTIONS(description='Werbethemabeschreibung.'),
BONUSKAUF_ANREIZTYP STRING(4)
OPTIONS(description='Kundenkarte\"KDP\" = personalisiert,\"KDN\" = für alle Kundenkartenbesitzer.'),
BONUSKAUF_GESCHAEFTSVORFALL_ID STRING(2)
OPTIONS(description='BBY Geschaeftsvorfall z.B. Z04 (% Preisnachlass), es gibt derzeit 35 unterschiedliche.'),
BONUSKAUF_KONDITIONSART_ID STRING(4)
OPTIONS(description='Konditionsart, welche an der Kasse verwendet wird. Z.B. ZK01, ZK03.'),
BONUSKAUF_LIMIT INTEGER
OPTIONS(description='Bonuskaufrabattlimit. Wenn Limit = 3, dann koennen max. 3 Stueck eines Artikel_2 verguenstigt gekauft werden. Der 4. waere wieder Normalpreis.'),
BONUSKAUF_FG INTEGER OPTIONS(description='Kennzeichen: Bonuskauf-Aktion.'),
BONUSKAUF_BEDINGUNG_ID INTEGER OPTIONS(description='Bonuskauf Bedingung (Kauf / Bonus / Praemie).'),
BONUSKAUF_DIMENSION_ID STRING(10) OPTIONS(description='Bonuskauf Dimension (Produkt / Produktgruppe / Segment …).'),
BONUSKAUF_PRODUKTGRUPPENNAME STRING(100)
OPTIONS(description='Name der Produktgruppe (fasst Artikel_2 zusammen, welche zur gleichen Gruppe_2 gehoeren). Beispiel: Kaufe 1 Artikel_2 aus Produktgruppe „Getraenke“ und 1 Artikel_2 aus Produktgruppe „Snack“ und bekomme dafür 5 € Discount. Du kannst also anhand der Produktgruppe erkennen, welche Artikel_2 zur gleichen Gruppe_2 gehoeren.'),
BONUSKAUF_BONUSMENGE NUMERIC(18,3)
OPTIONS(description='Menge, die man im Bonus bekommt. Z.B. 2 ST (wenn man 2 ST kostenlos bekommt).'),
BONUSKAUF_KAUFMENGE NUMERIC(18,3) OPTIONS(description='Menge, die man kaufen muss, um den Bonus zu bekommen.'),
BONUSKAUF_MINDESTBETRAG NUMERIC(18,3)
OPTIONS(description='BBY_MIN_AMOUNT ist der Betrag, den der Kunde min. an der Kasse ausgeben muss um den Bonus zu bekommen.'),
BONUSKAUF_RABATTTYPE_ID STRING(10)
OPTIONS(description='Bonuskauf Rabatttyp (Normalpreis / Rabattpreis / Kostenlos / …).'),
BONUSKAUF_PRODUKTVARIANTE_ID INTEGER OPTIONS(description='Bonuskauf Produktvariante (Beliebig / Identisch / Andere).'),
BONUSKAUF_RABATT_PERC NUMERIC(18,3) OPTIONS(description='Kann % oder absolut sein, abhaengig von BBY_DISC_TYPE.'),
BONUSKAUF_RABATT_ZUORDNUNG_ID INTEGER
OPTIONS(description='Bonuskauf Rabattzuordnung (Alle Produkte / guenstigstes / teuerstes).'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
BONUSKAUF_PROMOTIONSTYP STRING(4) OPTIONS(description='Promotionstyp, expected entries e.g. 0001, 0005, ZAI, ZBBR.'),
PREIS_NIEDRIGSTER NUMERIC(29,2)
OPTIONS(description='Guenstigster / niedrigster Preis der letzten 30 Tage. Bezugspreis für die Preisvorteilermittlung im Rahmen der Preisangabenverordnung, PAngV.'),
PREIS_NIEDRIGSTER_DIFF_PERC NUMERIC(29,3)
OPTIONS(description='Prozentualer Unterschied/Preisvorteil (PV, manchmal auch Preisveraenderung) des jetztigen (Angebots-)Preises zum geringsten Preis der vergangenen 30 Tage.'),
OPV_MARKT_FG INTEGER
OPTIONS(description='Flag: Preisvorteil für Artikel_2 in den digitalen Kanälen (App, Web, Digital Signage) zu diesem Markt nicht anzeigen. 1 = kein PV anzeigen, 0 = es wird ein PV angezeigt. Eine_2 1 hier bedeutet, dass es in diesem Markt für den Artikel_2 in den vergangenen 30 Tagen einen niedrigeren Preisvorteil gab als den aktuell geplanten PV. Das bedeutet auch, dass dann in opv_prospekt_fg eine_2 1 gesetzt, womit alle zugehörigen Märkte im Leafletcluster betroffen sind. In allen physischen Märkten die zu diesem Leafletcluster gehören wird dann kein PV angezeigt. Ein Markt mit opv_prospekt_fg = 1 kann aber trotzdem hier eine_2 0 haben und ein PV in digitalen Kanälen angezeigt werden, wenn er in den letzten 30 Tagen keinen günstigeren PV hatte.'),
OPV_PROSPEKT_FG INTEGER
OPTIONS(description='Flag: Preisvorteil für Artikel_2 im Prospekt zu dem dieser Markt gehört nicht anzeigen. 1 = kein PV anzeigen, 0 = es wird ein PV angezeigt. Wird auf 1 gesetzt, wenn irgendein Markt im Leafletcluster in den vergangenen 30 Tagen einen niedrigeren Preis hatte als der aktuell geplante PV (opv_markt_fg = 1). Eine_2 1 hier bedeutet auch, dass in allen physischen Märkten in diesem Leafletcluster kein PV angezeigt wird. Ob sie aber in den digitalen Kanälen anzeigen können hängt von opv_markt_fg ab.'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
UTP_LIEFERANT_BESTAETIGT_FG INTEGER
OPTIONS(description='Flag, welches angibt, ob ein UTP-Lieferant die Werbebestellmenge freigegeben hat  (0 oder 1)'),
PREIS_NIEDRIGSTER_LOGIK_CD STRING(1)
OPTIONS(description='Der Buchstabe beschreibt, welche Berechnungslogik im SAP zur Ermittlung des günstigsten Preises (PREIS_NIEDRIGSTER und PREIS_NIEDRIGSTER_DIFF_PERC) verwendet wurde. Dies kann z.B. auf Basis der letzten 7 Tage oder letzten 30 Tage geschehen.'),
STIMMUNG_FG INTEGER
OPTIONS(description='Flag beschreibt, ob ein Artikel_2 mit einem stimmungsvollen Motiv im Leaflet abgebildet ist.'),
PREISHAMMER_FG INTEGER OPTIONS(description='Flag beschreibt, ob ein Artikel_2 einen besonders attraktiven Preis hat.'),
EK_ART_ID_REF INTEGER
OPTIONS(description='Artikelnummer des Produktes aus PMR, welches vom Einkäufer als Referenz vorgeschlagen wird. Sie entspricht dbp_data.art.kl_art_id.'),
PRIMARY KEY (MANDANT_ID, ANGEBOT_ID, ART_ID, NB_ID, VERKAUFSORGANISATION_ID, WUP_ID) NOT ENFORCED
) OPTIONS(description='ZPMR_EOP_SST_WBS_TTY/Funktionsbaustein Interface PMR to WBS Local Interface.');