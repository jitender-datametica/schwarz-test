CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_DISPOMERKMAL

(
mandant_id
,dispomerkmal
)
AS
   SELECT

  v01.mandant_id, v01.dispomerkmal

   FROM dbp_view.v_l_dispomerkmal v01;