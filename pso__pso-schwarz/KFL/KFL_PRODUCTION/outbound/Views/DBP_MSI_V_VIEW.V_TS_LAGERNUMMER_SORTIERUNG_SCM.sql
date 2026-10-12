CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm (mandant_id
OPTIONS(description='Mandant in DWH.'), lagernummer_id OPTIONS(description='Lagernummer / Lagerkomplex.'), wup_id
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stellen der Marktnummer, die Nebenbetriebskennziffer.'),
lagersortiment_id OPTIONS(description='Lagersortiment ID.'), artikelsortiment_id
OPTIONS(description='Artikelsortiment ID.'), lagernummer_sortierung_scm_id
OPTIONS(description='Lagernummersortierung SCM.'), lagernummer_sortierung_scm_bez
OPTIONS(description='Lagernummersortierung SCM (Bezeichnung).'), dat_pflege_layout
OPTIONS(description='Datum, seit dem das Layout eines Verteilzentrums in SAP gepflegt wird. Das Layout wird benötigt um Entfernungen und darauf basierende Kennzahlen auszurechnen. Das Datum wird benötigt um zu verhindern, dass Kennzahlen zu einem Zeitraum gezogen werden, für den es noch kein fertiges / freigegebenes Layout gab.'),
dat_tms_wanko OPTIONS(description='Golive Datum des WANKO TMS.'))
OPTIONS(DESCRIPTION = `LIS - LAGERNUMMER SORTIERUNG SCM.`) AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 lagersortiment_id,
 artikelsortiment_id,
 lagernummer_sortierung_scm_id,
 lagernummer_sortierung_scm_bez,
 dat_pflege_layout,
 dat_tms_wanko
FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm;