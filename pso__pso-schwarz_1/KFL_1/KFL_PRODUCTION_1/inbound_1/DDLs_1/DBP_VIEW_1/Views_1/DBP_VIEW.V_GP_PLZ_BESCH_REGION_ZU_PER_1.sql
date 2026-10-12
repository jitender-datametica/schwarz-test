create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_GP_PLZ_BESCH_REGION_ZU_PER_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH.',
	GP_ID COMMENT 'Lieferant.',
	LAND_ID COMMENT 'Land_1 ID aus belos_adresse.',
	ABHOLUNG_PLZ COMMENT 'Postleitzahl (muss nicht = gp_plz sein, bzw. sind mehrere pro GP_1 möglich).',
	DAT_VON COMMENT 'Gültigkeitsdatum von.',
	DAT_BIS COMMENT 'Gültigkeitsdatum bis.',
	BESCH_REGION_ID COMMENT 'Beschaffungsregion SCM.',
	BESCH_REGION_KOORDINATION_ID COMMENT 'Beschaffungsregion SCM, welche die Koordination des Lieferanten übernimmt. Kann von besch_region_id abweichen.',
	ANZ_PAL_STAPELFAKTOR COMMENT 'Durchschnittliche Stapelfaktor (Anzahl Paletten übereinander) für den jeweiligen GP_1 (Lieferanten) und das zugehörige Gültigkeitsintervall. Dieser Wert ist eine_1 relevante Größe für die Abrechnung, insbesondere hinsichtlich der LKW-Auslastung. Der Wert dürfte in der Regel zwischen 1 und 5 liegen.'
) as 
    SELECT 
        mandant_id,
        gp_id,
        land_id,
        abholung_plz,
        dat_von,
        dat_bis,
        besch_region_id,
        besch_region_koordination_id,
        anz_pal_stapelfaktor

FROM DBP_DATA.GP_PLZ_BESCH_REGION_ZU_PER_1 ;
