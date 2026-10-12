CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_SAISON_1
(
mandant_id
, saison_id
)
AS
   SELECT
   v01.mandant_id,
   v01.saison_id
  FROM dbp_view.v_l_saison_1 v01;