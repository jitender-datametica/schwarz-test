CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WG_SPR_ZU_EN
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
   v02.wg_id AS MATKL, v02.spr_id, v02.mandant_id, v02.arthiertyp_id, v02.wg_bez, CASE
   WHEN v02.wg_id < 10 THEN '00' || CAST(v02.wg_id AS VARCHAR(3))
   WHEN v02.wg_id < 100 THEN '0' || CAST(v02.wg_id AS VARCHAR(3))
   ELSE CAST(v02.wg_id AS VARCHAR(3))
   END || ' ' || wg_bez
   AS wg_id_bez
   FROM
   (
   SELECT
   v01.wg_id, MAX(v01.spr_id) AS spr_id, v01.mandant_id, v01.arthiertyp_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.wg_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.wg_bez END)
   ) AS wg_bez
   FROM dbp_view.v_wg_spr_zu v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch
   AND v01.arthiertyp_id = 2

   GROUP BY v01.wg_id
   ,v01.mandant_id
   ,v01.arthiertyp_id
   ) v02;