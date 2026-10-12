CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_KONDITIONSART_SPR_ZU_EN_1
(
system_id
,mandant_id
,spr_id
,KSCHL
,KSCHL_BEZ
)
AS
   SELECT
   system_id, mandant_id, MAX(spr_id) AS spr_id, konditionsart_id AS KSCHL, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.konditionsart_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.konditionsart_bez END)
   ) AS KSCHL_BEZ

   FROM dbp_view.v_konditionsart_spr_zu_1 v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.system_id
   ,v01.mandant_id
   ,v01.konditionsart_id ;