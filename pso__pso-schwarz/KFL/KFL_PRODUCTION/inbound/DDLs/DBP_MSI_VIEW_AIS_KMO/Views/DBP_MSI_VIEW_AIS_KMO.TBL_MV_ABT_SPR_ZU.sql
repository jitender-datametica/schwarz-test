CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_ABT_SPR_ZU
AS 
SELECT
   v01.mandant_id,
   v01.abt_id,
   v01.arthiertyp_id,
   v01.abt_bez,
v01.spr_id
  FROM dbp_view.v_abt_spr_zu v01
    WHERE v01.mandant_id <> 1
   AND v01.arthiertyp_id = 2;