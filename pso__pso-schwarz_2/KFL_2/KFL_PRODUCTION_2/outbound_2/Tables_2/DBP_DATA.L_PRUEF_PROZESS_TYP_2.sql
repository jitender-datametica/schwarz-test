--==============================================================
-- Table: l_pruef_prozess_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_pruef_prozess_typ_2
   generated from Powerdesigner on Mittwoch, 21. Februar 2024 15:28:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_pruef_prozess_typ_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
pruef_prozess_typ_kz STRING(10) NOT NULL
OPTIONS(description='Kennzeichen des Prüf-Prozesses. Aktuell nur\'MAX\', in Zukunft weitere Prozesse geplant.'),
pruef_prozess_typ_bez STRING(100) NOT NULL OPTIONS(description='Bezeichnung des Prüf-Prozesses.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, pruef_prozess_typ_kz) NOT ENFORCED
) OPTIONS(description='Tabelle beinhaltet verschiedene Arten von Prüf-Prozessen in den Filialen.');