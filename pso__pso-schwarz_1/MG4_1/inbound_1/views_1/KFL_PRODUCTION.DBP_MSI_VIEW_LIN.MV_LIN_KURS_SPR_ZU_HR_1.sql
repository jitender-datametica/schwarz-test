create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_LIN_KURS_SPR_ZU_HR_1(
	MANDANT_ID,
	LIN_KURS_ID,
	LIN_KURS_BEZ,
	MANDANT_KBEZ
) as
-- 03.02.2020 srom0404, AP0052703, SPEC0068452, Ersetzen des Kennzeichen UWL, durch EWL und GSL, UWU entfernen 
-- 18.03.2024 twie: SPEC0233542 lin_bericht in Join aufgenommen, da Teil des Schlüssels

SELECT v1.mandant_id
      ,v1.lin_kurs_id
      ,v2.lin_kurs_bez
      ,v3.mandant_kbez
FROM dbp_view.v_l_lin_kurs_1 v1
INNER JOIN dbp_view.v_lin_kurs_spr_zu_1 v2
   ON v1.lin_kurs_id = v2.lin_kurs_id  --AND v1.mandant_id = v2.mandant_id
   AND v1.lin_bericht = v2.lin_bericht 
INNER JOIN dbp_view.v_mandant_1 v3
   ON v1.mandant_id = v3.mandant_id
WHERE v2.spr_id = 65
  AND (v1.lin_bericht IN ('EWL', 'GSL')
   OR v1.lin_bericht IS NULL)
GROUP BY v1.mandant_id
        ,v1.lin_kurs_id
        ,v2.lin_kurs_bez
        ,v3.mandant_kbez;