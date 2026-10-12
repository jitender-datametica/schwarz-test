CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_OWG_PER_2
(owg_id
,mandant_id
,dat_von
,dat_bis
,arthiertyp_id
,hwg_id
)
AS

   SELECT
   v01.owg_id,
   v01.mandant_id,
   v01.dat_von,
   v01.dat_bis,
   v01.arthiertyp_id,
   v01.hwg_id
   FROM dbp_view.v_owg_per_2 v01

   WHERE v01.mandant_id = 1
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;