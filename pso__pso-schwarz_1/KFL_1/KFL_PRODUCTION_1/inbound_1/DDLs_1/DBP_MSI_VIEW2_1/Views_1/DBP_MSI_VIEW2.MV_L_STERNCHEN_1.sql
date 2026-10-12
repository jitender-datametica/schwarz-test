CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_STERNCHEN_1
(
   list_durchg_fg
  ,bezugsweg1_fg
  ,bezugsweg4_fg
  ,kdis0_fg
  ,kdis1_fg
  ,mandant_id
  ,sternchen_id
)
AS
   SELECT
     list_durchg_fg, bezugsweg1_fg, bezugsweg4_fg, kdis0_fg, kdis1_fg, mandant_id, sternchen_id
   FROM dbp_view.v_l_sternchen_1
   WHERE
     mandant_id=1
;