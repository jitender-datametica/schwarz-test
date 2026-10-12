CREATE OR REPLACE VIEW DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU AS 
    SELECT 
        bonuskauf_id
        ,mandant_id
        ,crm_kunde_id
        ,kauf_id
        ,anz_einloesung
        ,wrg_id
        ,dat_kauf_rueckgabe
        ,dat_kauf
        ,kauf_status_nr
        ,anz_kaufbar
        ,dat_kauf_einloesung
        ,status_aktiv_nr
        ,datzeit_status_aktivierung
        ,status_einloesung
        ,dat_status_einloesung
        ,kontrollgruppe
        ,kampagnen_id
        ,checkout_fg
        ,anz_kauf_ist
        ,anz_kauf_soll
        ,sum_kauf_ist
        ,sum_kauf_soll
        ,dat_update
        ,kampagnen_version


FROM DBP_DATA.COS_BONUSKAUF_KUNDE_ZU ;