--==============================================================
-- Table: sortiment_leistung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sortiment_leistung
   generated from Powerdesigner on Donnerstag, 31. August 2023 09:45:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sortiment_leistung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden'),
kjwo_update BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
kl_wg_id BIGNUMERIC(38,0) OPTIONS(description='ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_owg_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_uwg_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
owg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Oberwarengruppe'),
wg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warenuntergruppe'),
rang_umsatz_wg BIGNUMERIC(38,0)
OPTIONS(description='Rang matching_id innerhalb WG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
rang_umsatz_uwg BIGNUMERIC(38,0)
OPTIONS(description='Rang matching_id innerhalb UWG auf Basis Umsatz (wird im ETL-Prozess ermittelt)'),
rang_absatz_uwg BIGNUMERIC(38,0)
OPTIONS(description='Rang matching_id innerhalb UWG auf Basis Absatz (wird im ETL-Prozess ermittelt)'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Führende Artikelnummer: Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
kl_art_id STRING(2400)
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer'),
art_bez STRING(400) OPTIONS(description='Artikelbezeichnung'),
art_status STRING(8) OPTIONS(description='Löschkennzeichen aus DE (L:gelöscht; R:räumen; Blank:aktiv; Null: KMO)'),
gp_id BIGNUMERIC(38,0) OPTIONS(description='Artikel Lieferant aus artbew'),
akt_lieferant STRING(480) OPTIONS(description='Aktueller Lieferant (gp_id) aus art_gp_zu_per mit dat_bis 31.12.9999'),
zek_id STRING(3) OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
disc_pe BIGNUMERIC(38,0) OPTIONS(description='Discount Kennzeichen PE (Herkunft noch klären!)'),
disc_marke BIGNUMERIC(38,0) OPTIONS(description='Discount Kennzeichen Marke (artkz_discount)'),
lcf STRING(4) OPTIONS(description='lactose_fg aus Tabelle art'),
vegan STRING(4) OPTIONS(description='vegan_fg aus Tabelle art'),
gluten STRING(4) OPTIONS(description='gluten_fg aus Tabelle art'),
bio STRING(4) OPTIONS(description='bio_fg aus Tabelle art'),
eigenmarke STRING(8) OPTIONS(description='eigenmarke_fg_kl aus Tabelle art'),
tierwohl STRING(80) OPTIONS(description='tierwohl_fg aus Tabelle art'),
posten_food STRING(4) OPTIONS(description='Flag Posten Food (abgeleitet aus artkz_posten)'),
posten_nonfood STRING(4) OPTIONS(description='Flag Posten NonFood (abgeleitet aus artkz_posten)'),
mwst NUMERIC(12,2) OPTIONS(description='Mehrwertsteuersatz'),
listung_k_sst_mvke STRING(32) OPTIONS(description='K-Listungsinformation - (MVKE - art_sm_vw_zu_per) nur für KMO'),
gewichtete_distribution NUMERIC(18,4)
OPTIONS(description='Gewichtete Verteilung KL-Artikel (Pendant zu distr_gew aus Nielsen-Daten)'),
index_af_id BIGNUMERIC(38,0) OPTIONS(description='Index für Aktionsfreie Ware (Ampel)'),
umsatz_af_pro_markt_woche BIGNUMERIC(38,5) OPTIONS(description='Umsatz aktionsfrei pro Markt und Woche'),
absatz_af_pro_markt_woche BIGNUMERIC(38,5) OPTIONS(description='Absatz aktionsfrei pro Markt und Woche'),
ertrag_af_pro_markt_woche BIGNUMERIC(38,5) OPTIONS(description='Rohertrag (ek_mep) aktionsfrei pro Markt und Woche'),
bonreichweite_af BIGNUMERIC(38,5)
OPTIONS(description='Bonreichweite aktionsfreie Ware aus Shopper (Verteilung über verschiedene WG hinweg)'),
spanne_af BIGNUMERIC(38,5) OPTIONS(description='Rohertragsspanne aktionsfreie Ware'),
index_sa_id BIGNUMERIC(38,0) OPTIONS(description='Index für Sonderaktion Ware (Ampel)'),
umsatz_sa_pro_markt_woche BIGNUMERIC(38,5) OPTIONS(description='Umsatz Sonderaktionpro Markt und Woche'),
absatz_sa_pro_markt_woche BIGNUMERIC(38,5) OPTIONS(description='Absatz Sonderaktion pro Markt und Woche'),
ertrag_sa_pro_markt_woche BIGNUMERIC(38,5) OPTIONS(description='Rohertrag (ek_mep) Sonderaktionpro Markt und Woche'),
bonreichweite_sa BIGNUMERIC(38,5)
OPTIONS(description='Bonreichweite Sonderaktionsware aus Shopper (Verteilung über verschiedene WG hinweg)'),
spanne_sa BIGNUMERIC(38,5) OPTIONS(description='Rohertragsspanne Sonderaktionsware'),
aktionsanteil_absatz BIGNUMERIC(38,5) OPTIONS(description='Anteil Absatz in Aktion zum Gesamtabsatz'),
absatz_total BIGNUMERIC(38,5) OPTIONS(description='Gesamtabsatz'),
schnelldreherquote BIGNUMERIC(38,5) OPTIONS(description='Schnelldreherquote aus SAL'),
schnelldreherquote_wg BIGNUMERIC(38,5) OPTIONS(description='Schnelldreherquote aus SAL auf Ebene WG'),
schnelldreherquote_owg BIGNUMERIC(38,5) OPTIONS(description='Schnelldreherquote aus SAL auf Ebene OWG'),
kolliabverkaufsquote BIGNUMERIC(38,5) OPTIONS(description='Kolli-Abverkaufsquote aus SAL '),
kolliabverkaufsquote_wg BIGNUMERIC(38,5) OPTIONS(description='Kolli-Abverkaufsquote aus SAL auf Ebene WG'),
kolliabverkaufsquote_owg BIGNUMERIC(38,5) OPTIONS(description='Kolli-Abverkaufsquote aus SAL auf Ebene OWG'),
abschriftsanteil BIGNUMERIC(38,5) OPTIONS(description='Anteil Abschriften aus definierten Abschriftenkennzeichen'),
abschriftsanteil_wg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Abschriften aus definierten Abschriftenkennzeichen innerhalb WG'),
abschriftsanteil_owg BIGNUMERIC(38,5)
OPTIONS(description='Anteil Abschriften aus definierten Abschriftenkennzeichen  innerhalb OWG'),
cherrypicker_quote BIGNUMERIC(38,5) OPTIONS(description='Cherrypicker Quote aus Shopper'),
cherrypicker_quote_wg BIGNUMERIC(38,5) OPTIONS(description='Cherrypicker Quote aus Shopper innerhalb WG'),
cherrypicker_quote_owg BIGNUMERIC(38,5) OPTIONS(description='Cherrypicker Quote aus Shopper innerhalb OWG'),
restbon NUMERIC(18,4) OPTIONS(description='Restbon aus Shopper'),
restbon_wg NUMERIC(18,4) OPTIONS(description='Restbon aus Shopper innerhalb WG'),
restbon_owg NUMERIC(18,4) OPTIONS(description='Restbon aus Shopper innerhalb OWG'),
vk_preis BIGNUMERIC(38,5)
OPTIONS(description='VK Preis  brutto PM-ID 1 (Preiskategorie 1) aus Tabelle art_pm_vw_zu_per'),
durchschnittspreis BIGNUMERIC(38,5)
OPTIONS(description='Durchschnittspreis für KL-Artikel (Pendant Nielsen: durchschnitt_preis)'),
preislagenverteilung BIGNUMERIC(38,5) OPTIONS(description='Preislagenverteilung (wird im ETL-Prozess ermittelt)'),
marktanteilbewertung BIGNUMERIC(38,5) OPTIONS(description='Marktanteilbewertung(wird im ETL-Prozess ermittelt)'),
produktwissen_vp STRING(2040) OPTIONS(description='Produktwissen gepflegt durch ZEK Vorperiode (VJ)'),
lieferantenwissen_vp STRING(2040) OPTIONS(description='Lieferantenwissen gepflegt durch ZEK Vorperiode (VJ)'),
produktwissen_pflege STRING(2040) OPTIONS(description='Produktwissen gepflegt durch ZEK'),
lieferantenwissen_pflege STRING(2040) OPTIONS(description='Lieferantenwissen gepflegt durch ZEK'),
listung_sst_pflege STRING(32)
OPTIONS(description='Sortimentsstufe (SST) gepflegt durch ZEK (für KMO ohne K-Sortimentsstufe)'),
ost_basis_pflege STRING(8) OPTIONS(description='Listung Ost Basis gepflegt durch ZEK'),
ost_gross_pflege STRING(8) OPTIONS(description='ost_gross_pflege'),
sued_ost_pflege STRING(8) OPTIONS(description='sued_ost_pflege'),
sued_west_pflege STRING(8) OPTIONS(description='sued_west_pflege'),
west_pflege STRING(8) OPTIONS(description='west_pflege'),
nord_pflege STRING(8) OPTIONS(description='nord_pflege'),
vorschlag STRING(2040)
OPTIONS(description='Vorschlag gepflegt durch ZEK, ob Listung reduziert oder erweitert werden soll'),
stk_re_pflege STRING(2040) OPTIONS(description='Stück Rohertrag gepflegt durch ZEK für Potentialartikel'),
umsatz_hr NUMERIC(18,4) OPTIONS(description='Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)'),
absatz_hr NUMERIC(18,4) OPTIONS(description='Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)'),
rohertrag_hr NUMERIC(18,4) OPTIONS(description='Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)'),
nielsen_art_bez STRING(2400) OPTIONS(description='Artikelbezeichnung aus Nielsen '),
gtin STRING(1200) OPTIONS(description='Global Trade Item Number (GTIN)'),
distr_gew NUMERIC(18,4)
OPTIONS(description='Gewichtete Verteilung Nielsen-Artikel (Pendant zu distribution_gewichtet KL-Daten)'),
umsatz_anteil_uwg NUMERIC(18,4) OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten'),
umsatz_anteil_uwg_kumuliert NUMERIC(18,4)
OPTIONS(description='Anteil Umsatz innerhalb UWG ermittelt aus Nielsen-Daten kumuliert'),
durchschnitt_anz_maerkte BIGNUMERIC(38,0) OPTIONS(description='Durschnittliche Anzahl Märkte (Nielsen Daten)'),
durchschnitt_preis NUMERIC(18,4)
OPTIONS(description='Durchschnittlicher VK (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)'),
kl_markt_anteil_owg NUMERIC(18,4) OPTIONS(description='Marktanteil Kaufland  (Nielsen Daten)'),
umsatz_artikel NUMERIC(18,4) OPTIONS(description='Gesamtumsatz'),
absatz_artikel NUMERIC(18,4)
OPTIONS(description='wird im Fontend nicht verwendet - Prüfung, ob im BE noch verwendet wird?'),
anz_monate BIGNUMERIC(38,0) OPTIONS(description='Anzahl Monate'),
anz_wochen BIGNUMERIC(38,0) OPTIONS(description='Anzahl Wochen'),
eigenmarke_fg BIGNUMERIC(38,0)
OPTIONS(description='eigenmarke_fg ermittelt aus Nielsen-Daten (1 = "SENSITIVE" oder "N/A "'),
listung_sst_mvke STRING(32)
OPTIONS(description='Listungsinformation (in KMO ohne K-Listung) - (MVKE - art_sm_vw_zu_per)'),
ost_basis STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
ost_gross STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
sued_ost STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
sued_west STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
west STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
nord STRING(4)
OPTIONS(description='Listungsinformation - wird ermittelt aufgrund von Sortiments-Baustein-Zuordnungen (baustein_art_zu_per)'),
anz_maerkte_sst BIGNUMERIC(38,0)
OPTIONS(description='Marktanzahl Sortimentsstufe (in KMO ohne "K") und Regio-Cluster (nur DE)'),
anz_maerkte_baustein_sonstige BIGNUMERIC(38,0)
OPTIONS(description='Marktanzahl Bausteine (ohne Duplikate) - für KMO alle Bausteine / für DE ohne Regio-Bausteine'),
anz_maerkte_listung_einzel BIGNUMERIC(38,0) OPTIONS(description='Marktanzahl Einzellistung'),
anz_maerkte_listung_gesamt BIGNUMERIC(38,0)
OPTIONS(description='Marktanzahl Listung gesamt (Distinct Marktzählung der gülitgen Listungseinträge aus art_list_wup_zu_per ohne Listungsquelle 2 (Aktionslistung))'),
listungsaktion STRING(1020)
OPTIONS(description='Nur befüllt, wenn ZEK Eingaben tätigt. Fall 1: ZEK wählt aus Optionen, werden direkt hier gespeichert. Fall 2: ZEK wählt Soll-Listung, der richtige Text wird vom BE ermittelt und in das Feld geschrieben.'),
anz_maerkte_k_sst BIGNUMERIC(38,0) OPTIONS(description='Marktanzahl K-Sortimentsstufe (nur KMO)'),
listung_k_sst_pflege STRING(16) OPTIONS(description='K-Sortimentsstufe (K_SST) gepflegt durch ZEK (nur KMO)'),
muki_wb_kz STRING(20) OPTIONS(description='Zeigt mit W/M/K an, ob und wie Artikel der Matching ID in Werbe-Muki sind'),
muki_wb_kl_art_id_verkettung STRING(1200)
OPTIONS(description='Liste alle WB-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'),
muki_vk_kz STRING(20) OPTIONS(description='Zeigt mit W/M/K an, ob und wie Artikel der Matching ID in VK-Muki sind'),
muki_vk_kl_art_id_verkettung STRING(1200)
OPTIONS(description='Liste alle VK-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'),
muki_ek_kz STRING(20) OPTIONS(description='Zeigt mit W/M/K an, ob und wie Artikel der Matching ID in EK-Muki sind'),
muki_ek_kl_art_id_verkettung STRING(1200)
OPTIONS(description='Liste alle EK-Mütter auf, die an Artikeln der Matching-ID beteiligt sind'),
absatz_total_vj BIGNUMERIC(38,5) OPTIONS(description='Gesamtabsatz VJ'),
max_anz_maerkte_sst BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die SST aus der MVKE tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
max_anz_maerkte_k_sst BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Märkte, die gelistet sein müssten, wenn die K-SST aus der MVKE tatsächlich auch gelistet wurde (aus WRF6) - DWH generiert'),
kassenumsatz_kl_absolut_brutto BIGNUMERIC(38,5) OPTIONS(description='Kassenumsatz Kaufland brutto'),
kassenumsatz_kl_absolut_netto BIGNUMERIC(38,5) OPTIONS(description='Kassenumsatz Kaufland netto'),
abschriften_wert_netto_absolut BIGNUMERIC(38,5)
OPTIONS(description='Abschriftensumme VK netto, DE alles außer AKZ -1, KMO alle Preisänderungen/Abschriften'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjmo, matching_id, kjwo_update) NOT ENFORCED
) CLUSTER BY mandant_id, kjmo, kjwo_update, art_id
OPTIONS(description='EK-INTEGER  -  Sortimentstool - Aggregat für den Leistungs- und Potentialbericht');