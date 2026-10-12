create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TRANSPORTATION_UNIT_CARRIER_LOG_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	TRANSPORTATION_UNIT_ID COMMENT 'Transportnummer',
	KJ_TRANSPORTATION_UNIT COMMENT 'Anlagejahr der Transporteinheit',
	TRANSPORTATION_UNIT_SR_ACT_ID COMMENT 'Warenannahme- und Versandaktivitätsnummer: Transporteinheit',
	BELEG_ID COMMENT 'Belegnummer',
	HANDLING_UNIT_GUID COMMENT 'Handling Unit_2 GUID',
	ART_GUID COMMENT 'Product',
	LADUNGSTRAEGER_STATUS_ID COMMENT 'Load Carrier: Log Status_2',
	ANZ_LADUNGSTRAEGER COMMENT 'Load Carrier Log: Good Quantity Received',
	ANZ_LADUNGSTRAEGER_DEFEKT COMMENT 'Load Carrier Log: Defect Quantity Received',
	ANZ_LADUNGSTRAEGER_TAUSCH COMMENT 'Load Carrier Log: Good Quantity Exchanged',
	ANZ_LADUNGSTRAEGER_DEFEKT_TAUSCH COMMENT 'Load Carrier Log: Defect Quantity Exchanged',
	LADUNGSTRAEGER_EINH_ID COMMENT 'Mengeneinheit',
	DATZEIT_ERSTELLUNG COMMENT 'Angelegt Am',
	DATZEIT_AENDERUNG COMMENT 'Geändert Am'
) as 
    SELECT 
        mandant_id,
        transportation_unit_id,
        kj_transportation_unit,
        transportation_unit_sr_act_id,
        beleg_id,
        handling_unit_guid,
        art_guid,
        ladungstraeger_status_id,
        anz_ladungstraeger,
        anz_ladungstraeger_defekt,
        anz_ladungstraeger_tausch,
        anz_ladungstraeger_defekt_tausch,
        ladungstraeger_einh_id,
        datzeit_erstellung,
        datzeit_aenderung

FROM DBP_DATA.TRANSPORTATION_UNIT_CARRIER_LOG_2 ;
