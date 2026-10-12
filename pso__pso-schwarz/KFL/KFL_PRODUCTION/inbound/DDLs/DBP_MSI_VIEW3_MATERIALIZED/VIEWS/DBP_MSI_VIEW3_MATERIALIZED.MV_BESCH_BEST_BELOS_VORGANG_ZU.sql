create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_BEST_BELOS_VORGANG_ZU(
	BELOS_VORGANG_ID,
	BEST_BELEG_ID,
	MANDANT_ID
) as
   SELECT
  belos_vorgang_id, best_beleg_id, mandant_id

   FROM dbp_view.v_besch_best_belos_vorgang_zu;