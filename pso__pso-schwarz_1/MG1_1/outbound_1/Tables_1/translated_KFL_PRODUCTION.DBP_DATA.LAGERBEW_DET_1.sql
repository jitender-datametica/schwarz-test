DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.LAGERBEW_DET_1;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.LAGERBEW_DET_1 (
MANDANT_ID INTEGER NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
LAGERBEW_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung aus mblnr.'),
LAGERBEW_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Lagerbelegbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Aus zeile.'),
KJ INTEGER NOT NULL
OPTIONS(description='Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötgit um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus mjahr.'),
GRUND_ID STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld enthält den Grund für eine_1 Lagerbewegung.'),
LAGER_BEWART_ID STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld enthält die Bewegungsart einer Lagerbewegung, aus bwart. Lookup-Tabelle ist l_lager_bewart.'),
ART_ID INTEGER OPTIONS(description='Artikel_1-ID, aus matnr.'),
WUP_ID INTEGER OPTIONS(description='WarenUmschlagsPlatz aus mseg.werks.'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
AUTO_FG STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Attribut auto_fg kennzeichnet Belegpositionen, die automatisch generiert wurden. Aus xauto. Wertevorrat: S, X, L, blank. Es handelt sich also nicht um ein Flag, wie die Bezeichnung suggeriert!) '),
LAGERORT_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort, aus LGORT.'),
GP_ID INTEGER OPTIONS(description='Geschäftspartner-ID (Lieferanten-ID), aus lifnr.'),
EINKAUFSORGANISATION_ID INTEGER
OPTIONS(description='Die Einkaufsorganisation_id ist erforderlich um einen Lieferanten der Tabelle GP_1 zusammen mit dem Attribut gp_id eindeutig zu identifizieren. 1000 = Warenlieferant, 5000 = Frischelieferant, 9000 = ? (könnte es auch geben).'),
SOLL_HABEN_KZ STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg.'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
BEST_BELEG_ID INTEGER
OPTIONS(description='Das Feld enthält die Beleg-ID der Bestellung und dient der eindeutigen Identifikation des Bestellbelegs. Aus ebeln.'),
BEST_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestell-ID der eindeutigen Identifikation der Bestellbelegposition. Aus ebelp.'),
BETRAG_LAGERBEW NUMERIC(18,4)
OPTIONS(description='Betrag der Belegposition in der Hauswährung des Buchungskreises. Aus dmbtr. Entspricht dem eknetto_bnk.'),
BETRAG_VERKAUF NUMERIC(18,2) NOT NULL
OPTIONS(description='Listenpreis (Verkaufspreis brutto * Menge). Das Feld entspricht mseg.vkwrt.'),
ERFSNGS_MENGE_EINH_ID STRING(3) NOT NULL
OPTIONS(description='Dieses Feld enthält die ID der Mengeneinheit für die Umrechnung der Basismenge in die alternative Mengeneinheit. Dazu ist der Umrechnungsfaktor aus der DWH Tabelle art_umrechnung_faktor_per_1 pro Material zu ermitteln. Aus erfme.'),
LAGERPLATZ_ID STRING(10) COLLATE 'und:ci'
OPTIONS(description='ID des Lagerplatzes. Vierte Ebene der Lagerhierarchie. Aus lgpla.'),
KUNDE_ID STRING(10) COLLATE 'und:ci' OPTIONS(description='ID des Kunden. Aus kunnr.'),
MENGE_LAGERBEW_KOLLI NUMERIC(18,3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per_1 ermittelt.'),
MENGE_LAGERBEW_BME NUMERIC(18,3) NOT NULL
OPTIONS(description='Mengenanteil der Gesamtbestellmenge, dem diese Kontierungsposition zugeordnet wird. Die eingegebene Menge bestimmt, welcher Anteil der Kosten auf diese Kontierungsposition verteilt wird. Aus menge.'),
MENGE_LAGERBEW_PALETTE NUMERIC(18,3)
OPTIONS(description='Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_1 und art_umrechnung_faktor_per_1 ermittelt.'),
MENGE_LIEFERSCHEIN NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge in Mengeneinheit aus Lieferschein, aus lsmng. Gibt die Menge an, die vom Lieferanten als gelieferte Menge auf Begleitpapieren (z.B. Lieferschein) ausgewiesen wird.'),
MENGE_LIEF NUMERIC(18,3) NOT NULL
OPTIONS(description='Gibt die gelieferte Menge in Bestellpreismengeneinheit an. Aus bpnmg.'),
MENGE_ERF NUMERIC(18,3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Menge in der Erfassungsmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_1 und art_umrechnung_faktor_per_1 ermittelt. Aus erfmg.'),
EMPFAENGER_ID INTEGER
OPTIONS(description='Dieses Feld enthält das empfangende Werk für diese Lagerbewegung, aus umwrk. Dieses Feld enthält die Fachschlüssel der VZ.'),
DAT_BUCH DATE NOT NULL
OPTIONS(description='Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_1 erfasst wird. Das Feld wird aus der Kopftabelle\"vererbt\", um einen PPI darüber bilden zu können (Performance!).'),
LAGERBEW_BELEG_STORNO_ID INTEGER
OPTIONS(description='Beleg-ID des stornierten Beleges. Referenz von Storno zu storniertem Beleg in der Tabelle lagerbew_det. Aus smbln.'),
LAGERBEW_BELEG_POS_STORNO_ID INTEGER
OPTIONS(description='Belegposition des stornierten Beleges. Referenz von Storno zu storniertem Beleg in der Tabelle lagerbew_det. Aus smblp.'),
LAGERBEW_BELEG_STORNO_KJ INTEGER
OPTIONS(description='Belegposition des stornierten Beleges. Referenz von Storno zu storniertem Beleg in der Tabelle lagerbew_det. Aus sjahr.'),
BETRAG_VK_NETTO NUMERIC(18,2) NOT NULL OPTIONS(description='Entspricht dem Attribut vkwra aus der Tabelle mseg.'),
SYSTEM_ID INTEGER NOT NULL OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
BETRAG_BELEGFLUSS_WG_ART NUMERIC(18,2) DEFAULT 0
OPTIONS(description='Betrag aus der Tabelle best_belegfluss. Denormalisierung zur Performancesteigerung bei WBF Abfragen. Nur gefüllt bei WG Erfassartikeln, sonst Null. Nicht im logischen Modell.'),
MANDANT_ID_KUNDE INTEGER OPTIONS(description='Der Mandant_1 des Kunden, kann ein anderer sein als der des WUP.'),
MANDANT_ID_EMPFAENGER INTEGER OPTIONS(description='Der Mandant_1 des Empfängers, kann ein anderer sein als der des WUP.'),
BW_VORGANG_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Dieses Feld wird im SAP-BW gebildet, u.a aus der Lager Bewegungsart und dem Soll-Haben-Kennzeichen.'),
BETRAG_VERKAUF_IST NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Tatsächlicher Marktpreis (Verkaufspreis brutto * Menge). Das Feld entspricht mseg.exvkw.'),
BETRAG_VK_NETTO_VZ NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Nettobetrag. Kein Original-mseg-Feld. Wird im DWH nur für Verteilzentren angereichert.'),
BETRAG_VERKAUF_IST_NETTO NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Tatsächlicher Marktpreis netto ((Verkaufspreis brutto minus MWSt) * Menge). Das Feld wird im DWH aus mseg.exvkw und Mehrwertsteuerbetrag errechnet.'),
BETRAG_EINSTANDSPREIS NUMERIC(18,4)
OPTIONS(description='Betrag der Belegposition bewertet zum Einstandspreis. Wird nur für KMO-Daten angereichert.'),
GP_ID_ZL INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Lieferantennummer. In der Versorgung wird der Lieferant aus der Bezugsquellenfindung angereichert - nur für KMO. Bei ZL-Bewegungsarten ist die gp_id in dieser Tabelle leer.'),
BQ_FINDUNG_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='ID zur Kennzeichnung des Ausstiegspunkts aus dem Kreisprozess. Wird bei der Versorgung angereichert. Nur für KMO gefüllt, sonst 0'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
LAGERBEW_BELEG_POS_MUTTER_ID INTEGER
OPTIONS(description='Verweis auf die umsortierte Lagerbewegungsbelegposition des zu diesem Artikel_1 übergeordneten Artikels (falls er existiert). Aus parent_id.\n            Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel_1 in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel_1 aufgeführt. Um Komponenten und Displays einander zuzuordnen, wurden in SAP neue Spalten hinzugefügt, welche die Belegzeilen (lagerbew_beleg_pos_id) neu sortieren und dann die neue Displaybelegzeile (line_id) bei den Komponenten angibt (aktuelle Spalte). In der veränderten Sortierung (line_id) werden die Komponenten ans Ende des Belegs gestellt: erst kommen alle Artikel_1 ohne Kopfartikel (lagerbew_beleg_pos_mutter_id = 0) und danach die Komponenten. In lagerbew_beleg_pos_mutter_id (aktuelle Spalte) steht dann der Wert der umsortierten Displaybelegzeile aus line_id.\n            (Der Spaltenname wurde zur Konsistenz an bestehende Spalten in anderen lagerbew_1 Tabellen angepasst. Ein besserer Name wäre_1 gewesen: lagerbew_bel'),
LINE_ID INTEGER
OPTIONS(description='Umsortierte Lagerbewegungsbelegpositionen zur Verbindung von Displays und Displaykomponenten (entspricht der Form früherer Belege vor der Einführung der Display / Komponenten Beziehung). Aus line_id.\n            Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel_1 in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel_1 aufgeführt. Um Komponenten und Displays einander zuzuordnen, wurden in SAP neue Spalten hinzugefügt, welche die Belegzeilen (lagerbew_beleg_pos_id) neu sortieren und dann die neue Displaybelegzeile (line_id) bei den Komponenten angibt (lagerbew_beleg_pos_mutter_id). In der veränderten Sortierung (aktuellen Spalte) werden die Komponenten ans Ende des Belegs gestellt: erst kommen alle Artikel_1 ohne Kopfartikel (lagerbew_beleg_pos_mutter_id = 0) und danach die Komponenten. In lagerbew_beleg_pos_mutter_id steht dann der Wert der umsortierten Displaybelegzeile aus line_id (aktuelle Spalte).\n            (Der Spaltenname wurde zur Konsistenz an bestehende Spalten i'),
DISPLAY_ART_ID INTEGER DEFAULT - 1
OPTIONS(description='Artikel_1-ID des Displays im Lagerbewegungsbeleg. Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel_1 in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel_1 aufgeführt. Über diese Spalte bekommen die Komponenten die art_id des zugehörigen Displays. Wird bei der Beladung gefüllt.'),
PRIMARY KEY (MANDANT_ID, LAGERBEW_BELEG_ID, LAGERBEW_BELEG_POS_ID, KJ) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT_BUCH
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Detaildaten der Lagerbewegungen aus der SAP Tabelle MSEG enthalten.');