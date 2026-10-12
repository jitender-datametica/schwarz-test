CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_HWG_ZU_PER_1
-- 10.11.18 Erweiterung um abt_id / sschuecke
(hwg_id
,mandant_id
,dat_von
,dat_bis
,arthiertyp_id
,abt_id
)
AS

   SELECT
   v01.hwg_id,
   v01.mandant_id,
   v01.dat_von,
   v01.dat_bis,
   v01.arthiertyp_id,
   v01.abt_id
   FROM dbp_view.v_hwg_per_1 v01

   WHERE v01.mandant_id = 1
   AND v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31';