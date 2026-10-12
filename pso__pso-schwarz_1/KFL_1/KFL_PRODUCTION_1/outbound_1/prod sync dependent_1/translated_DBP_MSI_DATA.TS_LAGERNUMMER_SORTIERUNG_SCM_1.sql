CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 in DWH.'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer / Lagerkomplex.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stellen der Marktnummer, die Nebenbetriebskennziffer.'),
lagersortiment_id STRING(1) NOT NULL OPTIONS(description='Lagersortiment ID.'),
artikelsortiment_id STRING(1) NOT NULL OPTIONS(description='Artikelsortiment ID.'),
lagernummer_sortierung_scm_id STRING(10) NOT NULL OPTIONS(description='Lagernummersortierung SCM.'),
lagernummer_sortierung_scm_bez STRING(255) OPTIONS(description='Lagernummersortierung SCM (Bezeichnung).'),
dat_pflege_layout DATE
OPTIONS(description='Datum, seit dem das Layout eines Verteilzentrums in SAP gepflegt wird. Das Layout wird benötigt um Entfernungen und darauf basierende Kennzahlen auszurechnen. Das Datum wird benötigt um zu verhindern, dass Kennzahlen zu einem Zeitraum gezogen werden, für den es noch kein fertiges / freigegebenes Layout gab.'),
dat_tms_wanko DATE OPTIONS(description='Golive Datum des WANKO TMS.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lagernummer_id, wup_id, nb_id, lagersortiment_id, artikelsortiment_id,
 lagernummer_sortierung_scm_id) NOT ENFORCED
) OPTIONS(description='LIS - Lagernummer Sortierung SCM.');