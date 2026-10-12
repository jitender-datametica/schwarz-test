CREATE OR REPLACE TABLE kfl_production_dbp_data.ek_infosatz (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ek_infosatz_id INTEGER NOT NULL
OPTIONS(description='Nummer des Infosatzes. Zusammen mit mandant_id eindeutiger Schluessel'),
art_id INTEGER NOT NULL OPTIONS(description=' Artikel - Id'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschaeftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id INTEGER NOT NULL
OPTIONS(description='Fuer verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
dat_erstellung DATE NOT NULL
OPTIONS(description='Erstelldatum Infosatz. Bei mehreren Treffern gilt der Satz mit dem aktuellsten Datum'),
gp_art_id STRING(40) COLLATE 'und:ci' OPTIONS(description='Lieferanten-Artikelnummer'),
dat_von DATE NOT NULL OPTIONS(description='Lieferbar / gueltig-ab'),
dat_bis DATE NOT NULL OPTIONS(description='Lieferbar / gueltig-bis'),
regel_gp_fg INTEGER NOT NULL OPTIONS(description='Flag für Regellieferanten'),
loesch_fg INTEGER NOT NULL OPTIONS(description='Flag geloescht'),
gp_teilsortiment_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Teilsortiment aus SAP ltsnr'),
konditionsgruppe_id STRING(10) OPTIONS(description='Eindeutiger Schluessel der Konditionsgruppen beim Lieferanten.'),
menge_einh_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Bestellmengeneinheit - nur gefüllt für DE (EINA PR1), leer für KMO'),
apollo_ian STRING(35)
OPTIONS(description='EN long: Apollo Suppl - IANEN short: APO. S-IAN DE long: Apollo Lft - IANDE short: APO. L-IANTA Dynpro DE:Apollo Lft-IANTA Dynpro EN:Apollo Supp-IAN'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
crossdocking_id INTEGER OPTIONS(description='ID des Umschlagplatzs bzw. Cross Docking Orts.'),
PRIMARY KEY (mandant_id, ek_infosatz_id) NOT ENFORCED
)
OPTIONS(description='AIS_KMO- Artikel-Lieferantenzuordnung aus der SAP-Tabelle EINA. Wird im DWH vorlaeufig nur für KMO genutzt');