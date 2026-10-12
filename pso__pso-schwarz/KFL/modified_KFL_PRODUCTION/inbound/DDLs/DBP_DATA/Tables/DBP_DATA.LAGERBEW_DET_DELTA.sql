--==============================================================
-- Table: lagerbew_det_delta
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerbew_det_delta
   generated from Powerdesigner on Mittwoch, 15. Februar 2023 17:55:27
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LAGERBEW_DET_DELTA (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   lagerbew_beleg_id                   INTEGER     NOT NULL COMMENT 'Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung aus mblnr.',
   lagerbew_beleg_pos_id               INTEGER     NOT NULL COMMENT 'Das Feld enthält die Nummer einer Lagerbelegbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Aus zeile.',
   kj                                  INTEGER     NOT NULL COMMENT 'Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötgit um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus mjahr.',
   grund_id                            VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Dieses Feld enthält den Grund für eine Lagerbewegung.',
   lager_bewart_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Dieses Feld enthält die Bewegungsart einer Lagerbewegung, aus bwart. Lookup-Tabelle ist l_lager_bewart.',
   art_id                              INTEGER     COMMENT 'Input: Artikel - Id einschließlich der Generationen-ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   wup_id                              INTEGER     COMMENT 'WarenUmschlagsPlatz aus mseg.werks.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   auto_fg                             VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Attribut auto_fg kennzeichnet Belegpositionen, die automatisch generiert wurden. Aus xauto. Wertevorrat: S, X, L, blank. Es handelt sich also nicht um ein Flag, wie die Bezeichnung suggeriert!) ',
   lagerort_id                         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk / Betrieb eindeutig. Aus lgort.',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner-ID (Lieferanten-ID), aus lifnr.',
   einkaufsorganisation_id             INTEGER     COMMENT 'Die Einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP zusammen mit dem Attribut gp_id eindeutig zu identifizieren. 1000 = Warenlieferant, 5000 = Frischelieferant, 9000 = ? (könnte es auch geben).',
   soll_haben_kz                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg.',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   best_beleg_id                       INTEGER     COMMENT 'Das Feld enthält die Beleg-ID der Bestellung und dient der eindeutigen Identifikation des Bestellbelegs. Aus ebeln.',
   best_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestell-ID der eindeutigen Identifikation der Bestellbelegposition. Aus ebelp.',
   betrag_lagerbew                     NUMBER(29,4)     COMMENT 'Betrag der Belegposition in der Hauswährung des Buchungskreises. Aus dmbtr. Entspricht dem eknetto_bnk.',
   betrag_verkauf                      NUMBER(29,2)     NOT NULL COMMENT 'Listenpreis (Verkaufspreis brutto * Menge). Das Feld entspricht mseg.vkwrt.',
   erfsngs_menge_einh_id               VARCHAR(3)       NOT NULL COMMENT 'Dieses Feld enthält die ID der Mengeneinheit für die Umrechnung der Basismenge in die alternative Mengeneinheit. Dazu ist der Umrechnungsfaktor aus der DWH Tabelle art_umrechnung_faktor_per pro Material zu ermitteln. Aus erfme.',
   lagerplatz_id                       VARCHAR(10)      COLLATE 'en-ci' COMMENT 'ID des Lagerplatzes. Vierte Ebene der Lagerhierarchie. Aus lgpla.',
   kunde_id                            VARCHAR(10)      COLLATE 'en-ci' COMMENT 'ID des Kunden. Aus kunnr.',
   menge_lagerbew_kolli                NUMBER(29,3)     NOT NULL COMMENT 'Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per ermittelt.',
   menge_lagerbew_bme                  NUMBER(29,3)     NOT NULL COMMENT 'Mengenanteil der Gesamtbestellmenge, dem diese Kontierungsposition zugeordnet wird. Die eingegebene Menge bestimmt, welcher Anteil der Kosten auf diese Kontierungsposition verteilt wird. Aus menge.',
   menge_lagerbew_palette              NUMBER(29,3)     COMMENT 'Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per und art_umrechnung_faktor_per ermittelt.',
   menge_lieferschein                  NUMBER(29,3)     NOT NULL COMMENT 'Menge in Mengeneinheit aus Lieferschein, aus lsmng. Gibt die Menge an, die vom Lieferanten als gelieferte Menge auf Begleitpapieren (z.B. Lieferschein) ausgewiesen wird.',
   menge_lief                          NUMBER(29,3)     NOT NULL COMMENT 'Gibt die gelieferte Menge in Bestellpreismengeneinheit an. Aus bpnmg.',
   menge_erf                           NUMBER(29,3)     NOT NULL COMMENT 'Dieses Feld enthält die Menge in der Erfassungsmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per und art_umrechnung_faktor_per ermittelt. Aus erfmg.',
   empfaenger_id                       INTEGER     COMMENT 'Dieses Feld enthält das empfangende Werk für diese Lagerbewegung, aus umwrk. Dieses Feld enthält die Fachschlüssel der VZ.',
   dat_buch                            DATE             NOT NULL COMMENT 'Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung erfasst wird. Das Feld wird aus der Kopftabelle "vererbt", um einen PPI darüber bilden zu können (Performance!).',
   lagerbew_beleg_storno_id            INTEGER     COMMENT 'Beleg-ID des stornierten Beleges. Referenz von Storno zu storniertem Beleg in der Tabelle lagerbew_det. Aus smbln.',
   lagerbew_beleg_pos_storno_id        INTEGER     COMMENT 'Belegposition des stornierten Beleges. Referenz von Storno zu storniertem Beleg in der Tabelle lagerbew_det. Aus smblp.',
   lagerbew_beleg_storno_kj            INTEGER     COMMENT 'Belegposition des stornierten Beleges. Referenz von Storno zu storniertem Beleg in der Tabelle lagerbew_det. Aus sjahr.',
   betrag_vk_netto                     NUMBER(29,2)     NOT NULL COMMENT 'Entspricht dem Attribut vkwra aus der Tabelle mseg.',
   betrag_belegfluss_wg_art            NUMBER(29,2)     DEFAULT 0 COMMENT 'Betrag aus der Tabelle best_belegfluss. Denormalisierung zur Performancesteigerung bei WBF Abfragen. Nur gefüllt bei WG Erfassartikeln, sonst Null. Nicht im logischen Modell.',
   mandant_id_kunde                    INTEGER     COMMENT 'Der Mandant des Kunden, kann ein anderer sein als der des WUP.',
   mandant_id_empfaenger               INTEGER     COMMENT 'Der Mandant des Empfängers, kann ein anderer sein als der des WUP.',
   bw_vorgang_id                       INTEGER     COMMENT 'Dieses Feld wird im SAP-BW gebildet, u.a aus der Lager Bewegungsart und dem Soll-Haben-Kennzeichen.',
   betrag_verkauf_ist                  NUMBER(29,2)     NOT NULL DEFAULT 0 COMMENT 'Tatsächlicher Marktpreis (Verkaufspreis brutto * Menge). Das Feld entspricht mseg.exvkw.',
   betrag_vk_netto_vz                  NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Nettobetrag. Kein Original-mseg-Feld. Wird im DWH nur für Verteilzentren angereichert.',
   betrag_verkauf_ist_netto            NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Tatsächlicher Marktpreis netto ((Verkaufspreis brutto minus MWSt) * Menge). Das Feld wird im DWH aus mseg.exvkw und Mehrwertsteuerbetrag errechnet.',
   betrag_einstandspreis               NUMBER(29,4)     COMMENT 'Betrag der Belegposition bewertet zum Einstandspreis. Wird nur für KMO-Daten angereichert.',
   gp_id_zl                            INTEGER     NOT NULL DEFAULT -1 COMMENT 'Lieferantennummer. In der Versorgung wird der Lieferant aus der Bezugsquellenfindung angereichert - nur für KMO. Bei ZL-Bewegungsarten ist die gp_id in dieser Tabelle leer.',
   bq_findung_id                       INTEGER     NOT NULL DEFAULT 0 COMMENT 'ID zur Kennzeichnung des Ausstiegspunkts aus dem Kreisprozess. Wird bei der Versorgung angereichert. Nur für KMO gefüllt, sonst 0',
   menge_bestand_bme                   NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Gesamter bewerteter Bestand vor der Buchung in Basismengeneinheiten. Aus lbkum.',
   wert_bestand                        NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Wert des gesamten bewerteten Bestands vor der Buchung. Aus salk3.',
   system_id                           INTEGER     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   buchungskreis_id                    INTEGER     COMMENT 'Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk / Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland.',
   shkum                               VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Soll / Haben Kennzeichen der Umbewertung, aus der Quellspalte shkum.',
   kostenstelle_id                     VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'ID der Kostenstelle, z.Bsp. 9676-400, aus dem Quellfeld kostl. Hat eine Referenz zur Tabelle kostenstelle_per.',
   sachkonto_id                        VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Alphanumerischer Wert aus dem Quellfeld sakto. Hat KEINE Referenz zur DWH-Tabelle l_sachkonto!',
   art_id_empfaenger                   INTEGER     NOT NULL DEFAULT -1 COMMENT 'Empfangendes / abgebendes Material aus ummat. Referenz zur Tabelle art.',
   lagerort_id_empfaenger              VARCHAR(4)       NOT NULL COLLATE 'en-ci' DEFAULT '    ' COMMENT 'Empfangender / Abgebender Lagerort, aus umlgo. Referenz zu l_lagerort.',
   art_id_bf                           INTEGER     NOT NULL DEFAULT -1 COMMENT 'Artikel, auf dem der Bestand geführt wird, aus matbf. Referenz zu art.',
   lagerbew_beleg_pos_mutter_id        INTEGER     NOT NULL DEFAULT 0 COMMENT 'Verweis auf die umsortierte Lagerbewegungsbelegposition des zu diesem Artikel übergeordneten Artikels (falls er existiert). Aus parent_id.
            Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel aufgeführt. Um Komponenten und Displays einander zuzuordnen, wurden in SAP neue Spalten hinzugefügt, welche die Belegzeilen (lagerbew_beleg_pos_id) neu sortieren und dann die neue Displaybelegzeile (line_id) bei den Komponenten angibt (aktuelle Spalte). In der veränderten Sortierung (line_id) werden die Komponenten ans Ende des Belegs gestellt: erst kommen alle Artikel ohne Kopfartikel (lagerbew_beleg_pos_mutter_id = 0) und danach die Komponenten. In lagerbew_beleg_pos_mutter_id (aktuelle Spalte) steht dann der Wert der umsortierten Displaybelegzeile aus line_id.
            (Der Spaltenname wurde zur Konsistenz an bestehende Spalten in anderen lagerbew Tabellen angepasst. Ein besserer Name wäre gewesen: lagerbew_beleg_parent_pos_sort_id oder lagerbew_beleg_pos_sort_mutter_id.)',
   line_id                             INTEGER     NOT NULL COMMENT 'Umsortierte Lagerbewegungsbelegpositionen zur Verbindung von Displays und Displaykomponenten (entspricht der Form früherer Belege vor der Einführung der Display / Komponenten Beziehung). Aus line_id.
            Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel aufgeführt. Um Komponenten und Displays einander zuzuordnen, wurden in SAP neue Spalten hinzugefügt, welche die Belegzeilen (lagerbew_beleg_pos_id) neu sortieren und dann die neue Displaybelegzeile (line_id) bei den Komponenten angibt (lagerbew_beleg_pos_mutter_id). In der veränderten Sortierung (aktuellen Spalte) werden die Komponenten ans Ende des Belegs gestellt: erst kommen alle Artikel ohne Kopfartikel (lagerbew_beleg_pos_mutter_id = 0) und danach die Komponenten. In lagerbew_beleg_pos_mutter_id steht dann der Wert der umsortierten Displaybelegzeile aus line_id (aktuelle Spalte).
            (Der Spaltenname wurde zur Konsistenz an bestehende Spalten in anderen lagerbew Tabellen angepasst. Ein besserer Name wäre gewesen: lagerbew_beleg_pos_sort_id.)',
   display_art_id                      INTEGER     DEFAULT -1 COMMENT 'Artikel-ID des Displays im Lagerbewegungsbeleg. Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel aufgeführt. Über diese Spalte bekommen die Komponenten die art_id des zugehörigen Displays. Wird bei der Beladung gefüllt.',
   endlief_fg                          INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag zeigt an, ob eine Lieferung abgeschlossen ist. Hergeleitet aus dem Endlieferungskennzeichen elikz.',
   xruem_fg                            INTEGER     NOT NULL COMMENT 'Flag: Rückbuchung in die Vorperiode erlaubt. Abgeleitet aus xruem.',
   betrag_exbwr                        NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Extern eingegebener Buchungsbetrag in Hauswährung. Aus exbwr.',
   betrag_bnk                          NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Bezugsnebenkosten in Hauswährung. Aus bnbtr.',
   betrag_umbewertung                  NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag der Umbewertung beim Rückbuchen in die Vorperiode. Aus dmbum.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LAGERBEW_DET_DELTA PRIMARY KEY (mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj) NOT ENFORCED
)  COMMENT = 'WWC - Hier sind aktuelle Daten geladen, die nach der eigentlichen täglichen Beladung noch eingetroffen sind. Quelle ist mseg';
