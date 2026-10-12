CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_OWG_PER
-- 15.04.2021 lsvi0303 NSR2095327 - removing owg_id 1011, 1012, 1014
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
   FROM dbp_view.v_owg_per v01

   WHERE v01.mandant_id = 1
   AND v01.owg_id NOT IN (1011, 1012, 1014)
   AND v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31';