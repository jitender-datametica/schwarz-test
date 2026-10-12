CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_GF_2
(
ek_fg
, gf_id
,  gf_name
,  mandant_id
)
AS
   SELECT
   ek_fg, gf_id, gf_name, mandant_id

   FROM dbp_view.v_gf_2
   WHERE ek_fg = 0;