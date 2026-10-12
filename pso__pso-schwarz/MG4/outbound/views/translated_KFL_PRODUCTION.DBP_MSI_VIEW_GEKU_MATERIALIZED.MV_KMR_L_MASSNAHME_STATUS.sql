-- 20230817 twie: SPEC0195708 neue audimex Lookup Massnahmestatus, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_massnahme_status (massnahme_status_id, amx_system_id,
massnahme_status_bez) AS SELECT massnahme_status_id,
 amx_system_id,
 massnahme_status_bez
FROM kfl_production_dbp_view.v_kmr_l_massnahme_status AS v01;