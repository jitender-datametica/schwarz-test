CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_AKTIV_KZ_2
-- AP0032822, SPEC0041631 - 26.10.2108, mkub1811 neue View
(
mandant_id
,aktiv_kz
)
AS
   SELECT
   v01.mandant_id, COALESCE(v03.aktiv_kz, 'k.A.') AS aktiv_kz
   FROM dbp_view.v_art_2 v01
   LEFT OUTER JOIN
   (
   SELECT
   v02.mandant_id, v02.art_id, CASE
   WHEN SUM(v02.anzahl_markt_listung) = 0 THEN ' '
   WHEN SUM(v02.anzahl_markt_listung) > 0 THEN 'X'
   END AS aktiv_kz
   FROM dbp_view.v_sternchen_logik_2 v02

   WHERE --v02.mandant_id <> 1 AND
   v02.dat_bis = '9999-12-31'
   GROUP BY 1, 2
   )v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.art_id = v03.art_id

   --WHERE v01.mandant_id <> 1
   GROUP BY 1, 2;