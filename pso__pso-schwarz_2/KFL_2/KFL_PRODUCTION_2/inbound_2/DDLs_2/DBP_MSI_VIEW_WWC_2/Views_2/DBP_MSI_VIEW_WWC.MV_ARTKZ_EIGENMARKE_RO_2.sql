CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_EIGENMARKE_RO_2
(
mandant_id
, eigenmarke_id
, spr_id
, eigenmarke_bez
)
AS
   SELECT
   v01.mandant_id, v01.eigenmarke_id, v01.spr_id, v01.eigenmarke_bez
   FROM dbp_view.v_artkz_eigenmarke_2 v01
   WHERE spr_id = 95
;