CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_HWG_WG_SPR_ZU
(hwg_id,hwg_bez,owg_id,owg_bez,wg_id,wg_bez,mandant_id,arthiertyp_id,spr_id
)
AS

   SELECT
   v01.hwg_id,
   v02.hwg_bez,
   v03.owg_id,
   v04.owg_bez,
   v05.wg_id,
   v06.wg_bez,
   v01.mandant_id,
   v01.arthiertyp_id,
   v02.spr_id

   --hwg_id
   FROM
   dbp_view.v_hwg_per v01
   INNER JOIN dbp_view.v_hwg_spr_zu v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.hwg_id = v01.hwg_id
   AND v02.spr_id = 22
   INNER JOIN dbp_view.v_owg_per v03
   ON v03.mandant_id = v01.mandant_id
   AND v03.hwg_id = v01.hwg_id
   INNER JOIN dbp_view.v_owg_spr_zu v04
   ON v04.mandant_id = v03.mandant_id
   AND v04.owg_id = v03.owg_id
   AND v04.spr_id = 22
   INNER JOIN dbp_view.v_wg_per v05
   ON v05.mandant_id = v03.mandant_id
   AND v05.owg_id = v03.owg_id
   INNER JOIN dbp_view.v_wg_spr_zu v06
   ON v06.mandant_id = v05.mandant_id
   AND v06.wg_id = v05.wg_id
   AND v06.spr_id = 22

   WHERE v01.mandant_id = 1
   AND v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31';