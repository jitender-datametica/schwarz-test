CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_MONAT_1
-- 20151006 srom: Anpassung auf akt_mo_komplett (RITM0152517)
-- 20200305 agau: Anpassung auf akt_mo_komplett BETWEEN -3 AND 12 (RITM1275906)
(
mo_kj
,kj
,kjmo
,dat_von
,kjmo_order
,kjmo_vormonat
,akt_mo
,akt_mo_komplett
)
AS
   SELECT
   mo_kj, kj, kjmo, dat_von, Rank() Over (ORDER BY kjmo) AS kjmo_order, kjmo_vormonat, akt_mo, akt_mo_komplett
   FROM
   (
   SELECT v01.mo_kj, v01.kj, v01.kjmo, min_dat AS dat_von, Max(v01.kjmo) Over (ORDER BY v01.kjmo ROWS BETWEEN 1 Preceding AND 1 Preceding) AS kjmo_vormonat, v01.akt_mo, v01.akt_mo_komplett
   FROM dbp_view.v_monat_1 v01
   ) dt1
   -- WHERE dt1.akt_mo BETWEEN -12 AND -1
   --WHERE dt1.akt_mo_komplett BETWEEN -11 AND 0
   WHERE dt1.akt_mo_komplett BETWEEN -3 AND 12;