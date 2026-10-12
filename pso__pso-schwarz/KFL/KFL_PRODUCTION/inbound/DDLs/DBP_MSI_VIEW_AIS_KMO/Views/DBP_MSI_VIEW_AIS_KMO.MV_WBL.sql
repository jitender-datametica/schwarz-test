CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WBL
(
ek_fg
, ek_gf_id
, wbl_dat_von
, wbl_id
, wbl_name
, mandant_id
)
AS
   SELECT
  ek_fg,
   gf_id,
   wbl_dat_von,
   wbl_id,
   wbl_name,
   mandant_id
  FROM dbp_view.v_wbl
  WHERE mandant_id <> 1;