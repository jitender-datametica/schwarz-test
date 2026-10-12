--==============================================================
-- Table: pmr_angebot_art_wup_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: pmr_angebot_art_wup_zu_1
   generated from Powerdesigner on Dienstag, 26. November 2024 10:54:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pmr_angebot_art_wup_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
angebot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Aus TableName wbs_werbeaenderungen_1 Offer/Angebot.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
verkaufsorganisation_id STRING(4) NOT NULL
OPTIONS(description='Organisatorische Einheit, die fuer den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
dat_von DATE OPTIONS(description='YYYY-MM_1-DD // Aktion_1 gueltig (von).'),
dat_bis DATE OPTIONS(description='YYYY-MM_1-DD // Aktion_1 gueltig (bis).'),
preis_aktion NUMERIC(9,2) OPTIONS(description='Aktions-Verkaufspreis (Brutto).'),
preis_normal NUMERIC(9,2) OPTIONS(description='Normal-Verkaufspreis (Brutto).'),
preis_nachlass_perc NUMERIC(9,2) OPTIONS(description='Preisnachlass in %.'),
bestand_bme NUMERIC(18,3) OPTIONS(description='Marktbestand in BME.'),
mindestmenge_bme NUMERIC(18,3) OPTIONS(description='Mindestmenge in BME.'),
maximalmenge_bme NUMERIC(18,3) OPTIONS(description='Maximalmenge in BME.'),
nis_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Sonstige Aenderung.'),
aktion_id STRING(20) OPTIONS(description='Aktionsnummer.'),
masterbonus_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Masterbonus.'),
gondelkopf_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Gondelkopf.'),
topartikel_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Topartikel.'),
pmr_werbethema_id STRING(6) OPTIONS(description='Werbethema ID.'),
pmr_werbethema_beschreibung STRING(50) OPTIONS(description='Werbethemabeschreibung.'),
bonuskauf_anreiztyp STRING(4)
OPTIONS(description='Kundenkarte "KDP" = personalisiert, "KDN" = für alle Kundenkartenbesitzer.'),
bonuskauf_geschaeftsvorfall_id STRING(2)
OPTIONS(description='BBY Geschaeftsvorfall z.B. Z04 (% Preisnachlass), es gibt derzeit 35 unterschiedliche.'),
bonuskauf_konditionsart_id STRING(4)
OPTIONS(description='Konditionsart, welche an der Kasse verwendet wird. Z.B. ZK01, ZK03.'),
bonuskauf_limit BIGNUMERIC(38,0)
OPTIONS(description='Bonuskaufrabattlimit. Wenn Limit = 3, dann koennen max. 3 Stueck eines Artikel_1 verguenstigt gekauft werden. Der 4. waere wieder Normalpreis.'),
bonuskauf_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen: Bonuskauf-Aktion.'),
bonuskauf_bedingung_id BIGNUMERIC(38,0) OPTIONS(description='Bonuskauf Bedingung (Kauf / Bonus / Praemie).'),
bonuskauf_dimension_id STRING(10) OPTIONS(description='Bonuskauf Dimension (Produkt / Produktgruppe / Segment …).'),
bonuskauf_produktgruppenname STRING(100)
OPTIONS(description='Name der Produktgruppe (fasst Artikel_1 zusammen, welche zur gleichen Gruppe_1 gehoeren). Beispiel: Kaufe 1 Artikel_1 aus Produktgruppe „Getraenke“ und 1 Artikel_1 aus Produktgruppe „Snack“ und bekomme dafür 5 € Discount. Du kannst also anhand der Produktgruppe erkennen, welche Artikel_1 zur gleichen Gruppe_1 gehoeren.'),
bonuskauf_bonusmenge NUMERIC(18,3)
OPTIONS(description='Menge, die man im Bonus bekommt. Z.B. 2 ST (wenn man 2 ST kostenlos bekommt).'),
bonuskauf_kaufmenge NUMERIC(18,3) OPTIONS(description='Menge, die man kaufen muss, um den Bonus zu bekommen.'),
bonuskauf_mindestbetrag NUMERIC(18,3)
OPTIONS(description='BBY_MIN_AMOUNT ist der Betrag, den der Kunde min. an der Kasse ausgeben muss um den Bonus zu bekommen.'),
bonuskauf_rabatttype_id STRING(10)
OPTIONS(description='Bonuskauf Rabatttyp (Normalpreis / Rabattpreis / Kostenlos / …).'),
bonuskauf_produktvariante_id BIGNUMERIC(38,0)
OPTIONS(description='Bonuskauf Produktvariante (Beliebig / Identisch / Andere).'),
bonuskauf_rabatt_perc NUMERIC(18,3) OPTIONS(description='Kann % oder absolut sein, abhaengig von BBY_DISC_TYPE.'),
bonuskauf_rabatt_zuordnung_id BIGNUMERIC(38,0)
OPTIONS(description='Bonuskauf Rabattzuordnung (Alle Produkte / guenstigstes / teuerstes).'),
bonuskauf_promotionstyp STRING(4) OPTIONS(description='Promotionstyp, expected entries e.g. 0001, 0005, ZAI, ZBBR.'),
preis_niedrigster BIGNUMERIC(38,2)
OPTIONS(description='Guenstigster / niedrigster Preis der letzten 30 Tage. Bezugspreis für die Preisvorteilermittlung im Rahmen der Preisangabenverordnung, PAngV.'),
preis_niedrigster_diff_perc BIGNUMERIC(38,3)
OPTIONS(description='Prozentualer Unterschied/Preisvorteil (PV, manchmal auch Preisveraenderung) des jetztigen (Angebots-)Preises zum geringsten Preis der vergangenen 30 Tage.'),
opv_markt_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Preisvorteil für Artikel_1 in den digitalen Kanälen (App, Web, Digital Signage) zu diesem Markt nicht anzeigen. 1 = kein PV anzeigen, 0 = es wird ein PV angezeigt. Eine_1 1 hier bedeutet, dass es in diesem Markt für den Artikel_1 in den vergangenen 30 Tagen einen niedrigeren Preisvorteil gab als den aktuell geplanten PV. Das bedeutet auch, dass dann in opv_prospekt_fg eine_1 1 gesetzt, womit alle zugehörigen Märkte im Leafletcluster betroffen sind. In allen physischen Märkten die zu diesem Leafletcluster gehören wird dann kein PV angezeigt. Ein Markt mit opv_prospekt_fg = 1 kann aber trotzdem hier eine_1 0 haben und ein PV in digitalen Kanälen angezeigt werden, wenn er in den letzten 30 Tagen keinen günstigeren PV hatte.'),
opv_prospekt_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Preisvorteil für Artikel_1 im Prospekt zu dem dieser Markt gehört nicht anzeigen. 1 = kein PV anzeigen, 0 = es wird ein PV angezeigt. Wird auf 1 gesetzt, wenn irgendein Markt im Leafletcluster in den vergangenen 30 Tagen einen niedrigeren Preis hatte als der aktuell geplante PV (opv_markt_fg = 1). Eine_1 1 hier bedeutet auch, dass in allen physischen Märkten in diesem Leafletcluster kein PV angezeigt wird. Ob sie aber in den digitalen Kanälen anzeigen können hängt von opv_markt_fg ab.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
utp_lieferant_bestaetigt_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag, welches angibt, ob ein UTP-Lieferant die Werbebestellmenge freigegeben hat  (0 oder 1)'),
preis_niedrigster_logik_cd STRING(1)
OPTIONS(description='Der Buchstabe beschreibt, welche Berechnungslogik im SAP zur Ermittlung des günstigsten Preises (PREIS_NIEDRIGSTER und PREIS_NIEDRIGSTER_DIFF_PERC) verwendet wurde. Dies kann z.B. auf Basis der letzten 7 Tage oder letzten 30 Tage geschehen.'),
stimmung_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag beschreibt, ob ein Artikel_1 mit einem stimmungsvollen Motiv im Leaflet abgebildet ist.'),
preishammer_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag beschreibt, ob ein Artikel_1 einen besonders attraktiven Preis hat.'),
ek_art_id_ref BIGNUMERIC(38,0)
OPTIONS(description='Artikelnummer des Produktes aus PMR, welches vom Einkäufer als Referenz vorgeschlagen wird. Sie entspricht dbp_data.art.kl_art_id.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_id, art_id, nb_id, verkaufsorganisation_id, wup_id) NOT ENFORCED
) OPTIONS(description='ZPMR_EOP_SST_WBS_TTY/Funktionsbaustein Interface PMR to WBS Local Interface.');