--==============================================================
-- Table: flw_art_gp_wup_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_gp_wup_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_gp_wup_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
einkaufs_infosatz_id INTEGER NOT NULL OPTIONS(description='Nummer des Einkaufsinfosatzes aus SAP Quelle EINA.INFNR'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
flw_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Einkaufsorganisation aus ekorg'),
einkaufs_infosatz_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Typ des Einkaufsinfosatzes aus SAP Quelle EINE.ESOKZ'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
loesch_fg BIGNUMERIC(38,0)
OPTIONS(description='Einkaufsinfo allgemeine Daten zum Löschen vorgemerkt aus SAP Quelle EINE.LOEKZ'),
dat_erfasst DATE OPTIONS(description='Erfassdatum des Einkaufsinfosatzes aus SAP Quelle EINE.ERDAT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (einkaufs_infosatz_id, flw_art_id, flw_lief_id, einkaufsorganisation_id, einkaufs_infosatz_typ_id, werk_id,
 mandant_id) NOT ENFORCED
)
OPTIONS(description='FLW - Einkaufsinfosatz - allgemeine und Einkaufsorganisationsdaten, zusammengeführt  aus SAP P21 Tabellen EINE und EINA');