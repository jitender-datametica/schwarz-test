-- 20220518 twie: SPEC0153699 neue audimex Lookup System, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_system_1 (amx_system_id, amx_system_bez) AS
SELECT amx_system_id,
 amx_system_bez
FROM dbp_view.v_kmr_l_system_1 AS V01;