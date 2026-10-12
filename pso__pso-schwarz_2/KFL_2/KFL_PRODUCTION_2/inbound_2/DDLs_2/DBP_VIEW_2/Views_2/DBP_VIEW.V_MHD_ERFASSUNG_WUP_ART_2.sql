CREATE OR REPLACE VIEW DBP_VIEW.V_MHD_ERFASSUNG_WUP_ART_2 AS 
    SELECT 
        mandant_id
        ,wup_id
        ,dat_erfassung
        ,dat_mhd
        ,art_id
        ,art_anz
        ,basismenge_einh_id
        ,mhd_erfassung_pruef_fg
        ,listung_fg
        ,dat_erstellung
        ,dat_aenderung
FROM DBP_DATA.mhd_erfassung_wup_art_2 ;