CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_RISIKOKLASSE
(
geku_risikoklasse_id
)
AS
-- 25.11.2015 twie: SPEC0003061 neues Attribut Risikoklasse, Eltern von Prioritaet

   SELECT
   geku_risikoklasse_id
   FROM dbp_view.v_l_geku_risikoklasse;