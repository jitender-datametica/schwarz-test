CREATE OR REPLACE VIEW DBP_VIEW.V_EK_INFOSATZ_WUP_ZU AS 
    SELECT 
        mandant_id
        ,ek_infosatz_id
        ,wup_id
        ,nb_id
        ,prozent_akzeptanz_unterlief
        ,loesch_fg
        ,mind_bestellmenge
        ,planlieferzeit
        ,rundungsprofil
        ,normal_bestellmenge
        ,ueberlieferung_toleranzgrenze
        ,ueberlieferung_unbegrenzt_fg
        ,unterlieferung_toleranzgrenze
        ,nettopreis
        ,bmpe
        ,bestaet_steuerschluessel
        ,wrg_id


FROM DBP_DATA.ek_infosatz_wup_zu ;