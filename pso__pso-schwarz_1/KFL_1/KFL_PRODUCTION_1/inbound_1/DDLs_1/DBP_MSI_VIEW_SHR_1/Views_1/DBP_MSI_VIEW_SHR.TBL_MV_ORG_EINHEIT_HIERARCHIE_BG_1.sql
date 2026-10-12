CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.TBL_MV_ORG_EINHEIT_HIERARCHIE_BG_1
AS
   SELECT
   v01.mandant_id, v01.hr_objekt_ebene1_id, v01.hr_objekt_ebene2_id, v01.hr_objekt_ebene3_id, v01.hr_objekt_ebene4_id, v01.hr_objekt_ebene5_id, v01.hr_objekt_ebene6_id, v01.hr_objekt_ebene7_id, v01.hr_objekt_ebene8_id, v01.hr_objekt_ebene9_id, v01.hr_objekt_ebene10_id, v01.hr_objekt_ebene11_id, v01.kostenstelle_id, v01.hr_objekt_ebene1_bez, v01.hr_objekt_ebene2_bez, v01.hr_objekt_ebene3_bez, v01.hr_objekt_ebene4_bez, v01.hr_objekt_ebene5_bez, v01.hr_objekt_ebene6_bez, v01.hr_objekt_ebene7_bez, v01.hr_objekt_ebene8_bez, v01.hr_objekt_ebene9_bez, v01.hr_objekt_ebene10_bez, v01.hr_objekt_ebene11_bez, v01.kjmo, v01.om_sort_id
   , V01.SPR_ID
   FROM dbp_view.v_org_einheit_hierarchie_1 v01
   WHERE v01.spr_id = 18;