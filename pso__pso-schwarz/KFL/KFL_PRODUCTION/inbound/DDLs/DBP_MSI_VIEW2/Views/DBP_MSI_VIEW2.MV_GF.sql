CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_GF
(
gf_id
, gf_name
, mandant_id
, ek_flg
)
AS
   SELECT
  gf_id, gf_name, mandant_id, ek_fg
   FROM dbp_view.v_gf
   WHERE mandant_id = 1
   AND ek_fg = 0;