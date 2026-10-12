CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ABT_HWG_ZU_PER
(abt_id,hwg_id,mandant_id,dat_von,dat_bis,arthiertyp_id
)
AS
   SELECT
   v01.abt_id,
   v02.hwg_id,
   v01.mandant_id,
   v02.dat_von,
   v02.dat_bis,
   v01.arthiertyp_id

   --abt_id
   FROM
   dbp_view.v_abt v01
   INNER JOIN dbp_view.v_hwg_per v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.abt_id = v02.abt_id

   WHERE v01.mandant_id = 1
   AND v02.arthiertyp_id = 2 AND v02.dat_bis = '9999-12-31';