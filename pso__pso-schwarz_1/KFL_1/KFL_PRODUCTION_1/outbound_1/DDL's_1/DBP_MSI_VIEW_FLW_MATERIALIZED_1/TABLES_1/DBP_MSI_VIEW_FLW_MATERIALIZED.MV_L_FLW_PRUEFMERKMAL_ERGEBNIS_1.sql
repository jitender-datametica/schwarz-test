CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_pruefmerkmal_ergebnis_1 (
prueflos_id INTEGER,
merkmal_lfd_nr INTEGER,
mandant_id INTEGER,
knoten_lfd_nr INTEGER,
erg_detail_id INTEGER,
satzstatus_id INTEGER,
fehlerklasse_id INTEGER,
katalogart_id STRING(1) COLLATE 'und:ci',
codegruppe_id STRING(10) COLLATE 'und:ci',
pruefcode_id STRING(4) COLLATE 'und:ci',
version_id INTEGER,
qual_meldung_id INTEGER,
dat_pruef_von DATE,
messwert_ni_fg INTEGER,
original_input STRING(30) COLLATE 'und:ci',
messwert NUMERIC(29,5)
);