CREATE OR REPLACE VIEW DBP_VIEW.V_PLATZIERUNGSWG_FLAECHE_FLACHETYP_ZU_1 AS 
    SELECT 
        mandant_id,
        platzierungswg_id,
        ginfo_flaeche_id,
        ginfo_flaeche_typ_id,
        techn_platz_id,
        flaeche_quelle_id
FROM DBP_DATA.PLATZIERUNGSWG_FLAECHE_FLACHETYP_ZU_1 ;