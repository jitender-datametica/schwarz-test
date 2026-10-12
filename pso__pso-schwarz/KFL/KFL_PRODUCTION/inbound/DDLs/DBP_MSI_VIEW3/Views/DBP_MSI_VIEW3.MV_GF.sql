CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_GF
(
ek_fg
, gf_id
,  gf_name
,  mandant_id
)
AS
   SELECT
   ek_fg, gf_id, gf_name, mandant_id

   FROM dbp_view.v_gf
   WHERE ek_fg = 0;