--==============================================================
-- Table: wbs_werbeaenderungen_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_werbeaenderungen_1
   generated from Powerdesigner on Donnerstag, 6. November 2025 09:17:49
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_WERBEAENDERUNGEN_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Aktion_1-ID.',
   offer_id                            INTEGER     NOT NULL COMMENT 'Offer / Angebot_1-ID',
   wup_id                              INTEGER     NOT NULL COMMENT 'Filialnummer.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
   dat_beladung                        DATE             NOT NULL COMMENT 'Technisches Beladungsdatum.',
   mandant_id_vz                       INTEGER     NOT NULL COMMENT 'Mandant_1 VZ.',
   wup_id_vz                           INTEGER     NOT NULL DEFAULT -1 COMMENT 'Verteilzentrumsnummer / VZ-WUP_1-ID.',
   nb_id                               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   nb_id_vz                            INTEGER     NOT NULL DEFAULT -111 COMMENT 'Nebenbetriebskennziffer VZ',
   dat_ab                              DATE             COMMENT 'Aktion_1 gültig von.',
   dat_bis                             DATE             COMMENT 'Aktion_1 gültig bis.',
   kjwo                                INTEGER     COMMENT 'Werbekalenderwoche, JJJJWW.',
   ausliefergruppe_id                  VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Ausliefergruppe / Auslieferungsgruppe.',
   wbs_phase_id                        INTEGER     COMMENT 'WBS-Phase. Gibt an, in welcher Phase bzw. in welchem Prozess-Schritt des Werbemengenberechnungsprozesses sich der Artikel_1 befindet.',
   gp_id                               INTEGER     COMMENT 'Lieferant-ID.',
   gk_fg                               INTEGER     COMMENT 'Flag: Gondelkopf',
   fachboden_fg                        INTEGER     COMMENT 'Flag: Fachboden',
   titel_fg                            INTEGER     COMMENT 'Flag: Titelseite',
   rueckseite_fg                       INTEGER     COMMENT 'Flag: Rückseite',
   erste_seite_fg                      INTEGER     COMMENT 'Flag: Erste Seite',
   kasse_fg                            INTEGER     COMMENT 'Flag: Kassenbereich',
   tv_fg                               INTEGER     COMMENT 'Flag: TV-Werbung',
   neuer_artikel_fg                    INTEGER     COMMENT 'Flag: Neuer Artikel_1',
   preis_normal                        NUMBER(29,2)      COMMENT 'Normal-Verkaufspreis (Brutto).',
   preis_aktion                        NUMBER(29,2)      COMMENT 'Aktions-Verkaufspreis (Brutto).',
   anz_tage_werbung                    INTEGER     COMMENT 'Anzahl Tage Werbung.',
   tage_bis_bestellung_lieferant       INTEGER     COMMENT 'Anzahl Tage bis Lieferantenbestellung.',
   tage_bis_deadline_print             INTEGER     COMMENT 'Anzahl Tage bis Print-Deadline.',
   tage_bis_initiale_belieferung       INTEGER     COMMENT 'Anzahl Tage bis zur initialen Belieferung.',
   anz_werbeaenderungen_aufg           INTEGER     COMMENT 'Anzahl Werbeänderungen (aufg.)',
   anz_werbeaenderungen_nach_print     INTEGER     COMMENT 'Anzahl Werbeänderungen (nach Print).',
   werbeaenderung_angebotspreisreduktion_fg INTEGER     COMMENT 'Flag: Aktions-Verkaufspreis Reduktion.',
   werbeaenderung_angebotspreiserhoehung_fg INTEGER     COMMENT 'Flag: Aktions-Verkaufspreis Erhöhung.',
   werbeaenderung_normalpreisreduktion_fg INTEGER     COMMENT 'Flag: Normal-Verkaufspreis Reduktion.',
   werbeaenderung_normalpreiserhoehung_fg INTEGER     COMMENT 'Flag: Normal-Verkaufspreis Erhöhung.',
   werbeaenderung_artikelneuanlage_fg  INTEGER     COMMENT 'Flag: Artikelneuanlage.',
   werbeaenderung_artikelentfernung_fg INTEGER     COMMENT 'Flag: Artikelentfernung.',
   werbeaenderung_marktanzahlerhoehung_fg INTEGER     COMMENT 'Flag: Anz. Märkte Erhöhung.',
   werbeaenderung_marktanzahlreduktion_fg INTEGER     COMMENT 'Flag: Anz. Märkte Reduktion.',
   werbeaenderung_abbildungsaenderung_fg INTEGER     COMMENT 'Flag: Änderung Abbildung.',
   werbeaenderung_radio_tv_billboard_fg INTEGER     COMMENT 'Flag: Radio / TV / Billboard.',
   werbeaenderung_kolliinhaltsaenderung_fg INTEGER     COMMENT 'Flag: Änderung Kolliinhalt.',
   werbeaenderung_werbethema_fg        INTEGER     COMMENT 'Flag: Änderung Werbethema.',
   werbeaenderung_sonstiges_fg         INTEGER     COMMENT 'Flag: Sonstige Änderung.',
   werbeaenderung_bonuskauf_promotionstyp_fg INTEGER     COMMENT 'Flag: Änderung bonuskauf_promotionstyp.',
   mindestplatzierung_fg               INTEGER     COMMENT 'Flag: Mindestplatzierung.',
   best_generiert_fg                   INTEGER     COMMENT 'Flag: Bestellung generiert.',
   hohe_mengenaenderung_fg             INTEGER     COMMENT 'Flag: Mengenänderung > 20 %.',
   geringe_mengenaenderung_fg          INTEGER     COMMENT 'Flag: Mengenänderung < 20 %.',
   gesteuerte_prognose_fg              INTEGER     COMMENT 'Flag: Prognose durch User gesteuert (Mengen FCST <> FCST_UDF).',
   menge_mindestplatzierung_bme        NUMBER(29,3)     COMMENT 'Menge Mindestplatzierung in BME.',
   fixmenge_fg                         INTEGER     COMMENT 'Flag: Fixmenge.',
   fixmenge_bme                        NUMBER(29,3)     COMMENT 'Fixmenge in BME.',
   mindestmenge_fg                     INTEGER     COMMENT 'Flag: Mindestmenge.',
   mindestmenge_bme                    NUMBER(29,3)     COMMENT 'Mindestmenge in BME.',
   maximalmenge_fg                     INTEGER     COMMENT 'Flag: Maximalmenge.',
   maximalmenge_bme                    NUMBER(29,3)     COMMENT 'Maximalmenge in BME.',
   bestand_wup_bme                     NUMBER(29,3)     COMMENT 'Marktbestand in BME.',
   offene_bestellungen_bme             NUMBER(29,3)     COMMENT 'Offene Bestellungen in BME.',
   order_forecast_bme                  NUMBER(29,3)     COMMENT 'Order Forecast in BME.',
   projizierter_bestand_vor_werbung_bme NUMBER(29,3)     COMMENT 'Projizierter Bestand vor Werbung in BME.',
   durchschnittlicher_abverkauf_bme    NUMBER(29,3)     COMMENT 'Durchschnittlicher Abverkauf in BME.',
   prognose_werbezeitraum_bme          NUMBER(29,3)     COMMENT 'Prognose Werbezeitraum in BME.',
   anteil_wup_artikel_perc             NUMBER(29,2)      COMMENT 'Anteil dieses Marktes an der Gesamt-Prognosemenge.',
   bedarf_bme                          NUMBER(29,3)     COMMENT 'Bedarf in Basismengeneinheit.',
   bedarf_ame                          NUMBER(29,3)     COMMENT 'Bedarf in Ausliefermengeneinheit.',
   bedarf_pal                          NUMBER(29,3)     COMMENT 'Bedarf in Paletten.',
   zielbestand_bme                     NUMBER(29,3)     COMMENT 'Zielbestand in Basismengeneinheit.',
   bestellmenge_ohne_bestand_ame       NUMBER(29,3)     COMMENT 'Errechnete Werbe-Bestellmenge ohne Bestandsberücksichtigung in Ausliefermengeneinheit (AME, z.B. Kolli oder KG). Ohne Bestandsberücksichtigung ist z.B. für den Fall, dass ein aktuell hoher Bestand vor der Aktion_1 wegen Mhd-Ablauf verfällt, oder es wegen anderer Aktionen zu erwarten ist, dass der Bestand sich abverkauft, weshalb die unreduzierte Bestellmenge genommen werden kann.',
   bestellmenge_ohne_bestand_pal       NUMBER(29,3)     COMMENT 'Errechnete Werbe-Bestellmenge ohne Bestandsberücksichtigung in Paletten (PAL). Ohne Bestandsberücksichtigung ist z.B. für den Fall, dass ein aktuell hoher Bestand vor der Aktion_1 wegen Mhd-Ablauf verfällt, oder es wegen anderer Aktionen zu erwarten ist, dass der Bestand sich abverkauft, weshalb die unreduzierte Bestellmenge genommen  werden kann.',
   bestellmenge_mit_bestand_ame        NUMBER(29,3)     COMMENT 'Errechnete Werbe-Bestellmenge mit Bestandsberücksichtigung in Ausliefermengeneinheit (AME, z.B. Kolli oder KG). Mit Bestandsberücksichtigung ist z.B. für den Fall, dass es einen aktuell hohen Bestand des Artikels gibt, der vor der Aktion_1 wahrscheinlich nicht signifikant abnimmt, was eine_1 Reduktion der Bestellmenge zur Folge haben kann..',
   bestellmenge_mit_bestand_pal        NUMBER(29,3)     COMMENT 'Errechnete Werbe-Bestellmenge mit Bestandsberücksichtigung in Paletten (PAL). Mit Bestandsberücksichtigung ist z.B. für den Fall, dass es einen aktuell hohen Bestand des Artikels gibt, der vor der Aktion_1 wahrscheinlich nicht signifikant abnimmt, was eine_1 Reduktion der Bestellmenge zur Folge haben kann.',
   aktion_reihenfolge_zukunft_nr       INTEGER     COMMENT 'Gibt an, an wievielter Stelle die betrachtete Aktion_1 in der aktuellen Reihenfolge kommender Aktionen steht. Der Rang kann sich im Zeitverlauf ändern (z.B. durch entfallene oder hinzukommende Aktionen) und wird mit jeder dat_beladung neu ermittelt, Mögliche Werte können 1, 2, 3, etc. sein.',
   preis_nachlass_perc                 NUMBER(29,2)      COMMENT 'Preisnachlass in %.',
   kollifaktor                         NUMBER(29,3)     COMMENT 'Kollifaktor (Menge in BME pro Kolli).',
   multi_offer_id_fg                   INTEGER     COMMENT 'Artikel_1 mit mehreren offer_ids / angebot_ids bzw. aktion_ids.',
   werbeaenderung_menge_vorlauf        NUMBER(29,3)     COMMENT 'Mengenänderung zum Vorlauf.',
   fixmenge_wfl_fg                     INTEGER     COMMENT 'Fixmenge Flag vom Warenfluss.',
   fixmenge_wfl_bme                    NUMBER(29,3)     COMMENT 'Fixmenge BME vom Warenfluss.',
   fixmenge_wfl_aenderung_fg           INTEGER     COMMENT 'Bezieht sich auf die Warenfluss FIXMenge Änderung , die in der Spalte FIXMENGE_WFL_BME stattfindet . Das Flag wird auf 1 gesetzt, wenn sich die vom Warenfluss gesetzte Fixmenge im Vergleich zum letzten Berechnungstag geändert hat.',
   fixmenge_wfl_vortag_bme             NUMBER(29,3)     COMMENT 'Diese Spaltesie ermöglicht dem Benutzer zu erfahren, welche Menge in BME der Warenfluss am Vortag hatte. Sie ist auch erforderlich, um die Änderung der Fixmenge WFL (Spalte: fixmenge_wfl_bme) nachzuvollziehen.',
   preis_normal_vorlauf                NUMBER(29,2)      COMMENT 'Normalpreis zum Vorlauf.',
   preis_aktion_vorlauf                NUMBER(29,2)      COMMENT 'Aktionspreis zum Vorlauf.',
   top_gk_fg                           INTEGER     COMMENT 'initiale Belieferung zur Identifizierung von Belegart UBGK zur Aussteuerung TOP Gondelkopfprozess.',
   bestand_vz                          NUMBER(29,3)     COMMENT 'Anzeige von VZ Bestand (Frei verfügbar).',
   blockierter_bestand_vz              NUMBER(29,3)     COMMENT 'Anzeige VZ Bestand (für Werbung blockiert).',
   final_verfuegbarer_bestand_vz       NUMBER(29,3)     COMMENT 'Anzeige Anteil (customizing) VZ Bestand (für Werbung blockiert)+Anzeige VZ Bestand (frei verfügbar)*Faktor.',
   bestellung_lieferant_menge          NUMBER(29,3)     COMMENT 'Übertragung Richtung VZ-Disposchnittstelle.',
   bestellung_lieferant_fg             INTEGER     COMMENT 'Sagt aus ob die Bestellung beim Lieferanten an das VZ getätigt wurde. Die Flag BESTELLUNG_LIEFERANT_MIT_BESTAND_FG sagt dann aus wie bzw. welche Art_1 von Bestellung getätigt wurde. Wenn BESTELLUNG_LIEFERANT_FG = 1 und BESTELLUNG_LIEFERANT_MIT_BESTAND_FG = 0 ist dann wurde eine_1 Bestellung ohne Bestandsberücksichtigung getätigt.',
   bestellung_lieferant_mit_bestand_fg INTEGER     COMMENT 'Flag: Wird gesetzt, wenn die Werbemenge mit Bestandsberücksichtigung durch die VZ-Disposition beim Lieferanten bestellt werden soll (Phase-Switch I).
            Wird für Artikellevel erst über Warengruppeneinstellungen in TS_WBS_WARENGRUPPE.AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG gesteuert, kann dann aber auch manuell für den Artikel_1 in MSTR gesetzt bzw. überschrieben werden.
            Mit der Flag soll auch verhindert werden, dass die initiale Liefermenge an die Märkte erneut mit Bestandsberücksichtigung ermittelt wird (Phase-Switch III), was einem doppelten Abzug entsprechen würde. Also für den Fall, dass ein MIT_BESTAND Phase-Switch auch auf 1 gestellt wird, während der andere schon auf 1 ist. (TS_WBS_WARENGRUPPE.AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG und TS_WBS_WARENGRUPPE.AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_III_FG sollten auch nicht gleichzeitig 1 sein.)',
   stille_aktion_fg                    INTEGER     COMMENT 'Identifikation "In Store Promotions" um Artikel_1 mit FG aus Berechnung auszuschließen.',
   prognose_ungesteuert                NUMBER(29,3)     COMMENT 'Prognose ungesteuert aus UDF, ohne Korrekturen / strukturierte Artikel.',
   menge_zuletzt_dc_promo              NUMBER(29,3)     COMMENT 'Menge die zuletzt aus DC Promo übertragen wurde.',
   pmr_werbethema_id                   VARCHAR(6)       COLLATE 'en-ci' COMMENT 'Thema ID.',
   referenzmarkt_fallback_fg           INTEGER     COMMENT 'Identifizierung von „Fallback“-PrognosenIdentifizierung von „Fallback“-Prognosen.',
   rabattaenderung_fg                  INTEGER     COMMENT 'Flag bei Preisänderung des Preisrabattes.',
   abbildung_vortag_id                 VARCHAR(6)       COMMENT 'Welche Abbildung im Handzettel hatte der Artikel_1 am Vortrag.',
   werbethema_vortag_bez               VARCHAR(50)      COMMENT 'Welches Werbethema hatte der Artikel_1 am Vortag.',
   art_id_mutter                       INTEGER     COMMENT 'Mutter ID zu VK_1-Set/Display Artikeln.',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR.',
   werbelistung_fg                     INTEGER     COMMENT 'Flag zur Anzeige der Werbelistung im PMR (Promotion Management for Retail). Zeigt an ob ein Artikel_1 während der Werbung in dem Markt gelistet ist.
            Je nach Marktgröße sind die Sortimente verschieden groß, weshalb ein Artikel_1 nach der Werbung wieder ausgelistet sein kann, wenn er nicht zum regulären Sortiment diese Marktes gehört. Bei Artikel_1 die nich regulär in einem Markt gelistet sind, ist die Flag = 0 solange es eine_1 Zwischenaktion vor der betrachteten Aktion_1 gibt, und wird auf 1 gesetzt, sobald die Zwischenaktion vorbei ist.
            Mit dieser Flag ist es möglich Artikel_1 anzulegen bevor die Werbelistung eintritt, womit eine_1 technische Einschränkung im Quellsystem / SAP überwunden wird, wodurch nur Daten für gelistete Artikel_1 übermittelt wurden. Da ein Artikel_1 für eine_1 zuküftige Aktion_1 in einem Markt vor der Aktion_1 ungelistet sein kann (wenn nicht im regulären Sortiment), und auch keine Werbelistung bestehen kann weil eine_1 Zischenaktion stattfindet, konnten vorher keine (groben) Berechnungen und Bestellungen in WBS für solche zuküftigen Aktionen durchgeführt werden.',
   werbelistung_aenderung_fg           INTEGER     COMMENT 'Flag zur Anzeige der Änderung der Werbelistung im PMR (Promotion Management for Retail). Zeigt an ob ein Artikel_1 während der Werbung in dem Markt gelistet ist. (Denormalisierung für Frontend-Optimierung. Die Änderung ließe sich vermutlich auch aus dem Unterschied zwischen den Tagen errechnen.)
            Wenn WERBELISTUNG_FG (siehe eigener Kommentar) von 0 auf 1 gesetzt wird, dann wird am selben Tag_1 auch diese Flag auf 1 gesetzt, und am darauf folgenden Tag_1 wieder auf 0. Die betrachtete Flag kennzeichnet das Datum ab dem genauere Nachberechnungen mit Hilfe von WBS durchgeführt werden können. Eventuell können sich daraus Änderungen an den Bestellmengen ergeben da ab hier eine_1 andere Basis herangezogen werden kann.',
   aktion_reihenfolge_aenderung_fg     INTEGER     COMMENT 'Flag: Zeigt an, dass zu einem bestimmten DAT_BELADUNG die Aktionsreihenfolge sich geändert hat. Ist für den User hilfreich um nach Änderungen zu filtern.',
   vortag_aktion_reihenfolge_zukunft_nr INTEGER     COMMENT 'Gibt an, an wievielter Stelle die betrachtete Aktion_1 am Vortag in der aktuellen Reihenfolge kommender Aktionen steht. ',
   zeitpunkt_bestellung_lieferant_prognose_bedarf_bme NUMBER(29,3)     COMMENT 'Prognostizierter Bedarf in Basismengeneinheit zum Zeitpunkt der Bestellung beim Lieferanten. Redundant gespeichert zum Wert in BEDARF_BME zu dem Datum als die Bestellung getätigt wurde. Die tatsächliche Bestellmenge kann entweder die volle Bedarfsmenge hier gewesen sein oder die Bedarfsmenge abzüglich des am Datum der Bestellung prognostizierten Bestands zu Werbebeginn im Markt (auch die Prognosen ändern sich über die Zeit_1).',
   wup_id_ref                          INTEGER     COMMENT 'Der Referenzmarkt, der fuer den Artikelvergleich gespeichert wird. Fuer eine_1 zukuenftige Aktion_1 eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion_1 und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel_1 und Markt der geplanten Aktion_1 sein. Der Referenztyp sagt aus um welche Art_1 von Vergleich es sich handelt.
            Fuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ_1, welche manuell von Nutzern gepflegt.
            Fuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER_1 eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.',
   nb_id_ref                           INTEGER     COMMENT 'NB_ID_REF, welche zur WUP_ID_REF gehört.',
   art_id_ref                          INTEGER     COMMENT 'Der Referenzartikel, der für den Artikelvergleich gespeichert wurde. Fuer eine_1 zukuenftige Aktion_1 eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion_1 und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel_1 und Markt der geplanten Aktion_1 sein. Der Referenztyp sagt aus um welche Art_1 von Vergleich es sich handelt.
            Fuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ_1, welche manuell von Nutzern gepflegt.
            Fuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER_1 eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.',
   faktor_ref                          NUMBER(29,2)     COMMENT 'Faktor für die Gewichtung der Referenzmetriken.
            Fuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ_1, welche manuell von Nutzern gepflegt.
            Fuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER_1 eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.',
   wfl_menge_geprueft_fg               INTEGER     COMMENT 'Warenfluss_menge_Flag oder Supply chain Managment flag , die der Benutzer setzen kann in der Tabelle (MENGENAENDERUNGEN_WRITEBACK), um zu markieren, dass er die Mengen für diesen Artkel bereits überprüft hat, und würde die beibhalten solange es keine Änderungen bei der Promotion gibt ',
   wfl_menge_geprueft_reset_fg         INTEGER     COMMENT 'Flag, welches auf 1 gesetzt werden soll, wenn das WFL_MENGE_GEPRUEFT_FG "resettet" wird d.h von 1 auf 0 springt.',
   wfl_nutzer_kommentar_txt            VARCHAR(100)     COMMENT 'Frei-Text-Feld für den Benutzer
            Dieses Feld dient dazu, einen zusätzlichen Kommentar zu einem Artikel_1 hinzuzufügen. um besser nachzuvollziehen, was das Problem vorher war',
   fixmenge_ek_aenderung_fg            INTEGER     COMMENT 'Bezieht sich auf die  Einkauf FIXMenge Änderung , die in der Spalte Festmenge_BME stattfindet . Das Flag wird auf 1 gesetzt, wenn sich die vom Einkauf gesetzte Fixmenge im Vergleich zum letzten Berechnungstag geändert hat.',
   fixmenge_ek_vortag_bme              NUMBER(29,3)     COMMENT 'Diese Spalte ermöglicht dem Benutzer zu erfahren, welche Menge in BME der Einkauf am Vortag hatte. Sie ist auch ist erforderlich, um die Änderung der Fixmenge EK nachzuvollziehen (Spalte: fixmenge_bme). ',
   anz_angebote_zeitraum               INTEGER     COMMENT 'Anzahl der Angebote, welche die Artikel_markt Kombination und im gleichen Zeitraum stattfinden (art_id, wup_id, dat_von, dat_bis  for the current dat_beladung).',
   anz_angebote_zeitraum_aenderung_fg  INTEGER     COMMENT 'Flag, welche anzeigt, ob sich die Anzahl der Angebote, die die Artikel_1-Markt-Kombination aufweisen und im selben Zeitraum stattfinden, im Vergleich zum letzten Berechnungstag geändert hat.',
   nur_online_fg                       INTEGER     COMMENT 'Flag, welches anzeigt, ob die Werbung nur online geschaltet wurde.
            ',
   kundenkarte_personalisiert_fg       INTEGER     COMMENT 'Flag: welches anzeigt ob die werbung einen personalisierter Kundenkarten-Coupon ist',
   werbeaenderung_kundenkarte_personalisiert_fg INTEGER     COMMENT 'Flag, welches anzeigt, ob eine_1 Änderung in dem KUNDENKARTE_PERSONALISIERT Coupons im Vergleich zum letzten Tag_1 erfolgte',
   stille_aktion_mit_menge_fg          INTEGER     COMMENT 'Flag, welches anzeigt, dass die Werbung eine_1 stille Werbung ist, die nur in Filialen beworben ist, aber mit Menge_hochrechnung.( für Kombination WERBEMITTEL_ART_ID = 0920 & WERBEMITTEL_ID = 50)',
   min_platzierung_markt_cluster_id    INTEGER     COMMENT 'Markt-Cluster für Mindestplatzierung (1-3).',
   estimation_id                       INTEGER     COMMENT 'With this ID the user can decide in which way the estimation for WBS TP2 should be calculated.
            ID 0 = no estimation
            ID 1 = calculate normal estimation process
            ID 2 = only fill up maximum capacity (Berechnung für die Werbung in WBS, aber nur um das Regal aufzufüllen)',
   estimation_id_aenderung_fg          INTEGER     COMMENT 'Flag zur Anzeige der Änderung der Estimation-ID im Vergleich zum Vortag (1 oder 0). Ist für den User hilfreich um nach Änderungen zu filtern.',
   utp_relevant_fg                     INTEGER     COMMENT 'Gibt an ob einen Artikel_1 als UTP-relevant markiert ist (0 oder 1).
            UTP = Unfair trade practices. Ist ein EU-Gesetz um kleine Lieferanten vor Großaufträgen zu schützen.',
   utp_relevant_aenderung_fg           INTEGER     COMMENT 'Flag zeigt die Änderung der UTP_RELEVANT_FG im Vergleich zum Vortag (1 oder 0). Ist für den User hilfreich um nach Änderungen zu filtern.',
   utp_lieferant_bestaetigt_fg         INTEGER     COMMENT 'Flag gibt an, ob ein UTP-Lieferant die Werbebestellmenge freigegeben hat (0 oder 1).',
   dat_gueltig_von_konditionsart_zar5  DATE             COMMENT 'Beginn der Gültigkeit der Konditionsart ZAR5.',
   dat_gueltig_bis_konditionsart_zar5  DATE             COMMENT 'Ende der Gültigkeit der Konditionsart ZAR5.',
   menge_kolliinhalt_vortag_bme        NUMBER(29,3)     COMMENT 'Kolliinhalt des Vortages. Aus Feld: Kollifaktor (Menge in BME pro Kolli).',
   init_lief_modus_kz                  VARCHAR(100)     COMMENT 'Beschreibt den Modus, in welchem die initiale Belieferung berechnet wird (O = Order, S = Simulation, N = None).
            - N: wenn keine initiale Belieferung errechnet wird (vor wbs_phase_id = 8).
            - S: berechnen die Erstlieferung 40 Tage vor der Promotion - es werden keine wirklichen Bestellungen in den Geschäften erzeugt sondern die Spalte ermöglicht DC Dispo, den ersten Liefersplit schon sehr früh zu sehen und die Mengen beim Lieferanten entsprechend zu bestellen (wbs_phase_id 7 bis 3).
            - O: der ursprüngliche initiale Lieferlauf findet 9 Tage vor der Promotion statt, und der Berechnungslauf wird als "O" (Order Creation) gekennzeichnet (ab wbs_phase_id = 2).',
   gp_id_aenderung_fg                  INTEGER     COMMENT 'Flag, welches angibt, ob sich die Lieferantennummer (GP_ID) geändert hat',
   konditionsart_zar5_gueltigkeit_aenderung_fg INTEGER     COMMENT 'Flag, welches angibt, ob sich der Zeitraum für die ZAR5-Gültigkeit geändert hat.',
   posten_kz_sap                       VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Postenkennzeichen. Für Artikel_1, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert)',
   posten_kz_sap_aenderung_fg          INTEGER     COMMENT 'Flag, welches angibt, ob der Artikel_1 von Posten auf Sortimentsartikel oder umgekehrt geändert hat',
   bonuskauf_promotionstyp_liste_txt   VARCHAR(1000)    COMMENT 'Die Spalte enthält den konkatenierte Aktionsart (Feld AKART in PMR), erwartete Einträge sind z.B. 0001, 0005, ZAI, ZBBR.
            Gibt die Aktionsart für eine_1 Aktion_ID an Z.B:
            Aktionsart ''0001'' eine_1 Standard-Aktion_1 im Prospekt
            oder ''ZBBR'' wäre_1 eine_1 Bonuskauf-Aktion.
            Die Art_1 der Aktion_1 hat Einfluss darauf, ob und wie die SCM-Mengen für diese Aktion_1 berechnet werden.',
   saison_id                           VARCHAR(10)      COLLATE 'en-ci' COMMENT 'ID der Saison aus saiso, z.Bsp 9.',
   saison_id_aenderung_fg              INTEGER     COMMENT 'Flag, gibt an, ob der Artikel_1 das Saisonkennzeichen geändert hat',
   best_menge_einh_id                  VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Bestellmengeneinheit. Diese Mengeneinheit wird standardmäßig bei Bestellungen verwendet.',
   best_menge_einh_vortag_id           VARCHAR(3)       COMMENT 'Bestellmengeneinheit des Vortages. Diese Mengeneinheit wird standardmäßig bei Bestellungen verwendet.',
   best_menge_einh_id_aenderung_fg     INTEGER     COMMENT 'Flag, gibt an, ob es eine_1 Änderung der Bestellmengeneinheit zum Vortag gab',
   bedarf_estimation_id_2_bme          NUMBER(29,3)     COMMENT 'Simulierter Bedarf in Basismengeneinheit, welcher unter Verwendung der Estimation_ID = 2 ermittelt werden würde.',
   bestellmenge_estimation_id_2_ohne_bestand_ame NUMBER(29,3)     COMMENT 'Simulierte Werbe-Bestellmenge ohne Bestandsberücksichtigung in Ausliefermengeneinheit (AME, z.B. Kolli oder KG), welcher unter Verwendung der Estimation_ID = 2 ermittelt werden würde.',
   bestellmenge_estimation_id_2_mit_bestand_ame NUMBER(29,3)     COMMENT 'Simulierte Werbe-Bestellmenge mit Bestandsberücksichtigung in Ausliefermengeneinheit (AME, z.B. Kolli oder KG), welcher unter Verwendung der Estimation_ID = 2 ermittelt werden würde.',
   adjustment_id                       INTEGER     COMMENT 'Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.
            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R
            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.
            2 = Platzhalter (Stand 28.03.2025)
            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_1 manuelle Bestellanlage durch das Land_1 notwendig.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_WERBEAENDERUNGEN PRIMARY KEY (mandant_id, aktion_id, offer_id, wup_id, art_id, dat_beladung, mandant_id_vz, wup_id_vz) NOT ENFORCED
)  COMMENT = 'SCM-WBS - Werbeänderungen (kumuliert).';
