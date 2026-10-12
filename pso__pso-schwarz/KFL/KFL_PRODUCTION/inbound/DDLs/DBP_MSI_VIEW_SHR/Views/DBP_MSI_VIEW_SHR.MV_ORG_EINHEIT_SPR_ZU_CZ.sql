CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_ORG_EINHEIT_SPR_ZU_CZ
(
mandant_id
,hr_objekt_id
,spr_id
,hr_objekt_bez

)
AS
   SELECT
   v01.mandant_id, v01.hr_objekt_id, v01.spr_id, v01.hr_objekt_bez


   FROM dbp_view.v_org_einheit_spr_zu v01
   WHERE spr_id = 124
;