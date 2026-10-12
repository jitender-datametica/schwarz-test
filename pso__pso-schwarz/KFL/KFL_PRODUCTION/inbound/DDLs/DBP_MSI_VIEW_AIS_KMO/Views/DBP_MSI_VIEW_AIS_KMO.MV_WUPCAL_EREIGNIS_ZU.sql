CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WUPCAL_EREIGNIS_ZU
(
wup_id
, mandant_id
, nb_id
, dat
, ereignistyp_id
, ereignis_id
, offen
)
AS
   SELECT
  wup_id,
   mandant_id,
   nb_id,
   dat,
   ereignistyp_id,
   ereignis_id,
   offen
  FROM dbp_view.v_wupcal_ereignis_zu
  WHERE mandant_id <> 1;