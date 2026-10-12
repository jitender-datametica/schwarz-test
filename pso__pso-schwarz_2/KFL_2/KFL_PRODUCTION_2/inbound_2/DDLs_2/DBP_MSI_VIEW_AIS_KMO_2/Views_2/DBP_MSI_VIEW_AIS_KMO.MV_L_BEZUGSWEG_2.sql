CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_BEZUGSWEG_2
(
bezugsweg_id

)
AS
   SELECT
  bezugsweg_id

  FROM dbp_view.v_l_bezugsweg_2

  GROUP BY bezugsweg_id;