--==============================================================
-- Table: reichweite_vz_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: reichweite_vz_2
   generated from Powerdesigner on Dienstag, 28. November 2023 13:50:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.reichweite_vz_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 in DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb'),
gp_dispo_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferant ID Dispo (Surrogate Key). Die gp_id entspricht der Lieferantennummer aus SAP, ist Business key, während gp_dispo_id von SAP täglich neu generiert wird.             Gp_dispo_id ändert sich mit jedem Planungslauf. Gp_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
art_dispo_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird.             Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '),
dat_plan DATE NOT NULL OPTIONS(description='Datum des Plannungslauf in SAP'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferant'),
gp_teilsortiment_id STRING(10) NOT NULL
OPTIONS(description='Lieferantenteilsortimen. Die Lookup-Tabelle hierzu ist l_gp_teilsortiment. Aus ltsnr.'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2 ID'),
disponent_id STRING(3) OPTIONS(description='Disponent. Quelle: gp_dispo_vz_tag.'),
menge_best_min BIGNUMERIC(38,0) OPTIONS(description='Mindestbestellmenge. Quelle: gp_dispo_vz_tag.'),
menge_best_min_einh_id STRING(3) OPTIONS(description='Mindestbestellmenge Einheit. Quelle: gp_dispo_vz_tag.'),
planlieferzeit BIGNUMERIC(38,0) OPTIONS(description='Planliefertzeit in Tagen. Quelle: gp_dispo_vz_tag.'),
menge_einh_lam_id STRING(3)
OPTIONS(description='Mengeneinheit Lagerausgang (i. d. R. Kolli). Quelle: art_gp_dispo_tag.'),
dat_listung_vz_von DATE OPTIONS(description='Datum Listung im VZ (von). Quelle: art_gp_dispo_tag.'),
dat_listung_vz_bis DATE OPTIONS(description='Datum Listung im VZ (bis). Quelle: art_gp_dispo_tag.'),
anz_wup_kdis BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Märkte kDis ("kein Druck in Sortimentliste" = Artikel_2 nicht bestellbar). Quelle: art_gp_dispo_tag.'),
anz_wup_dis BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Märkte Dis ("Druck in Sortimentliste" = Artikel_2 bestellbar). Quelle: art_gp_dispo_tag.'),
dat_raeumen_ab DATE
OPTIONS(description='Datum räumen (ab). Ein Artikel_2 wird bis zu einem gewissen Zeitpunkt normal abverkauft und ab dem Räumungsdatum wird er rabattiert abverkauft, z.B. weil er sich schlecht abverkauft und wir ihn nicht im Sortiment behalten wollen. Quelle: art_gp_dispo_tag.'),
dat_aktion_1 DATE OPTIONS(description='Datum 1. Aktionsstart. Quelle: art_gp_dispo_tag.'),
dat_aktion_2 DATE OPTIONS(description='Datum 2. Aktionsstart. Quelle: art_gp_dispo_tag.'),
dat_aktion_3 DATE OPTIONS(description='Datum 3. Aktionsstart. Quelle: art_gp_dispo_tag.'),
reichweite BIGNUMERIC(38,14)
OPTIONS(description='Reichweite in Tagen. Drückt aus wie viele Tage ein Bestand im VZ hält bis er leer ist. Quelle: art_gp_dispo_tag.'),
reichweite_neu BIGNUMERIC(38,14)
OPTIONS(description='Reichweite in Tagen (neu). Neu heißt nicht nur Bestand, sondern auch unter Berücksichtigung erwarteter Wareneingänge. Quelle: art_gp_dispo_tag.'),
dat_listung_markt_von DATE OPTIONS(description='Datum Listung im Markt (von). Quelle: art_gp_dispo_tag.'),
dat_listung_markt_bis DATE OPTIONS(description='Datum Listung im Markt (bis). Quelle: art_gp_dispo_tag.'),
artikelstatus_betrieb STRING(2)
OPTIONS(description='Artikelstatus Betrieb (VZ), z.B. F1/F2 bei Lieferschwierigkeiten. F1 - temporäre_2 Schwierigkeiten, F2 - dauerhafte Lieferschwierigkeiten (aber Artikel_2 bleibt disponierbar, und auch bestellbar). Quelle: art_gp_dispo_tag.'),
rlz_vz BIGNUMERIC(38,14)
OPTIONS(description='Restlaufzeit VZ (Prozentualer Anteil am Soll-MHD, i.d.R 75% des Gesamt-MHD). Quelle: art_gp_dispo_tag.'),
umrech_faktor_best_bme BIGNUMERIC(38,14)
OPTIONS(description='Umrechnungsfaktor Basis- in Bestellmengeneinheit. Quelle: art_gp_dispo_tag.'),
lagefaktor BIGNUMERIC(38,0)
OPTIONS(description='Umrechnungsfaktor Basismengeneinheit in Palettenlage. Quelle: art_gp_dispo_tag.'),
palettenfaktor BIGNUMERIC(38,0)
OPTIONS(description='Umrechnungsfaktor Basismengeneinheit in Palette. Quelle: art_gp_dispo_tag.'),
gp_dispo_multi_id BIGNUMERIC(38,0)
OPTIONS(description='Bei mehreren Lieferanten (Eigenmarken, O&G, ...). Quelle: art_gp_dispo_tag.'),
ratio BIGNUMERIC(38,0)
OPTIONS(description='Anteil der jew. Lieferanten bei mehreren Lieferanten. Quelle: art_gp_dispo_tag.'),
posten_fg BIGNUMERIC(38,0) OPTIONS(description='Posten-Flag (0/1). Quelle: art_gp_dispo_tag.'),
posten_kz_sap STRING(2)
OPTIONS(description='Postenkennzeichen (Posten, sortimentsnah, ...). Für Artikel_2, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert). Quelle: art_gp_dispo_tag.'),
saison_fg BIGNUMERIC(38,0) OPTIONS(description='Saison-Flag (0/1). Quelle: art_gp_dispo_tag.'),
saison_id STRING(10) OPTIONS(description='Saison-Kennzeichen (Ostern, Weihnachten, ...). Quelle: art_gp_dispo_tag.'),
auspackware_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Auspackware im VZ (0/1). Quelle: art_gp_dispo_tag.'),
rundungsprofil STRING(10)
OPTIONS(description='Rundungsprofil bei Lieferantenbestellung. Zeigt wie gerundet wird, (z. B. aufgerundet auf ganze Palette, halbe Palette). Quelle: art_gp_dispo_tag.'),
einkaeufer_grp_id BIGNUMERIC(38,0)
OPTIONS(description='Einkäufergruppe beschreibt eine_2 Gruppe_2 von Menschen, die für die Beschaffung bestimmter Artikel_2 zuständig sind. Quelle: art_gp_dispo_tag.'),
neuer_artikel_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Neuer Artikel_2 (0/1). Quelle: art_gp_dispo_tag.'),
werbung_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Artikel_2 mit Aktionslistung (0/1). Quelle: art_gp_dispo_tag.'),
menge_lgbest_erp_frei_kolli BIGNUMERIC(38,14)
OPTIONS(description='Menge Lagerbestand frei verwendbar, in Kolli. Quelle: lagerbestand_atp_per.menge_lgbest_frei, aggregiert.'),
menge_blockbestand_akt_kolli BIGNUMERIC(38,14)
OPTIONS(description='Menge Blockbestand Werbung in Kolli. Der Blockbestand sagt aus, wie viel der gelagerten Menge im VZ für einen Zweck gesperrt ist (hier: Aktion_2). Quelle: lagerbestand_atp_per.menge_lgbest_block_werbung, aggregiert.'),
menge_blockbestand_iwt_kolli BIGNUMERIC(38,14)
OPTIONS(description='Menge Blockbestand IWT in Kolli. Der Blockbestand sagt aus, wie viel der gelagerten Menge im VZ für einen Zweck gesperrt ist (hier: IWT - internationaler Warentransfer oder -transport). Die Mengen die für den weiteren Transport an weitere Länder gesperrt sind. Quelle: lagerbestand_atp_per.menge_lgbest_block_iwt, aggregiert.'),
menge_best_iwt_bme BIGNUMERIC(38,14)
OPTIONS(description='Bestellmenge für IWT in Basis-ME (IWT - internationaler Warentransfer oder -transport). Quelle: best_blockbestand.menge_block, aggregiert..'),
menge_best_gesamt_bme BIGNUMERIC(38,14)
OPTIONS(description='Bestellmenge gesamt in Basis-ME. Quelle: best_offen.menge_best, aggregiert.'),
menge_best_akt_bme BIGNUMERIC(38,14)
OPTIONS(description='Bestellmenge für Werbung, in BME. Quelle: best_blockbestand.menge_block, aggregiert.'),
menge_best_bevorratung_bme BIGNUMERIC(38,14)
OPTIONS(description='Bestellmenge für Bevorratung in Basis-ME. Quelle: vz_best_split.menge_bevorratung, aggregiert.'),
menge_wa BIGNUMERIC(38,14)
OPTIONS(description='Warenausgangsmenge (PLND_GI - Planned Goods Issues). Geplannte Warenausgänge insgesamt. Quelle: aof_prognose.menge, aggregiert.'),
menge_wa_akt BIGNUMERIC(38,14)
OPTIONS(description='Warenausgangsmenge Werbung (PLND_GI_PR - Planned Goods Issues for Promotion). Geplannte Warenausgänge für die Werbung. Quelle: aof_prognose.menge, aggregiert.'),
dat_lief_next DATE
OPTIONS(description='Nächstes Lieferdatum (aus VZ-Dispo-Tabellen ("Dispo-2020")). Quelle: lief_einteilung.dat_lief_wunsch, aggregiert.'),
dat_lief_max DATE
OPTIONS(description='Max. Lieferdatum (aus VZ-Dispo-Tabellen ("Dispo-2020")). Quelle: lief_einteilung.dat_lief_wunsch, aggregiert. Das maximale Lieferdatum kann sich unterscheiden wenn das nächst-angeforderte Datum vom Lieferanten nicht eingehalten / erreicht werden kann.'),
diff_tage_next_max_lief BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Tage zwischen nächstem und max. Lieferdatum. Das maximale Lieferdatum kann sich unterscheiden wenn das nächst-angeforderte Datum vom Lieferanten nicht eingehalten / erreicht werden kann.'),
menge_best_offen_gesamt_bme BIGNUMERIC(38,14)
OPTIONS(description='Menge offene Bestellungen gesamt in BME (aus VZ-Dispo-Tabellen ("Dispo-2020")). Quelle: best_offen.menge_best, aggregiert.'),
menge_best_offen_gesamt_kolli BIGNUMERIC(38,14)
OPTIONS(description='Menge offene Bestellungen gesamt in Kolli (aus VZ-Dispo-Tabellen ("Dispo-2020")). Quelle: best_offen.menge_best, aggregiert.'),
anz_best_pos BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Bestellpositionen (aus VZ-Dispo-Tabellen ("Dispo-2020")). Quelle: best_offen.mandant_id, count.'),
menge_best_offen_next_bme BIGNUMERIC(38,14)
OPTIONS(description='Menge offene Bestellungen nächster Liefertermin in BME (aus VZ-Dispo-Tabellen ("Dispo-2020")). BME = Basismengeeinheit. Quelle: best_offen.menge_best, aggregiert.'),
menge_best_offen_next_kolli BIGNUMERIC(38,14)
OPTIONS(description='Menge offene Bestellungen nächster Liefertermin in Kolli (aus VZ-Dispo-Tabellen ("Dispo-2020")). Quelle: best_offen.menge_best, aggregiert.'),
prognose_reichweite_tage_vz_bestand BIGNUMERIC(38,0)
OPTIONS(description='Prognostizierte Reichweite in Tagen (aus Bestand). Aggregat.'),
prognose_reichweite_tage_vz_bestand_we BIGNUMERIC(38,0)
OPTIONS(description='Prognostizierte Reichweite in Tagen (Bestand inkl. geplantem Wareneingang). Aggregat.'),
anz_tage_we_next BIGNUMERIC(38,0) OPTIONS(description='Anzahl Tage bis zum nächsten Wareneingang'),
prognose_reichweite_tage_vz_minusbestand BIGNUMERIC(38,0)
OPTIONS(description='Prognostizierte Tage mit Minusbestand bis zum nächsten (geplanten) Wareneingang VZ'),
menge_best_nwbs_bme BIGNUMERIC(38,14)
OPTIONS(description='Bestellmenge für non-WBS, in BME. Quelle: best_blockbestand.menge_block (Prozess ID 3), aggregiert.'),
menge_blockbestand_nwbs_kolli BIGNUMERIC(38,14)
OPTIONS(description='Menge Blockbestand non-WBS in Kolli. Quelle: lagerbestand_atp_per.menge_lgbest_block_nwbs, aggregiert.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, gp_dispo_id, art_dispo_id, dat_plan) NOT ENFORCED
)
OPTIONS(description='SCM - This table aggregates supply chain tables to generate values for how long stocks in the warehouses last.');