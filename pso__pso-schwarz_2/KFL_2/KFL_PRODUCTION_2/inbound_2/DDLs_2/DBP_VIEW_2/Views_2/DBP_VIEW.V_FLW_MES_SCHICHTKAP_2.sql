CREATE OR REPLACE VIEW DBP_VIEW.V_FLW_MES_SCHICHTKAP_2 AS 
    SELECT 
        mandant_id
        ,schicht_id
        ,kapatyp_id
        ,schichttyp_id
        ,ngrad_angabe
        ,kapa_dauer
        ,kapa_einh
        ,mengen_anz
        ,dat_schicht
        ,pause_dauer_sec


FROM DBP_DATA.flw_mes_schichtkap_2 ;