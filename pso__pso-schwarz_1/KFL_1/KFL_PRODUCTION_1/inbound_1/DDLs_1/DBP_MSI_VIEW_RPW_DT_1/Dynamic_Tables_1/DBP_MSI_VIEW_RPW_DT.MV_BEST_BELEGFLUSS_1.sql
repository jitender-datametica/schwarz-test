create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BEST_BELEGFLUSS_1(
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	BEST_ENTW_TYP_ID,
	BESTAETIGUNG_LFD_NR,
	BETRAG,
	DAT_BUCH,
	FOLGE_BELEG_ID,
	FOLGE_BELEG_POS_ID,
	KJ,
	KONTIERUNG_POS_ID,
	LAGER_BEWART_ID,
	MANDANT_ID,
	MENGE_ANTEIL,
	MENGE_BASIS,
	MENGE_BEST,
	NB_ID,
	REF_BELEG_ID,
	REF_BELEG_POS_ID,
	REF_GJ,
	SOLL_HABEN_KZ,
	VORGART_BEST_ENTW_ID,
	WRG_ID,
	WUP_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
--22.11.2023 prescherad / Umbenennung der Spalte Betrag zu betrag_ek_netto

       SELECT
       best_beleg_id,
       best_beleg_pos_id,
       best_entw_typ_id,
       bestaetigung_lfd_nr,
       CASE WHEN soll_haben_kz = 'H'
       THEN betrag_ek_netto * (-1)
       ELSE betrag_ek_netto
       END AS betrag,
       dat_buch,
       folge_beleg_id,
       folge_beleg_pos_id,
       kj,
       kontierung_pos_id,
       lager_bewart_id,
       mandant_id,
       menge_anteil,
       menge_basis,
       menge_best,
       nb_id,
       ref_beleg_id,
       ref_beleg_pos_id,
       ref_gj,
       soll_haben_kz,
       vorgart_best_entw_id,
       wrg_id,
       wup_id,
       7 AS system_id
       FROM dbp_view.v_best_belegfluss_1
       WHERE best_entw_typ_id = 'E'
       AND mandant_id = 1;
