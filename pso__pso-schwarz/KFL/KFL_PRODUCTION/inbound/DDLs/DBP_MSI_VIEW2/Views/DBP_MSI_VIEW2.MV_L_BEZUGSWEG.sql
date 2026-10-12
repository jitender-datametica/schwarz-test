CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_BEZUGSWEG
(
bezugsweg_id
,mandant_id

)
AS
   SELECT
  bezugsweg_id, mandant_id

   FROM dbp_view.v_l_bezugsweg
   WHERE mandant_id = 1;