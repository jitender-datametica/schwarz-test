CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_bauabschnitt_abgelaufen_BAU
(projekt_nr
,bauabschnitt_id
,bauabschnitt_abgelaufen_kz
)
AS
SELECT
projekt_nr
,bauabschnitt_id
,bauabschnitt_abgelaufen_kz
FROM
(SELECT
abg.projekt_nr
,CASE WHEN abg.projekt_phase_id IS NOT NULL
THEN abg.projekt_id || '0000'
END  bauabschnitt_id
,MIN(abg.bauabschnitt_abgelaufen_kz) AS bauabschnitt_abgelaufen_kz
FROM   dbp_msi_view_ios.mv_bauabschnitt_abgelaufen abg

GROUP BY 1,2) xx
;

