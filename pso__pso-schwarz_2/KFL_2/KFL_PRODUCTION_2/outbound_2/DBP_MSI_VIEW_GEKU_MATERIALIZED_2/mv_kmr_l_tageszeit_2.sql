-- 20220518 twie: SPEC0153699 neue audimex Lookup Tageszeit, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_tageszeit_2 (tageszeit_id, amx_system_id,
tageszeit_bez) AS SELECT tageszeit_id,
 amx_system_id,
 tageszeit_bez
FROM dbp_view.v_kmr_l_tageszeit_2 AS V01;