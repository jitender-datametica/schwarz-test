CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BELEGART_SPR_ZU_RO_2
(
system_id
,mandant_id
,spr_id
,BLART
,belegart_bez
)
AS
   SELECT
   v01.system_id, v01.mandant_id, v01.spr_id, v01.belegart_id  AS BLART, v01.belegart_bez AS belegart_bez
   FROM dbp_view.v_belegart_spr_zu_2 v01
   WHERE spr_id = 95
;