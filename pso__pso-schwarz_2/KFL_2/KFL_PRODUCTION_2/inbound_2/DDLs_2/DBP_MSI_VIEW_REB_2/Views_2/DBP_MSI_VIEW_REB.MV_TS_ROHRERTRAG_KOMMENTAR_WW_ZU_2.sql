CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_TS_ROHRERTRAG_KOMMENTAR_WW_ZU_2
(
mandant_id
,kjwo_ww
,kommentar
)
AS

   SELECT
   v01.mandant_id, v01.kjwo_ww, v01.kommentar

   FROM dbp_msi_view_reb.ts_rohertrag_kommentar_ww_zu_2 v01;