CREATE OR REPLACE VIEW DBP_VIEW.V_HFM_INVENTUR_TERMIN_OWG_WUP_DETAIL AS 
    SELECT 
        mandant_id
        ,wup_id
        ,nb_id
        ,dat_plan_zaehlung
        ,inventurart_int_id
        ,owg_id
        ,arthiertyp_id
        ,dat_vorletzte_zaehlung
        ,wrg_id
        ,anfangsbestand
        ,warenzugang
        ,warenzugang_dzl
        ,warenzugang_dzl_korr
        ,warenzugang_zl
        ,warenzugang_zl_korr
        ,warenzugang_retoure
        ,abschriften_ohne_diebstahl
        ,werbegutschriften
        ,abschriften_operativ
        ,abschriften_ta_vt_sonstige
        ,endbestand_rechnerisch
        ,endbestand_gezaehlt
        ,umsatz_soll
FROM DBP_DATA.hfm_inventur_termin_owg_wup_detail ;