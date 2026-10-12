CREATE OR REPLACE TABLE kfl_production_dbp_data.artbew_promotion_zu_2 (
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT '),
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='In SAP vergebene ID, leider nur wahrscheinlich numerisch'),
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'),
ean_kasse INTEGER DEFAULT 0 NOT NULL OPTIONS(description='von den Kassensystemen gelieferte EAN_2'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
betrag_promo_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Um die Mehrwertsteuer verminderter Promotionsbetrag'),
betrag_mwst NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mehrwertsteuerbetrag des Promotionsbetrags'),
umrechnungskurs NUMERIC(29,5) NOT NULL
OPTIONS(description='Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs_2 angereichert'),
system_id INTEGER NOT NULL OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
menge_promo NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='abverkaufte Menge'),
umsatz_promo_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Um die Mehrwertsteuer verminderter Promotionsumsatz'),
umsatz_mwst NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mehrwertsteuerbetrag des Promotionsumsatzes'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
umrechnungskurs_hist NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat, bonuskauf_id, ean_kasse) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Hier werden Promotionen gespeichert - Zusatztabelle zu artbew_2');