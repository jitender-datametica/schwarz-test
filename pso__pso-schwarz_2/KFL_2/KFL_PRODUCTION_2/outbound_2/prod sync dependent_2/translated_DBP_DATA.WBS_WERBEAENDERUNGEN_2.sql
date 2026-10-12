CREATE OR REPLACE TABLE dbp_data.wbs_werbeaenderungen_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Aktion_2-ID.'),
offer_id INTEGER NOT NULL OPTIONS(description='Offer / Angebot_2-ID'),
wup_id INTEGER NOT NULL OPTIONS(description='Filialnummer.'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
dat_beladung DATE NOT NULL OPTIONS(description='Technisches Beladungsdatum.'),
mandant_id_vz INTEGER NOT NULL OPTIONS(description='Mandant_2 VZ.'),
wup_id_vz INTEGER DEFAULT -1 NOT NULL OPTIONS(description='Verteilzentrumsnummer / VZ-WUP_2-ID.'),
nb_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
nb_id_vz INTEGER DEFAULT -111 NOT NULL OPTIONS(description='Nebenbetriebskennziffer VZ'),
dat_ab DATE OPTIONS(description='Aktion_2 gültig von.'),
dat_bis DATE OPTIONS(description='Aktion_2 gültig bis.'),
kjwo INTEGER OPTIONS(description='Werbekalenderwoche, JJJJWW.'),
ausliefergruppe_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Ausliefergruppe / Auslieferungsgruppe.'),
wbs_phase_id INTEGER
OPTIONS(description='WBS-Phase. Gibt an, in welcher Phase bzw. in welchem Prozess-Schritt des Werbemengenberechnungsprozesses sich der Artikel_2 befindet.'),
gp_id INTEGER OPTIONS(description='Lieferant-ID.'),
gk_fg INTEGER OPTIONS(description='Flag: Gondelkopf'),
fachboden_fg INTEGER OPTIONS(description='Flag: Fachboden'),
titel_fg INTEGER OPTIONS(description='Flag: Titelseite'),
rueckseite_fg INTEGER OPTIONS(description='Flag: Rückseite'),
erste_seite_fg INTEGER OPTIONS(description='Flag: Erste Seite'),
kasse_fg INTEGER OPTIONS(description='Flag: Kassenbereich'),
tv_fg INTEGER OPTIONS(description='Flag: TV-Werbung'),
neuer_artikel_fg INTEGER OPTIONS(description='Flag: Neuer Artikel_2'),
preis_normal NUMERIC(29,2) OPTIONS(description='Normal-Verkaufspreis (Brutto).'),
preis_aktion NUMERIC(29,2) OPTIONS(description='Aktions-Verkaufspreis (Brutto).'),
anz_tage_werbung INTEGER OPTIONS(description='Anzahl Tage Werbung.'),
tage_bis_bestellung_lieferant INTEGER OPTIONS(description='Anzahl Tage bis Lieferantenbestellung.'),
tage_bis_deadline_print INTEGER OPTIONS(description='Anzahl Tage bis Print-Deadline.'),
tage_bis_initiale_belieferung INTEGER OPTIONS(description='Anzahl Tage bis zur initialen Belieferung.'),
anz_werbeaenderungen_aufg INTEGER OPTIONS(description='Anzahl Werbeänderungen (aufg.)'),
anz_werbeaenderungen_nach_print INTEGER OPTIONS(description='Anzahl Werbeänderungen (nach Print).'),
werbeaenderung_angebotspreisreduktion_fg INTEGER OPTIONS(description='Flag: Aktions-Verkaufspreis Reduktion.'),
werbeaenderung_angebotspreiserhoehung_fg INTEGER OPTIONS(description='Flag: Aktions-Verkaufspreis Erhöhung.'),
werbeaenderung_normalpreisreduktion_fg INTEGER OPTIONS(description='Flag: Normal-Verkaufspreis Reduktion.'),
werbeaenderung_normalpreiserhoehung_fg INTEGER OPTIONS(description='Flag: Normal-Verkaufspreis Erhöhung.'),
werbeaenderung_artikelneuanlage_fg INTEGER OPTIONS(description='Flag: Artikelneuanlage.'),
werbeaenderung_artikelentfernung_fg INTEGER OPTIONS(description='Flag: Artikelentfernung.'),
werbeaenderung_marktanzahlerhoehung_fg INTEGER OPTIONS(description='Flag: Anz. Märkte Erhöhung.'),
werbeaenderung_marktanzahlreduktion_fg INTEGER OPTIONS(description='Flag: Anz. Märkte Reduktion.'),
werbeaenderung_abbildungsaenderung_fg INTEGER OPTIONS(description='Flag: Änderung Abbildung.'),
werbeaenderung_radio_tv_billboard_fg INTEGER OPTIONS(description='Flag: Radio / TV / Billboard.'),
werbeaenderung_kolliinhaltsaenderung_fg INTEGER OPTIONS(description='Flag: Änderung Kolliinhalt.'),
werbeaenderung_werbethema_fg INTEGER OPTIONS(description='Flag: Änderung Werbethema.'),
werbeaenderung_sonstiges_fg INTEGER OPTIONS(description='Flag: Sonstige Änderung.'),
werbeaenderung_bonuskauf_promotionstyp_fg INTEGER OPTIONS(description='Flag: Änderung bonuskauf_promotionstyp.'),
mindestplatzierung_fg INTEGER OPTIONS(description='Flag: Mindestplatzierung.'),
best_generiert_fg INTEGER OPTIONS(description='Flag: Bestellung generiert.'),
hohe_mengenaenderung_fg INTEGER OPTIONS(description='Flag: Mengenänderung > 20 %.'),
geringe_mengenaenderung_fg INTEGER OPTIONS(description='Flag: Mengenänderung < 20 %.'),
gesteuerte_prognose_fg INTEGER OPTIONS(description='Flag: Prognose durch User gesteuert (Mengen FCST <> FCST_UDF).'),
menge_mindestplatzierung_bme NUMERIC(29,3) OPTIONS(description='Menge Mindestplatzierung in BME.'),
fixmenge_fg INTEGER OPTIONS(description='Flag: Fixmenge.'),
fixmenge_bme NUMERIC(29,3) OPTIONS(description='Fixmenge in BME.'),
mindestmenge_fg INTEGER OPTIONS(description='Flag: Mindestmenge.'),
mindestmenge_bme NUMERIC(29,3) OPTIONS(description='Mindestmenge in BME.'),
maximalmenge_fg INTEGER OPTIONS(description='Flag: Maximalmenge.'),
maximalmenge_bme NUMERIC(29,3) OPTIONS(description='Maximalmenge in BME.'),
bestand_wup_bme NUMERIC(29,3) OPTIONS(description='Marktbestand in BME.'),
offene_bestellungen_bme NUMERIC(29,3) OPTIONS(description='Offene Bestellungen in BME.'),
order_forecast_bme NUMERIC(29,3) OPTIONS(description='Order Forecast in BME.'),
projizierter_bestand_vor_werbung_bme NUMERIC(29,3) OPTIONS(description='Projizierter Bestand vor Werbung in BME.'),
durchschnittlicher_abverkauf_bme NUMERIC(29,3) OPTIONS(description='Durchschnittlicher Abverkauf in BME.'),
prognose_werbezeitraum_bme NUMERIC(29,3) OPTIONS(description='Prognose Werbezeitraum in BME.'),
anteil_wup_artikel_perc NUMERIC(29,2) OPTIONS(description='Anteil dieses Marktes an der Gesamt-Prognosemenge.'),
bedarf_bme NUMERIC(29,3) OPTIONS(description='Bedarf in Basismengeneinheit.'),
bedarf_ame NUMERIC(29,3) OPTIONS(description='Bedarf in Ausliefermengeneinheit.'),
bedarf_pal NUMERIC(29,3) OPTIONS(description='Bedarf in Paletten.'),
zielbestand_bme NUMERIC(29,3) OPTIONS(description='Zielbestand in Basismengeneinheit.'),
bestellmenge_ohne_bestand_ame NUMERIC(29,3)
OPTIONS(description='Errechnete Werbe-Bestellmenge ohne Bestandsberücksichtigung in Ausliefermengeneinheit (AME, z.B. Kolli oder KG). Ohne Bestandsberücksichtigung ist z.B. für den Fall, dass ein aktuell hoher Bestand vor der Aktion_2 wegen Mhd-Ablauf verfällt, oder es wegen anderer Aktionen zu erwarten ist, dass der Bestand sich abverkauft, weshalb die unreduzierte Bestellmenge genommen werden kann.'),
bestellmenge_ohne_bestand_pal NUMERIC(29,3)
OPTIONS(description='Errechnete Werbe-Bestellmenge ohne Bestandsberücksichtigung in Paletten (PAL). Ohne Bestandsberücksichtigung ist z.B. für den Fall, dass ein aktuell hoher Bestand vor der Aktion_2 wegen Mhd-Ablauf verfällt, oder es wegen anderer Aktionen zu erwarten ist, dass der Bestand sich abverkauft, weshalb die unreduzierte Bestellmenge genommen  werden kann.'),
bestellmenge_mit_bestand_ame NUMERIC(29,3)
OPTIONS(description='Errechnete Werbe-Bestellmenge mit Bestandsberücksichtigung in Ausliefermengeneinheit (AME, z.B. Kolli oder KG). Mit Bestandsberücksichtigung ist z.B. für den Fall, dass es einen aktuell hohen Bestand des Artikels gibt, der vor der Aktion_2 wahrscheinlich nicht signifikant abnimmt, was eine_2 Reduktion der Bestellmenge zur Folge haben kann..'),
bestellmenge_mit_bestand_pal NUMERIC(29,3)
OPTIONS(description='Errechnete Werbe-Bestellmenge mit Bestandsberücksichtigung in Paletten (PAL). Mit Bestandsberücksichtigung ist z.B. für den Fall, dass es einen aktuell hohen Bestand des Artikels gibt, der vor der Aktion_2 wahrscheinlich nicht signifikant abnimmt, was eine_2 Reduktion der Bestellmenge zur Folge haben kann.'),
aktion_reihenfolge_zukunft_nr INTEGER
OPTIONS(description='Gibt an, an wievielter Stelle die betrachtete Aktion_2 in der aktuellen Reihenfolge kommender Aktionen steht. Der Rang kann sich im Zeitverlauf ändern (z.B. durch entfallene oder hinzukommende Aktionen) und wird mit jeder dat_beladung neu ermittelt, Mögliche Werte können 1, 2, 3, etc. sein.'),
preis_nachlass_perc NUMERIC(29,2) OPTIONS(description='Preisnachlass in %.'),
kollifaktor NUMERIC(29,3) OPTIONS(description='Kollifaktor (Menge in BME pro Kolli).'),
multi_offer_id_fg INTEGER OPTIONS(description='Artikel_2 mit mehreren offer_ids / angebot_ids bzw. aktion_ids.'),
werbeaenderung_menge_vorlauf NUMERIC(29,3) OPTIONS(description='Mengenänderung zum Vorlauf.'),
fixmenge_wfl_fg INTEGER OPTIONS(description='Fixmenge Flag vom Warenfluss.'),
fixmenge_wfl_bme NUMERIC(29,3) OPTIONS(description='Fixmenge BME vom Warenfluss.'),
fixmenge_wfl_aenderung_fg INTEGER
OPTIONS(description='Bezieht sich auf die Warenfluss FIXMenge Änderung , die in der Spalte FIXMENGE_WFL_BME stattfindet . Das Flag wird auf 1 gesetzt, wenn sich die vom Warenfluss gesetzte Fixmenge im Vergleich zum letzten Berechnungstag geändert hat.'),
fixmenge_wfl_vortag_bme NUMERIC(29,3)
OPTIONS(description='Diese Spaltesie ermöglicht dem Benutzer zu erfahren, welche Menge in BME der Warenfluss am Vortag hatte. Sie ist auch erforderlich, um die Änderung der Fixmenge WFL (Spalte: fixmenge_wfl_bme) nachzuvollziehen.'),
preis_normal_vorlauf NUMERIC(29,2) OPTIONS(description='Normalpreis zum Vorlauf.'),
preis_aktion_vorlauf NUMERIC(29,2) OPTIONS(description='Aktionspreis zum Vorlauf.'),
top_gk_fg INTEGER
OPTIONS(description='initiale Belieferung zur Identifizierung von Belegart UBGK zur Aussteuerung TOP Gondelkopfprozess.'),
bestand_vz NUMERIC(29,3) OPTIONS(description='Anzeige von VZ Bestand (Frei verfügbar).'),
blockierter_bestand_vz NUMERIC(29,3) OPTIONS(description='Anzeige VZ Bestand (für Werbung blockiert).'),
final_verfuegbarer_bestand_vz NUMERIC(29,3)
OPTIONS(description='Anzeige Anteil (customizing) VZ Bestand (für Werbung blockiert)+Anzeige VZ Bestand (frei verfügbar)*Faktor.'),
bestellung_lieferant_menge NUMERIC(29,3) OPTIONS(description='Übertragung Richtung VZ-Disposchnittstelle.'),
bestellung_lieferant_fg INTEGER
OPTIONS(description='Sagt aus ob die Bestellung beim Lieferanten an das VZ getätigt wurde. Die Flag BESTELLUNG_LIEFERANT_MIT_BESTAND_FG sagt dann aus wie bzw. welche Art_2 von Bestellung getätigt wurde. Wenn BESTELLUNG_LIEFERANT_FG = 1 und BESTELLUNG_LIEFERANT_MIT_BESTAND_FG = 0 ist dann wurde eine_2 Bestellung ohne Bestandsberücksichtigung getätigt.'),
bestellung_lieferant_mit_bestand_fg INTEGER
OPTIONS(description='Flag: Wird gesetzt, wenn die Werbemenge mit Bestandsberücksichtigung durch die VZ-Disposition beim Lieferanten bestellt werden soll (Phase-Switch I).\n            Wird für Artikellevel erst über Warengruppeneinstellungen in TS_WBS_WARENGRUPPE.AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG gesteuert, kann dann aber auch manuell für den Artikel_2 in MSTR gesetzt bzw. überschrieben werden.\n            Mit der Flag soll auch verhindert werden, dass die initiale Liefermenge an die Märkte erneut mit Bestandsberücksichtigung ermittelt wird (Phase-Switch III), was einem doppelten Abzug entsprechen würde. Also für den Fall, dass ein MIT_BESTAND Phase-Switch auch auf 1 gestellt wird, während der andere schon auf 1 ist. (TS_WBS_WARENGRUPPE.AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG und TS_WBS_WARENGRUPPE.AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_III_FG sollten auch nicht gleichzeitig 1 sein.)'),
stille_aktion_fg INTEGER
OPTIONS(description='Identifikation\""In Store Promotions\"" um Artikel_2 mit FG aus Berechnung auszuschließen.'),
prognose_ungesteuert NUMERIC(29,3)
OPTIONS(description='Prognose ungesteuert aus UDF, ohne Korrekturen / strukturierte Artikel.'),
menge_zuletzt_dc_promo NUMERIC(29,3) OPTIONS(description='Menge die zuletzt aus DC Promo übertragen wurde.'),
pmr_werbethema_id STRING(6) COLLATE 'und:ci' OPTIONS(description='Thema ID.'),
referenzmarkt_fallback_fg INTEGER
OPTIONS(description='Identifizierung von „Fallback“-PrognosenIdentifizierung von „Fallback“-Prognosen.'),
rabattaenderung_fg INTEGER OPTIONS(description='Flag bei Preisänderung des Preisrabattes.'),
abbildung_vortag_id STRING(6) OPTIONS(description='Welche Abbildung im Handzettel hatte der Artikel_2 am Vortrag.'),
werbethema_vortag_bez STRING(50) OPTIONS(description='Welches Werbethema hatte der Artikel_2 am Vortag.'),
art_id_mutter INTEGER OPTIONS(description='Mutter ID zu VK_2-Set/Display Artikeln.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR.'),
werbelistung_fg INTEGER
OPTIONS(description='Flag zur Anzeige der Werbelistung im PMR(Promotion Management for Retail).Zeigt an ob ein Artikel_2 während der Werbung in dem Markt gelistet ist.Je nach Marktgröße sind die Sortimente verschieden groß, weshalb ein Artikel_2 nach der Werbung wieder ausgelistet sein kann, wenn er nicht zum regulären Sortiment diese Marktes gehört. Bei Artikel_2 die nich regulär in einem Markt gelistet sind, ist die Flag = 0 solange es eine_2 Zwischenaktion vor der betrachteten Aktion_2 gibt, und wird auf 1 gesetzt, sobald die Zwischenaktion vorbei ist.Mit dieser Flag ist es möglich Artikel_2 anzulegen bevor die Werbelistung eintritt, womit eine_2 technische Einschränkung im Quellsystem/SAP überwunden wird, wodurch nur Daten für gelistete Artikel_2 übermittelt wurden. Da ein Artikel_2 für eine_2 zuküftige Aktion_2 in einem Markt vor der Aktion_2 ungelistet sein kann(wenn nicht im regulären Sortiment), und auch keine Werbelistung bestehen kann weil eine_2 Zischenaktion stattfindet, konnten vorher keine (groben) Berechnungen und Bestellungen in WBS für.'),
werbelistung_aenderung_fg INTEGER
OPTIONS(description='Flag zur Anzeige der Änderung der Werbelistung im PMR (Promotion Management for Retail). Zeigt an ob ein Artikel_2 während der Werbung in dem Markt gelistet ist. (Denormalisierung für Frontend-Optimierung. Die Änderung ließe sich vermutlich auch aus dem Unterschied zwischen den Tagen errechnen.)\n            Wenn WERBELISTUNG_FG (siehe eigener Kommentar) von 0 auf 1 gesetzt wird, dann wird am selben Tag_2 auch diese Flag auf 1 gesetzt, und am darauf folgenden Tag_2 wieder auf 0. Die betrachtete Flag kennzeichnet das Datum ab dem genauere Nachberechnungen mit Hilfe von WBS durchgeführt werden können. Eventuell können sich daraus Änderungen an den Bestellmengen ergeben da ab hier eine_2 andere Basis herangezogen werden kann.'),
aktion_reihenfolge_aenderung_fg INTEGER
OPTIONS(description='Flag: Zeigt an, dass zu einem bestimmten DAT_BELADUNG die Aktionsreihenfolge sich geändert hat. Ist für den User hilfreich um nach Änderungen zu filtern.'),
vortag_aktion_reihenfolge_zukunft_nr INTEGER
OPTIONS(description='Gibt an, an wievielter Stelle die betrachtete Aktion_2 am Vortag in der aktuellen Reihenfolge kommender Aktionen steht. '),
zeitpunkt_bestellung_lieferant_prognose_bedarf_bme NUMERIC(29,3)
OPTIONS(description='Prognostizierter Bedarf in Basismengeneinheit zum Zeitpunkt der Bestellung beim Lieferanten. Redundant gespeichert zum Wert in BEDARF_BME zu dem Datum als die Bestellung getätigt wurde. Die tatsächliche Bestellmenge kann entweder die volle Bedarfsmenge hier gewesen sein oder die Bedarfsmenge abzüglich des am Datum der Bestellung prognostizierten Bestands zu Werbebeginn im Markt (auch die Prognosen ändern sich über die Zeit_2).'),
wup_id_ref INTEGER
OPTIONS(description='Der Referenzmarkt, der fuer den Artikelvergleich gespeichert wird. Fuer eine_2 zukuenftige Aktion_2 eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion_2 und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel_2 und Markt der geplanten Aktion_2 sein. Der Referenztyp sagt aus um welche Art_2 von Vergleich es sich handelt.\n            Fuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ_2, welche manuell von Nutzern gepflegt.\n            Fuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER_2 eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.'),
nb_id_ref INTEGER OPTIONS(description='NB_ID_REF, welche zur WUP_ID_REF gehört.'),
art_id_ref INTEGER
OPTIONS(description='Der Referenzartikel, der für den Artikelvergleich gespeichert wurde. Fuer eine_2 zukuenftige Aktion_2 eines Artikels in einem Markt werden Liefer- und Abverkaufsdaten einer vergangenen Aktion_2 und dem Referenzartikel und -markt herangezogen. Muss nicht gleich sein zu Artikel_2 und Markt der geplanten Aktion_2 sein. Der Referenztyp sagt aus um welche Art_2 von Vergleich es sich handelt.\n            Fuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ_2, welche manuell von Nutzern gepflegt.\n            Fuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER_2 eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.'),
faktor_ref NUMERIC(29,2)
OPTIONS(description='Faktor für die Gewichtung der Referenzmetriken.\n            Fuer WBS_ART_WUP_REF_TYP_ID = [2,3,4] kommt es aus der Tabelle ART_WUP_STATUS_REFERENZ_2, welche manuell von Nutzern gepflegt.\n            Fuer den Fall, dass WBS_ART_WUP_REF_TYP_ID = 1 werden die Werte aus Tabelle WBS_ART_AKTION_PER_2 eingefuegt: ART_ID_REF = ART_ID, WUP_ID_REF = WUP_ID und NB_ID_REF = NB_ID sowie FAKTOR_REF = 1.'),
wfl_menge_geprueft_fg INTEGER
OPTIONS(description='Warenfluss_menge_Flag oder Supply chain Managment flag , die der Benutzer setzen kann in der Tabelle (MENGENAENDERUNGEN_WRITEBACK), um zu markieren, dass er die Mengen für diesen Artkel bereits überprüft hat, und würde die beibhalten solange es keine Änderungen bei der Promotion gibt '),
wfl_menge_geprueft_reset_fg INTEGER
OPTIONS(description='Flag, welches auf 1 gesetzt werden soll, wenn das WFL_MENGE_GEPRUEFT_FG\""resettet\"" wird d.h von 1 auf 0 springt.'),
wfl_nutzer_kommentar_txt STRING(100)
OPTIONS(description='Frei-Text-Feld für den Benutzer\n            Dieses Feld dient dazu, einen zusätzlichen Kommentar zu einem Artikel_2 hinzuzufügen. um besser nachzuvollziehen, was das Problem vorher war'),
fixmenge_ek_aenderung_fg INTEGER
OPTIONS(description='Bezieht sich auf die  Einkauf FIXMenge Änderung , die in der Spalte Festmenge_BME stattfindet . Das Flag wird auf 1 gesetzt, wenn sich die vom Einkauf gesetzte Fixmenge im Vergleich zum letzten Berechnungstag geändert hat.'),
fixmenge_ek_vortag_bme NUMERIC(29,3)
OPTIONS(description='Diese Spalte ermöglicht dem Benutzer zu erfahren, welche Menge in BME der Einkauf am Vortag hatte. Sie ist auch ist erforderlich, um die Änderung der Fixmenge EK nachzuvollziehen (Spalte: fixmenge_bme). '),
anz_angebote_zeitraum INTEGER
OPTIONS(description='Anzahl der Angebote, welche die Artikel_markt Kombination und im gleichen Zeitraum stattfinden (art_id, wup_id, dat_von, dat_bis  for the current dat_beladung).'),
anz_angebote_zeitraum_aenderung_fg INTEGER
OPTIONS(description='Flag, welche anzeigt, ob sich die Anzahl der Angebote, die die Artikel_2-Markt-Kombination aufweisen und im selben Zeitraum stattfinden, im Vergleich zum letzten Berechnungstag geändert hat.'),
nur_online_fg INTEGER OPTIONS(description='Flag, welches anzeigt, ob die Werbung nur online geschaltet wurde.'),
kundenkarte_personalisiert_fg INTEGER
OPTIONS(description='Flag: welches anzeigt ob die werbung einen personalisierter Kundenkarten-Coupon ist'),
werbeaenderung_kundenkarte_personalisiert_fg INTEGER
OPTIONS(description='Flag, welches anzeigt, ob eine_2 Änderung in dem KUNDENKARTE_PERSONALISIERT Coupons im Vergleich zum letzten Tag_2 erfolgte'),
stille_aktion_mit_menge_fg INTEGER
OPTIONS(description='Flag, welches anzeigt, dass die Werbung eine_2 stille Werbung ist, die nur in Filialen beworben ist, aber mit Menge_hochrechnung.( für Kombination WERBEMITTEL_ART_ID = 0920 & WERBEMITTEL_ID = 50)'),
min_platzierung_markt_cluster_id INTEGER OPTIONS(description='Markt-Cluster für Mindestplatzierung (1-3).'),
estimation_id INTEGER
OPTIONS(description='With this ID the user can decide in which way the estimation for WBS TP2 should be calculated.\n            ID 0 = no estimation\n            ID 1 = calculate normal estimation process\n            ID 2 = only fill up maximum capacity (Berechnung für die Werbung in WBS, aber nur um das Regal aufzufüllen)'),
estimation_id_aenderung_fg INTEGER
OPTIONS(description='Flag zur Anzeige der Änderung der Estimation-ID im Vergleich zum Vortag (1 oder 0). Ist für den User hilfreich um nach Änderungen zu filtern.'),
utp_relevant_fg INTEGER
OPTIONS(description='Gibt an ob einen Artikel_2 als UTP-relevant markiert ist (0 oder 1).\n            UTP = Unfair trade practices. Ist ein EU-Gesetz um kleine Lieferanten vor Großaufträgen zu schützen.'),
utp_relevant_aenderung_fg INTEGER
OPTIONS(description='Flag zeigt die Änderung der UTP_RELEVANT_FG im Vergleich zum Vortag (1 oder 0). Ist für den User hilfreich um nach Änderungen zu filtern.'),
utp_lieferant_bestaetigt_fg INTEGER
OPTIONS(description='Flag gibt an, ob ein UTP-Lieferant die Werbebestellmenge freigegeben hat (0 oder 1).'),
dat_gueltig_von_konditionsart_zar5 DATE OPTIONS(description='Beginn der Gültigkeit der Konditionsart ZAR5.'),
dat_gueltig_bis_konditionsart_zar5 DATE OPTIONS(description='Ende der Gültigkeit der Konditionsart ZAR5.'),
menge_kolliinhalt_vortag_bme NUMERIC(29,3)
OPTIONS(description='Kolliinhalt des Vortages. Aus Feld: Kollifaktor (Menge in BME pro Kolli).'),
init_lief_modus_kz STRING(100)
OPTIONS(description='Beschreibt den Modus, in welchem die initiale Belieferung berechnet wird (O = Order, S = Simulation, N = None).\n            - N: wenn keine initiale Belieferung errechnet wird (vor wbs_phase_id = 8).\n            - S: berechnen die Erstlieferung 40 Tage vor der Promotion - es werden keine wirklichen Bestellungen in den Geschäften erzeugt sondern die Spalte ermöglicht DC Dispo, den ersten Liefersplit schon sehr früh zu sehen und die Mengen beim Lieferanten entsprechend zu bestellen (wbs_phase_id 7 bis 3).\n            - O: der ursprüngliche initiale Lieferlauf findet 9 Tage vor der Promotion statt, und der Berechnungslauf wird als\""O\"" (Order Creation) gekennzeichnet (ab wbs_phase_id = 2).'),
gp_id_aenderung_fg INTEGER
OPTIONS(description='Flag, welches angibt, ob sich die Lieferantennummer (GP_ID) geändert hat'),
konditionsart_zar5_gueltigkeit_aenderung_fg INTEGER
OPTIONS(description='Flag, welches angibt, ob sich der Zeitraum für die ZAR5-Gültigkeit geändert hat.'),
posten_kz_sap STRING(2) COLLATE 'und:ci'
OPTIONS(description='Postenkennzeichen. Für Artikel_2, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert)'),
posten_kz_sap_aenderung_fg INTEGER
OPTIONS(description='Flag, welches angibt, ob der Artikel_2 von Posten auf Sortimentsartikel oder umgekehrt geändert hat'),
bonuskauf_promotionstyp_liste_txt STRING(1000)
OPTIONS(description='Die Spalte enthält die konkatenierten Aktionsarten (Feld AKART in PMR), erwartete Einträge sind z.B. 0001, 0005, ZAI, ZBBR.\n            Gibt die Aktionsart für eine_2 Aktion_ID an Z.B:\n            Aktionsart\'0001\' eine_2 Standard-Aktion_2 im Prospekt\n            oder\'ZBBR\' wäre_2 eine_2 Bonuskauf-Aktion.\n            Die Art_2 der Aktion_2 hat Einfluss darauf, ob und wie die SCM-Mengen für diese Aktion_2 berechnet werden.'),
saison_id STRING(10) COLLATE 'und:ci' OPTIONS(description='ID der Saison aus saiso, z.Bsp 9.'),
saison_id_aenderung_fg INTEGER OPTIONS(description='Flag, gibt an, ob der Artikel_2 das Saisonkennzeichen geändert hat'),
best_menge_einh_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Bestellmengeneinheit. Diese Mengeneinheit wird standardmäßig bei Bestellungen verwendet.'),
best_menge_einh_vortag_id STRING(3)
OPTIONS(description='Bestellmengeneinheit des Vortages. Diese Mengeneinheit wird standardmäßig bei Bestellungen verwendet.'),
best_menge_einh_id_aenderung_fg INTEGER
OPTIONS(description='Flag, gibt an, ob es eine_2 Änderung der Bestellmengeneinheit zum Vortag gab'),
bedarf_estimation_id_2_bme NUMERIC(29,3)
OPTIONS(description='Simulierter Bedarf in Basismengeneinheit, welcher unter Verwendung der Estimation_ID = 2 ermittelt werden würde.'),
bestellmenge_estimation_id_2_ohne_bestand_ame NUMERIC(29,3)
OPTIONS(description='Simulierte Werbe-Bestellmenge ohne Bestandsberücksichtigung in Ausliefermengeneinheit (AME, z.B. Kolli oder KG), welcher unter Verwendung der Estimation_ID = 2 ermittelt werden würde.'),
bestellmenge_estimation_id_2_mit_bestand_ame NUMERIC(29,3)
OPTIONS(description='Simulierte Werbe-Bestellmenge mit Bestandsberücksichtigung in Ausliefermengeneinheit (AME, z.B. Kolli oder KG), welcher unter Verwendung der Estimation_ID = 2 ermittelt werden würde.'),
adjustment_id INTEGER
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n            2 = Platzhalter (Stand 28.03.2025)\n            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_2 manuelle Bestellanlage durch das Land_2 notwendig.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
bonuskauf_promotionstyp_liste_vortag_txt STRING(1000)
OPTIONS(description='Die Spalte enthält die konkatenierten Aktionsarten des vorangegangenen Berechnungslaufs.\n            Struktur und Logik entsprechen der Spalte BONUSKAUF_PROMOTIONSTYP_LISTE_TXT, jedoch mit dem Stand des Vorlaufs.'),
dk_fg INTEGER
OPTIONS(description='Flag gibt an, ob eine_2 Aktion_2 (Offer) in der UDF-Prognose durch die sogenannte Doorkeeper-Logik herausgefiltert wurde.\n            1 (Ja): Die Aktion_2 wurde durch den Doorkeeper ausgefiltert und ist somit in UDF inaktiv.\n            0 (Nein): Die Aktion_2 wurde nicht ausgefiltert und bleibt in UDF aktiv.\n            Quelle ist das Feld DK_RELEVANCE aus der SAP Tabelle ZUDF_OFRWBS_DATA. Mapping: wenn X=1, sonst 0.'),
PRIMARY KEY (mandant_id, offer_id, wup_id, art_id, dat_beladung, mandant_id_vz, wup_id_vz) NOT ENFORCED
) OPTIONS(description='SCM-WBS - Werbeänderungen (kumuliert).');

