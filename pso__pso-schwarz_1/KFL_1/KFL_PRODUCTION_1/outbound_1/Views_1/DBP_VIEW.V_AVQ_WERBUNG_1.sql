CREATE OR REPLACE VIEW kfl_production_dbp_view.v_avq_werbung_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'), wup_id
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), art_id
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
dat_aktion_von OPTIONS(description='Werbung/Aktion_1 gültig ab'), dat_aktion_bis
OPTIONS(description='Werbung/Aktion_1 gültig bis'), kjwo OPTIONS(description='Kalenderwoche'), anz_tage_aktion
OPTIONS(description='Anzahl Tage Aktion_1'), wtag_id_start OPTIONS(description='Wochentag (Aktion_1 von)'), wtag_id_ende
OPTIONS(description='Wochentag (Aktion_1 bis)'), cluster_dauer_id
OPTIONS(description='Cluste für die Dauer, z. B. 1: 1 Tages-Aktionen, 2: 2-4 Tage (Wochenstart/-ende), 3: 5-9 Tage (Normal Wochenwerbung), 4: alles > 9 Tage'),
werbemittel_avq_top_prio_nr OPTIONS(description='Werbemittel (AVQ) mit der höchsten Priorität/ID'),
werbeflaechenabschnitt_avq_top_prio_nr OPTIONS(description='Werbeflächenabschnitt (AVQ) mit der höchsten Priorität/ID'),
werbeflaechenthema_avq_top_prio_nr OPTIONS(description='Werbeflächenthema (AVQ) mit der höchsten Priorität/ID'),
art_mutter_wb_id OPTIONS(description='Artikel_1 ID Werbemutter'), posten_wb_id
OPTIONS(description='Postenkennzeichen der Werbemutter'), posten_id
OPTIONS(description='Postenkennzeichen des Einzelartikels'), pmr_top_art_fg
OPTIONS(description='TOP-Artikel_1 Flag (PMR)'), werbeprozess_id
OPTIONS(description='0 - keine Mengenberechnung, 1 - WBS TP1, 2 - WBS TP2, 3 - WBS TP1+2, 4 - F&R'),
aktionsklassifizierung_id
OPTIONS(description='SA/AF/BBY/irrelevant da gänzlich gelöscht oder gesperrt / k. Preisaktivierung…'),
aktionsklassifizierung_det_id OPTIONS(description='Prospekt/K-Card-only/BBY/Kombi'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), betrag_vk_aktion_brutto
OPTIONS(description='Verkaufspreis in Aktion_1'), betrag_vk_kcard_brutto
OPTIONS(description='Verkaufspreis in Aktion_1 für K-CARD Kunden'), betrag_vor_aktion_brutto
OPTIONS(description='Verkaufspreis vor Aktion_1'), faktor_flaki
OPTIONS(description='Umrechnungsfaktor Flasche in Kiste. (Flasche/Kiste)'), mhd_zeitraum
OPTIONS(description='Dieses Feld gibt den standardmaessigen Mindesthaltbarkeitszeitraum für diesen Artikel_1 in Tagen an (wird redundant aus der Tabelle art_1 geladen).'),
prz_min_restlaufzeit_lager
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_1 vom Lager ausgeliefert wird (wird redundant aus der Tabelle art_1 geladen).'),
menge_plan_wbs OPTIONS(description='Planmenge aus WBS'), menge_plan_upload OPTIONS(description='Planmenge aus Upload '),
wbs_estimation_id OPTIONS(description='Estimation ID WBS'), wbs_adjustment_id OPTIONS(description='Adjustment ID WBS'),
menge_bestand_aktionsstart OPTIONS(description='Bestandsmenge zum Beginn der Aktion.'), menge_bestand_aktionsende
OPTIONS(description='Bestandsmenge am Ende der Aktion.'), menge_ueberbestand
OPTIONS(description='Überbestand nach Aktion_1'), menge_bestand_min_sicherheit
OPTIONS(description='Menge, die unterste Grenze für den Sicherheitsbestand angibt. angereichert aus art_wup_status_per_1 (MARC_1).'),
menge_bestand_soll_max
OPTIONS(description='Maximaler Sollbestand (PRWOG) (wird redundant aus der Tabelle art_wup_nachschub_per_1 geladen).'),
menge_sollbestand OPTIONS(description='Sollbestand (wird redundant aus der Tabelle art_wup_status_per_1 geladen) (MARC_1).'),
anz_nullbestand_gesamt OPTIONS(description='Anzahl Tage mit Nullbestand waehrend des Aktionszeitraums.'),
anz_nullbestand_tag1
OPTIONS(description='Anzahl Nullbestände am ersten Aktions-Wochentag für den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their first day)'),
anz_nullbestand_tag1bis3
OPTIONS(description='Anzahl Nullbestand in den ersten drei Aktionstagen für den Artikel_1 innerhalb der Kalenderwoche (kjwo).'),
anz_minusbestand_gesamt OPTIONS(description='Anzahl Tage mit Minusbestand waehrend des Aktionszeitraums.'),
anz_minusbestand_tag1 OPTIONS(description='Minusbestand am ersten Tag_1 des Aktionszeitraums.'), anz_minusbestand_tag1bis3
OPTIONS(description='Anzahl Tage mit Minusbestand während der ersten drei Tage des Aktionszeitraums.'),
anz_exc209_gesamt OPTIONS(description='Anzahl Tage mit Nullbestand in Aktion_1'), anz_exc209_tag1
OPTIONS(description='Nullbestand am 1. Tag_1 (F&R Exception)'), anz_exc209_tag1bis3
OPTIONS(description='Anzahl Tage mit Nullbestand Tag_1 1-3 (F&R Exception)'), anz_exc214_gesamt
OPTIONS(description='Anzahl Tage mit Negativbestand in Aktion_1 (F&R Exception)'), anz_exc214_tag1
OPTIONS(description='Negativbestand am 1. Tag_1 (F&R Exception)'), anz_exc214_tag1bis3
OPTIONS(description='Anzahl Tage mit Negativbestand Tag_1 1-3 (F&R Exception)'), menge_gesamt
OPTIONS(description='Absatz gesamt in Basis-ME'), betrag_umsatz_gesamt OPTIONS(description='Umsatz netto gesamt'),
menge_historie_af OPTIONS(description='Durchschnittliche Abverkaufsmenge der letzten 6 aktionsfreien Wochen.'),
menge_nur_tag1 OPTIONS(description='Absatz Tag_1 1 in Basis-ME'), menge_tag_1_7bis13
OPTIONS(description='Absatz Tag_1 1 bis 13 Uhr in Basis-ME'), menge_we_gesamt
OPTIONS(description='Wareneingang in der Werbewoche.'), menge_we_vor_aktion
OPTIONS(description='Wareneingang vor Aktion_1'), menge_we_in_aktion
OPTIONS(description='Wareneingang in der Werbewoche und der Vorwoche, nur zentrale Bestellarten.'), angebot_typ_cd
OPTIONS(description='Alphanumerischer Code des Angebotstyps. Da die Werte aus der Detailebene aggregiert werden, wird bei abweichenden Werten anhand einer festgelegten fachlichen Priorität entschieden, welcher Wert auf Kopfebene ausgewiesen wird.'),
aktion_typ_id
OPTIONS(description='Gibt die Art_1 der Aktion_1 an (z. B. KDN = App-Promotion, KDP = personalisiert, KDI = externer Partner). Bei abweichenden Werten auf Detailebene wird der finale Wert für die Kopfebene anhand einer festgelegten fachlichen Priorität ermittelt.'),
geschaeftsvorfall_id
OPTIONS(description='Eindeutige ID eines Geschäftsvorfalls (z. B. 01). Bei abweichenden Werten aus den zugrundeliegenden Detail-Datensätzen entscheidet eine_1 festgelegte fachliche Priorität über den ausgewiesenen Wert.'),
konditionsart_id
OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart. Bei abweichenden Werten auf Detailebene greift zur Aggregation auf die Kopfebene eine_1 festgelegte fachliche Prioritätsregel.'),
rabatt_typ_id
OPTIONS(description='ID des Rabatt-Typs, die die Art_1 des gewährten Rabattes angibt (z. B. 1 = Normalpreis, 2 = Rabattpreis, 3 = Absoluter Rabatt). Bei abweichenden Werten auf Detailebene entscheidet eine_1 fachliche Priorität.'),
anz_bonuskauf_bezahlt
OPTIONS(description='Gibt bei Bonuskäufen die Anzahl der Artikel_1 an, die bezahlt werden müssen. Zur Aggregation auf den Gesamt-Werbezeitraum wird hier die Summe (SUM) der zugehörigen Detailwerte gebildet.'),
anz_bonuskauf_kauf
OPTIONS(description='Gibt bei Bonuskäufen die Anzahl der Artikel_1 an, die gekauft werden müssen, um die Bedingung zu erfüllen. Zur Aggregation auf die Kopfebene wird die Summe (SUM) der Detailwerte gebildet.'),
anz_bonuskauf_gratis
OPTIONS(description='Gibt bei Bonuskäufen die Anzahl der Artikel_1 an, die kostenlos erhalten werden. Da diese Tabelle aggregiert ist, wird hier die Summe (SUM) der Detailwerte ausgewiesen.'),
menge_bonuskauf_min
OPTIONS(description='Gibt bei Bonuskäufen die absatzbezogene Mindestmenge an, die erreicht werden muss, um die Bonusbuy-Bedingung zu erfüllen. Bei abweichenden Detailwerten wird zur Aggregation das Maximum (MAX) ausgewiesen.'),
proz_bonuskauf_rabatt
OPTIONS(description='Der prozentuale Rabatt bei einem Bonuskauf. Zur Aggregation auf den Gesamt-Werbezeitraum wird hier das Maximum (MAX) der Rabattprozente aus der Detailebene gebildet.'),
betrag_bonuskauf_rabatt
OPTIONS(description='Der absolute Wert des Rabattes bei einem Bonuskauf. Da die Werte aus der Detailebene stammen, wird zur Aggregation auf die Kopfebene das Maximum (MAX) ausgewiesen.'),
listung_fg
OPTIONS(description='Flag gibt an, ob für die Artikel_1-Markt-Kombination im gesamten Aktionszeitraum eine_1 Listung vorlag. (aus SAP WLK1_1) Durch die Aggregation auf den Gesamtzeitraum wird hier das Maximum der Tageswerte ausgewiesen. 1 = Listung lag an mindestens einem Tag_1 der Aktion_1 vor, 0 = keine Listung im gesamten Zeitraum.'))
AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_aktion_von,
 dat_aktion_bis,
 kjwo,
 anz_tage_aktion,
 wtag_id_start,
 wtag_id_ende,
 cluster_dauer_id,
 werbemittel_avq_top_prio_nr,
 werbeflaechenabschnitt_avq_top_prio_nr,
 werbeflaechenthema_avq_top_prio_nr,
 art_mutter_wb_id,
 posten_wb_id,
 posten_id,
 pmr_top_art_fg,
 werbeprozess_id,
 aktionsklassifizierung_id,
 aktionsklassifizierung_det_id,
 wrg_id,
 betrag_vk_aktion_brutto,
 betrag_vk_kcard_brutto,
 betrag_vor_aktion_brutto,
 faktor_flaki,
 mhd_zeitraum,
 prz_min_restlaufzeit_lager,
 menge_plan_wbs,
 menge_plan_upload,
 wbs_estimation_id,
 wbs_adjustment_id,
 menge_bestand_aktionsstart,
 menge_bestand_aktionsende,
 menge_ueberbestand,
 menge_bestand_min_sicherheit,
 menge_bestand_soll_max,
 menge_sollbestand,
 anz_nullbestand_gesamt,
 anz_nullbestand_tag1,
 anz_nullbestand_tag1bis3,
 anz_minusbestand_gesamt,
 anz_minusbestand_tag1,
 anz_minusbestand_tag1bis3,
 anz_exc209_gesamt,
 anz_exc209_tag1,
 anz_exc209_tag1bis3,
 anz_exc214_gesamt,
 anz_exc214_tag1,
 anz_exc214_tag1bis3,
 menge_gesamt,
 betrag_umsatz_gesamt,
 menge_historie_af,
 menge_nur_tag1,
 menge_tag_1_7bis13,
 menge_we_gesamt,
 menge_we_vor_aktion,
 menge_we_in_aktion,
 angebot_typ_cd,
 aktion_typ_id,
 geschaeftsvorfall_id,
 konditionsart_id,
 rabatt_typ_id,
 anz_bonuskauf_bezahlt,
 anz_bonuskauf_kauf,
 anz_bonuskauf_gratis,
 menge_bonuskauf_min,
 proz_bonuskauf_rabatt,
 betrag_bonuskauf_rabatt,
 listung_fg
FROM kfl_production_dbp_data.avq_werbung_1;