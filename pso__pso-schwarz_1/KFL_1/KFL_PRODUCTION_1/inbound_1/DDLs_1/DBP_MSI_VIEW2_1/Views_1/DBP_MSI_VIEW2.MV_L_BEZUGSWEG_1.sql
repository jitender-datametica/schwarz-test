CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_BEZUGSWEG_1
(
bezugsweg_id
,mandant_id

)
AS
   SELECT
  bezugsweg_id, mandant_id

   FROM dbp_view.v_l_bezugsweg_1
   WHERE mandant_id = 1;