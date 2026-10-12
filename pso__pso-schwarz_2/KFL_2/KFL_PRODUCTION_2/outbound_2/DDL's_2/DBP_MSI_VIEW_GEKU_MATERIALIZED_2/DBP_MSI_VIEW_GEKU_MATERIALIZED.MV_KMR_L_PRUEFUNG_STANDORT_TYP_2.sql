-- 20220518 twie: SPEC0153699 neue audimex Lookup Standorttyp, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_kmr_l_pruefung_standort_typ_2 (standort_typ_id,
amx_system_id, standort_typ_bez) AS SELECT standort_typ_id,
 amx_system_id,
 standort_typ_bez
FROM kfl_production_dbp_view.v_kmr_l_pruefung_standort_typ_2 AS V01;