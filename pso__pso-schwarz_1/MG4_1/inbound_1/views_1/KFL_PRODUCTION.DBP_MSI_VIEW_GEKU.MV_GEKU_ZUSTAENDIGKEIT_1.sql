create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_ZUSTAENDIGKEIT_1(
	KUNDENFAKTOR_ID,
	GEKU_DWH_ARTIKEL_ID,
	KMR_QUELLE_ID,
	ZUSTAENDIGKEIT
) as
-- 07.06.2018 twie: SPEC0038139 Schlüssel für DWH Artikel_1 um kmr_quelle_id ergänzg für Zusammenführung Hierarchie

   SELECT
   kundenfaktor_id
   , geku_dwh_artikel_id
   , 3 AS kmr_quelle_id
   , zustaendigkeit
   FROM dbp_view.v_geku_zustaendigkeit_1;