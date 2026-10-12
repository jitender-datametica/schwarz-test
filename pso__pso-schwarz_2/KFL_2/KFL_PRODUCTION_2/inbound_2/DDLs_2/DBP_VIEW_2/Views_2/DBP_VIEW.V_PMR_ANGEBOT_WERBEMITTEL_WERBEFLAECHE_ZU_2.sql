CREATE OR REPLACE VIEW DBP_VIEW.V_PMR_ANGEBOT_WERBEMITTEL_WERBEFLAECHE_ZU_2 AS 
    SELECT 
        angebot_id,
        mandant_id,
        werbemittel_art_id,
        werbemittel_id,
        werbeflaeche_abschnitt_name,
        werbeflaeche_thema_id,
        werbeflaeche_thema_bez

FROM DBP_DATA.PMR_ANGEBOT_WERBEMITTEL_WERBEFLAECHE_ZU_2 ;