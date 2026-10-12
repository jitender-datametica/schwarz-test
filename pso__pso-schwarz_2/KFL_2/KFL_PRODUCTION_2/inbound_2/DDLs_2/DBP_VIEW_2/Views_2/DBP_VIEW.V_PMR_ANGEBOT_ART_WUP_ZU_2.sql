CREATE OR REPLACE VIEW DBP_VIEW.V_PMR_ANGEBOT_ART_WUP_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,angebot_id                               COMMENT 'Aus TableName wbs_werbeaenderungen_2 Offer/Angebot.'
  ,art_id                                   COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'
  ,wup_id                                   COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'
  ,verkaufsorganisation_id                  COMMENT 'Organisatorische Einheit, die fuer den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'
  ,dat_von                                  COMMENT 'YYYY-MM_2-DD // Aktion_2 gueltig (von).'
  ,dat_bis                                  COMMENT 'YYYY-MM_2-DD // Aktion_2 gueltig (bis).'
  ,preis_aktion                             COMMENT 'Aktions-Verkaufspreis (Brutto).'
  ,preis_normal                             COMMENT 'Normal-Verkaufspreis (Brutto).'
  ,preis_nachlass_perc                      COMMENT 'Preisnachlass in %.'
  ,bestand_bme                              COMMENT 'Marktbestand in BME.'
  ,mindestmenge_bme                         COMMENT 'Mindestmenge in BME.'
  ,maximalmenge_bme                         COMMENT 'Maximalmenge in BME.'
  ,nis_fg                                   COMMENT 'Flag: Sonstige Aenderung.'
  ,aktion_id                                COMMENT 'Aktionsnummer.'
  ,masterbonus_fg                           COMMENT 'Flag: Masterbonus.'
  ,gondelkopf_fg                            COMMENT 'Flag: Gondelkopf.'
  ,topartikel_fg                            COMMENT 'Flag: Topartikel.'
  ,pmr_werbethema_id                        COMMENT 'Werbethema ID.'
  ,pmr_werbethema_beschreibung              COMMENT 'Werbethemabeschreibung.'
  ,bonuskauf_anreiztyp                      COMMENT 'Kundenkarte "KDP" = personalisiert, "KDN" = für alle Kundenkartenbesitzer.'
  ,bonuskauf_geschaeftsvorfall_id           COMMENT 'BBY Geschaeftsvorfall z.B. Z04 (% Preisnachlass), es gibt derzeit 35 unterschiedliche.'
  ,bonuskauf_konditionsart_id               COMMENT 'Konditionsart, welche an der Kasse verwendet wird. Z.B. ZK01, ZK03.'
  ,bonuskauf_limit                          COMMENT 'Bonuskaufrabattlimit. Wenn Limit = 3, dann koennen max. 3 Stueck eines Artikel_2 verguenstigt gekauft werden. Der 4. waere wieder Normalpreis.'
  ,bonuskauf_fg                             COMMENT 'Kennzeichen: Bonuskauf-Aktion.'
  ,bonuskauf_bedingung_id                   COMMENT 'Bonuskauf Bedingung (Kauf / Bonus / Praemie).'
  ,bonuskauf_dimension_id                   COMMENT 'Bonuskauf Dimension (Produkt / Produktgruppe / Segment …).'
  ,bonuskauf_produktgruppenname             COMMENT 'Name der Produktgruppe (fasst Artikel_2 zusammen, welche zur gleichen Gruppe_2 gehoeren). Beispiel: Kaufe 1 Artikel_2 aus Produktgruppe „Getraenke“ und 1 Artikel_2 aus Produktgruppe „Snack“ und bekomme dafür 5 € Discount. Du kannst also anhand der Produktgruppe erkennen, welche Artikel_2 zur gleichen Gruppe_2 gehoeren.'
  ,bonuskauf_bonusmenge                     COMMENT 'Menge, die man im Bonus bekommt. Z.B. 2 ST (wenn man 2 ST kostenlos bekommt).'
  ,bonuskauf_kaufmenge                      COMMENT 'Menge, die man kaufen muss, um den Bonus zu bekommen.'
  ,bonuskauf_mindestbetrag                  COMMENT 'BBY_MIN_AMOUNT ist der Betrag, den der Kunde min. an der Kasse ausgeben muss um den Bonus zu bekommen.'
  ,bonuskauf_rabatttype_id                  COMMENT 'Bonuskauf Rabatttyp (Normalpreis / Rabattpreis / Kostenlos / …).'
  ,bonuskauf_produktvariante_id             COMMENT 'Bonuskauf Produktvariante (Beliebig / Identisch / Andere).'
  ,bonuskauf_rabatt_perc                    COMMENT 'Kann % oder absolut sein, abhaengig von BBY_DISC_TYPE.'
  ,bonuskauf_rabatt_zuordnung_id            COMMENT 'Bonuskauf Rabattzuordnung (Alle Produkte / guenstigstes / teuerstes).'
  ,bonuskauf_promotionstyp                  COMMENT 'Promotionstyp, expected entries e.g. 0001, 0005, ZAI, ZBBR.'
  ,preis_niedrigster                        COMMENT 'Guenstigster / niedrigster Preis der letzten 30 Tage. Bezugspreis für die Preisvorteilermittlung im Rahmen der Preisangabenverordnung, PAngV.'
  ,preis_niedrigster_diff_perc              COMMENT 'Prozentualer Unterschied/Preisvorteil (PV, manchmal auch Preisveraenderung) des jetztigen (Angebots-)Preises zum geringsten Preis der vergangenen 30 Tage.'
  ,opv_markt_fg                             COMMENT 'Flag: Preisvorteil für Artikel_2 in den digitalen Kanälen (App, Web, Digital Signage) zu diesem Markt nicht anzeigen. 1 = kein PV anzeigen, 0 = es wird ein PV angezeigt. Eine_2 1 hier bedeutet, dass es in diesem Markt für den Artikel_2 in den vergangenen 30 Tagen einen niedrigeren Preisvorteil gab als den aktuell geplanten PV. Das bedeutet auch, dass dann in opv_prospekt_fg eine_2 1 gesetzt, womit alle zugehörigen Märkte im Leafletcluster betroffen sind. In allen physischen Märkten die zu diesem Leafletcluster gehören wird dann kein PV angezeigt. Ein Markt mit opv_prospekt_fg = 1 kann aber trotzdem hier eine_2 0 haben und ein PV in digitalen Kanälen angezeigt werden, wenn er in den letzten 30 Tagen keinen günstigeren PV hatte.'
  ,opv_prospekt_fg                          COMMENT 'Flag: Preisvorteil für Artikel_2 im Prospekt zu dem dieser Markt gehört nicht anzeigen. 1 = kein PV anzeigen, 0 = es wird ein PV angezeigt. Wird auf 1 gesetzt, wenn irgendein Markt im Leafletcluster in den vergangenen 30 Tagen einen niedrigeren Preis hatte als der aktuell geplante PV (opv_markt_fg = 1). Eine_2 1 hier bedeutet auch, dass in allen physischen Märkten in diesem Leafletcluster kein PV angezeigt wird. Ob sie aber in den digitalen Kanälen anzeigen können hängt von opv_markt_fg ab.'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,utp_lieferant_bestaetigt_fg              COMMENT 'Flag, welches angibt, ob ein UTP-Lieferant die Werbebestellmenge freigegeben hat  (0 oder 1)'
  ,preis_niedrigster_logik_cd               COMMENT 'Der Buchstabe beschreibt, welche Berechnungslogik im SAP zur Ermittlung des günstigsten Preises (PREIS_NIEDRIGSTER und PREIS_NIEDRIGSTER_DIFF_PERC) verwendet wurde. Dies kann z.B. auf Basis der letzten 7 Tage oder letzten 30 Tage geschehen.'
  ,stimmung_fg                              COMMENT 'Flag beschreibt, ob ein Artikel_2 mit einem stimmungsvollen Motiv im Leaflet abgebildet ist.'
  ,preishammer_fg                           COMMENT 'Flag beschreibt, ob ein Artikel_2 einen besonders attraktiven Preis hat.'
  ,ek_art_id_ref                            COMMENT 'Artikelnummer des Produktes aus PMR, welches vom Einkäufer als Referenz vorgeschlagen wird. Sie entspricht dbp_data.art.kl_art_id.'
)
COMMENT = 'ZPMR_EOP_SST_WBS_TTY/Funktionsbaustein Interface PMR to WBS Local Interface.'
 AS 
    SELECT 
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

FROM DBP_DATA.PMR_ANGEBOT_ART_WUP_ZU_2 ;