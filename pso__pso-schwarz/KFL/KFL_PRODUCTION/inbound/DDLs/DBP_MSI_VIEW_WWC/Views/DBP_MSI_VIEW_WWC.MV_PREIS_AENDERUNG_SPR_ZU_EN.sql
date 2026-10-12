CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_PREIS_AENDERUNG_SPR_ZU_EN
(
mandant_id
,PV_GRUND
,preis_aend_grund_bez
,spr_id
)
AS
   SELECT
   v01.mandant_id, v01.preis_aend_grund_id AS PV_GRUND, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.preis_aend_grund_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.preis_aend_grund_bez END)
   ) AS preis_aend_grund_bez, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_preis_aenderung_spr_zu v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY  v01.mandant_id
   ,v01.preis_aend_grund_id;