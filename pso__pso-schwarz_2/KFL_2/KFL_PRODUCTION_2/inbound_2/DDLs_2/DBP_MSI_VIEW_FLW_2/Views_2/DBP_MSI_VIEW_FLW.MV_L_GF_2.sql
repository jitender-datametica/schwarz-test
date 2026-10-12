CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_GF_2
-- 02.10.2013 twie: Erweitert um mandant_id 2
(
gf_id
, gf_name
, mandant_id
, ek_flg
)
AS
   SELECT
  gf_id, gf_name, mandant_id, ek_fg
   FROM dbp_view.v_gf_2
   WHERE mandant_id IN (1,2)
   AND ek_fg = 0;