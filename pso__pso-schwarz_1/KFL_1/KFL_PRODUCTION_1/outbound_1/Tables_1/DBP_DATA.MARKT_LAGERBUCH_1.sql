--==============================================================
-- Table: markt_lagerbuch_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markt_lagerbuch_1
   generated from Powerdesigner on Mittwoch, 29. Oktober 2025 13:29:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.markt_lagerbuch_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenumschlagsplatz-ID der Filiale, in der der Artikel_1 verkauft wird.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.'),
stellplatz_nr STRING(20) NOT NULL OPTIONS(description='Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3'),
markt_lagerbereich_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Lagerbereichs in der Filiale.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
dat_mhd DATE NOT NULL OPTIONS(description='Mindesthaltbarkeitsdatum des Artikels.'),
betrag_vk_brutto BIGNUMERIC(38,4) NOT NULL OPTIONS(description='VK_1 Brutto Einzelpreis des Artikels.'),
dat_lagerbuch DATE NOT NULL OPTIONS(description='Datum der Lagerbuchdaten.'),
menge_lagerbestand_stellplatz BIGNUMERIC(38,3) OPTIONS(description='Lagerbestand auf dem Stellplatz.'),
menge_lagerbestand_gesamt BIGNUMERIC(38,3) OPTIONS(description='Gesamter Bestand im Filiallager.'),
menge_filialbestand BIGNUMERIC(38,3)
OPTIONS(description='Gesamter Filialbestand. Enthält die Summe des aktuellen Lagerbestands und des Bestands im Verkaufsregal für die zugehörige Filiale.'),
menge_opt_bestand BIGNUMERIC(38,3) OPTIONS(description='Maximaler oder optischer Bestand des Artikels im Regal.'),
rate_verraeumung BIGNUMERIC(38,2)
OPTIONS(description='Für jeden Artikel_1 im Lager wird geprüft wieviel % des Bestandes ins Verkaufsregal verräumt werden können. Hierfür wird aus dem Filialbestand minus Lagerbestand minus Wareneingangs-Bestand der Regalbestand ermittelt. '),
dat_aenderung DATE NOT NULL OPTIONS(description='letzte Änderung auf dem Stellplatz.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, stellplatz_nr, markt_lagerbereich_id, art_id, dat_mhd, betrag_vk_brutto,
 dat_lagerbuch) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält einen Überblick über die Bestandsituation in einer Filiale (Lager, Verkaufsfläche). Sie wird aus dem System Couchbase versorgt.');