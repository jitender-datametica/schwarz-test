create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.GP_PLZ_BESCH_REGION_ZU_PER_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Lieferant.',
	LAND_ID VARCHAR(2) NOT NULL COMMENT 'Land_1 ID aus belos_adresse.',
	ABHOLUNG_PLZ VARCHAR(10) NOT NULL COMMENT 'Postleitzahl (muss nicht = gp_plz sein, bzw. sind mehrere pro GP_1 möglich).',
	DAT_VON DATE NOT NULL COMMENT 'Gültigkeitsdatum von.',
	DAT_BIS DATE COMMENT 'Gültigkeitsdatum bis.',
	BESCH_REGION_ID NUMBER(38,0) COMMENT 'Beschaffungsregion SCM.',
	BESCH_REGION_KOORDINATION_ID NUMBER(38,0) COMMENT 'Beschaffungsregion SCM, welche die Koordination des Lieferanten übernimmt. Kann von besch_region_id abweichen.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	ANZ_PAL_STAPELFAKTOR NUMBER(38,3) COMMENT 'Durchschnittliche Stapelfaktor (Anzahl Paletten übereinander) für den jeweiligen GP_1 (Lieferanten) und das zugehörige Gültigkeitsintervall. Dieser Wert ist eine_1 relevante Größe für die Abrechnung, insbesondere hinsichtlich der LKW-Auslastung. Der Wert dürfte in der Regel zwischen 1 und 5 liegen.',
	constraint PK_GP_PLZ_BESCH_REGION_ZU_PER primary key (MANDANT_ID, GP_ID, ABHOLUNG_PLZ, DAT_VON, LAND_ID)
)COMMENT='LOG - This table contains relations between supplier_1 (gp_id), zipcode of the pickup destination (abholung_plz) and procurement region_1 (Beschaffungsregion, besch_region_id and besch_region_koordination_id). A supplier_1 can have several addresses where goods are produced and picked up by transporters, which can therefore have different zip codes from the gp_plz of the main gp_1 office. A Beschaffungsregion is a procurement region_1; besch_region_id is the one where the procurement happens, while besch_region_koordination_id can be a different one because the coordinating office region_1 can be different from the pickup region. Both of them refer to besch_region_id in ts_l_beschaffungsregion. Filled through Sharepoint-Upload.'
;
