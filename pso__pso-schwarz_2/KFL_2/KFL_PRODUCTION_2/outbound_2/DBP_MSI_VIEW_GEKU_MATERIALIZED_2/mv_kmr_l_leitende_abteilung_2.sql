-- 20220518 twie: SPEC0153699 neue audimex Lookup Leitende Abteilung, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_leitende_abteilung_2 (leit_abteilung_id,
amx_system_id, leit_abteilung_bez) AS SELECT leit_abteilung_id,
 amx_system_id,
 leit_abteilung_bez
FROM dbp_view.v_kmr_l_leitende_abteilung_2 AS V01;