CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_HL_EN_1
(
mandant_id
,hausleiter_id
,ma_anrede
,ma_name
,ma_vorname
,spr_id
)
AS
   SELECT  v01.mandant_id, v01.ma_id AS hausleiter_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.ma_anrede END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.ma_anrede END)
   ) AS ma_anrede, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.ma_name END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.ma_name END)
   ) AS ma_name, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.ma_vorname END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.ma_vorname END)
   ) AS ma_vorname, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_ma_spr_zu_1 v01

   WHERE  spr_id IN (22,24)
   AND (mandant_id, ma_id) IN (SELECT mandant_id, hausleiter_id
   FROM dbp_msi_v_view.v_wup_denorm_1)
   GROUP BY v01.mandant_id
   ,v01.ma_id;