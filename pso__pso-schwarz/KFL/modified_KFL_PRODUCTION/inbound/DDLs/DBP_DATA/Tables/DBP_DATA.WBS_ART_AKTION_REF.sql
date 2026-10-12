--==============================================================
-- Table: wbs_art_aktion_ref
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_art_aktion_ref
   generated from Powerdesigner on Freitag, 27. Dezember 2024 11:25:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_ART_AKTION_REF DATA_RETENTION_TIME_IN_DAYS = 2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Filiale-ID (6906, 3000, ...).',
   nb_id                               INTEGER     NOT NULL COMMENT 'Nebenbetrieb-ID (Lager, Filiale, ...).',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer.',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Aktionsnummer, Promotion-ID.',
   kjwo_von                            INTEGER     NOT NULL COMMENT 'Start-Kalenderwoche der Aktion entsprechend dat_von.',
   dat_von                             DATE             NOT NULL COMMENT 'Aktuelle Aktion gültig von: Datum im Format JJJJ-MM-TT.',
   dat_bis                             DATE             NOT NULL COMMENT 'Aktuelle Aktion gültig bis: Datum im Format JJJJ-MM-TT.',
   aktion_dauer                        INTEGER     NOT NULL COMMENT 'Dauer der Aktion.',
   wtag_id_von                         INTEGER     NOT NULL COMMENT 'Werbestart Wochentag.',
   mandant_id_vz                       INTEGER     COMMENT 'Mandant VZ. Das Auslieferungsland kann sich in gewissen Fällen vom Markt unterscheiden, z.B. wird Moldau (mandant_id 4) aus Rumänien (mandant_id 7) beliefert. Das Attribut wird hier redundant angelegt um die Performance im Frontend zu steigern (es wird ein Join mit WBS_WERBEAENDERUNGEN vermieden).',
   wup_id_vz                           INTEGER     COMMENT 'WUP ID VZ. Marktnummer des Verteilzentrums. Das Attribut wird hier redundant angelegt um die Performance im Frontend zu steigern.',
   mutter_wb_id                        INTEGER     COMMENT 'Artikelnummer des Werbemutterartikels.',
   wup_id_ref                          INTEGER     COMMENT 'Der Referenzmarkt, der fuer den Aktionsvergleich gespeichert wird. Fuer eine zukuenftige Aktion eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel und Markt der geplanten Aktion sein. Der Referenztyp sagt aus um welche Art von Vergleich es sich handelt.
            Fuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ, welche manuell von Nutzern gepflegt.
            Fuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.',
   nb_id_ref                           INTEGER     COMMENT 'NB_ID_REF, welche zur WUP_ID_REF gehört.',
   art_id_ref                          INTEGER     COMMENT 'Der Referenzartikel, der für den Artikelvergleich gespeichert wurde. Fuer eine zukuenftige Aktion eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel und Markt der geplanten Aktion sein. Der Referenztyp sagt aus um welche Art von Vergleich es sich handelt.
            Fuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ, welche manuell von Nutzern gepflegt.
            Fuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.',
   faktor_ref                          NUMBER(29,2)     COMMENT 'Faktor für die Gewichtung der Referenzmetriken.
            Fuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ, welche manuell von Nutzern gepflegt.
            Fuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.',
   aktion_id_ref                       VARCHAR(10)      NOT NULL DEFAULT '-1' COMMENT 'Aktionsnummer (historische Aktion), Promotion-ID.',
   dat_von_ref                         DATE             NOT NULL DEFAULT CAST ('01-01-1900' AS DATE) COMMENT 'Historische Aktion gültig von: Datum im Format JJJJ-MM-TT.',
   dat_bis_ref                         DATE             COMMENT 'Historische Aktion gültig bis: Datum im Format JJJJ-MM-TT.',
   aktion_reihenfolge                  INTEGER     NOT NULL COMMENT 'Position in der Zeitlichen Reihenfolge der vergangenen Aktionen. Bei 0 gibt es keine vergleichbare historische Aktion.',
   anz_akt_selbe_dauer                 INTEGER     COMMENT 'Anzahl Aktionen mit selber Dauer.',
   menge_sa_bme_ref                    NUMBER(29,3)     COMMENT 'Tatsächlich verkaufte Promotion Menge in der historischen Aktion in BME (wurde gefiltert auf bewart = 1002, SonderAktion, beinhaltet auch BBY),',
   menge_gesamt_bme_ref                NUMBER(29,3)     COMMENT 'Die Summe der gesamten Promotionsmenge, die während des Aktionszeitraums verkauft wurde, unabhängig davon, ob sie durch die Promotion oder aus anderen Gründen, z.B. Kundenkartenrabatt verkauft wurde, in BME (für bewart = Sonderaktion und aktionsfrei, z.B. Kundenkarte, Bonusrabatt, etc.).',
   zeitraum_korrigierte_menge_ref      NUMBER(29,3)     COMMENT 'Korrigierte Menge in BME (historische Referenzperiode).',
   zeitraum_menge_af_4wo_ref           NUMBER(29,3)     COMMENT 'Menge Abverkauf AF 4 Wochen vor Aktion (historische Referenzperiode).',
   sales_fg_ref                        INTEGER     COMMENT 'Flag: Zeigt an, ob in einer Woche Absätze vorhanden waren (historische Referenzperiode).',
   in_gruppe_fg                        INTEGER     COMMENT 'Flag: Zeigt an, ob ein Artikel zu einer Serie gehört.',
   anz_art_in_gruppe                   INTEGER     COMMENT 'Anzahl Artikel in Serie.',
   anz_art_in_gruppe_ref               INTEGER     COMMENT 'Anzahl Artikel in Serie (historische Referenzperiode).',
   tv_fg_ref                           INTEGER     COMMENT 'Flag: Zeigt an, ob der Artikel TV-Werbung hatte (historische Referenzperiode).',
   titelseite_fg_ref                   INTEGER     COMMENT 'Flag: Zeigt an, ob der Artikel Titelseiten-Werbung hatte (historische Referenzperiode).',
   rueckseite_fg_ref                   INTEGER     COMMENT 'Flag: Zeigt an, ob der Artikel Rückseiten-Werbung hatte (historische Referenzperiode).',
   gk_fg_ref                           INTEGER     COMMENT 'Flag: Zeigt an, ob der Artikel eine Gondelkopfplatzierung hatte (historische Referenzperiode).',
   vk_aktion_brutto_ref                NUMBER(29,2)     COMMENT 'VK-Preis Aktion Brutto (historische Referenzperiode).',
   vk_vor_aktion_brutto_ref            NUMBER(29,2)     COMMENT 'VK-Preis vor Aktion Brutto (historische Referenzperiode).',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR.',
   multi_offer_id_fg_ref               INTEGER     COMMENT 'Flag zur Markierung von Aktionszeiträumen mit multiplen Angeboten. Im selben Zeitraum können für einen Artikel mehrere Angebote existieren, z.B. über den Prospekt und über die K-Card.',
   bonuskauf_fg_ref                    INTEGER     COMMENT 'Flag zur Markierung von Bonusbuy-Aktionen. Zuordnung von BONUSKAUF_ID und AKTION_ID steht in L_BONUSKAUF.',
   lokale_geschaeftsvorfall_bez_ref    VARCHAR(40)      COMMENT 'Bezeichnung des Bonusbuy-Geschäftsvorfalls in lokaler Sprache. Zuordnung von BONUSKAUF_ID und GESCHAEFTSVORFALL_ID steht in L_BONUSKAUF.',
   wbs_art_wup_ref_typ_id              INTEGER     COMMENT 'Artikel_WUP (MARKT) Referenztyp id ,(zeigt die Art des vergleich an bezüglich   Art_ID mit  ART_ID_REF und  WUP_ID mit WUP_ID_REF)
            "1	gleicher Artikel, gleicher Markt
            2	anderer Artikel, gleicher Markt
            3	gleicher Artikel, anderer Markt
            4	anderer Artikel, anderer Markt"',
   berechnete_menge_gesamt_bme_ref     NUMBER(29,3)     COMMENT 'Gibt die urspruenglich berechnete Werbemenge fuer diese Artikel-Markt-Aktion-Kombination aus.',
   lief_menge_initial_bme_ref          NUMBER(29,3)     COMMENT 'Liefermenge, die für die Erstlieferung versendet wurde, in BME. Gibt die tatsaechlich gelieferte Menge in der initialen Belieferung an (nach Fair Share).',
   lief_menge_hochrechnung_bme_ref     NUMBER(29,3)     COMMENT 'Liefermenge, die nach der Anpassungsberechnung versendet wurde, in BME. Gibt die tatsaechlich gelieferte Menge aus der Hochrechnung an (nach Fair Share). WBS führt eine Berechnung nach der Initialen Belieferung durch (Hochrechnung), was dann die nachgelieferte Menge in der betrachteten Spalte beinflusst (kann auch 0 sein). Die Summe von lief_menge_initial_bme_ref und lief_menge_hochrechnung_bme_ref kann sich unterscheiden von berechnete_menge_gesamt_bme_ref.',
   lief_menge_anteil_prozent_ref       NUMBER(29,2)     COMMENT 'Gibt an, wieviel % der Werbeware im Vergleich zur urspruenglich berechneten Werbemenge ausgeliefert wurde. Dies dient dem User dazu zu bewerten, ob der Werbeabsatz eventuell zu gering war, weil Ware nicht im Markt vorhanden war.
            "(MENGE_INITIAL_BME + MENGE_WBS [nach Umrechnung von AME zu BME]) / MENGE_GESAMT_BME"',
   nur_online_fg_ref                   INTEGER     COMMENT 'Flag: Zeigt an, ob die Werbung nur online geschaltet wurde.',
   kundenkarte_personalisiert_fg_ref   INTEGER     COMMENT 'Flag: Zeigt an, ob die Werbung ein personalisierter Kundenkarten-Coupon ist.',
   stille_aktion_fg_ref                INTEGER     COMMENT 'Flag: Stille Aktion Typ: "In Store Promotions" (ohne Mengenberechnung) - Identifikation, um Artikel mit dieser FG aus der Berechnung auszuschließen.
            Stille Aktionen sind Werbungen, die nur in Geschäften zu sehen sind und nirgendwo beworben wurden, und können je nach Typ eine Mengenberechnung haben oder nicht. Der Typ wird im Voraus von einem User vergeben. Für diesen Typ Stille Aktion werden keine Mengenberechnungen durchgeführt.',
   stille_aktion_mit_menge_fg_ref      INTEGER     COMMENT 'Flag: Stille Aktion Typ: "In Store Promotions mit Menge" - für Kombination WERBEMITTEL_ART_ID = 0920 & WERBEMITTEL_ID = 50. Artikel wird nur in Filiale beworben, erhält aber Mengenberechnung.
            Stille Aktionen sind Werbungen, die nur in Geschäften zu sehen sind und nirgendwo beworben wurden, und können je nach Typ eine Mengenberechnung haben oder nicht. Der Typ wird im Voraus von einem User vergeben. Für diesen Typ Stille Aktion werden Mengenberechnungen durchgeführt.',
   werbeflaeche_abschnitt_name_ref     VARCHAR(100)     COMMENT 'Gibt an, in welchem Abschnitt eines Bereichs (in einer Werbeflyerseite) das Angebot abgebildet ist (z.B. TOPLEFT1) - Section (of leaflet page) where the advertisement is put.',
   werbeflaeche_thema_bez_ref          VARCHAR(100)     COMMENT 'Bezeichnung für die WERBEFLAECHE_THEMA_ID (z.B. PANO01 = Schulanfang) - Name of the promotion theme.',
   fixmenge_fg_ref                     INTEGER     COMMENT 'Fixmenge EK Flag gibt an, ob vom Einkauf eine Fixmenge für diese Aktion festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.',
   fixmenge_wfl_fg_ref                 INTEGER     COMMENT 'Fixmenge WFL Flag gibt an, ob vom Warenfluss eine Fixmenge für diese Aktion festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.',
   mindestplatzierung_fg_ref           INTEGER     COMMENT 'Flag gibt an, ob vom Warenfluss eine Mindestplatzierung für diese Aktion festgelegt wurde. Aus dbp_data.wbs_werbeaenderungen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_ART_AKTION_REF PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, aktion_id, dat_von, aktion_id_ref, dat_von_ref, aktion_reihenfolge) NOT ENFORCED
)  COMMENT = 'SCM-WBS - Operational data for WBS tool. This table is used in WBS frontend. It contains information about the historical article promotions in reference to new promotions. For a new promotion of an article it shows the identical previous promotions.';
