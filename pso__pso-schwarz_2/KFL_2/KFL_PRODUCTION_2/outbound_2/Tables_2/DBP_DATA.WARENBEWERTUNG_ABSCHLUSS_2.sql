--==============================================================
-- Table: warenbewertung_abschluss_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: warenbewertung_abschluss_2
   generated from Powerdesigner on Freitag, 27. Oktober 2023 15:57:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.warenbewertung_abschluss_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nebenbetriebskennziffer, im bisherigen System die 4. Stelle der Marktnummer.'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
buchungskreis_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland.'),
dat_aenderung DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT - Datum Stichtag.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
version_id STRING(1) NOT NULL OPTIONS(description='Versionsnummer'),
dat_von DATE OPTIONS(description='Datum gültig von.'),
dat_bis DATE OPTIONS(description='Datum gültig bis.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR.'),
gld BIGNUMERIC(38,2) OPTIONS(description='Gleitender Durchschnittspreis / Periodischer Verrechnungspreis.'),
menge_bestand_bme BIGNUMERIC(38,3) OPTIONS(description='Gesamter bewerteter Bestand in Basismengeneinheit.'),
wert_bestand BIGNUMERIC(38,2) OPTIONS(description='Wert des gesamten bewerteten Bestandes.'),
proz_inventurfort BIGNUMERIC(38,3) OPTIONS(description='Inventurfortschreibung %'),
betrag_inventurfort BIGNUMERIC(38,2) OPTIONS(description='Inventurfortschreibung'),
inventurfort_wert_bestand BIGNUMERIC(38,2) OPTIONS(description='Bestandswert nach Inventur.'),
inventurfort_menge_bestand_bme BIGNUMERIC(38,3) OPTIONS(description='Bestandsmenge nach Inventur.'),
apm_art_fg STRING(1) OPTIONS(description='Anschaffungspreisminderung artikelgenau'),
apm_wg STRING(1) OPTIONS(description='Auszugrenzende WG Anschaffungspreisminderung'),
proz_apm_art BIGNUMERIC(38,2) OPTIONS(description='Anschaffungspreisminderung (APM) % Artikel_2'),
proz_apm_korr BIGNUMERIC(38,2) OPTIONS(description='Berechneter Anschaffungspreisminderung Korrekturfaktor'),
proz_apm_korr_art BIGNUMERIC(38,2)
OPTIONS(description='Berechnung nach Konzept Anschaffungspreisminderung WE Logik nach Korrekturfaktor'),
proz_apm_hwg BIGNUMERIC(38,2) OPTIONS(description='Anschaffungspreisminderung % HWG'),
proz_apm_hwg_pa BIGNUMERIC(38,2) OPTIONS(description='Anschaffungspreisminderung HWG + Pauschal'),
proz_apm_ja_pa BIGNUMERIC(38,2) OPTIONS(description='Anschaffungspreisminderung % JA Pauschal'),
proz_apm_ges BIGNUMERIC(38,2) OPTIONS(description='Anschaffungspreisminderung % Artikel_2'),
betrag_apm_art BIGNUMERIC(38,2) OPTIONS(description='Anschaffungspreisminderung Artikelgenau'),
betrag_apm_pa BIGNUMERIC(38,2) OPTIONS(description='Anschaffungspreisminderung Pauschal'),
apm_wert_bestand BIGNUMERIC(38,2) OPTIONS(description='Bestand nach Anschaffungspreisminderung'),
ausg_wg_nwp STRING(1) OPTIONS(description='Auszugrenzende WG NWP'),
ek_34n BIGNUMERIC(38,2) OPTIONS(description='NN Einkaufspreis'),
inf_value BIGNUMERIC(38,6) OPTIONS(description='Wert Bestand zu 3/4N'),
ek_2n_1 BIGNUMERIC(38,2) OPTIONS(description='NN Einkaufspreis'),
nw_abwert BIGNUMERIC(38,6) OPTIONS(description='NW Abwertung'),
wnn_value BIGNUMERIC(38,3) OPTIONS(description='Wert nach Anschaffungspreisminderung, NW'),
ausg_wg_vfb STRING(1) OPTIONS(description='Auszugrenzende WG VFB'),
proz_abschlag BIGNUMERIC(38,2) OPTIONS(description='Abschlag noch anfall. Kosten %'),
betrag_vk_netto_vp BIGNUMERIC(38,2) OPTIONS(description='Artikel_2 Wert in VP ohne MwSt'),
betrag_vk_wert BIGNUMERIC(38,3) OPTIONS(description='Wert zu VK_2'),
betrag_abw_vf BIGNUMERIC(38,3) OPTIONS(description='Verlustfreien Bewertung (VFB)'),
betrag_gesamt BIGNUMERIC(38,3) OPTIONS(description='Wert nach Inv., Anschaffungspreisminderung, NW, VFB'),
ausg_wg_rw STRING(1) OPTIONS(description='Auszugrenzende WG RW'),
dat_erster_vk DATE OPTIONS(description='Erste Verkauf Datum'),
tage BIGNUMERIC(38,0) OPTIONS(description='Tage'),
umsatz_menge BIGNUMERIC(38,4) OPTIONS(description='Umsatz für Menge in Basismengeneinheit.'),
menge_hr BIGNUMERIC(38,3) OPTIONS(description='Absatzmenge HR'),
kj_reichweite BIGNUMERIC(38,2) OPTIONS(description='Reichweite in Jahren'),
menge_abverkauf_gm STRING(1) OPTIONS(description='Abverk. < 1 Monat_2'),
proz_rw BIGNUMERIC(38,2) OPTIONS(description='RW-Satz'),
rw_abschl BIGNUMERIC(38,2) OPTIONS(description='RW Abschlag'),
best_abw BIGNUMERIC(38,2) OPTIONS(description='Bestandswert nach Abwertung'),
umsatz_lw BIGNUMERIC(38,2) OPTIONS(description='Umsatz Wert in lokal Währung'),
abverkauf_fg STRING(1) OPTIONS(description='Anzeige Abverkauf = 0 (dann Eintrag 1)'),
abt_abschluss STRING(2) OPTIONS(description='Trennung Food (F) und Nonfood (T - Textil; H - HAWA)'),
sum_abw BIGNUMERIC(38,2)
OPTIONS(description='Summe der drei einzelnen Abwertungen aus den Spalten nw_abwert (Niederstwertprinzip), betrag_abw_vf (Verlustfreie Bewertung) und rw_abschlag (Reichweitenabschlag). Abwertungen sind Verfahren im Rechnungswesen für die Bilanzbewertung von Beständen. Die Werte kommen vorberechnet aus SAP.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_id, nb_id, mandant_id, system_id, buchungskreis_id, dat_aenderung, art_id, version_id) NOT ENFORCED
) OPTIONS(description='WWC - Tabelle für die Warenbewertung nach zwei Versionen, artikelgenau und pauschal.');