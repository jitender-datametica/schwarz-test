CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WG_SPR_ZU_CZ_1
-- 05.04.2018, AP0021792, srom: OWG Umstellung
(
MATKL
, spr_id
, mandant_id
, arthiertyp_id
, wg_bez
, wg_id_bez
)
AS
   SELECT
   v01.wg_id AS MATKL, v01.spr_id, v01.mandant_id, v01.arthiertyp_id, v01.wg_bez, CASE
   WHEN v01.wg_id < 10 THEN '00' || CAST(v01.wg_id AS VARCHAR(3))
   WHEN v01.wg_id < 100 THEN '0' || CAST(v01.wg_id AS VARCHAR(3))
   ELSE CAST(v01.wg_id AS VARCHAR(3))
   END || ' ' || wg_bez
   AS wg_id_bez

   FROM dbp_view.v_wg_spr_zu_1 v01
   WHERE v01.spr_id = 124
   AND v01.arthiertyp_id = 2;