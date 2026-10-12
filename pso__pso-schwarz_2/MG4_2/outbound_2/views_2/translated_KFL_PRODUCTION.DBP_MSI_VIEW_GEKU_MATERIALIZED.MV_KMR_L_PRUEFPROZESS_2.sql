-- 20220518 twie: SPEC0153699 neue audimex Lookup Prozess, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_pruefprozess_2 (gepr_prozess_id, amx_system_id,
gepr_prozess_imp_referenz, gepr_prozess_bez) AS SELECT gepr_prozess_id,
 amx_system_id,
 gepr_prozess_imp_referenz,
 gepr_prozess_bez
FROM kfl_production_dbp_view.v_kmr_l_pruefprozess_2 AS v01;