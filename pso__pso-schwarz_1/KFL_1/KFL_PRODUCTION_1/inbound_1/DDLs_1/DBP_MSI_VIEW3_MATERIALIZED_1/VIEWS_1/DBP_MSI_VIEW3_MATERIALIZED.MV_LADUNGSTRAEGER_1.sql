create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LADUNGSTRAEGER_1(
	ANZ_LADTRAEGER,
	ANZ_LADTRAEGER_ORIG,
	ANZ_LADTRAEGER_DEFEKT,
	ART_ID,
	DAT_ERSTELLUNG,
	HANDLING_UNIT_ID_EXT,
	LAGERNUMMER_ID,
	LIEF_BELEG_ID,
	MANDANT_ID,
	NB_ID,
	STATUS_LADTRAEGER,
	SYSTEM_ID,
	TOUR_ID,
	WUP_ID,
	KJ_LIEF_BELEG
) as
   SELECT

     anz_ladtraeger, anz_ladtraeger_orig, anz_ladtraeger_defekt, art_id, dat_erstellung, handling_unit_id_ext, lagernummer_id, lief_beleg_id, mandant_id, nb_id, status_ladtraeger, system_id, tour_id, wup_id, kj_lief_beleg

   FROM dbp_view.v_ladungstraeger_1
   WHERE extract(year from dat_erstellung) >= year(current_timestamp) - 2;