CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_EK_GF
(
ek_gf_id
, ek_gf_name
, mandant_id
, ek_fg
)
AS
   SELECT
   gf_id, gf_name, mandant_id, ek_fg
   FROM dbp_view.v_gf
   WHERE ek_fg = 1;