CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_projekt_bauabschnitt
-- kkai0912 20160921  - Bezeichnung Testversion herausgenommen
(
mandant_id
,projekt_nr
,techn_platz_id
,projekt_nr_endung
,projekt_id
,sort_projekt_id
,projekt_phase_id
,teil_massnahme_id
,einzel_massnahme
,cpr_aufgabe_id
,cpr_suchfeld_id
,aufgabenart_id
,teil_massn_fg
,cpr_projekt_bez_sort
,bauabschnitt_gj
,projekt_status1
,projekt_status2
,projekt_status3
,phase_status1
,phase_status2
,phase_status3
,cpr_phase_version_id
,cpr_phase_version_dat
,bauabschnitt_id
,bauabschnitt_nr
,bauabschnitt_nr_lfd
,bauabschnitt_abgelaufen_fg
,bauabschnitt_bez
,bauabschnitt_langtext
)
AS
(
SELECT
v01.mandant_id
, v01.cpr_ext_id AS projekt_nr
, v01.techn_platz_id
,SUBSTRING (v01.cpr_ext_id, 14, 2) AS projekt_nr_endung
, v01.projekt_id
, v01.projekt_id AS sort_projekt_id
, v02.projekt_phase_id
, v02.teil_massnahme_id
, COALESCE( v02.einzel_massnahme, ' ') AS einzel_massnahme
, v03.cpr_aufgabe_id
, v03.cpr_suchfeld_id
, v03.aufgabenart_id
, v02.teil_massn_kz AS teil_massn_fg
, v04.cpr_projekt_bez AS cpr_projekt_bez_sort
, cll.bauabschnitt_gj
, v01.cpr_systemstatus1_id AS projekt_status1
, v01.cpr_systemstatus2_id AS projekt_status2
, v01.cpr_systemstatus3_id AS projekt_status3
, v02.cpr_systemstatus1_id AS phase_status1
, v02.cpr_systemstatus2_id AS phase_status2
, v02.cpr_systemstatus3_id AS phase_status3
, v02.cpr_phase_version_id
, v02.cpr_phase_version_dat

, CASE
/* WHEN v03.cpr_suchfeld_id = 161
--AND v03.aufgabenart_id IN ('A2', 'Z1')
THEN v02.projekt_id || v03.cpr_aufgabe_id*/
WHEN  v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
THEN v02.projekt_id || v02.projekt_phase_id
ELSE v02.projekt_id || '0000'
END  AS bauabschnitt_id
,SUBSTRING(bauabschnitt_id, 33, 4)  bauabschnitt_nr
,SUBSTRING(bauabschnitt_id, 33, 4)  bauabschnitt_nr_lfd

,CASE WHEN bauabschnitt_id = (v02.projekt_id || '0000' )
THEN COALESCE(v07.bauabschnitt_abgelaufen_fg,1)
ELSE COALESCE(v07.bauabschnitt_abgelaufen_fg, cll.bauabschnitt_abgelaufen_fg,0)
END AS bauabschnitt_abgelaufen_fg


, COALESCE(CASE
/* WHEN v03.cpr_suchfeld_id = 161 AND v03.aufgabenart_id IN ('A2', 'Z1') THEN
v06.aufgabe_bez*/
WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
THEN
v05.cpr_phase_bez
ELSE v04.cpr_projekt_bez
END, ' ')
AS bauabschnitt_bez
, COALESCE(CASE
/* WHEN v03.cpr_suchfeld_id = 161 AND v03.aufgabenart_id IN ('A2', 'Z1') THEN
v06.aufgabe_langtext*/
WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
THEN v05.cpr_phase_langtext
ELSE v04.cpr_projekt_langtext
END, ' ')
AS bauabschnitt_langtext

FROM dbp_view.v_cpr_projekt_per v01

JOIN dbp_view.v_cpr_phase_per  v02
ON v01.projekt_id = v02.projekt_id
AND v02.dat_bis = '9999-12-31'

LEFT JOIN dbp_view.v_cpr_aufgabe_per v03
ON v02.projekt_phase_id = v03.projekt_phase_id
AND v03.dat_bis = '9999-12-31'

LEFT JOIN
(
SELECT
ph.projekt_id
, ph.projekt_phase_id
, CASE WHEN (cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND cl.dat_termin + 30 <=  current_DATE() AND cl.dat_termin IS NOT NULL)
OR  ph.cpr_systemstatus2_id = 1 THEN 1 ELSE 0 END AS bauabschnitt_abgelaufen_fg

, CASE WHEN (cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND cl.dat_termin IS NOT NULL)
THEN  SUBSTRING(cl.dat_termin, 1, 4)
WHEN (cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND cl.dat_termin IS NULL) THEN 9999
END AS bauabschnitt_gj

FROM dbp_msi_view_ios.mv_cpr_cl_punkt cl
JOIN dbp_view.v_cpr_phase_per ph
ON  ph.projekt_phase_id = cl.projekt_phase_id

JOIN dbp_view.v_cpr_aufgabe_per au
ON  ph.projekt_phase_id = au.projekt_phase_id

AND ph.dat_bis = '9999-12-31'

AND cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'
GROUP BY 1,2,3,4
) cll
ON v02.projekt_phase_id = cll.projekt_phase_id


--LEFT OUTER ==> Es gibt Projekte ohne Tabelleninhalte
LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per v04
ON v01.projekt_id = v04.projekt_id
AND v04.dat_bis = '9999-12-31'
AND v04.spr_id = 22

--LEFT OUTER ==> Es gibt Phasen ohne Tabelleninhalte
LEFT JOIN dbp_view.v_cpr_phase_spr_zu_per v05
ON v02.projekt_phase_id = v05.projekt_phase_id
AND v05.dat_bis = '9999-12-31'
AND v05.spr_id = 22

--hier muss ein LEFT rein (kkai0912 160921)
LEFT JOIN dbp_view.v_cpr_aufgabe_spr_zu_per v06
ON v03.cpr_aufgabe_id = v06.cpr_aufgabe_id
AND v06.dat_bis = '9999-12-31'
AND v06.spr_id = 22


LEFT JOIN dbp_msi_view_ios.mv_bauabschnitt v07
ON  v07.projekt_nr       = v01.cpr_ext_id
AND v07.projekt_id       = v01.projekt_id
AND v07.bauabschnitt_id_  = v02.projekt_id || '0000'

WHERE v01.dat_bis = '9999-12-31'
);