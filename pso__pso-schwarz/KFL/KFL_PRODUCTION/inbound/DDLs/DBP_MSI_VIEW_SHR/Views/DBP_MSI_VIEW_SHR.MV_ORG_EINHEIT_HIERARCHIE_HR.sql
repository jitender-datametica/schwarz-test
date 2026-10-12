CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_ORG_EINHEIT_HIERARCHIE_HR
(
  mandant_id
, hr_objekt_ebene1_id
, hr_objekt_ebene2_id
, hr_objekt_ebene3_id
, hr_objekt_ebene4_id
, hr_objekt_ebene5_id
, hr_objekt_ebene6_id
, hr_objekt_ebene7_id
, hr_objekt_ebene8_id
, hr_objekt_ebene9_id
, hr_objekt_ebene10_id
, hr_objekt_ebene11_id
, kostenstelle_id
, hr_objekt_ebene1_bez
, hr_objekt_ebene2_bez
, hr_objekt_ebene3_bez
, hr_objekt_ebene4_bez
, hr_objekt_ebene5_bez
, hr_objekt_ebene6_bez
, hr_objekt_ebene7_bez
, hr_objekt_ebene8_bez
, hr_objekt_ebene9_bez
, hr_objekt_ebene10_bez
, hr_objekt_ebene11_bez
, kjmo
, mandant_sort_id
, user_id
)
AS
-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

SELECT V01.MANDANT_ID ,
       V01.HR_OBJEKT_EBENE1_ID ,
       V01.HR_OBJEKT_EBENE2_ID ,
       V01.HR_OBJEKT_EBENE3_ID ,
       V01.HR_OBJEKT_EBENE4_ID ,
       V01.HR_OBJEKT_EBENE5_ID ,
       V01.HR_OBJEKT_EBENE6_ID ,
       V01.HR_OBJEKT_EBENE7_ID ,
       V01.HR_OBJEKT_EBENE8_ID ,
       V01.HR_OBJEKT_EBENE9_ID ,
       V01.HR_OBJEKT_EBENE10_ID ,
       V01.HR_OBJEKT_EBENE11_ID ,
       V01.KOSTENSTELLE_ID ,
       V01.HR_OBJEKT_EBENE1_BEZ ,
       V01.HR_OBJEKT_EBENE2_BEZ ,
       V01.HR_OBJEKT_EBENE3_BEZ ,
       V01.HR_OBJEKT_EBENE4_BEZ ,
       V01.HR_OBJEKT_EBENE5_BEZ ,
       V01.HR_OBJEKT_EBENE6_BEZ ,
       V01.HR_OBJEKT_EBENE7_BEZ ,
       V01.HR_OBJEKT_EBENE8_BEZ ,
       V01.HR_OBJEKT_EBENE9_BEZ ,
       V01.HR_OBJEKT_EBENE10_BEZ ,
       V01.HR_OBJEKT_EBENE11_BEZ ,
       V01.KJMO ,
       V01.OM_SORT_ID ,
       LOWER(V03.USER_ID) AS user_id
FROM DBP_MSI_VIEW_SHR.TBL_MV_ORG_EINHEIT_HIERARCHIE_HR V01
JOIN
  (SELECT V021.USER_ID ,
          V021.HR_OBJEKT_EBENE1_ID ,
          V021.MANDANT_ID
   FROM DBP_SECURITY.USER_HR_OBJEKT_ID_ZU V021
   JOIN DBP_MSI.AKT_MSI_USER V022 
   ON V021.USER_ID = V022.USER_ID) V03 
ON V01.HR_OBJEKT_EBENE1_ID = V03.HR_OBJEKT_EBENE1_ID
AND V01.MANDANT_ID = V03.MANDANT_ID
WHERE V01.SPR_ID = 65;