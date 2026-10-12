--==============================================================
-- Table: artbew_mo_ek_cp_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_mo_ek_cp_sum_2
   generated from Powerdesigner on Mittwoch, 27. August 2025 19:46:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_MO_EK_CP_SUM_2 CLUSTER BY (
     MANDANT_ID,
     KJMO,
     WUP_BEREINIGT_FG 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   bewart_id                           INTEGER     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   bewart_det_id                       INTEGER     NOT NULL DEFAULT 9999 COMMENT 'Detaillierte Bewegungsart zum Aufbruch der bestehenden bewart_id',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID).Lieferant des Artikel_2-Markt innerhalb des Monats gem. Lieferantenfindung dbp_data.artbew_dat_ek_cp_sum.',
   kjmo                                INTEGER     NOT NULL COMMENT 'Monat_2 eines Kalenderjahres, Format JJJJMM',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   wup_bereinigt_fg                    INTEGER     NOT NULL COMMENT 'Flag: Zeigt ob die Kennzahlen für diesen Markt in die "bereinigte" Sicht einfließen dürfen, d.h. der Markt hatte in den letzten 12 Monaten vor dem Wochenbeginn der aktuellen Auwertung geöffnet und wird in der betrachteten Woche_2 nicht permanent geschlossen (zieht höchstens um).',
   posten_id                           VARCHAR(2)       NOT NULL COMMENT 'Postenkennzeichen. Für Artikel_2, die nicht staendig im Sortiment sind. Angereichert jeweils aktuell aus dem historisierten Artikelstamm art_per.Wird für den Split der Wochenebene in Aggregat benötigt.',
   zek_id                              VARCHAR(3)       NOT NULL DEFAULT '-1' COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   eigenmarke_fg                       INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag Eigenmarke (wenn zek_id (Verhandler) und zek_vat_id (Verantwortlicher) in der Tabelle art_2 nicht identisch sind, wird das Flag auf 1 gesetzt (Eigenmarke-Artikel_2))',
   umsatz_netto                        NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
   umsatz_netto_vj                     NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Vorjahreswert - Umsatz vermindert um den Mehrwertsteuerbetrag ',
   betrag_kmep                         NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag_2 des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).',
   betrag_kmep_vj                      NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ergibt sich aus der Differenz von EK4N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag_2 des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).',
   betrag_kmep_o_fwu                   NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag_2 des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).',
   betrag_kmep_o_fwu_vj                NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Vergleichswert des Vorjahres - Der Betrag KMEP (teilweise auch als WA-Bonus bezeichnet) ohne Festwertumlage ergibt sich aus der Differenz von EK3N zu EK2N multipliziert mit der Absatzmenge des gewählten Artikels in der gewählten Filiale in diesem Kalendermonat. Für die EK-Preise werden dazu nach Wareneingängen gewichtete Durchschnittspreise des Kalendermonats herangezogen. Die Logik unterscheidet sich hierbei zwischen DE (statische Variante mit Wareneinsatz + Boni zum Tag_2 des Abverkaufes) und KMO (dynamische Variante mit Wareneinsatz = Gleitender Durchschnitt + Boni als Durchschnittssatz aus verschiedenen Wareneingängen / Lieferanten).',
   logkostenzuschlag                   NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)',
   logkostenzuschlag_vj                NUMBER(29,4)     DEFAULT 0 COMMENT 'Vorjahreswert - Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)',
   werbe_abschrift_netto               NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Marktabschriften_2 durch Werbung (netto- vermindert um den Mehrwertsteuerbetrag)',
   werbe_abschrift_netto_vj            NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Vorjahreswert - Marktabschriften_2 durch Werbung (netto- vermindert um den Mehrwertsteuerbetrag)',
   preis_abschrift_netto               NUMBER(29,2)     NOT NULL COMMENT 'Preisabschrift DE: marktabschriften_2 (abschriftart_id in (5,7); KMO:Filterung art_umbewertung_2 wie folgt: Mandant_2 2,5: preis_aend_grund_id in (7,10); Mandant_2 3: preis_aend_grund_id =11; Mandant_2 6: preis_aend_grund_id =2; Mandant_2 7,8: preis_aend_grund_id =7',
   preis_abschrift_netto_vj            NUMBER(29,2)     COMMENT 'Preisabschr.VJ DE: marktabschriften_2 (abschriftart_id in (5,7); KMO:Filterung art_umbewertung_2 wie folgt: Mandant_2 2,5: preis_aend_grund_id in (7,10); Mandant_2 3: preis_aend_grund_id =11; Mandant_2 6: preis_aend_grund_id =2; Mandant_2 7,8: preis_aend_grund_id =7',
   umrechnungskurs_hist                NUMBER(29,5)     NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_2 ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_MO_EK_CP_SUM PRIMARY KEY (mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id, kjmo, wrg_id, wup_bereinigt_fg, posten_id, gp_id) NOT ENFORCED
)  COMMENT = 'PTY - EK-INT - Aggregat Artbew_2 auf Ebene Artikel_2 / Bewegungsart / Monat_2 mit Preisveränderung für Werbung (EK-Cockpit)';
