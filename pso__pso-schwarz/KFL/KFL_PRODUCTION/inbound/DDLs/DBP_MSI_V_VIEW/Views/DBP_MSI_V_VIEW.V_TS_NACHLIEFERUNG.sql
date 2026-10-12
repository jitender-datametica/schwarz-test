CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_NACHLIEFERUNG AS 
    SELECT 
        nachlieferung_request_id
        ,gp_exp_name
        ,mandant_id
        ,wup_id
        ,art_id
        ,dat_start
        ,anzahl_dateien
        ,active_fg
        ,ldap_user
        ,gp_id
        ,periodizitaet
        ,datzeit_insert
        ,datzeit_update

FROM DBP_MSI_DATA.ts_nachlieferung ;