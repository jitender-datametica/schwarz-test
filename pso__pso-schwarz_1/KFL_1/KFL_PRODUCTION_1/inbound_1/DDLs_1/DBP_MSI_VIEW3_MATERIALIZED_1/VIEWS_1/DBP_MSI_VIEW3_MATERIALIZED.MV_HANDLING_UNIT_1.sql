create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_HANDLING_UNIT_1(
	MANDANT_ID,
	SYSTEM_ID,
	NB_ID,
	WUP_ID,
	HANDLING_UNIT_ID,
	PACKMITTEL_TYP,
	HU_GEW_EINH_ID,
	HU_VOL_EINH_ID,
	LAGERNUMMER_ID,
	PACKMITTELART_ID,
	MAT_GRU_PACKMITTEL,
	VERSANDSTELLE_ID,
	GEWICHT_LADUNG,
	GEWICHT_EIGEN,
	NETTO_VOL_LADUNG,
	VOL_EIGEN,
	VERSANDEINHEIT_ID,
	HANDLING_UNIT_ID_EXT,
	LIEF_BELEG_ID,
	ANZAHL_STELLPLATZ,
	MENGE_GEFAHRGUT,
	BRTVOL_LADUNG,
	BRTGEW_LADUNG,
	MENGE_HANDLING_KOLLI_ORIG,
	HU_STATUS_ID,
	HU_STELLPLATZ_FAKTOR,
	BRTVOL_LADUNG_GEDECKELT,
	TRAEGERTYP_BEZ,
	KJ_LIEF_BELEG
) as
   SELECT
    v01.mandant_id, v01.system_id, v01.nb_id, v01.wup_id, v01.handling_unit_id, v01.packmittel_typ, v01.hu_gew_einh_id, v01.hu_vol_einh_id, v01.lagernummer_id, v01.packmittelart_id, v01.mat_gru_packmittel, v01.versandstelle_id, v01.gewicht_ladung, v01.gewicht_eigen, v01.vol_ladung AS netto_vol_ladung, v01.vol_eigen, v01.versandeinheit_id, v01.handling_unit_id_ext, v01.lief_beleg_id, CASE WHEN v01.versandeinheit_id IN (-1,1) THEN v01.anzahl_stellplatz ELSE 0 END AS anzahl_stellplatz, v01.menge_gefahrgut, v01.brtvol_ladung, v01.brtgew_ladung, v01.menge_handling_kolli_orig, v01.hu_status_id, v01.hu_stellplatz_faktor, v01.brtvol_ladung_gedeckelt, CASE WHEN v01.versandeinheit_id NOT IN (1,-1) THEN 'AUFGEPACKT'
   WHEN v01.versandeinheit_id = -1 THEN 'NORMAL'
   WHEN v01.versandeinheit_id = 1 THEN 'TRÄGER'
END AS traegertyp_bez, v01.kj_lief_beleg

   FROM dbp_view.v_handling_unit_1 v01
   WHERE (v01.kj_lief_beleg = -1 OR v01.kj_lief_beleg >= year(current_timestamp) - 2);