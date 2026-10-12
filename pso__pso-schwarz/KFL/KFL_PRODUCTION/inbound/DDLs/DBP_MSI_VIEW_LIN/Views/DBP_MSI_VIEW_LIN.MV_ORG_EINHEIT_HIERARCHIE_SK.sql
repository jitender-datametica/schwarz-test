CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_ORG_EINHEIT_HIERARCHIE_SK
-- srom0404: lt. Mail A. Wolter vom 17.04.2015, nur die aktuellste Zuordnung
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
, mandant_sort_id
, user_id
)
AS
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
       V01.OM_SORT_ID ,
       V03.USER_ID
FROM DBP_VIEW.V_ORG_EINHEIT_HIERARCHIE V01
INNER JOIN
  (SELECT V021.USER_ID ,
          V021.HR_OBJEKT_EBENE1_ID ,
          V021.MANDANT_ID
   FROM DBP_SECURITY.USER_HR_OBJEKT_ID_ZU V021
   INNER JOIN DBP_MSI_DATA.AKT_MSI_USER V022 ON V021.USER_ID = V022.USER_ID) V03 ON V01.HR_OBJEKT_EBENE1_ID = V03.HR_OBJEKT_EBENE1_ID
AND V01.MANDANT_ID = V03.MANDANT_ID
AND V01.SPR_ID = 108 -- Es soll nur die aktuellste Zuordnung angezeigt werden
 QUALIFY ROW_NUMBER() OVER (PARTITION BY V01.MANDANT_ID ,
                                         HR_OBJEKT_EBENE11_ID
                            ORDER BY KJMO DESC NULLS LAST) = 1 ;