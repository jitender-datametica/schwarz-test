--==============================================================
-- Table: artbew_dat_ek_cp_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_dat_ek_cp_sum
   generated from Powerdesigner on Montag, 25. August 2025 14:51:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_dat_ek_cp_sum (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
bewart_det_id BIGNUMERIC(38,0) DEFAULT 9999 NOT NULL
OPTIONS(description='Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
wup_bereinigt_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag: Zeigt ob die Kennzahlen für diesen Markt in die "bereinigte" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche nicht permanent geschlossen (zieht höchstens um).'),
transaktion_typ_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Gibt den Typ der Transaktion an:  0 = Umsatz, 1 = Abschriften'),
zek_id STRING(3) DEFAULT '-1' NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
gp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID).Lieferant des Artikel-Markt-Tag gem. Lieferantenfindung dbp_data.art_gp_ nm_zu_per.'),
eigenmarke_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag Eigenmarke (wenn zek_id (Verhandler) und zek_vat_id (Verantwortlicher) in der Tabelle art nicht identisch sind, wird das Flag auf 1 gesetzt (Eigenmarke-Artikel))'),
umsatz_netto BIGNUMERIC(38,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
umsatz_netto_vj BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vorjahreswert - Umsatz vermindert um den Mehrwertsteuerbetrag '),
betrag_kmep_kw BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise der Kalenderwoche herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_kw_vj BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise der Kalenderwoche herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_ww BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise der Werbewoche herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_ww_vj BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise der Werbewoche herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_km BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_km_vj BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_o_fwu_kw BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise der Kalenderwoche herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_o_fwu_kw_vj BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise der Kalenderwoche herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_o_fwu_ww BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise der Werbewoche herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_o_fwu_ww_vj BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise der Werbewoche herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_o_fwu_km BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
betrag_kmep_o_fwu_km_vj BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale an diesem Tag. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
logkostenzuschlag BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'),
logkostenzuschlag_vj BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vorjahreswert - Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'),
werbe_abschrift_netto BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Marktabschriften durch Werbung (netto- vermindert um den Mehrwertsteuerbetrag)'),
werbe_abschrift_netto_vj BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vorjahreswert - Marktabschriften durch Werbung (netto- vermindert um den Mehrwertsteuerbetrag)'),
preis_abschrift_netto BIGNUMERIC(38,2) NOT NULL
OPTIONS(description='Preisabschrift DE: marktabschriften (abschriftart_id in (5,7); KMO:Filterung art_umbewertung wie folgt: Mandant 2,5: preis_aend_grund_id in (7,10); Mandant 3: preis_aend_grund_id =11; Mandant 6: preis_aend_grund_id =2; Mandant 7,8: preis_aend_grund_id =7'),
preis_abschrift_netto_vj BIGNUMERIC(38,2)
OPTIONS(description='Preisabschr.VJ DE: marktabschriften (abschriftart_id in (5,7); KMO:Filterung art_umbewertung wie folgt: Mandant 2,5: preis_aend_grund_id in (7,10); Mandant 3: preis_aend_grund_id =11; Mandant 6: preis_aend_grund_id =2; Mandant 7,8: preis_aend_grund_id =7'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id, dat, wrg_id, wup_bereinigt_fg,
 transaktion_typ_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat, wup_bereinigt_fg
OPTIONS(description='EK-INTEGER  - Aggregat Artbew auf Ebene Artikel / Bewegungsart / Tag mit Preisveränderung für Werbung');