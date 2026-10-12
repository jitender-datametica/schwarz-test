CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_VT_GF_1
(
vt_gf_id
, vt_gf_name
, mandant_id
)
AS
   SELECT
  gf_id,
   gf_name,
   mandant_id
  FROM dbp_view.v_gf_1
  WHERE mandant_id <> 1
  AND ek_fg = 0 and gf_id > 0;