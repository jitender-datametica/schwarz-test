CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_ZUSTAENDIGKEIT_2
(
kundenfaktor_id
,geku_dwh_artikel_id
,kmr_quelle_id
,zustaendigkeit
)
AS
-- 07.06.2018 twie: SPEC0038139 Schlüssel für DWH Artikel_2 um kmr_quelle_id ergänzg für Zusammenführung Hierarchie

   SELECT
   kundenfaktor_id
   , geku_dwh_artikel_id
   , 3 AS kmr_quelle_id
   , zustaendigkeit
   FROM dbp_view.v_geku_zustaendigkeit_2;