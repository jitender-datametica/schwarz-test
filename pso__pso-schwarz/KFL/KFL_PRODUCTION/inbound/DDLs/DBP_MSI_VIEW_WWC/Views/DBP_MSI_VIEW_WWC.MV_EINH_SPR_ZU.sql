CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_EINH_SPR_ZU
-- AP0032822, SPEC0041631 - 5.11.2108, mkub1811 neue View
(
einh_id
,mandant_id
,spr_id
,einh_bez_kaufm
,einh_bez
)
AS
   SELECT
   v01.einh_id, v01.mandant_id, v01.spr_id, v01.einh_bez_kaufm, v01.einh_bez

   FROM dbp_view.v_einh_spr_zu v01

   WHERE v01.spr_id=22;