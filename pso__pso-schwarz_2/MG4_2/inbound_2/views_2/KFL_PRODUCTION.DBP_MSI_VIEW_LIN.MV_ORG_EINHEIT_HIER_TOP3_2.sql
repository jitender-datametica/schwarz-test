create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_ORG_EINHEIT_HIER_TOP3_2(
	MANDANT_ID,
	HR_OBJEKT_EBENE1_ID,
	HR_OBJEKT_EBENE2_ID,
	HR_OBJEKT_EBENE3_ID,
	HR_OBJEKT_EBENE4_ID,
	HR_OBJEKT_EBENE5_ID,
	HR_OBJEKT_EBENE6_ID,
	HR_OBJEKT_EBENE7_ID,
	HR_OBJEKT_EBENE8_ID,
	HR_OBJEKT_EBENE9_ID,
	HR_OBJEKT_EBENE10_ID,
	HR_OBJEKT_EBENE11_ID,
	KOSTENSTELLE_ID,
	HR_OBJEKT_EBENE1_BEZ,
	HR_OBJEKT_EBENE2_BEZ,
	HR_OBJEKT_EBENE3_BEZ,
	HR_OBJEKT_EBENE4_BEZ,
	HR_OBJEKT_EBENE5_BEZ,
	HR_OBJEKT_EBENE6_BEZ,
	HR_OBJEKT_EBENE7_BEZ,
	HR_OBJEKT_EBENE8_BEZ,
	HR_OBJEKT_EBENE9_BEZ,
	HR_OBJEKT_EBENE10_BEZ,
	HR_OBJEKT_EBENE11_BEZ,
	MANDANT_SORT_ID,
	KJMO
) as
SELECT
 v01.mandant_id
,v01.hr_objekt_ebene1_id
,v01.hr_objekt_ebene2_id
,v01.hr_objekt_ebene3_id
,v01.hr_objekt_ebene4_id
,v01.hr_objekt_ebene5_id
,v01.hr_objekt_ebene6_id
,v01.hr_objekt_ebene7_id
,v01.hr_objekt_ebene8_id
,v01.hr_objekt_ebene9_id
,v01.hr_objekt_ebene10_id
,v01.hr_objekt_ebene11_id
,v01.kostenstelle_id
,v01.hr_objekt_ebene1_bez
,v01.hr_objekt_ebene2_bez
,v01.hr_objekt_ebene3_bez
,v01.hr_objekt_ebene4_bez
,v01.hr_objekt_ebene5_bez
,v01.hr_objekt_ebene6_bez
,v01.hr_objekt_ebene7_bez
,v01.hr_objekt_ebene8_bez
,v01.hr_objekt_ebene9_bez
,v01.hr_objekt_ebene10_bez
,v01.hr_objekt_ebene11_bez
,v01.om_sort_id
,v01.kjmo
FROM dbp_view.v_org_einheit_hierarchie_2 v01
INNER JOIN dbp_view.v_monat_2 v02
   ON v01.kjmo = v02.kjmo
WHERE v01.spr_id = 22 
  AND v02.akt_mo BETWEEN -3 AND 0
  AND (
	   (mandant_id = 4 AND hr_objekt_ebene1_id = 35084871) 
    OR (mandant_id = 7 AND hr_objekt_ebene1_id = 35000075) 
    OR mandant_id NOT IN (4, 7)  
   )
      
   





;