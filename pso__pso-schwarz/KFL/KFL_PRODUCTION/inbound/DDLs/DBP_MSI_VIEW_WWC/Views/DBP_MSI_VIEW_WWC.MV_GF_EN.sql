CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_GF_EN
(
mandant_id
,gf_id
,ma_anrede
,ma_name
,ma_vorname
,gf_name
,spr_id
)
AS
   SELECT  v01.mandant_id, v01.ma_id AS gf_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.ma_anrede END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.ma_anrede END)
   ) AS ma_anrede, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.ma_name END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.ma_name END)
   ) AS ma_name, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.ma_vorname END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.ma_vorname END)
   ) AS ma_vorname, CAST(COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.ma_name END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.ma_name END)
   ) AS varchar(40)) AS gf_name, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_ma_spr_zu v01

   WHERE v01.spr_id IN (22,24)
   AND (mandant_id, ma_id) IN (SELECT mandant_id, gf_gbl_vertrieb_id
   FROM dbp_msi_v_view.v_wup_denorm)

   GROUP BY v01.mandant_id
   ,v01.ma_id;