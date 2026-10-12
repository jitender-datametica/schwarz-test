CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_ORG_EINHEIT_PER
(
mandant_id
,hr_objekt_id
,kjmo

)
AS
   SELECT
   v01.mandant_id, v01.hr_objekt_id, v01.kjmo

   FROM dbp_view.v_org_einheit_per v01
;