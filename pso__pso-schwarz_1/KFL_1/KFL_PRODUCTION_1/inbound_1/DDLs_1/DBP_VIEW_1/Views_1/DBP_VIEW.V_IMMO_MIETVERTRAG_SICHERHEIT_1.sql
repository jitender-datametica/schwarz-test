CREATE OR REPLACE VIEW DBP_VIEW.V_IMMO_MIETVERTRAG_SICHERHEIT_1 AS 
    SELECT 
        mandant_id
        ,mv_intreno
        ,sicherheit_lfd_nr
        ,beschreibung
        ,sicherheit_typ
        ,dat_bis
        ,betrag_soll
        ,soll_wrg_id
        ,betrag_ist
        ,ist_wrg_id
        ,dat_eingeloest_am
        ,dat_rueckgabe_am
        ,dat_eingang_am
        ,dat_uebergabe_am
        ,buergschaft_nr
        ,buergschaft_grund
        ,rueckgabe_voraussetzung
        ,bank_id
        ,kaution_bez
        ,dat_ausstellung_am
FROM DBP_DATA.immo_mietvertrag_sicherheit_1 ;