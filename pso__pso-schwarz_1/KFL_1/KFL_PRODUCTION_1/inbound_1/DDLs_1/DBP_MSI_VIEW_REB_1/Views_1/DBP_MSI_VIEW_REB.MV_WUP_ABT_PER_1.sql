CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WUP_ABT_PER_1
(
gjmo
, wup_id
, mandant_id
, nb_id
, abt_id
, arthiertyp_id
, umsatz_netto_plan
, umsatz_netto_plan_wrg
, umsatz_netto_plan_konz
)
AS
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