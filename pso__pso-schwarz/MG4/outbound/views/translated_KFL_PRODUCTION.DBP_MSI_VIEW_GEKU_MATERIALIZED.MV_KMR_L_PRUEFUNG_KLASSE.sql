-- 20220518 twie: SPEC0153699 neue audimex Lookup Prüfung Klasse (Prüfungsart), inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_pruefung_klasse (pruefung_klasse_id, amx_system_id,
pruefung_klasse_bez) AS SELECT pruefung_klasse_id,
 amx_system_id,
 pruefung_klasse_bez
FROM kfl_production_dbp_view.v_kmr_l_pruefung_klasse AS v01;