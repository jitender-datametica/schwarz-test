CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_GP_AKTUELL
(
mandant_id
, akt_gp_id
, akt_gp_name
)
AS
   SELECT
   v01.mandant_id, v01.gp_id, v02.gp_name

   FROM dbp_view.v_art_gp_zu_per v01
   LEFT JOIN dbp_view.v_gp v02
   ON v01.gp_id = v02.gp_id
   AND v01.mandant_id = v02.mandant_id

   WHERE v01.dat_bis = '9999-12-31'
   GROUP BY 1,2,3;