CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_MONATSABSCHLUSS_SPR_ZU_CZ_1
-- 04.12.2014 twie: Anzeige letzter freigegebener Monat_1
--27.02.2014 twie: mit DATE-1 erst 2 Tage nach Buchungsschluss die neuen Daten anzeigen
--  weil Cube schon abends aufgebaut, somit 1 Tag_1 danach noch alte Daten
--  synchron halten mit MSI Filter Monatsabschluss CO

AS
SELECT

v01.kj_ker_mo_id AS kjmo_abschluss
, CAST(TRIM(v03.mo_bez) || ' ' || TRIM(v02.kj) AS VARCHAR(40)) AS mo_bez_lang

FROM
(
SELECT
MAX(kj_ker_mo_id) AS kj_ker_mo_id
FROM dbp_view.v_l_buchungsstatus_ker_1 v01
WHERE dat_buchungs_schluss < CURRENT_DATE - 1
) v01

INNER JOIN dbp_view.v_monat_1 v02
ON v01.kj_ker_mo_id = v02.kjmo

INNER JOIN dbp_view.v_monat_spr_zu_1  v03
ON v02.mo_kj = v03.mo_id
AND v03.spr_id = 124
;