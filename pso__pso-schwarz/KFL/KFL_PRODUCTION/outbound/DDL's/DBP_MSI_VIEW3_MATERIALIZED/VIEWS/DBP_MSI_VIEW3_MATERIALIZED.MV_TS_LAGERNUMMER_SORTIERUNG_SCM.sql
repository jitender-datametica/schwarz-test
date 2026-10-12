CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_ts_lagernummer_sortierung_scm (mandant_id,
lagernummer_id, wup_id, nb_id, lagersortiment_id, artikelsortiment_id, lagernummer_sortierung_scm_id,
lagernummer_sortierung_scm_bez) AS SELECT V01.mandant_id,
 V01.lagernummer_id,
 V01.wup_id,
 V01.nb_id,
 COALESCE(V02.lagersortiment_id, '-1') AS lagersortiment_id,
 COALESCE(V02.artikelsortiment_id, '-1') AS artikelsortiment_id,
 COALESCE(V02.lagernummer_sortierung_scm_id, '-1') AS lagernummer_sortierung_scm_id,
 COALESCE(V02.lagernummer_sortierung_scm_bez, 'N/A') AS lagernummer_sortierung_scm_bez
FROM kfl_production_dbp_view.v_l_lagernummer AS V01
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm AS V02 ON V01.lagernummer_id = V02.lagernummer_id
      AND V01.mandant_id = V02.mandant_id AND V01.nb_id = V02.nb_id AND V01.wup_id = V02.wup_id;