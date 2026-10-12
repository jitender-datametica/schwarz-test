create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_TS_ROHRERTRAG_KOMMENTAR_WW_ZU(
	MANDANT_ID,
	KJWO_WW,
	KOMMENTAR
) as

   SELECT
   v01.mandant_id, v01.kjwo_ww, v01.kommentar

   FROM dbp_msi_view_reb.ts_rohertrag_kommentar_ww_zu v01;