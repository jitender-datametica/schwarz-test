create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_CROSS_DOCKING_AVIS(
	MANDANT_ID,
	CD_BELEG_ID,
	WUP_ID,
	NB_ID,
	CD_TYP_ID,
	LAGERORT_ID,
	GP_ID,
	KUNDE_ID,
	DAT_LIEF_SOLL,
	HANDLING_UNIT_ID_EXT,
	LIEF_BELEG_EXT_ID,
	CD_STATUS_ID,
	MANDANT_ID_KUNDE
) as


   SELECT v01.mandant_id, v01.cd_beleg_id, v01.wup_id, v01.nb_id, v01.cd_typ_id, v01.lagerort_id, v01.gp_id, 
   
   CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE v05.aktuell_wup_id END kunde_id,
   v01.dat_lief_soll, v01.handling_unit_id_ext, v01.lief_beleg_ext_id, v01.cd_status_id, v01.mandant_id_kunde

   FROM dbp_view.v_cross_docking_avis v01
   INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id ELSE v01.mandant_id_kunde END
   AND v05.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0));