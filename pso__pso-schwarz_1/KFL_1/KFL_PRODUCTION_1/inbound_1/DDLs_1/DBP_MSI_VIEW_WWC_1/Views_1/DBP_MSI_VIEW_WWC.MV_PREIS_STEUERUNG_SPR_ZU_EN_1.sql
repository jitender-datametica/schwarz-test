CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_PREIS_STEUERUNG_SPR_ZU_EN_1
(
mandant_id
,preis_steuer_kz
,preis_steuerung_bez
,spr_id
)
AS
   SELECT
   v01.mandant_id, v01.preis_steuer_kz, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.preis_steuerung_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.preis_steuerung_bez END)
   ) AS preis_steuerung_bez, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_preis_steuerung_spr_zu_1 v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.preis_steuer_kz;