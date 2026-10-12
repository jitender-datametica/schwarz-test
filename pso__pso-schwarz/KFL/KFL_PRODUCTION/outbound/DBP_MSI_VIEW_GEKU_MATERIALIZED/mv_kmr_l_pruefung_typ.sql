-- 20220518 twie: SPEC0153699 neue audimex Lookup Prüfungsstyp, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_pruefung_typ (pruefung_typ_id,
amx_system_id, pruefung_typ_bez) AS SELECT pruefung_typ_id,
 amx_system_id,
 pruefung_typ_bez
FROM dbp_view.v_kmr_l_pruefung_typ AS V01;