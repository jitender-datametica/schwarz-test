create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_TS_WUP_TM_GP_KOSTEN_UPLOAD_PER(
	MANDANT_ID COMMENT 'Mandant im DWH',
	SYSTEM_ID COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_GP_ID COMMENT 'ID des Geschäftspartners. Aus plkd.nr  (hier: Spedition)',
	TMS_GP_TYP_CD COMMENT 'Geschäftspartnertyp. L- Lager, S - Spediteur, 0(null) - Markt(Kunde)     (hier: nur Speditionen)',
	WUP_ID COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum  (hier: nur Werk)',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	KOSTEN_UPLOAD_FG COMMENT 'Flag: für Touren die von einer gg. Spedition aus einem gg. VZ gefahren werden, werden Daten in der Tabelle transportation_unit_kosten_upload erwartet',
	DAT_BIS COMMENT 'Gültig bis',
	DAT_VON COMMENT 'Gültig von'
) as 
    SELECT 
        mandant_id,
        system_id,
        tms_gp_id,
        tms_gp_typ_cd,
        wup_id,
        nb_id,
        kosten_upload_fg,
        dat_bis,
        dat_von

FROM DBP_MSI_DATA.TS_WUP_TM_GP_KOSTEN_UPLOAD_PER ;
