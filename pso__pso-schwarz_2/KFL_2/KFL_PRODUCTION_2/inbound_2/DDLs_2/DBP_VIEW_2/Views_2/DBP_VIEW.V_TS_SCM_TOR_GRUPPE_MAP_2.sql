CREATE OR REPLACE VIEW DBP_VIEW.V_TS_SCM_TOR_GRUPPE_MAP_2 AS 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,wup_id
        ,nb_id
        ,tor_id_zugeordnet
        ,tor_gruppe
        ,hallenseite_bez


FROM DBP_DATA.ts_scm_tor_gruppe_map_2 ;