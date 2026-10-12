CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_PRODUKTIONSWOCHE
-- 23.04.12: twie Neue Berechnungslogik
(
pjwo
,akt_pjwo
,pjwo_vw
)
AS

   SELECT
   t1. pjwo, t1.akt_wo AS akt_pjwo, t3.pjwo as pjwo_vw
   FROM dbp_view.v_tag t1 --alle Datensaetze des heutigen Wochentages ausgeben, somit ein Datensatz pro Woche

   JOIN dbp_view.v_tag t2 --Wochentag des heutigen Datums ermitteln

   ON t1.wtag_id = t2.wtag_id
   AND  t2.akt_tag = 0
   JOIN dbp_view.v_tag t3 -- PJWO 7 Tage zuvor auslesen -> PJWO Vorwoche

   ON t1.dat = t3.dat+7;