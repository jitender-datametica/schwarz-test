CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_HWG_WG_ZU_PER_1
(
hwg_id,
owg_id,
wg_id,
mandant_id,
dat_von,
dat_bis,
arthiertyp_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS

   SELECT
   v01.hwg_id,
   v02.owg_id,
   v03.wg_id,
   v01.mandant_id,
   v01.dat_von,
   v01.dat_bis,
   v01.arthiertyp_id

   --hwg_id
   FROM
   dbp_view.v_hwg_per_1 v01
   INNER JOIN dbp_view.v_owg_per_1 v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.hwg_id = v01.hwg_id
   INNER JOIN dbp_view.v_wg_per_1 v03
   ON v03.mandant_id = v02.mandant_id
   AND v03.owg_id = v02.owg_id

   WHERE v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31';