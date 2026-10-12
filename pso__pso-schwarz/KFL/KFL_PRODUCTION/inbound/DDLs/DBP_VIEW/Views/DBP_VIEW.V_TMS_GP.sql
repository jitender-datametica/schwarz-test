create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TMS_GP(
	MANDANT_ID COMMENT 'Mandant im DWH',
	SYSTEM_ID COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_GP_ID COMMENT 'ID des Geschäftspartners. Aus plkd.nr',
	TMS_GP_TYP_CD COMMENT 'Geschäftspartnertyp. L = Lager, S = Spediteur, 0(null) = Markt(Kunde)',
	TMS_GP_LFD_NR COMMENT 'SKey für die Tabelle tms_gp im Quellsystem. Aus plkd.kd_id',
	TMS_GP_NAME COMMENT 'Name des Geschäftspartners',
	TMS_GP_ALTNV_NAME COMMENT 'Alternativer Name des Geschäftspartners',
	TMS_GP_STRASSE COMMENT 'Straße des Geschäftspartners Adresse',
	TMS_GP_ORT_NAME COMMENT 'Ort des Geschäftspartners Adresse',
	TMS_GP_PLZ COMMENT 'Postleitzahl des Geschäftspartners Adresse',
	TMS_LAND_CD COMMENT 'Länderkennzeichen',
	SPERR_FG COMMENT 'Kennzeichnung für Sperrung des Kunden',
	SAMMELBELEG_ID COMMENT 'Kennzeichen für Sammelbelege (aktuell nur J/N/leer)',
	TMS_STANDORTTYP_ID COMMENT 'Standort-Typ (Außenlager, VZ, FLW, Markt,…)'
) as 
    SELECT 
        mandant_id,
        system_id,
        tms_gp_id,
        tms_gp_typ_cd,
        tms_gp_lfd_nr,
        tms_gp_name,
        tms_gp_altnv_name,
        tms_gp_strasse,
        tms_gp_ort_name,
        tms_gp_plz,
        tms_land_cd,
        sperr_fg,
        sammelbeleg_id,
        tms_standorttyp_id

FROM DBP_DATA.TMS_GP ;
