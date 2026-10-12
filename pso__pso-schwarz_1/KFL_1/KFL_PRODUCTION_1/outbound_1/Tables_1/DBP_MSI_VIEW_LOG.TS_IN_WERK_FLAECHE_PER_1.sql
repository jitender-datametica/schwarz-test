--==============================================================
-- Table: ts_in_werk_flaeche_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_in_werk_flaeche_per_1
   generated from Powerdesigner on Montag, 20. Februar 2023 09:55:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_log.ts_in_werk_flaeche_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk'),
gebaeude_bez STRING(100) DEFAULT 'total' NOT NULL OPTIONS(description='Gebäude Bezeichnung, z. B. FOOD'),
gebaeudeteil_bez STRING(100) DEFAULT 'total' NOT NULL OPTIONS(description='Gebäudeteil Bezeichnung, z. B. Halle 1'),
flaeche_qm NUMERIC(18,3) OPTIONS(description='Flaeche in Quadratmetern'),
dat_von DATE OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
dat_bis DATE OPTIONS(description='Gültig bis'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werk_id, gebaeude_bez, gebaeudeteil_bez) NOT ENFORCED
)
OPTIONS(description='Flaeche in m² pro Werk (SAP Industry) mit Gueltigkeitsintervall, da Erweiterungen von VZ haeufiger vorkommen koennen. Wird durch TS Dokument versorgt.');