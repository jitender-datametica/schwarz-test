CREATE OR REPLACE VIEW DBP_VIEW.V_COI_UMP_FILIALEFFEKTE_PER_1 AS 
    SELECT 
        mandant_id
        ,gj_plan
        ,version_id
        ,land_level
        ,wup_id
        ,nb_id
        ,filialeffekt_massnahme_typ
        ,filialeffekt_auswirkung_bez
        ,dat_filialeffekt_von
        ,wrg_id
        ,massnahme_id
        ,dat_filialeffekt_bis
        ,faktor_filialeffekt
        ,wert_filialeffekt
        ,umsatz_netto_massnahme_ges
        ,bereinigt_fg
FROM DBP_DATA.coi_ump_filialeffekte_per_1 ;