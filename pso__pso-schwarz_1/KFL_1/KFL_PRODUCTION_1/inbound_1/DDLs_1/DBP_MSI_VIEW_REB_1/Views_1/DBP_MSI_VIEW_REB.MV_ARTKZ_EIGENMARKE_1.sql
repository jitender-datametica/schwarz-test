CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_EIGENMARKE_1
(
mandant_id
,eigenmarke_id
,eigenmarke_bez
)
AS
   SELECT
   mandant_id, eigenmarke_id, eigenmarke_bez

   FROM dbp_view.v_artkz_eigenmarke_1
   WHERE mandant_id = 1
   AND spr_id = 22;