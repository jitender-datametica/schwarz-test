CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_IDEE
(
idee_fg
)
AS
-- 23.03.2015 twie: Lookupview Idee aus universeller Flagtabelle ja/nein

   SELECT
   flag AS idee_fg
   FROM dbp_view.v_flag_spr_zu
   WHERE  flag_typ_id = 1 -- entspricht ja/nein Flag
   GROUP BY flag;