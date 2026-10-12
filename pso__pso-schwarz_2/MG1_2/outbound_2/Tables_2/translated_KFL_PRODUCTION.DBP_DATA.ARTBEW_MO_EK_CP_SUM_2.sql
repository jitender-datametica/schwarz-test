DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ARTBEW_MO_EK_CP_SUM_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTBEW_MO_EK_CP_SUM_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
BEWART_ID INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
BEWART_DET_ID INTEGER DEFAULT 9999 NOT NULL
OPTIONS(description='Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
KJMO INTEGER NOT NULL OPTIONS(description='Monat_2 eines Kalenderjahres, Format JJJJMM'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
WUP_BEREINIGT_FG INTEGER NOT NULL
OPTIONS(description='Flag: Zeigt ob die Kennzahlen für diesen Markt in die\"bereinigte\" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche_2 nicht permanent geschlossen (zieht höchstens um).'),
POSTEN_ID STRING(2) NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel_2, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem historisierten Artikelstamm art_per.Wird für den Split der Wochenebene in Aggregat benötigt.'),
ZEK_ID STRING(3) DEFAULT '-1' NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
EIGENMARKE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag Eigenmarke (wenn zek_id (Verhandler) und zek_vat_id (Verantwortlicher) in der Tabelle art_2 nicht identisch sind, wird das Flag auf 1 gesetzt (Eigenmarke-Artikel_2))'),
UMSATZ_NETTO NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
UMSATZ_NETTO_VJ NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vorjahreswert - Umsatz vermindert um den Mehrwertsteuerbetrag '),
BETRAG_KMEP NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag_2 des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
BETRAG_KMEP_VJ NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag_2 des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
BETRAG_KMEP_O_FWU NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag_2 des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
BETRAG_KMEP_O_FWU_VJ NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag_2 des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).'),
LOGKOSTENZUSCHLAG NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'),
LOGKOSTENZUSCHLAG_VJ NUMERIC(29,4) DEFAULT 0
OPTIONS(description='Vorjahreswert - Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'),
WERBE_ABSCHRIFT_NETTO NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Marktabschriften_2 durch Werbung (netto- vermindert um den Mehrwertsteuerbetrag)'),
WERBE_ABSCHRIFT_NETTO_VJ NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Vorjahreswert - Marktabschriften_2 durch Werbung (netto- vermindert um den Mehrwertsteuerbetrag)'),
PREIS_ABSCHRIFT_NETTO NUMERIC(29,2) NOT NULL
OPTIONS(description='Preisabschrift DE: marktabschriften_2 (abschriftart_id in (5,7); KMO:Filterung art_umbewertung_2 wie folgt: Mandant_2 2,5: preis_aend_grund_id in (7,10); Mandant_2 3: preis_aend_grund_id =11; Mandant_2 6: preis_aend_grund_id =2; Mandant_2 7,8: preis_aend_grund_id =7'),
PREIS_ABSCHRIFT_NETTO_VJ NUMERIC(29,2)
OPTIONS(description='Preisabschr.VJ DE: marktabschriften_2 (abschriftart_id in (5,7); KMO:Filterung art_umbewertung_2 wie folgt: Mandant_2 2,5: preis_aend_grund_id in (7,10); Mandant_2 3: preis_aend_grund_id =11; Mandant_2 6: preis_aend_grund_id =2; Mandant_2 7,8: preis_aend_grund_id =7'),
UMRECHNUNGSKURS_HIST NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID, BEWART_ID, BEWART_DET_ID, WUP_ID, NB_ID, KJMO, WRG_ID, WUP_BEREINIGT_FG, POSTEN_ID)
NOT ENFORCED
) CLUSTER BY MANDANT_ID, KJMO, WUP_BEREINIGT_FG
OPTIONS(description='PTY - EK-INTEGER - Aggregat Artbew_2 auf Ebene Artikel_2 / Bewegungsart / Monat_2 mit Preisveränderung für Werbung (EK-Cockpit)');