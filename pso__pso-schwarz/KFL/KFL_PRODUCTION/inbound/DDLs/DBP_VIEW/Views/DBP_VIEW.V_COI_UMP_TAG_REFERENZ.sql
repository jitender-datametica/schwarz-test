CREATE OR REPLACE VIEW DBP_VIEW.V_COI_UMP_TAG_REFERENZ AS 
    SELECT 
        mandant_id
        ,gj_plan
        ,version_id
        ,land_level
        ,dat_plan
        ,dat_referenz
        ,wrg_id
        ,faktor_kalender
        ,wert_kalender
        ,umsatz_netto_tag_ges
FROM DBP_DATA.coi_ump_tag_referenz ;