create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_WUP_ABT_PER_1(
	GJMO,
	WUP_ID,
	MANDANT_ID,
	NB_ID,
	ABT_ID,
	ARTHIERTYP_ID,
	UMSATZ_NETTO_PLAN,
	UMSATZ_NETTO_PLAN_WRG,
	UMSATZ_NETTO_PLAN_KONZ
) as
   SELECT
   gjmo,
   wup_id,
   mandant_id,
   nb_id,
   abt_id,
   arthiertyp_id,
   umsatz_netto_plan,
   umsatz_netto_plan_wrg,
   umsatz_netto_plan_konz

  FROM dbp_view.v_wup_abt_per_1
  WHERE mandant_id = 1
  AND arthiertyp_id = 2
;