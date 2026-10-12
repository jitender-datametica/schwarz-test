CREATE OR REPLACE VIEW DBP_VIEW.V_COI_UMP_EK_MASSNAHME_PER_2 AS 
    SELECT 
        mandant_id
        ,gj_plan
        ,version_id
        ,land_level
        ,vs_id
        ,wup_id
        ,nb_id
        ,arthiertyp_id
        ,abt_id
        ,hwg_id
        ,ek_massnahme_typ
        ,dat_ek_massnahme_von
        ,wrg_id
        ,massnahme_id
        ,ek_massnahme_bez
        ,dat_ek_massnahme_bis
        ,faktor_ek
        ,wert_ek
        ,umsatz_netto_massnahme_ges
        ,bereinigt_fg
FROM DBP_DATA.coi_ump_ek_massnahme_per_2 ;