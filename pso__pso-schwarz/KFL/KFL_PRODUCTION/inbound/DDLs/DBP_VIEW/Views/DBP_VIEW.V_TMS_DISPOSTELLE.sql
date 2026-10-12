create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TMS_DISPOSTELLE(
	MANDANT_ID COMMENT 'Mandant im DWH',
	SYSTEM_ID COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_DISPOSTELLE_ID COMMENT 'ID des Dispostelles. Auspldispst.dst_id',
	TMS_DISPOSTELLE_NAME COMMENT 'Dispostelle Name',
	LAGERNUMMER_ID COMMENT 'Lagernummer der Dispostelle',
	BESTAND_TMS_GP_ID COMMENT 'TMS Geschäftspartner-ID des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.',
	BESTAND_TMS_GP_TYP_CD COMMENT 'TMS Geschäftspartnertyp-Code des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.'
) as 
    SELECT 
        mandant_id,
        system_id,
        tms_dispostelle_id,
        tms_dispostelle_name,
        lagernummer_id,
        bestand_tms_gp_id,
        bestand_tms_gp_typ_cd

FROM DBP_DATA.TMS_DISPOSTELLE ;
