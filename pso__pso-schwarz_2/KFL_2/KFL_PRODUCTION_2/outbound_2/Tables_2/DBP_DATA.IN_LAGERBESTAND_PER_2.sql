--==============================================================
-- Table: in_lagerbestand_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_lagerbestand_per_2
   generated from Powerdesigner on Mittwoch, 17. August 2022 20:22:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_lagerbestand_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
in_art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk'),
in_lagerort_id STRING(4) NOT NULL OPTIONS(description='Lagerort'),
dat_von DATE NOT NULL OPTIONS(description='Gültig von'),
dat_bis DATE OPTIONS(description='Gültig bis'),
menge_lgbest_frei_bme NUMERIC(18,3) OPTIONS(description='Bewerteter, frei verwendbarer Bestand'),
menge_lgbest_umlag_bme NUMERIC(18,3) OPTIONS(description='Umlagerungsbestand (von Lagerort zu Lagerort)'),
menge_lgbest_qual_bme NUMERIC(18,3) OPTIONS(description='Qualitätsprüfbestand'),
menge_lgbest_nf_charge_bme NUMERIC(18,3) OPTIONS(description='Gesamtbestand aller nicht freien Chargen'),
menge_lgbest_gesp_bme NUMERIC(18,3) OPTIONS(description='Gesperrter Bestand'),
menge_lgbest_ret_gesp_bme NUMERIC(18,3) OPTIONS(description='Retourensperrbestand'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, in_art_id, werk_id, in_lagerort_id, dat_von) NOT ENFORCED
)
OPTIONS(description='Lagerbestand pro Artikel_2/Werk aus SAP Industry (Tabelle MARD_2) auf Tagesebene in Basismengeneinheit getrennt nach frei verfügbarem Bestand / Umlagerungsbestand etc.');