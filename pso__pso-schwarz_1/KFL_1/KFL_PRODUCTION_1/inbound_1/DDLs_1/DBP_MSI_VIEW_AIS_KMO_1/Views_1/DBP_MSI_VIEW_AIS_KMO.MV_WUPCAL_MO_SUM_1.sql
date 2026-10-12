CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WUPCAL_MO_SUM_1
(
wup_id
, mandant_id
, nb_id
, kjmo
, gjmo
, bonanzahl
)
AS
   SELECT
  wup_id,
   mandant_id,
   nb_id,
   kjmo,
   gjmo,
   bonanzahl
  FROM dbp_view.v_wupcal_mo_sum_1
  WHERE mandant_id <> 1;