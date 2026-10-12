CREATE OR REPLACE VIEW DBP_VIEW.V_TS_MERCAREON_MAPPING_1 AS 
    SELECT 
        mercareon_standort
        ,mercareon_entladestelle
        ,mandant_id
        ,wup_id
        ,nb_id
        ,lagernummer_ewm_id
        ,lagernummer_les_id
        ,entladestelle_id
        ,artikelsortiment_id


FROM DBP_DATA.ts_mercareon_mapping_1 ;