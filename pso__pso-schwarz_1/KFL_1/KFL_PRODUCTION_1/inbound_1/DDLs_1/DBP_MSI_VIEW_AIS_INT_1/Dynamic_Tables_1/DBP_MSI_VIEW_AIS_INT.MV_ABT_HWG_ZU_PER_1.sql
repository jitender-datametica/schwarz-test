CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ABT_HWG_ZU_PER_1
(
   abt_id,
   hwg_id,
   mandant_id,
   dat_von,
   dat_bis,
   arthiertyp_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
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
   dbp_view.v_abt_1 v01
   INNER JOIN dbp_view.v_hwg_per_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.abt_id = v02.abt_id
    
   WHERE v02.arthiertyp_id = 2 AND v02.dat_bis = '9999-12-31';