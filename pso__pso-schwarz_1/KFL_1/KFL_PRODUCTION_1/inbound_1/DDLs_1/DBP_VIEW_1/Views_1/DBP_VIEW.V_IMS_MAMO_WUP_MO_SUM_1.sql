CREATE OR REPLACE VIEW DBP_VIEW.V_IMS_MAMO_WUP_MO_SUM_1 AS 
    SELECT 
        mandant_id
        ,wup_id
        ,nb_id
        ,hwg_id
        ,kjmo
        ,zaehler_monat
        ,umsatz_netto
        ,umsatz_netto_kum
        ,umsatz_netto_vp
        ,umsatz_netto_vp_kum
        ,umsatz_netto_sa
        ,umsatz_netto_sa_kum
        ,umsatz_netto_sa_vp
        ,umsatz_netto_sa_vp_kum
        ,ek_mep
        ,ek_mep_kum
        ,ek_mep_vp
        ,ek_mep_vp_kum
        ,bonanzahl_sug
        ,bonanzahl_sug_kum
        ,bonanzahl_sug_vp
        ,bonanzahl_sug_vp_kum
        ,vis_netto_stunden
        ,vis_netto_stunden_kum
        ,vis_netto_stunden_vp
        ,vis_netto_stunden_vp_kum
        ,vis_umsatz_netto
        ,vis_umsatz_netto_kum
        ,vis_umsatz_netto_vp
        ,vis_umsatz_netto_vp_kum
        ,preis_abschrift_netto
        ,preis_abschrift_netto_kum
        ,preis_abschrift_netto_vp
        ,preis_abschrift_netto_vp_kum


FROM DBP_DATA.ims_mamo_wup_mo_sum_1 ;