create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BEST_BELEGFLUSS_BNK_1(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	ANZAHLPOSITIONEN,
	FOLGE_BELEG_ID,
	FOLGE_BELEG_POS_ID,
	KJ,
	KOND_STUFE_ID,
	KOND_ZAEHL_ID,
	VORGART_BEST_ENTW_ID,
	BEST_ENTW_TYP_ID,
	BETRAG_KONDITION,
	SOLL_HABEN_KZ,
	REF_LAGERBEW_BELEG_ID,
	GP_ID,
	DAT_ERFASST,
	DAT_BUCH,
	SYSTEM_ID,
	KONDITIONSART_ID,
	WRG_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       v01.mandant_id,
       v01.best_beleg_id,
       v01.best_beleg_pos_id,
       1 AS anzahlpositionen,
       v01.folge_beleg_id,
       v01.folge_beleg_pos_id,
       v01.kj,
       v01.kond_stufe_id,
       v01.kond_zaehl_id,
       v01.vorgart_best_entw_id,
       v01.best_entw_typ_id,
       v01.betrag_kondition,
       v01.soll_haben_kz,
       v01.ref_lagerbew_beleg_id,
       v01.gp_id,
       v01.dat_erfasst,
       v01.dat_buch,
       7,
       v01.konditionsart_id,
       v01.wrg_id

FROM dbp_view.v_best_belegfluss_bnk_1 v01
       WHERE mandant_id = 1;
