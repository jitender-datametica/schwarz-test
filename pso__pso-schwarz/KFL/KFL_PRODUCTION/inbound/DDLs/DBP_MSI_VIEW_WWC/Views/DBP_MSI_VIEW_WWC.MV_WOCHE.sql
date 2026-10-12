CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WOCHE -- AP0002977, srom0404, 18.08.2016, Einschränkung auf Zeitraum akt_kj analog Monatsview
--            geht nur über Atgeskalender, da akt_kj nicht in Wochentabelle vorhanden
-- 01.04.2020 NSR0505888, srom0404, telefonische Anforderung Fachbereich, anpassen akt_kj BETWEEN -3 AND 3 (vorher BETWEEN -2 AND 0)
-- 10.02.2021 SPEC0097989 richternic, VVJ Felder mit aufnehmen
(
  gjwo,
  gjwo_vj,
  kjwo,
  kjwo_vj,
  kjwo_vvj,
  wo_dat_von,
  wo_dat_bis,
  akt_wo,
  akt_wo_komplett
) AS
SELECT
  v01.gjwo,
  v01.gjwo_vj,
  v01.kjwo,
  v01.kjwo_vj,
  v01.kjwo_vvj,
  v01.wo_dat_von,
  v01.wo_dat_bis,
  v01.akt_wo,
  v01.akt_wo_komplett
FROM
  dbp_view.v_woche v01
  INNER JOIN dbp_view.v_tag v02 ON v01.kjwo = v02.kjwo
WHERE
  v02.akt_kj BETWEEN -3
  AND 3
GROUP BY
  v01.gjwo,
  v01.gjwo_vj,
  v01.kjwo,
  v01.kjwo_vj,
  v01.kjwo_vvj,
  v01.wo_dat_von,
  v01.wo_dat_bis,
  v01.akt_wo,
  v01.akt_wo_komplett;