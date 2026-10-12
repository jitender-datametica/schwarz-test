CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_OWG_PER_1
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
   FROM dbp_view.v_owg_per_1 v01

   WHERE v01.mandant_id <> 1
   AND v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31';