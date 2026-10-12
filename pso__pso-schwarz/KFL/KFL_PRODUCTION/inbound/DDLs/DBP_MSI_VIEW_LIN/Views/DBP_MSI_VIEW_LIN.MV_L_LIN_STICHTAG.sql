CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_L_LIN_STICHTAG
-- 20151006 srom: Anpassung auf akt_mo_komplett (RITM0152517)
(
kjmo
)
AS
   SELECT kjmo
   FROM dbp_view.v_monat
   --WHERE akt_mo BETWEEN -12 AND -1
   WHERE akt_mo_komplett BETWEEN -11 AND 0
   GROUP BY kjmo
;