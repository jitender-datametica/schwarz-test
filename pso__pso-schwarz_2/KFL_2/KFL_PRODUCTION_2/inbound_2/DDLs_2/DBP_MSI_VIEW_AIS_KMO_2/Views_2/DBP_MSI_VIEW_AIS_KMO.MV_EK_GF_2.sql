CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_EK_GF_2
(
ek_gf_id
, ek_gf_name
, mandant_id
, ek_fg
)
AS
   SELECT
  gf_id,
   gf_name,
   mandant_id,
   ek_fg
  FROM dbp_view.v_gf_2
  WHERE mandant_id <> 1
  AND ek_fg = 1;