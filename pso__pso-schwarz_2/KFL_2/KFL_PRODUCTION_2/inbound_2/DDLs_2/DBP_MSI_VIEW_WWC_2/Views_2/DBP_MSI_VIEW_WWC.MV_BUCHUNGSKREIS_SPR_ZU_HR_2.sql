CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BUCHUNGSKREIS_SPR_ZU_HR_2
(
mandant_id
,BUKRS
,spr_id
,buchungskreis_bez
)
AS
   SELECT
   v01.mandant_id, v01.buchungskreis_id AS BUKRS, v01.spr_id, v01.buchungskreis_bez
   FROM dbp_view.v_buchungskreis_spr_zu_2 v01
   where v01.spr_id = 65
;