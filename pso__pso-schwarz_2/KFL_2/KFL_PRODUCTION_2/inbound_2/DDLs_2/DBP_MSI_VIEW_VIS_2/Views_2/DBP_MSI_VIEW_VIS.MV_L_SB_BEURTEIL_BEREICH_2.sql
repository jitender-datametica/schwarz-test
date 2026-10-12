CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SB_BEURTEIL_BEREICH_2
(
mandant_id
,beurteilung_bereich_id
,bereich_nr
)
AS
   SELECT
  mandant_id, beurteilung_bereich_id, bereich_nr
   FROM dbp_view.v_l_sb_beurteil_bereich_2  v01;