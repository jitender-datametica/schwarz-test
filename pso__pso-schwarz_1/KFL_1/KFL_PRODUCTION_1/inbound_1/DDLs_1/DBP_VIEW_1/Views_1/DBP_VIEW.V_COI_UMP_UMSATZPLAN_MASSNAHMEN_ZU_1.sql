CREATE OR REPLACE VIEW DBP_VIEW.V_COI_UMP_UMSATZPLAN_MASSNAHMEN_ZU_1 AS 
    SELECT 
        mandant_id
        ,gj_plan
        ,version_id
        ,wup_id
        ,nb_id
        ,dat_plan
        ,arthiertyp_id
        ,hwg_id
        ,massnahme_art_id
        ,massnahme_typ_bez
        ,massnahme_id
        ,wrg_id
        ,massnahme_art_bez
        ,massnahme_auswirkung_bez
        ,faktor
        ,wert
FROM DBP_DATA.coi_ump_umsatzplan_massnahmen_zu_1 ;