CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_LIN_STICHTAG_1
-- 20151006 srom: Anpassung auf akt_mo_komplett (RITM0152517)
(
kjmo
)
AS
   SELECT kjmo
   FROM dbp_view.v_monat_1
   -- WHERE akt_mo BETWEEN -6 AND -1
   WHERE akt_mo_komplett BETWEEN -5 AND 0
   GROUP BY kjmo
;