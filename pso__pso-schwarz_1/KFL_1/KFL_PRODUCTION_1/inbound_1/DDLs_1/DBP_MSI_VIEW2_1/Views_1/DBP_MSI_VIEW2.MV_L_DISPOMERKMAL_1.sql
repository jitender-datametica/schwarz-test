CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_DISPOMERKMAL_1
(
dispomerkmal
,dispomerkmal_bez
)
AS
   SELECT
  dispomerkmal, dispomerkmal_bez

   FROM dbp_view.v_dispomerkmal_spr_zu_1
   WHERE mandant_id = 1;