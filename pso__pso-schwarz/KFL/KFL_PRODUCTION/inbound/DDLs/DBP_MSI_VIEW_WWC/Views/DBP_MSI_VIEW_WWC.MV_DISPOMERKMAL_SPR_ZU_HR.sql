CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_DISPOMERKMAL_SPR_ZU_HR
(
mandant_id
,DISMM
,spr_id
,DIBEZ
)
AS
   SELECT
   mandant_id, dispomerkmal AS DISMM, spr_id, dispomerkmal_bez AS DIBEZ
   FROM dbp_view.v_dispomerkmal_spr_zu
   WHERE spr_id = 65
   AND mandant_id <> 1
;