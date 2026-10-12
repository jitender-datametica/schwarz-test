CREATE OR REPLACE TABLE kfl_production_dbp_data.avq_werbung (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
dat_aktion_von DATE NOT NULL OPTIONS(description='Werbung/Aktion gültig ab'),
dat_aktion_bis DATE NOT NULL OPTIONS(description='Werbung/Aktion gültig bis'),
kjwo INTEGER NOT NULL OPTIONS(description='Kalenderwoche'),
anz_tage_aktion INTEGER NOT NULL OPTIONS(description='Anzahl Tage Aktion'),
wtag_id_start INTEGER NOT NULL OPTIONS(description='Wochentag (Aktion von)'),
wtag_id_ende INTEGER NOT NULL OPTIONS(description='Wochentag (Aktion bis)'),
cluster_dauer_id INTEGER NOT NULL
OPTIONS(description='Cluste für die Dauer, z. B. 1: 1 Tages-Aktionen, 2: 2-4 Tage (Wochenstart/-ende), 3: 5-9 Tage (Normal Wochenwerbung), 4: alles > 9 Tage'),
werbemittel_avq_top_prio_nr INTEGER NOT NULL OPTIONS(description='Werbemittel (AVQ) mit der höchsten Priorität/ID'),
werbeflaechenabschnitt_avq_top_prio_nr INTEGER NOT NULL
OPTIONS(description='Werbeflächenabschnitt (AVQ) mit der höchsten Priorität/ID'),
werbeflaechenthema_avq_top_prio_nr INTEGER NOT NULL
OPTIONS(description='Werbeflächenthema (AVQ) mit der höchsten Priorität/ID'),
art_mutter_wb_id INTEGER NOT NULL OPTIONS(description='Artikel ID Werbemutter'),
posten_wb_id STRING(2) NOT NULL OPTIONS(description='Postenkennzeichen der Werbemutter'),
posten_id STRING(2) NOT NULL OPTIONS(description='Postenkennzeichen des Einzelartikels'),
pmr_top_art_fg INTEGER NOT NULL OPTIONS(description='TOP-Artikel Flag (PMR)'),
werbeprozess_id INTEGER NOT NULL
OPTIONS(description='0 - keine Mengenberechnung, 1 - WBS TP1, 2 - WBS TP2, 3 - WBS TP1+2, 4 - F&R'),
aktionsklassifizierung_id STRING(10) NOT NULL
OPTIONS(description='SA/AF/BBY/irrelevant da gänzlich gelöscht oder gesperrt / k. Preisaktivierung…'),
aktionsklassifizierung_det_id INTEGER NOT NULL OPTIONS(description='Prospekt/K-Card-only/BBY/Kombi'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
betrag_vk_aktion_brutto NUMERIC(29,3) NOT NULL OPTIONS(description='Verkaufspreis in Aktion'),
betrag_vk_kcard_brutto NUMERIC(29,3) NOT NULL OPTIONS(description='Verkaufspreis in Aktion für K-CARD Kunden'),
betrag_vor_aktion_brutto NUMERIC(29,3) OPTIONS(description='Verkaufspreis vor Aktion'),
faktor_flaki NUMERIC(29,6) NOT NULL OPTIONS(description='Umrechnungsfaktor Flasche in Kiste. (Flasche/Kiste)'),
mhd_zeitraum INTEGER NOT NULL
OPTIONS(description='Dieses Feld gibt den standardmaessigen Mindesthaltbarkeitszeitraum für diesen Artikel in Tagen an (wird redundant aus der Tabelle art geladen).'),
prz_min_restlaufzeit_lager INTEGER NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel vom Lager ausgeliefert wird (wird redundant aus der Tabelle art geladen).'),
menge_plan_wbs NUMERIC(29,3) NOT NULL OPTIONS(description='Planmenge aus WBS'),
menge_plan_upload NUMERIC(29,3) NOT NULL OPTIONS(description='Planmenge aus Upload '),
wbs_estimation_id INTEGER NOT NULL OPTIONS(description='Estimation ID WBS'),
wbs_adjustment_id INTEGER NOT NULL OPTIONS(description='Adjustment ID WBS'),
menge_bestand_aktionsstart NUMERIC(29,3) NOT NULL OPTIONS(description='Bestandsmenge zum Beginn der Aktion.'),
menge_bestand_aktionsende NUMERIC(29,3) NOT NULL OPTIONS(description='Bestandsmenge am Ende der Aktion.'),
menge_ueberbestand NUMERIC(29,3) NOT NULL OPTIONS(description='Überbestand nach Aktion'),
menge_bestand_min_sicherheit NUMERIC(29,3) NOT NULL
OPTIONS(description='Menge, die unterste Grenze für den Sicherheitsbestand angibt. angereichert aus art_wup_status_per (MARC).'),
menge_bestand_soll_max NUMERIC(29,3) NOT NULL
OPTIONS(description='Maximaler Sollbestand (PRWOG) (wird redundant aus der Tabelle art_wup_nachschub_per geladen).'),
menge_sollbestand NUMERIC(29,3) NOT NULL
OPTIONS(description='Sollbestand (wird redundant aus der Tabelle art_wup_status_per geladen) (MARC).'),
anz_nullbestand_gesamt INTEGER NOT NULL
OPTIONS(description='Anzahl Tage mit Nullbestand waehrend des Aktionszeitraums.'),
anz_nullbestand_tag1 INTEGER NOT NULL
OPTIONS(description='Anzahl Nullbestände am ersten Aktions-Wochentag für den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their first day)'),
anz_nullbestand_tag1bis3 INTEGER NOT NULL
OPTIONS(description='Anzahl Nullbestand in den ersten drei Aktionstagen für den Artikel innerhalb der Kalenderwoche (kjwo).'),
anz_minusbestand_gesamt INTEGER NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand waehrend des Aktionszeitraums.'),
anz_minusbestand_tag1 INTEGER NOT NULL OPTIONS(description='Minusbestand am ersten Tag des Aktionszeitraums.'),
anz_minusbestand_tag1bis3 INTEGER NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand während der ersten drei Tage des Aktionszeitraums.'),
anz_exc209_gesamt INTEGER NOT NULL OPTIONS(description='Anzahl Tage mit Nullbestand in Aktion'),
anz_exc209_tag1 INTEGER NOT NULL OPTIONS(description='Nullbestand am 1. Tag (F&R Exception)'),
anz_exc209_tag1bis3 INTEGER NOT NULL OPTIONS(description='Anzahl Tage mit Nullbestand Tag 1-3 (F&R Exception)'),
anz_exc214_gesamt INTEGER NOT NULL OPTIONS(description='Anzahl Tage mit Negativbestand in Aktion (F&R Exception)'),
anz_exc214_tag1 INTEGER NOT NULL OPTIONS(description='Negativbestand am 1. Tag (F&R Exception)'),
anz_exc214_tag1bis3 INTEGER NOT NULL OPTIONS(description='Anzahl Tage mit Negativbestand Tag 1-3 (F&R Exception)'),
menge_gesamt NUMERIC(29,3) NOT NULL OPTIONS(description='Absatz gesamt in Basis-ME'),
betrag_umsatz_gesamt NUMERIC(29,3) NOT NULL OPTIONS(description='Umsatz netto gesamt'),
menge_historie_af NUMERIC(29,3) NOT NULL
OPTIONS(description='Durchschnittliche Abverkaufsmenge der letzten 6 aktionsfreien Wochen.'),
menge_nur_tag1 NUMERIC(29,3) NOT NULL OPTIONS(description='Absatz Tag 1 in Basis-ME'),
menge_tag_1_7bis13 NUMERIC(29,3) NOT NULL OPTIONS(description='Absatz Tag 1 bis 13 Uhr in Basis-ME'),
menge_we_gesamt NUMERIC(29,3) NOT NULL OPTIONS(description='Wareneingang in der Werbewoche.'),
menge_we_vor_aktion NUMERIC(29,3) NOT NULL OPTIONS(description='Wareneingang vor Aktion'),
menge_we_in_aktion NUMERIC(29,3) NOT NULL
OPTIONS(description='Wareneingang in der Werbewoche und der Vorwoche, nur zentrale Bestellarten.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
angebot_typ_cd STRING(10)
OPTIONS(description='Alphanumerischer Code des Angebotstyps. Da die Werte aus der Detailebene aggregiert werden, wird bei abweichenden Werten anhand einer festgelegten fachlichen Priorität entschieden, welcher Wert auf Kopfebene ausgewiesen wird.'),
aktion_typ_id STRING(4)
OPTIONS(description='Gibt die Art der Aktion an (z. B. KDN = App-Promotion, KDP = personalisiert, KDI = externer Partner). Bei abweichenden Werten auf Detailebene wird der finale Wert für die Kopfebene anhand einer festgelegten fachlichen Priorität ermittelt.'),
geschaeftsvorfall_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='Eindeutige ID eines Geschäftsvorfalls (z. B. 01). Bei abweichenden Werten aus den zugrundeliegenden Detail-Datensätzen entscheidet eine festgelegte fachliche Priorität über den ausgewiesenen Wert.'),
konditionsart_id STRING(4)
OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart. Bei abweichenden Werten auf Detailebene greift zur Aggregation auf die Kopfebene eine festgelegte fachliche Prioritätsregel.'),
rabatt_typ_id INTEGER
OPTIONS(description='ID des Rabatt-Typs, die die Art des gewährten Rabattes angibt (z. B. 1 = Normalpreis, 2 = Rabattpreis, 3 = Absoluter Rabatt). Bei abweichenden Werten auf Detailebene entscheidet eine fachliche Priorität.'),
anz_bonuskauf_bezahlt INTEGER
OPTIONS(description='Gibt bei Bonuskäufen die Anzahl der Artikel an, die bezahlt werden müssen. Zur Aggregation auf den Gesamt-Werbezeitraum wird hier die Summe (SUM) der zugehörigen Detailwerte gebildet.'),
anz_bonuskauf_kauf INTEGER
OPTIONS(description='Gibt bei Bonuskäufen die Anzahl der Artikel an, die gekauft werden müssen, um die Bedingung zu erfüllen. Zur Aggregation auf die Kopfebene wird die Summe (SUM) der Detailwerte gebildet.'),
anz_bonuskauf_gratis INTEGER
OPTIONS(description='Gibt bei Bonuskäufen die Anzahl der Artikel an, die kostenlos erhalten werden. Da diese Tabelle aggregiert ist, wird hier die Summe (SUM) der Detailwerte ausgewiesen.'),
menge_bonuskauf_min NUMERIC(29,5)
OPTIONS(description='Gibt bei Bonuskäufen die absatzbezogene Mindestmenge an, die erreicht werden muss, um die Bonusbuy-Bedingung zu erfüllen. Bei abweichenden Detailwerten wird zur Aggregation das Maximum (MAX) ausgewiesen.'),
proz_bonuskauf_rabatt NUMERIC(29,5)
OPTIONS(description='Der prozentuale Rabatt bei einem Bonuskauf. Zur Aggregation auf den Gesamt-Werbezeitraum wird hier das Maximum (MAX) der Rabattprozente aus der Detailebene gebildet.'),
betrag_bonuskauf_rabatt NUMERIC(29,5)
OPTIONS(description='Der absolute Wert des Rabattes bei einem Bonuskauf. Da die Werte aus der Detailebene stammen, wird zur Aggregation auf die Kopfebene das Maximum (MAX) ausgewiesen.'),
listung_fg INTEGER
OPTIONS(description='Flag gibt an, ob für die Artikel-Markt-Kombination im gesamten Aktionszeitraum eine Listung vorlag. (aus SAP WLK1) Durch die Aggregation auf den Gesamtzeitraum wird hier das Maximum der Tageswerte ausgewiesen. 1 = Listung lag an mindestens einem Tag der Aktion vor, 0 = keine Listung im gesamten Zeitraum.'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_aktion_von, dat_aktion_bis) NOT ENFORCED
)
OPTIONS(description='AVQ(Abverkaufsquote) Basistabelle - Kennzahlen und wichtige Attribute auf Ebene Markt/Artikel/Werbezeitraum');