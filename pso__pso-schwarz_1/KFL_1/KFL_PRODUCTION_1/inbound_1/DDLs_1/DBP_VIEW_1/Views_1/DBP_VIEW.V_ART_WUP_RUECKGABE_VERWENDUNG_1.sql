CREATE OR REPLACE VIEW DBP_VIEW.V_ART_WUP_RUECKGABE_VERWENDUNG_1 AS 
    SELECT 
        mandant_id,
        rueckgabe_nr,
        dat_rueckgabe,
        wup_id,
        nb_id,
        reklamationsgrund_id,
        art_id,
        menge_art,
        einh_id,
        wrg_id,
        betrag_vk_netto_rueckgabe,
        betrag_vk_netto_kauf,
        dat_mhd,
        rueckgabe_verwendung_kz,
        verarbeitet_fg,
        dat_verarbeitung
FROM DBP_DATA.ART_WUP_RUECKGABE_VERWENDUNG_1 ;