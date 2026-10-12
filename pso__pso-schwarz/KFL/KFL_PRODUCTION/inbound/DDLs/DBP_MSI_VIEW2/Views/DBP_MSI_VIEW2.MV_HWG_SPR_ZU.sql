CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_HWG_SPR_ZU
-- 10.11.18 Erweiterung um abt_id / sschuecke
(hwg_id
,hwg_bez
,mandant_id
,arthiertyp_id
,spr_id
,abt_id
)
AS

   SELECT
   v01.hwg_id,
   v02.hwg_bez,
   v01.mandant_id,
   v01.arthiertyp_id,
   v02.spr_id,
   v01.abt_id
   FROM dbp_view.v_hwg_per v01
   INNER JOIN dbp_view.v_hwg_spr_zu v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.hwg_id = v01.hwg_id
   AND v02.spr_id = 22

   WHERE v01.mandant_id = 1
   AND v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31';