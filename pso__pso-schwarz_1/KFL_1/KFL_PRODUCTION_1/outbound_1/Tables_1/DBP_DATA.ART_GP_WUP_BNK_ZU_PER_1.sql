--==============================================================
-- Table: art_gp_wup_bnk_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_wup_bnk_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_gp_wup_bnk_zu_per_1 (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
dat_von DATE NOT NULL OPTIONS(description='Gueltigkeitsbeginn des Datensatzes.'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_bis DATE OPTIONS(description='Gueltigkeitsende des Datensatzes.'),
cycle_id BIGNUMERIC(38,0),
betrag_auslandsfracht NUMERIC(9,4) OPTIONS(description='Wert der Auslandsfracht.'),
betrag_auslandsfracht2 NUMERIC(9,4) OPTIONS(description='Wert der Auslandsfracht 2.'),
betrag_zoll NUMERIC(9,4) OPTIONS(description='Wert des Zolls.'),
betrag_antidump NUMERIC(9,4) OPTIONS(description='Wert/Betrag fuer Anti Dumping.'),
betrag_inlandsfracht NUMERIC(9,4) OPTIONS(description='Wert der Inlandsfracht.'),
betrag_gem_rueckn NUMERIC(9,4) OPTIONS(description='Wert/Betragfuer das gemeinsame Ruecknahmesystem.'),
betrag_duales_system NUMERIC(9,4) OPTIONS(description='Wert/Betrag fuer das duale System Deutschland.'),
betrag_gema NUMERIC(9,4) OPTIONS(description='Wert/Betrag fuer die GEMA Gebuehr.'),
betrag_verbrauchsst NUMERIC(9,4) OPTIONS(description='Wert der Verbruachssteuer.'),
betrag_verpackung NUMERIC(9,4) OPTIONS(description='Wert/Betrag fuer die Verpackung.'),
betrag_prov NUMERIC(9,4) OPTIONS(description='Wert/Betrag der Provision.'),
betrag_hk_prov NUMERIC(9,4) OPTIONS(description='Wert/Betrag der Hong Kong Provision.'),
betrag_agentur_prov NUMERIC(9,4) OPTIONS(description='Wert/Betrag der Agentur Provision.'),
betrag_mto NUMERIC(9,4) OPTIONS(description='Wert der MTO (Markant Trading Organiszation) Konditionen.'),
betrag_pruefkosten NUMERIC(9,4) OPTIONS(description='Wert der Pruefungskosten.'),
betrag_eu_regelung NUMERIC(9,4) OPTIONS(description='Wert/Betrag der EU Regelung.'),
betrag_sonst_kosten NUMERIC(9,4) OPTIONS(description='Wert/Betrag der sonstigen Kosten.'),
kond_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Konditionseinheit (Waehrung oder Prozentsatz).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, art_id, gp_id, einkaufsorganisation_id, wup_id, dat_von) NOT ENFORCED
)
OPTIONS(description='RPW - Diese Tabelle enthaelt zeitabhaengig die statistisch geplanten Bezugsnebenkosten pro Artikel_1, Lieferant und WUP. Quelle fuer diese Information ist die SAP Tabelle ZBNK.');