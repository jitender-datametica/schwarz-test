CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_bauabschnitt
-- kkai0912 20160921  - Bezeichnung Testversion herausgenommen
AS
(
SELECT DISTINCT

projekt_nr
, projekt_id
, MIN(bauabschnitt_abgelaufen_fg) AS bauabschnitt_abgelaufen_fg
, bauabschnitt_id_
FROM
(SELECT DISTINCT
v01.cpr_ext_id AS projekt_nr
, v01.projekt_id
, v02.projekt_phase_id
--, v03.cpr_aufgabe_id
--, v03.aufgabenart_id
--, v02.teil_massn_kz
, COALESCE(cll.bauabschnitt_abgelaufen_fg,0) AS bauabschnitt_abgelaufen_fg
--, MIN(cll.bauabschnitt_abgelaufen_fg) AS bauabschnitt_abgelaufen_fg
, CASE
--WHEN v03.cpr_suchfeld_id = 161
--AND v03.aufgabenart_id IN ('A2', 'Z1')
--THEN v02.projekt_id || v03.cpr_aufgabe_id
WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1 THEN
v02.projekt_id || v02.projekt_phase_id
ELSE v02.projekt_id || '0000'
END
AS bauabschnitt_id_

FROM dbp_view.v_cpr_projekt_per v01

JOIN dbp_view.v_cpr_phase_per  v02
ON v01.projekt_id = v02.projekt_id
AND v02.dat_bis = '9999-12-31'
AND v01.cpr_systemstatus1_id = 2

JOIN dbp_view.v_cpr_aufgabe_per v03
ON v02.projekt_phase_id = v03.projekt_phase_id
AND v03.dat_bis = '9999-12-31'

JOIN dbp_msi_view_ios.mv_projekt_fg ufg
ON  (v01.projekt_id = ufg.projekt_id)
AND ufg.ist_aufnahme_technik_fg < 1

LEFT JOIN
(
SELECT
ph.projekt_id
, ph.projekt_phase_id
, CASE WHEN (cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND cl.dat_termin + 30 <=  current_DATE() AND cl.dat_termin IS NOT NULL)
OR  ph.cpr_systemstatus2_id = 1 THEN 1 ELSE 0 END AS bauabschnitt_abgelaufen_fg
FROM dbp_msi_view_ios.mv_cpr_cl_punkt cl
JOIN dbp_view.v_cpr_phase_per ph
ON  ph.projekt_phase_id = cl.projekt_phase_id

JOIN dbp_view.v_cpr_aufgabe_per au
ON  ph.projekt_phase_id = au.projekt_phase_id

AND ph.dat_bis = '9999-12-31'

AND cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'
GROUP BY 1,2,3
) cll
ON v02.projekt_phase_id = cll.projekt_phase_id

WHERE v01.dat_bis = '9999-12-31'
--group by 1,2,3,5
) ALLES
GROUP BY
1,2,4
);