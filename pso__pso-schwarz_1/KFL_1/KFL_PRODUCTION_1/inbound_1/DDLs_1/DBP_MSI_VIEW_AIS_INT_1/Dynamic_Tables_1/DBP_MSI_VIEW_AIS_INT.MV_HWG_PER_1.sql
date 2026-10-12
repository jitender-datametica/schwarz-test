CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_HWG_PER_1
(hwg_id
,mandant_id
,dat_von
,dat_bis
,arthiertyp_id
,abt_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.hwg_id,
   v01.mandant_id,
   v01.dat_von,
   v01.dat_bis,
   v01.arthiertyp_id,
   v01.abt_id

   FROM dbp_view.v_hwg_per_1 v01
   WHERE v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31';