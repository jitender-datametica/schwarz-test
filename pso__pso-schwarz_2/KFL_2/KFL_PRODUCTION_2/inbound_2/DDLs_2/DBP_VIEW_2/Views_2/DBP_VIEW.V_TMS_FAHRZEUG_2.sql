create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TMS_FAHRZEUG_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	SYSTEM_ID COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_FAHRZEUG_ID COMMENT 'ID des Fahrzeugs (Fahrzeugnummer). Aus plfaz.nr',
	TMS_FAHRZEUG_LFD_NR COMMENT 'SKey für die Tabelle tms_fahrzeug_2 im Quellsystem. Aus plfaz.faz_id',
	TMS_FAHRZEUGTYP_ID COMMENT 'Fahrzeugtyp',
	TMS_FAHRZEUG_TRAILER_ID COMMENT 'Hängernummer 1',
	SPEDITEUR_TMS_GP_ID COMMENT 'ID des tms_gp_2, welcher hier als Spediteur auftrifft',
	SPEDITEUR_TMS_GP_TYP_CD COMMENT 'Code für den tms_gp_2-Typ, welcher hier als Spediteur auftrifft. immer \""S\"" (Typ = S Spediteur)',
	VERBRAUCH_PRO_100KM COMMENT 'Verbrauch pro 100 Km',
	TMS_TREIBSTOFF_ID COMMENT 'Treibstoffart (Diesel, Benzin, usw.)'
) as 
    SELECT 
        mandant_id,
        system_id,
        tms_fahrzeug_id,
        tms_fahrzeug_lfd_nr,
        tms_fahrzeugtyp_id,
        tms_fahrzeug_trailer_id,
        spediteur_tms_gp_id,
        spediteur_tms_gp_typ_cd,
        verbrauch_pro_100km,
        tms_treibstoff_id

FROM DBP_DATA.TMS_FAHRZEUG_2 ;
