CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BEST_ENTW_TYP_SPR_ZU_EN_1
(
mandant_id
,BEWTP
,spr_id
,BEWTP_KBEZ
,BEWTP_BEZ
)
AS
   SELECT
   v01.mandant_id, v01.best_entw_typ_id AS BEWTP, MAX(v01.spr_id) AS spr_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.best_entw_typ_kbez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.best_entw_typ_kbez END)
   ) AS BEWTP_KBEZ, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.best_entw_typ_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.best_entw_typ_bez END)
   ) AS BEWTP_BEZ

   FROM dbp_view.v_best_entw_typ_spr_zu_1 v01
   WHERE spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.best_entw_typ_id
;