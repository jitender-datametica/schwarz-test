CREATE OR REPLACE VIEW DBP_VIEW.V_BELOS_LADUNG_2 AS 
    SELECT 
        mandant_id
        ,belos_ladung_id
        ,spedition_hub_id
        ,gewicht_gesamt
        ,anzahl_auftrag
        ,zusatz_spot


FROM DBP_DATA.belos_ladung_2 ;