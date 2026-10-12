-- 07.06.2018 twie: SPEC0038139 Schlüssel für DWH Artikel_2 um kmr_quelle_id ergänzg für Zusammenführung Hierarchie

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_zustaendigkeit_2 (kundenfaktor_id, geku_dwh_artikel_id,
kmr_quelle_id, zustaendigkeit) AS SELECT kundenfaktor_id,
 geku_dwh_artikel_id,
 3 AS kmr_quelle_id,
 zustaendigkeit
FROM kfl_production_dbp_view.v_geku_zustaendigkeit_2;