CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_SHR_PRUEFBERICHTE
(
mandant_id
, kjmo_pruef
)
AS
   SELECT

   v01.mandant_id, max(v01.kjmo) AS kjmo_pruef

   FROM dbp_view.v_mitarbeiterbew  v01
   GROUP BY 1;