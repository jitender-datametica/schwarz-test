CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_LAGERORT
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

  FROM dbp_view.v_l_lagerort
  WHERE lagerort_id NOT IN ('-1', '-2', '-3')
  AND mandant_id <> 1;