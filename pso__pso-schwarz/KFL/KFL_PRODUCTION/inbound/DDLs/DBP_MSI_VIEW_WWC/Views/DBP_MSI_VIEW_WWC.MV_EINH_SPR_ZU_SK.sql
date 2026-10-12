CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_EINH_SPR_ZU_SK
-- AP0032822, SPEC0041631 - 2.11.2108, mkub1811 neue View
(
einh_id
,mandant_id
,spr_id
,einh_bez_kaufm
,einh_bez
)
AS
   SELECT
   einh_id, mandant_id, spr_id, einh_bez_kaufm, einh_bez
   FROM dbp_view.v_einh_spr_zu
   WHERE spr_id = 108;