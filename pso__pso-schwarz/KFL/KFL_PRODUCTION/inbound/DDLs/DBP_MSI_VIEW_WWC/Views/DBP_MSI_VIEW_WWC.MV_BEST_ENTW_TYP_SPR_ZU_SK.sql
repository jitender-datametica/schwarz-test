CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BEST_ENTW_TYP_SPR_ZU_SK
(
mandant_id
,BEWTP
,spr_id
,BEWTP_KBEZ
,BEWTP_BEZ
)
AS
   SELECT
   v01.mandant_id, v01.best_entw_typ_id AS BEWTP, v01.spr_id, v01.best_entw_typ_kbez AS BEWTP_KBEZ, v01.best_entw_typ_bez AS BEWTP_BEZ
   FROM dbp_view.v_best_entw_typ_spr_zu v01
   WHERE v01.spr_id = 108
;