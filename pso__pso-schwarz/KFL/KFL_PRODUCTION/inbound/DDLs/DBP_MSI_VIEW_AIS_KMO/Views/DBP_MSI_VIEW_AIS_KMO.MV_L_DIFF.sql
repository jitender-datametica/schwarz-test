CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_DIFF

(
mandant_id
,diff_id
)
AS
   SELECT
   mandant_id,
   diff_id
   FROM dbp_view.v_l_kz_differenz
   WHERE mandant_id <> 1;