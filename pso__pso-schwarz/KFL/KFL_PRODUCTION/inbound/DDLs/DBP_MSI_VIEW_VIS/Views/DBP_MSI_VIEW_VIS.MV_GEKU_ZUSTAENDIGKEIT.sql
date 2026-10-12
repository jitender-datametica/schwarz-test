CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_ZUSTAENDIGKEIT
-- 25.06.2018 ttod: SPEC0038139 Schlüssel für DWH Artikel um kmr_quelle_id ergänzg für Zusammenführung Hierarchie

(
kundenfaktor_id
,geku_dwh_artikel_id
,kmr_quelle_id
,zustaendigkeit
)
AS
   SELECT
   kundenfaktor_id, geku_dwh_artikel_id, 3 AS kmr_quelle_id, zustaendigkeit
   FROM dbp_view.v_geku_zustaendigkeit
;