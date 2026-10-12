--==============================================================
-- Table: flw_tqm_massentest_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_tqm_massentest_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_tqm_massentest_1 (
flw_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
dat_test DATE NOT NULL OPTIONS(description='Datum des Tests'),
pc_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschluessel fuer die Profitcenter'),
krk_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
anz_stck_geprueft BIGNUMERIC(38,0) NOT NULL OPTIONS(description='geprüfte Stückzahl'),
anz_kf_fehler BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl kritische Fehler'),
anz_vk_fehler BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Verkaufs-Fehler'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_lief_id, mandant_id, flw_art_id, dat_test) NOT ENFORCED
) OPTIONS(description='FLW - im Fleischwerk erfasste Daten, die via HFM ins DWH übertragen werden');