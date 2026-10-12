CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ORG_EINHEIT_HIERARCHIE_1
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
)
AS
   SELECT
   v01.mandant_id, v01.hr_objekt_ebene1_id, v01.hr_objekt_ebene2_id, v01.hr_objekt_ebene3_id, v01.hr_objekt_ebene4_id, v01.hr_objekt_ebene5_id, v01.hr_objekt_ebene6_id, v01.hr_objekt_ebene7_id, v01.hr_objekt_ebene8_id, v01.hr_objekt_ebene9_id, v01.hr_objekt_ebene10_id, v01.hr_objekt_ebene11_id, v01.kostenstelle_id, v01.hr_objekt_ebene1_bez, v01.hr_objekt_ebene2_bez, v01.hr_objekt_ebene3_bez, v01.hr_objekt_ebene4_bez, v01.hr_objekt_ebene5_bez, v01.hr_objekt_ebene6_bez, v01.hr_objekt_ebene7_bez, v01.hr_objekt_ebene8_bez, v01.hr_objekt_ebene9_bez, v01.hr_objekt_ebene10_bez, v01.hr_objekt_ebene11_bez, v01.kjmo

   FROM dbp_view.v_org_einheit_hierarchie_1 v01

   JOIN
   (
   SELECT
   mandant_id, MAX(kjmo) AS kjmo
   FROM dbp_view.v_shr_kennzahlen_1
   GROUP BY 1
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.kjmo = v02.kjmo
   ;