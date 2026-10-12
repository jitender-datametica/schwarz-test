--==============================================================
-- Table: ginfo_flaeche_areaattr_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_flaeche_areaattr_per_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ginfo_flaeche_areaattr_per_2 (
techn_platz_id STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der technische Platz ist eine_2 von Kaufland Facility Management verwaltete Einheit'),
flaeche_attribut_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Diese ID wird im DWH generiert und ist ein ganzzahliger Wert'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
dat_bis DATE NOT NULL
OPTIONS(description='Endedatum  der Gültigkeit einer Fläche. Bei aktuell gültigen Sätzen ist hier der 31.12.9999 eingetragen'),
flaeche_cad NUMERIC(18,2)
OPTIONS(description='Fläche per CAD ermittelt, in der Tabelle ginfo_flaeche_det_per_2 gespeichert'),
flaeche_schaetzung NUMERIC(18,2) OPTIONS(description='Schätzwert der Fläche'),
flaeche_beauftragung NUMERIC(18,2) OPTIONS(description='Beauftragte Fläche'),
quelle_beauftragung BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Angabe, woher die Flächenangabe für die Beauftragung kommt, ob aus cad (1), aus Schätzung (2) oder aus Beauftragung (3)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flaeche_attribut_id, dat_von) NOT ENFORCED
) OPTIONS(description='IOS - Beauftragte Flächen mit Quelle der Flächenangaben aus sitecare_area');