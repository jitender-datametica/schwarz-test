CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_WOCHE
-- 02.11.2011 AL & TW akt_wo Definition angepasst kalendarisch
-- 15.09.2015 twie: Bezeichnung fuer Werbewoche
(
gjwo
,gjwo_vj
,kjwo
,kjwo_vj
,wo_dat_von
,wo_dat_bis
,akt_wo
,akt_wo_komplett
,ww_bez

)
AS
   SELECT gjwo, gjwo_vj, kjwo, kjwo_vj, wo_dat_von, wo_dat_bis, akt_wo_komplett  - 1  akt_wo, akt_wo_komplett, 'WW' || CAST(kjwo AS VARCHAR(6)) AS ww_bez

   FROM dbp_view.v_woche;