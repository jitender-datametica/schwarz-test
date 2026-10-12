CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_WG_PER_2

(
mandant_id
, wg_id
, arthiertyp_id
, abt_id
, wg_id_lang
, owg_id
, werbeteam_cd
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.mandant_id,
   v01.wg_id,
   v01.arthiertyp_id,
   v01.abt_id,
   CASE
  WHEN v01.wg_id < 0 THEN TO_VARCHAR(v01.wg_id, 'FM000')
   ELSE TO_VARCHAR(v01.wg_id, 'FM000') END AS wg_id_lang,
   v01.owg_id,
   v01.werbeteam_cd
   
  FROM dbp_view.v_wg_per_2 v01

   WHERE v01.dat_bis = '9999-12-31';