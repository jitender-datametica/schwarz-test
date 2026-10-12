DROP TABLE IF EXISTS kfl_production_dbp_data.lagerbew_det_2;
CREATE OR REPLACE TABLE kfl_production_dbp_data.lagerbew_det_2 (
mandant_id INTEGER NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
lagerbew_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung aus mblnr.'),
lagerbew_beleg_pos_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Lagerbelegbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Aus zeile.'),
kj INTEGER NOT NULL
OPTIONS(description='Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötgit um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus mjahr.'),
grund_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld enthält den Grund für eine_2 Lagerbewegung.'),
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld enthält die Bewegungsart einer Lagerbewegung, aus bwart. Lookup-Tabelle ist l_lager_bewart.'),
art_id INTEGER OPTIONS(description='Artikel_2-ID, aus matnr.'),
wup_id INTEGER OPTIONS(description='WarenUmschlagsPlatz aus mseg.werks.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
auto_fg STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Attribut auto_fg kennzeichnet Belegpositionen, die automatisch generiert wurden. Aus xauto. Wertevorrat: S, X, L, blank. Es handelt sich also nicht um ein Flag, wie die Bezeichnung suggeriert!) '),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort, aus LGORT.'),
gp_id INTEGER OPTIONS(description='Geschäftspartner-ID (Lieferanten-ID), aus lifnr.'),
einkaufsorganisation_id INTEGER
OPTIONS(description='Die Einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP_2 zusammen mit dem Attribut gp_id eindeutig zu identifizieren. 1000 = Warenlieferant, 5000 = Frischelieferant, 9000 = ? (könnte es auch geben).'),
soll_haben_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
best_beleg_id INTEGER
OPTIONS(description='Das Feld enthält die Beleg-ID der Bestellung und dient der eindeutigen Identifikation des Bestellbelegs. Aus ebeln.'),
best_beleg_pos_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestell-ID der eindeutigen Identifikation der Bestellbelegposition. Aus ebelp.'),
betrag_lagerbew NUMERIC(18,4)
OPTIONS(description='Betrag der Belegposition in der Hauswährung des Buchungskreises. Aus dmbtr. Entspricht dem eknetto_bnk.'),
betrag_verkauf NUMERIC(18,2) NOT NULL
OPTIONS(description='Listenpreis (Verkaufspreis brutto * Menge). Das Feld entspricht mseg.vkwrt.'),
erfsngs_menge_einh_id STRING(3) NOT NULL
OPTIONS(description='Dieses Feld enthält die ID der Mengeneinheit für die Umrechnung der Basismenge in die alternative Mengeneinheit. Dazu ist der Umrechnungsfaktor aus der DWH Tabelle art_umrechnung_faktor_per_2 pro Material zu ermitteln. Aus erfme.'),
lagerplatz_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='ID des Lagerplatzes. Vierte Ebene der Lagerhierarchie. Aus lgpla.'),
kunde_id STRING(10) COLLATE 'und:ci' OPTIONS(description='ID des Kunden. Aus kunnr.'),
menge_lagerbew_kolli NUMERIC(18,3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per_2 ermittelt.'),
menge_lagerbew_bme NUMERIC(18,3) NOT NULL
OPTIONS(description='Mengenanteil der Gesamtbestellmenge, dem diese Kontierungsposition zugeordnet wird. Die eingegebene Menge bestimmt, welcher Anteil der Kosten auf diese Kontierungsposition verteilt wird. Aus menge.'),
menge_lagerbew_palette NUMERIC(18,3)
OPTIONS(description='Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_2 und art_umrechnung_faktor_per_2 ermittelt.'),
menge_lieferschein NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge in Mengeneinheit aus Lieferschein, aus lsmng. Gibt die Menge an, die vom Lieferanten als gelieferte Menge auf Begleitpapieren (z.B. Lieferschein) ausgewiesen wird.'),
menge_lief NUMERIC(18,3) NOT NULL
OPTIONS(description='Gibt die gelieferte Menge in Bestellpreismengeneinheit an. Aus bpnmg.'),
menge_erf NUMERIC(18,3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Menge in der Erfassungsmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_2 und art_umrechnung_faktor_per_2 ermittelt. Aus erfmg.'),
empfaenger_id INTEGER
OPTIONS(description='Dieses Feld enthält das empfangende Werk für diese Lagerbewegung, aus umwrk. Dieses Feld enthält die Fachschlüssel der VZ.'),
dat_buch DATE NOT NULL
OPTIONS(description='Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_2 erfasst wird. Das Feld wird aus der Kopftabelle\"vererbt\", um einen PPI darüber bilden zu können (Performance!).'),
lagerbew_beleg_storno_id INTEGER
OPTIONS(description='Beleg-ID des stornierten Beleges. Referenz von Storno zu storniertem Beleg in der Tabelle lagerbew_det. Aus smbln.'),
lagerbew_beleg_pos_storno_id INTEGER
OPTIONS(description='Belegposition des stornierten Beleges. Referenz von Storno zu storniertem Beleg in der Tabelle lagerbew_det. Aus smblp.'),
lagerbew_beleg_storno_kj INTEGER
OPTIONS(description='Belegposition des stornierten Beleges. Referenz von Storno zu storniertem Beleg in der Tabelle lagerbew_det. Aus sjahr.'),
betrag_vk_netto NUMERIC(18,2) NOT NULL OPTIONS(description='Entspricht dem Attribut vkwra aus der Tabelle mseg.'),
system_id INTEGER NOT NULL OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
betrag_belegfluss_wg_art NUMERIC(18,2) DEFAULT 0
OPTIONS(description='Betrag aus der Tabelle best_belegfluss. Denormalisierung zur Performancesteigerung bei WBF Abfragen. Nur gefüllt bei WG Erfassartikeln, sonst Null. Nicht im logischen Modell.'),
mandant_id_kunde INTEGER OPTIONS(description='Der Mandant_2 des Kunden, kann ein anderer sein als der des WUP.'),
mandant_id_empfaenger INTEGER OPTIONS(description='Der Mandant_2 des Empfängers, kann ein anderer sein als der des WUP.'),
bw_vorgang_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Dieses Feld wird im SAP-BW gebildet, u.a aus der Lager Bewegungsart und dem Soll-Haben-Kennzeichen.'),
betrag_verkauf_ist NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Tatsächlicher Marktpreis (Verkaufspreis brutto * Menge). Das Feld entspricht mseg.exvkw.'),
betrag_vk_netto_vz NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Nettobetrag. Kein Original-mseg-Feld. Wird im DWH nur für Verteilzentren angereichert.'),
betrag_verkauf_ist_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Tatsächlicher Marktpreis netto ((Verkaufspreis brutto minus MWSt) * Menge). Das Feld wird im DWH aus mseg.exvkw und Mehrwertsteuerbetrag errechnet.'),
betrag_einstandspreis NUMERIC(18,4)
OPTIONS(description='Betrag der Belegposition bewertet zum Einstandspreis. Wird nur für KMO-Daten angereichert.'),
gp_id_zl INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Lieferantennummer. In der Versorgung wird der Lieferant aus der Bezugsquellenfindung angereichert - nur für KMO. Bei ZL-Bewegungsarten ist die gp_id in dieser Tabelle leer.'),
bq_findung_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='ID zur Kennzeichnung des Ausstiegspunkts aus dem Kreisprozess. Wird bei der Versorgung angereichert. Nur für KMO gefüllt, sonst 0'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
lagerbew_beleg_pos_mutter_id INTEGER
OPTIONS(description='Verweis auf die umsortierte Lagerbewegungsbelegposition des zu diesem Artikel_2 übergeordneten Artikels (falls er existiert). Aus parent_id.\n            Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel_2 in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel_2 aufgeführt. Um Komponenten und Displays einander zuzuordnen, wurden in SAP neue Spalten hinzugefügt, welche die Belegzeilen (lagerbew_beleg_pos_id) neu sortieren und dann die neue Displaybelegzeile (line_id) bei den Komponenten angibt (aktuelle Spalte). In der veränderten Sortierung (line_id) werden die Komponenten ans Ende des Belegs gestellt: erst kommen alle Artikel_2 ohne Kopfartikel (lagerbew_beleg_pos_mutter_id = 0) und danach die Komponenten. In lagerbew_beleg_pos_mutter_id (aktuelle Spalte) steht dann der Wert der umsortierten Displaybelegzeile aus line_id.\n            (Der Spaltenname wurde zur Konsistenz an bestehende Spalten in anderen lagerbew_2 Tabellen angepasst. Ein besserer Name wäre_2 gewesen: lagerbew_bel'),
line_id INTEGER
OPTIONS(description='Umsortierte Lagerbewegungsbelegpositionen zur Verbindung von Displays und Displaykomponenten (entspricht der Form früherer Belege vor der Einführung der Display / Komponenten Beziehung). Aus line_id.\n            Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel_2 in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel_2 aufgeführt. Um Komponenten und Displays einander zuzuordnen, wurden in SAP neue Spalten hinzugefügt, welche die Belegzeilen (lagerbew_beleg_pos_id) neu sortieren und dann die neue Displaybelegzeile (line_id) bei den Komponenten angibt (lagerbew_beleg_pos_mutter_id). In der veränderten Sortierung (aktuellen Spalte) werden die Komponenten ans Ende des Belegs gestellt: erst kommen alle Artikel_2 ohne Kopfartikel (lagerbew_beleg_pos_mutter_id = 0) und danach die Komponenten. In lagerbew_beleg_pos_mutter_id steht dann der Wert der umsortierten Displaybelegzeile aus line_id (aktuelle Spalte).\n            (Der Spaltenname wurde zur Konsistenz an bestehende Spalten i'),
display_art_id INTEGER DEFAULT - 1
OPTIONS(description='Artikel_2-ID des Displays im Lagerbewegungsbeleg. Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel_2 in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel_2 aufgeführt. Über diese Spalte bekommen die Komponenten die art_id des zugehörigen Displays. Wird bei der Beladung gefüllt.'),
PRIMARY KEY (mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj) NOT ENFORCED
) CLUSTER BY mandant_id, dat_buch
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Detaildaten der Lagerbewegungen aus der SAP Tabelle MSEG enthalten.');