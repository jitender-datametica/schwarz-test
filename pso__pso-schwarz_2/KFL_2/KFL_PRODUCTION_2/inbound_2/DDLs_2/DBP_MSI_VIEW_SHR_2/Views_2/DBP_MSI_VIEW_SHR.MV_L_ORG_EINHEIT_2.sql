CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_ORG_EINHEIT_2
(
mandant_id
,hr_objekt_id
,objekt_typ_id
,hr_objekt_bez_kurz
)
AS
   SELECT
   v01.mandant_id, v01.hr_objekt_id, v01.objekt_typ_id, v01.hr_objekt_bez_kurz

   FROM dbp_view.v_l_org_einheit_2 v01;