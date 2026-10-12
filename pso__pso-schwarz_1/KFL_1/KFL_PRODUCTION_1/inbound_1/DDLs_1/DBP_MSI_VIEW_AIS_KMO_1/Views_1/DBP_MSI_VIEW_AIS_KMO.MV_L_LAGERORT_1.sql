CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_LAGERORT_1
(
lagerort_id
, mandant_id
, nb_id
, wup_id
, lagernummer_id

)
AS
   SELECT
  lagerort_id,
   mandant_id,
   nb_id,
   wup_id,
   lagernummer_id

  FROM dbp_view.v_l_lagerort_1
  WHERE lagerort_id NOT IN ('-1', '-2', '-3')
  AND mandant_id <> 1;