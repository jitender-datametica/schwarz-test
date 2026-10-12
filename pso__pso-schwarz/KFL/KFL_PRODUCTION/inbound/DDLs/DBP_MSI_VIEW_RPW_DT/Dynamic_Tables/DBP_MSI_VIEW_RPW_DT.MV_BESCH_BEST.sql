create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BESCH_BEST(
	MANDANT_ID,
	BEST_BELEG_ID,
	GP_ID,
	DAT_BEST_BELEG,
	BESTELLART_ID,
	BEST_BELEG_STATUS_ID,
	LOESCH_FG,
	NACHBEST_FG,
	EINKAUFSORGANISATION_ID,
	DAT_AENDERUNG,
	KUNDE_ID,
	WUP_ID,
	NB_ID,
	SYSTEM_ID,
	KJ,
	SUBMI_ID,
	REF_BELEG_ID_INTERN
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
          mandant_id,
          best_beleg_id,
          gp_id,
          dat_best_beleg,
          bestellart_id,
          best_beleg_status_id,
          loesch_fg,
          nachbest_fg,
          einkaufsorganisation_id,
          dat_aenderung,
          kunde_id,
          wup_id,
          nb_id,
          7,
          EXTRACT(YEAR FROM dat_best_beleg),
          submi_id,
          ref_beleg_id_intern
          FROM dbp_view.v_besch_best
          WHERE mandant_id = 1
          AND einkaufsorganisation_id <> 5000;
