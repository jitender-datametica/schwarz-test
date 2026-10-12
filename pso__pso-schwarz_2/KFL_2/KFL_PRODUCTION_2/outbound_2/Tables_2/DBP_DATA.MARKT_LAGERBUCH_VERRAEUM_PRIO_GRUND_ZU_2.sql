--==============================================================
-- Table: markt_lagerbuch_verraeum_prio_grund_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markt_lagerbuch_verraeum_prio_grund_zu_2
   generated from Powerdesigner on Mittwoch, 29. Oktober 2025 13:29:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.markt_lagerbuch_verraeum_prio_grund_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenumschlagsplatz-ID der Filiale, in der der Artikel_2 verkauft wird.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.'),
stellplatz_nr STRING(20) NOT NULL OPTIONS(description='Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3'),
markt_lagerbereich_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Lagerbereichs in der Filiale.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
dat_mhd DATE NOT NULL OPTIONS(description='Mindesthaltbarkeitsdatum des Artikels.'),
betrag_vk_brutto BIGNUMERIC(38,4) NOT NULL OPTIONS(description='VK_2 Brutto Einzelpreis des Artikels.'),
dat_lagerbuch DATE NOT NULL OPTIONS(description='Datum der Lagerbuchdaten.'),
verraeumung_prio_grund_id STRING(2) NOT NULL
OPTIONS(description='ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, stellplatz_nr, markt_lagerbereich_id, art_id, dat_mhd, betrag_vk_brutto,
 dat_lagerbuch, verraeumung_prio_grund_id) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle für Lagerbuch in der Filiale zu Verräumungs-Prioritätsgründen. Quellsystem: Couchbase. Diese Tabelle stellt die Verbindung zwischen den Artikeln im Lagerbuch der Filiale und den Gründen her, die diese Artikel_2 als "kritisch" für die Verräumung auf die Verkaufsfläche einstufen. Es ist möglich, dass ein bestimmter Artikel_2 im Lagerbuch mehrere Prioritätsgründe aufweist.');