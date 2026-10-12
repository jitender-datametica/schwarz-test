--==============================================================
-- Table: artbew_promotion_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_promotion_zu
   generated from Powerdesigner on Dienstag, 28. Januar 2025 16:46:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_promotion_zu (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT '),
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='In SAP vergebene ID, leider nur wahrscheinlich numerisch'),
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'),
ean_kasse NUMERIC(26,0) DEFAULT 0 NOT NULL OPTIONS(description='von den Kassensystemen gelieferte EAN'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
betrag_promo_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Um die Mehrwertsteuer verminderter Promotionsbetrag'),
betrag_mwst NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mehrwertsteuerbetrag des Promotionsbetrags'),
umrechnungskurs BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs angereichert'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
menge_promo NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='abverkaufte Menge'),
umsatz_promo_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Um die Mehrwertsteuer verminderter Promotionsumsatz'),
umsatz_mwst NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mehrwertsteuerbetrag des Promotionsumsatzes'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat, bonuskauf_id, ean_kasse) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Hier werden Promotionen gespeichert - Zusatztabelle zu artbew');