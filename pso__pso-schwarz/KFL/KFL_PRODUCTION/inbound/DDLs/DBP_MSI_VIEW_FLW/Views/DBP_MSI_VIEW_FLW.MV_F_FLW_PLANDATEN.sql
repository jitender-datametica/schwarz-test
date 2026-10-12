CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_PLANDATEN
(
gjmo,
kjmo,
wup_id,
nb_id,
mandant_id,
umsatz_anlieferung_plan,
rohertrag_anlieferung_plan,
abschrift_inventur_plan,
wrg_id
)
AS

   SELECT
   v01.gjmo,
   v02.kjmo,
   v01.wup_id,
   v01.nb_id,
   v01.mandant_id,
   v01.umsatz_anlieferung_plan,
   v01.rohertrag_anlieferung_plan,
   v01.abschrift_inventur_plan,
   v01.wrg_id

   FROM dbp_view.v_flw_plandaten v01
   join dbp_view.v_monat v02
   ON v01.gjmo = v02.gjmo;