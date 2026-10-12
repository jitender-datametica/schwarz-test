CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WOCHE_1
(
kjwo
,gjwo
,kjwovj
,gjwovj
,kjwovvj
,gjwovvj
,wo_dat_von
,wo_dat_bis
,akt_wo
,akt_wo_komplett
,akt_wo_kalendarisch
)
AS
   SELECT
   kjwo, gjwo, kjwo - 100, gjwo - 100, kjwo - 200, gjwo - 200, wo_dat_von, wo_dat_bis, akt_wo, akt_wo_komplett, akt_wo_kalendarisch
   FROM dbp_view.v_woche_1
   WHERE kjwo > 200449
;