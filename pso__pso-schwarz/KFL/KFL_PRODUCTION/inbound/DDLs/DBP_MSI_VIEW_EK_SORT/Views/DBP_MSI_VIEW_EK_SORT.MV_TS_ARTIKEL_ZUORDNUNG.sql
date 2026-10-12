CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_TS_ARTIKEL_ZUORDNUNG
(
mandant_id
,ean_id
,art_id
,kl_owg_id
,kl_uwg_id
)
AS
   SELECT
   mandant_id, ean_id, art_id, wg_id AS kl_owg_id, wug_id AS kl_uwg_id

   FROM dbp_view.v_ts_artikel_zuordnung;