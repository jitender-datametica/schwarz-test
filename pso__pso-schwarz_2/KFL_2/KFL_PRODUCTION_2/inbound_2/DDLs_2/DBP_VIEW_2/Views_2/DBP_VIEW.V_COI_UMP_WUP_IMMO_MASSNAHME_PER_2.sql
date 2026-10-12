CREATE OR REPLACE VIEW DBP_VIEW.V_COI_UMP_WUP_IMMO_MASSNAHME_PER_2 AS 
    SELECT 
        mandant_id
        ,gj_plan
        ,version_id
        ,wup_id
        ,nb_id
        ,dat_immo_massnahme_von
        ,dat_immo_auswirkung_von
        ,massnahme_id
        ,dat_immo_massnahme_bis
        ,dat_immo_auswirkung_bis
        ,wrg_id
        ,immo_massnahme_typ
        ,immo_auswirkung_bez
        ,betriebsunterbrechung_fg
        ,faktor_immo
        ,wert_immo
        ,umsatz_netto_massnahme_ges
FROM DBP_DATA.coi_ump_wup_immo_massnahme_per_2 ;