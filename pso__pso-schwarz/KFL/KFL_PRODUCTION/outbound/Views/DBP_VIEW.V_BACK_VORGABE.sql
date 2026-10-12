CREATE OR REPLACE VIEW kfl_production_dbp_view.v_back_vorgabe AS SELECT mandant_id,
 wup_cluster_id,
 wug_cluster_id,
 back_drehklasse_id,
 aktion_fg,
 key_bc_bez,
 aufschlag_zeit,
 ant_mag,
 faktor_ist,
 min_gesamt_fs,
 ant_min_fs,
 prognoseart
FROM kfl_production_dbp_data.back_vorgabe;