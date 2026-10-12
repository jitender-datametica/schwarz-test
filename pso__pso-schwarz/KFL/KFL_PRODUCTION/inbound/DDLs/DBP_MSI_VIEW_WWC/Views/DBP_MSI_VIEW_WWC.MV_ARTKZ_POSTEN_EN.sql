CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_POSTEN_EN
(
mandant_id
, posten_id
, posten_bez
, posten_kz
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.posten_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.posten_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.posten_bez END)
   ) AS posten_bez, MAX(CASE WHEN v01.mandant_id = 1 AND v01.posten_id IN ('PN','PF') THEN 'X'
   WHEN v01.mandant_id <> 1 AND v01.posten_id = '1' THEN 'X'
   ELSE ''
   END) AS posten_kz, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_artkz_posten v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.posten_id;