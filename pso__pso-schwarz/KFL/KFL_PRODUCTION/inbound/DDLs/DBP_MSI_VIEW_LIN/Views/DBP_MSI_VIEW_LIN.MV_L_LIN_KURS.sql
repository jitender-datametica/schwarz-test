CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_L_LIN_KURS
-- nfis - SPEC0045159: Erweiterung where-clause um UWU
-- 03.02.2020, srom0404, AP0052703, SPEC0068452, Ersetzen des Kennzeichen UWL, durch EWL und GSL, UWU entfernen
(
 mandant_id
,lin_kurs_id
,lin_kursgruppe_id
,sortkz
,lin_bericht
)
AS
SELECT v01.mandant_id
      ,v01.lin_kurs_id
      ,v01.lin_kursgruppe_id
      ,v01.sortkz
   ,v01.lin_bericht
FROM dbp_view.v_l_lin_kurs v01
WHERE lin_bericht IN ('EWL', 'GSL')
   OR lin_bericht IS NULL;