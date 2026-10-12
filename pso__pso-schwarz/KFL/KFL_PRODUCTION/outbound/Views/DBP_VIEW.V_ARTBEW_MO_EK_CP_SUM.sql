CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew_mo_ek_cp_sum (mandant_id OPTIONS(description='Mandant im DWH'),
art_id
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
bewart_id
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
bewart_det_id OPTIONS(description='Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id'), wup_id
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), gp_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID).Lieferant des Artikel-Markt innerhalb des Monats gem. Lieferantenfindung dbp_data.artbew_dat_ek_cp_sum.'),
kjmo OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), wup_bereinigt_fg
OPTIONS(description='Flag: Zeigt ob die Kennzahlen für diesen Markt in die\""bereinigte\"" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche nicht permanent geschlossen (zieht höchstens um).'),
posten_id
OPTIONS(description='Postenkennzeichen. Für Artikel, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem historisierten Artikelstamm art_per.Wird für den Split der Wochenebene in Aggregat benötigt.'),
zek_id OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
eigenmarke_fg
OPTIONS(description='Flag Eigenmarke (wenn zek_id (Verhandler) und zek_vat_id (Verantwortlicher) in der Tabelle art nicht identisch sind, wird das Flag auf 1 gesetzt (Eigenmarke-Artikel))'),
umsatz_netto OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'), umsatz_netto_vj
OPTIONS(description='Vorjahreswert - Umsatz vermindert um den Mehrwertsteuerbetrag '), betrag_kmep
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_vj
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_o_fwu
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_o_fwu_vj
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
logkostenzuschlag
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'),
logkostenzuschlag_vj
OPTIONS(description='Vorjahreswert - Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'),
werbe_abschrift_netto
OPTIONS(description='Marktabschriften durch Werbung (netto- vermindert um den Mehrwertsteuerbetrag)'),
werbe_abschrift_netto_vj
OPTIONS(description='Vorjahreswert - Marktabschriften durch Werbung (netto- vermindert um den Mehrwertsteuerbetrag)'),
preis_abschrift_netto
OPTIONS(description='Preisabschrift DE: marktabschriften (abschriftart_id in (5,7); KMO:Filterung art_umbewertung wie folgt: Mandant 2,5: preis_aend_grund_id in (7,10); Mandant 3: preis_aend_grund_id =11; Mandant 6: preis_aend_grund_id =2; Mandant 7,8: preis_aend_grund_id =7'),
preis_abschrift_netto_vj
OPTIONS(description='Preisabschr.VJ DE: marktabschriften (abschriftart_id in (5,7); KMO:Filterung art_umbewertung wie folgt: Mandant 2,5: preis_aend_grund_id in (7,10); Mandant 3: preis_aend_grund_id =11; Mandant 6: preis_aend_grund_id =2; Mandant 7,8: preis_aend_grund_id =7'),
umrechnungskurs_hist OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '), betrag_kmep_inv_netto_km
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) für die Inventur innerhalb Warenbewegungen ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Die Absatzmenge menge_lagerbew_bme aus lagerbew_det mit lager_bewart_id in (701,702,711,712,V30,V31,V32,V33,V35,V36,V37,V38,V45,V50,V54,W00,W02,W05,W10,W12,W15,W16,W17,W25,W27,W30).Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise der Kalenderwoche herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'))
AS SELECT mandant_id,
 art_id,
 bewart_id,
 bewart_det_id,
 wup_id,
 nb_id,
 gp_id,
 kjmo,
 wrg_id,
 wup_bereinigt_fg,
 posten_id,
 zek_id,
 eigenmarke_fg,
 umsatz_netto,
 umsatz_netto_vj,
 betrag_kmep,
 betrag_kmep_vj,
 betrag_kmep_o_fwu,
 betrag_kmep_o_fwu_vj,
 logkostenzuschlag,
 logkostenzuschlag_vj,
 werbe_abschrift_netto,
 werbe_abschrift_netto_vj,
 preis_abschrift_netto,
 preis_abschrift_netto_vj,
 umrechnungskurs_hist,
 betrag_kmep_inv_netto_km
FROM kfl_production_dbp_data.artbew_mo_ek_cp_sum;