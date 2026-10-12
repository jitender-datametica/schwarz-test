CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_DISPOMERKMAL_2
(
dispomerkmal
,dispomerkmal_bez
)
AS
   SELECT
  dispomerkmal, dispomerkmal_bez

   FROM dbp_view.v_dispomerkmal_spr_zu_2
   WHERE mandant_id = 1;