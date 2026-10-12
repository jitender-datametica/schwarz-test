create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_BEW_LIEF_1(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	LAGERBEW_BELEG_ID,
	BDE_VORGANG_ID,
	WERK_ID,
	CHARGE_ID,
	LAGERORT_ID,
	DAT_ERFASST,
	ZEIT_ERFASST,
	BELEG_GRUPPE_ID,
	DAT_HALTBARKEIT,
	AUFTRAG_ID,
	KJ,
	LOESCH_FG,
	IN_ART_ID,
	DME_EINH_ID,
	NETTOGEW_LIEF,
	MENGE_BME_LIEF,
	MENGE_DME_LIEF,
	FLW_BELEG_TYP_ID,
	MENGE_EINH_ID,
	STORNO_FG,
	STATUS_MB,
	RETOURENPOS_FG,
	BETRAG_BEW,
	WRG_ID
) as 
SELECT
   v01.mandant_id, best_beleg_id, best_beleg_pos_id, lagerbew_beleg_id, bde_vorgang_id, werk_id, charge_id, lagerort_id, dat_erfasst, zeit_erfasst, beleg_gruppe_id, dat_haltbarkeit, auftrag_id, kj, loesch_fg, flw_art_id AS in_art_id, dme_einh_id, nettogew_lief, menge_bme_lief, menge_dme_lief, flw_beleg_typ_id, menge_einh_id, storno_fg, status_mb, retourenpos_fg
   ,  CAST(
   CASE WHEN v01.wrg_id_org <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(betrag_bew_org,0)
   
   WHEN v01.wrg_id_org <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(betrag_bew_org,0) / v500.umrechnungskurs)
   
   WHEN v01.wrg_id_org = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(betrag_bew_org,0) * v500.umrechnungskurs
   
   WHEN v01.wrg_id_org = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(betrag_bew_org,0)
   END
   AS DECIMAL(18,6))
   AS betrag_bew
   , v400.wrg_id AS wrg_id
   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_FLW_BEW_LIEF_1 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300
   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs_1 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id_org = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat_erfasst BETWEEN v500.dat_von AND v500.dat_bis;