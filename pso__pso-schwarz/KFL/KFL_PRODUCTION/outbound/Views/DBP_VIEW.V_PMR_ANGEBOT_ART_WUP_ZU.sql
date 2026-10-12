CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pmr_angebot_art_wup_zu (mandant_id
OPTIONS(description='Mandant im DWH.'), angebot_id
OPTIONS(description='Aus TableName wbs_werbeaenderungen Offer/Angebot.'), art_id
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
nb_id OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), wup_id
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), verkaufsorganisation_id
OPTIONS(description='Organisatorische Einheit, die fuer den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
dat_von OPTIONS(description='YYYY-MM-DD // Aktion gueltig (von).'), dat_bis
OPTIONS(description='YYYY-MM-DD // Aktion gueltig (bis).'), preis_aktion
OPTIONS(description='Aktions-Verkaufspreis (Brutto).'), preis_normal
OPTIONS(description='Normal-Verkaufspreis (Brutto).'), preis_nachlass_perc OPTIONS(description='Preisnachlass in %.'),
bestand_bme OPTIONS(description='Marktbestand in BME.'), mindestmenge_bme OPTIONS(description='Mindestmenge in BME.'),
maximalmenge_bme OPTIONS(description='Maximalmenge in BME.'), nis_fg OPTIONS(description='Flag: Sonstige Aenderung.'),
aktion_id OPTIONS(description='Aktionsnummer.'), masterbonus_fg OPTIONS(description='Flag: Masterbonus.'), gondelkopf_fg
OPTIONS(description='Flag: Gondelkopf.'), topartikel_fg OPTIONS(description='Flag: Topartikel.'), pmr_werbethema_id
OPTIONS(description='Werbethema ID.'), pmr_werbethema_beschreibung OPTIONS(description='Werbethemabeschreibung.'),
bonuskauf_anreiztyp OPTIONS(description='Kundenkarte "KDP" = personalisiert, "KDN" = für alle Kundenkartenbesitzer.'),
bonuskauf_geschaeftsvorfall_id
OPTIONS(description='BBY Geschaeftsvorfall z.B. Z04 (% Preisnachlass), es gibt derzeit 35 unterschiedliche.'),
bonuskauf_konditionsart_id OPTIONS(description='Konditionsart, welche an der Kasse verwendet wird. Z.B. ZK01, ZK03.'),
bonuskauf_limit
OPTIONS(description='Bonuskaufrabattlimit. Wenn Limit = 3, dann koennen max. 3 Stueck eines Artikel verguenstigt gekauft werden. Der 4. waere wieder Normalpreis.'),
bonuskauf_fg OPTIONS(description='Kennzeichen: Bonuskauf-Aktion.'), bonuskauf_bedingung_id
OPTIONS(description='Bonuskauf Bedingung (Kauf / Bonus / Praemie).'), bonuskauf_dimension_id
OPTIONS(description='Bonuskauf Dimension (Produkt / Produktgruppe / Segment …).'), bonuskauf_produktgruppenname
OPTIONS(description='Name der Produktgruppe (fasst Artikel zusammen, welche zur gleichen Gruppe gehoeren). Beispiel: Kaufe 1 Artikel aus Produktgruppe „Getraenke“ und 1 Artikel aus Produktgruppe „Snack“ und bekomme dafür 5 € Discount. Du kannst also anhand der Produktgruppe erkennen, welche Artikel zur gleichen Gruppe gehoeren.'),
bonuskauf_bonusmenge
OPTIONS(description='Menge, die man im Bonus bekommt. Z.B. 2 ST (wenn man 2 ST kostenlos bekommt).'),
bonuskauf_kaufmenge OPTIONS(description='Menge, die man kaufen muss, um den Bonus zu bekommen.'),
bonuskauf_mindestbetrag
OPTIONS(description='BBY_MIN_AMOUNT ist der Betrag, den der Kunde min. an der Kasse ausgeben muss um den Bonus zu bekommen.'),
bonuskauf_rabatttype_id OPTIONS(description='Bonuskauf Rabatttyp (Normalpreis / Rabattpreis / Kostenlos / …).'),
bonuskauf_produktvariante_id OPTIONS(description='Bonuskauf Produktvariante (Beliebig / Identisch / Andere).'),
bonuskauf_rabatt_perc OPTIONS(description='Kann % oder absolut sein, abhaengig von BBY_DISC_TYPE.'),
bonuskauf_rabatt_zuordnung_id
OPTIONS(description='Bonuskauf Rabattzuordnung (Alle Produkte / guenstigstes / teuerstes).'), bonuskauf_promotionstyp
OPTIONS(description='Promotionstyp, expected entries e.g. 0001, 0005, ZAI, ZBBR.'), preis_niedrigster
OPTIONS(description='Guenstigster / niedrigster Preis der letzten 30 Tage. Bezugspreis für die Preisvorteilermittlung im Rahmen der Preisangabenverordnung, PAngV.'),
preis_niedrigster_diff_perc
OPTIONS(description='Prozentualer Unterschied/Preisvorteil (PV, manchmal auch Preisveraenderung) des jetztigen (Angebots-)Preises zum geringsten Preis der vergangenen 30 Tage.'),
opv_markt_fg
OPTIONS(description='Flag: Preisvorteil für Artikel in den digitalen Kanälen (App, Web, Digital Signage) zu diesem Markt nicht anzeigen. 1 = kein PV anzeigen, 0 = es wird ein PV angezeigt. Eine 1 hier bedeutet, dass es in diesem Markt für den Artikel in den vergangenen 30 Tagen einen niedrigeren Preisvorteil gab als den aktuell geplanten PV. Das bedeutet auch, dass dann in opv_prospekt_fg eine 1 gesetzt, womit alle zugehörigen Märkte im Leafletcluster betroffen sind. In allen physischen Märkten die zu diesem Leafletcluster gehören wird dann kein PV angezeigt. Ein Markt mit opv_prospekt_fg = 1 kann aber trotzdem hier eine 0 haben und ein PV in digitalen Kanälen angezeigt werden, wenn er in den letzten 30 Tagen keinen günstigeren PV hatte.'),
opv_prospekt_fg
OPTIONS(description='Flag: Preisvorteil für Artikel im Prospekt zu dem dieser Markt gehört nicht anzeigen. 1 = kein PV anzeigen, 0 = es wird ein PV angezeigt. Wird auf 1 gesetzt, wenn irgendein Markt im Leafletcluster in den vergangenen 30 Tagen einen niedrigeren Preis hatte als der aktuell geplante PV (opv_markt_fg = 1). Eine 1 hier bedeutet auch, dass in allen physischen Märkten in diesem Leafletcluster kein PV angezeigt wird. Ob sie aber in den digitalen Kanälen anzeigen können hängt von opv_markt_fg ab.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), utp_lieferant_bestaetigt_fg
OPTIONS(description='Flag, welches angibt, ob ein UTP-Lieferant die Werbebestellmenge freigegeben hat  (0 oder 1)'),
preis_niedrigster_logik_cd
OPTIONS(description='Der Buchstabe beschreibt, welche Berechnungslogik im SAP zur Ermittlung des günstigsten Preises (PREIS_NIEDRIGSTER und PREIS_NIEDRIGSTER_DIFF_PERC) verwendet wurde. Dies kann z.B. auf Basis der letzten 7 Tage oder letzten 30 Tage geschehen.'),
stimmung_fg
OPTIONS(description='Flag beschreibt, ob ein Artikel mit einem stimmungsvollen Motiv im Leaflet abgebildet ist.'),
preishammer_fg OPTIONS(description='Flag beschreibt, ob ein Artikel einen besonders attraktiven Preis hat.'),
ek_art_id_ref
OPTIONS(description='Artikelnummer des Produktes aus PMR, welches vom Einkäufer als Referenz vorgeschlagen wird. Sie entspricht dbp_data.art.kl_art_id.'))
OPTIONS(DESCRIPTION = `ZPMR_EOP_SST_WBS_TTY/FUNKTIONSBAUSTEIN INTERFACE PMR TO WBS LOCAL INTERFACE.`) AS SELECT
 mandant_id,
 angebot_id,
 art_id,
 nb_id,
 wup_id,
 verkaufsorganisation_id,
 dat_von,
 dat_bis,
 preis_aktion,
 preis_normal,
 preis_nachlass_perc,
 bestand_bme,
 mindestmenge_bme,
 maximalmenge_bme,
 nis_fg,
 aktion_id,
 masterbonus_fg,
 gondelkopf_fg,
 topartikel_fg,
 pmr_werbethema_id,
 pmr_werbethema_beschreibung,
 bonuskauf_anreiztyp,
 bonuskauf_geschaeftsvorfall_id,
 bonuskauf_konditionsart_id,
 bonuskauf_limit,
 bonuskauf_fg,
 bonuskauf_bedingung_id,
 bonuskauf_dimension_id,
 bonuskauf_produktgruppenname,
 bonuskauf_bonusmenge,
 bonuskauf_kaufmenge,
 bonuskauf_mindestbetrag,
 bonuskauf_rabatttype_id,
 bonuskauf_produktvariante_id,
 bonuskauf_rabatt_perc,
 bonuskauf_rabatt_zuordnung_id,
 bonuskauf_promotionstyp,
 preis_niedrigster,
 preis_niedrigster_diff_perc,
 opv_markt_fg,
 opv_prospekt_fg,
 wrg_id,
 utp_lieferant_bestaetigt_fg,
 preis_niedrigster_logik_cd,
 stimmung_fg,
 preishammer_fg,
 ek_art_id_ref
FROM kfl_production_dbp_data.pmr_angebot_art_wup_zu;