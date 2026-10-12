CREATE OR REPLACE VIEW DBP_VIEW.V_ANLIEFERUNG_ZEITFENSTER_1 AS 
    SELECT 
        mercareon_standort
        ,mercareon_entladestelle
        ,dat
        ,zeit_1
        ,anz_zf_gesamt
        ,anz_zf_gebucht
        ,anz_zf_reserviert
        ,anz_zf_gesperrt
        ,anz_zf_frei


FROM DBP_DATA.anlieferung_zeitfenster_1 ;