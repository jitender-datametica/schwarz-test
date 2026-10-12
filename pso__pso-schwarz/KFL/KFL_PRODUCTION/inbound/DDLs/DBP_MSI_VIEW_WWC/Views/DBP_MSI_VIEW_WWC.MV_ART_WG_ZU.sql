CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_WG_ZU
(
art_id
,mandant_id
,PRDHA
,wug_id
,MATKL
,wg_id
)
AS
   SELECT
   art_id, mandant_id, wug_id AS PRDHA, wug_id, wg_id AS MATKL, wg_id
   FROM dbp_view.v_art_wg_zu_per
   WHERE arthiertyp_id = 2
   AND dat_bis = '9999-12-31';