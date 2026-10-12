CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ABT_HWG_SPR_ZU
(
abt_id
, abt_bez
, hwg_id
, hwg_bez
, mandant_id
, arthiertyp_id
, spr_id
)
AS
   SELECT
   v01.abt_id, v02.abt_bez, v03.hwg_id, v04.hwg_bez, v01.mandant_id, v01.arthiertyp_id, v02.spr_id

   FROM dbp_view.v_abt v01
   INNER JOIN dbp_view.v_abt_spr_zu v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.abt_id = v01.abt_id
   AND v02.spr_id = 22
   INNER JOIN dbp_view.v_hwg_per v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.abt_id = v03.abt_id
   AND CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
   INNER JOIN dbp_view.v_hwg_spr_zu v04
   ON v04.mandant_id = v03.mandant_id
   AND v04.hwg_id = v03.hwg_id
   AND v04.spr_id = 22

   WHERE v01.mandant_id = 1;