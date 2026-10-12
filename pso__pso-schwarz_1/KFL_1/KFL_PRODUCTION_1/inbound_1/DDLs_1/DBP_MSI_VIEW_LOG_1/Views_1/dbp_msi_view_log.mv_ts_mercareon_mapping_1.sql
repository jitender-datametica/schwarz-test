CREATE OR REPLACE VIEW dbp_msi_view_log.mv_ts_mercareon_mapping_1(
	MERCAREON_STANDORT,
	MERCAREON_ENTLADESTELLE,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	LAGERNUMMER_EWM_ID,
	LAGERNUMMER_LES_ID,
	ENTLADESTELLE_ID,
	ARTIKELSORTIMENT_ID
) AS

--2022-03-29, AP0102132, SPEC0148033, initial, dknop
    SELECT 
        mercareon_standort
        ,mercareon_entladestelle
        ,mandant_id
        ,wup_id
        ,'-111'
        ,lagernummer_ewm_id
        ,lagernummer_les_id
        ,entladestelle_id
        ,artikelsortiment_id


FROM dbp_view.v_ts_mercareon_mapping_1 ;