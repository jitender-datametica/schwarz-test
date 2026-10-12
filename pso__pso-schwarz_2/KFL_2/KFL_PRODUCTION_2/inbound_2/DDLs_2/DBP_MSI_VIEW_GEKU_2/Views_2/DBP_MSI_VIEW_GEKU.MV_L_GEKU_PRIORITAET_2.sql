CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_PRIORITAET_2
(
geku_prioritaet_id
,geku_risikoklasse_id
)
AS
-- 25.11.2015 twie: SPEC0003061 Risikoklasse als Elternattribut

   SELECT
   geku_prioritaet_id
   , geku_risikoklasse_id
   FROM dbp_view.v_l_geku_prioritaet_2;