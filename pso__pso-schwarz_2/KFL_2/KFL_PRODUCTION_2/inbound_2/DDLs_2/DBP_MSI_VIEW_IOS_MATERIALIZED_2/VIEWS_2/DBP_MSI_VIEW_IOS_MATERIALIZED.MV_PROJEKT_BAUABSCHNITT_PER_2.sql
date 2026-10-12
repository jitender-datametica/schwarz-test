create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_PROJEKT_BAUABSCHNITT_PER_2(
	MANDANT_ID,
	PROJEKT_NR,
	TECHN_PLATZ_ID,
	PROJEKT_NR_ENDUNG,
	PROJEKT_ID,
	SORT_PROJEKT_ID,
	PROJEKT_PHASE_ID,
	TEIL_MASSNAHME_ID,
	EINZEL_MASSNAHME,
	CPR_AUFGABE_ID,
	CPR_SUCHFELD_ID,
	AUFGABENART_ID,
	TEIL_MASSN_FG,
	CPR_PROJEKT_BEZ_SORT,
	BAUABSCHNITT_GJ,
	PROJEKT_STATUS1,
	PROJEKT_STATUS2,
	PROJEKT_STATUS3,
	PHASE_STATUS1,
	PHASE_STATUS2,
	PHASE_STATUS3,
	CPR_PHASE_VERSION_ID,
	CPR_PHASE_VERSION_DAT,
	BAUABSCHNITT_ID,
	BAUABSCHNITT_NR,
	BAUABSCHNITT_ABGELAUFEN_FG,
	BAUABSCHNITT_BEZ,
	BAUABSCHNITT_LANGTEXT,
	DAT_VON,
	DAT_BIS
) as
(
SELECT
v01.mandant_id
, v01.cpr_ext_id AS projekt_nr
, v01.techn_platz_id
,SUBSTRING (v01.cpr_ext_id , 14, 2) AS projekt_nr_endung
, v01.projekt_id
, v01.projekt_id AS sort_projekt_id
, v02.projekt_phase_id
, v02.teil_massnahme_id
, v02.einzel_massnahme
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
--WHEN v03.cpr_suchfeld_id = 161 AND v03.aufgabenart_id IN ('A2', 'Z1')  THEN
--v02.projekt_id || v03.cpr_aufgabe_id
WHEN  v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
THEN v02.projekt_id || v02.projekt_phase_id
ELSE v02.projekt_id || '0000'
END  AS bauabschnitt_id
,SUBSTRING(bauabschnitt_id, 33, 4)  bauabschnitt_nr

,CASE WHEN bauabschnitt_id = (v02.projekt_id || '0000' )
THEN COALESCE(KK.bauabschnitt_abgelaufen_fg,1)
ELSE COALESCE(KK.bauabschnitt_abgelaufen_fg, cll.bauabschnitt_abgelaufen_fg,0)
END AS bauabschnitt_abgelaufen_fg


, COALESCE(CASE
--WHEN v03.cpr_suchfeld_id = 161 AND v03.aufgabenart_id IN ('A2', 'Z1') THEN
--v06.aufgabe_bez
WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
THEN v05.cpr_phase_bez
ELSE v04.cpr_projekt_bez
END, ' ')
AS bauabschnitt_bez
, COALESCE(CASE
--WHEN v03.cpr_suchfeld_id = 161 AND v03.aufgabenart_id IN ('A2', 'Z1') THEN
--v06.aufgabe_langtext
WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
THEN v05.cpr_phase_langtext
ELSE v04.cpr_projekt_langtext
END, ' ')
AS bauabschnitt_langtext
, v99.dat  AS dat_von
,CASE WHEN v99.dat = CURRENT_DATE() THEN TO_DATE('9999-12-31') ELSE v99.dat  END AS dat_bis

FROM dbp_view.v_cpr_projekt_per_2 v01

JOIN dbp_view.v_cpr_phase_per_2  v02
ON v01.projekt_id = v02.projekt_id

JOIN dbp_view.v_cpr_aufgabe_per_2 v03
ON v02.projekt_phase_id = v03.projekt_phase_id

JOIN dbp_view.v_tag_2 v99
ON  v99.dat <= CURRENT_DATE()
AND v99.dat BETWEEN CURRENT_DATE() - 14 AND CURRENT_DATE()

AND v99.dat BETWEEN v02.dat_von AND v02.dat_bis
AND v99.dat BETWEEN v01.dat_von AND v01.dat_bis
AND v99.dat BETWEEN v03.dat_von AND v03.dat_bis

LEFT JOIN
(
SELECT
ph.projekt_id
, ph.projekt_phase_id
, CASE WHEN (cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND cl.dat_termin + 30 <=  CURRENT_DATE() AND cl.dat_termin IS NOT NULL)
OR  ph.cpr_systemstatus2_id = 1 THEN 1 ELSE 0 END AS bauabschnitt_abgelaufen_fg

, CASE WHEN (cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND cl.dat_termin IS NOT NULL)
THEN  SUBSTRING(cl.dat_termin , 1, 4)
WHEN (cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG' AND cl.dat_termin IS NULL) THEN 9999
END AS bauabschnitt_gj

FROM KFL_PRODUCTION.DBP_MSI_VIEW_IOS_MATERIALIZED.mv_cpr_cl_punkt_2 cl
JOIN dbp_view.v_cpr_phase_per_2 ph
ON  ph.projekt_phase_id = cl.projekt_phase_id
AND cl.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'

JOIN dbp_view.v_cpr_aufgabe_per_2 au
ON  ph.projekt_phase_id = au.projekt_phase_id

JOIN dbp_view.v_tag_2 v99
ON  v99.dat <= CURRENT_DATE()
AND v99.dat BETWEEN CURRENT_DATE() - 14 AND CURRENT_DATE()

AND v99.dat BETWEEN au.dat_von AND au.dat_bis


GROUP BY 1,2,3,4
) cll
ON v02.projekt_phase_id = cll.projekt_phase_id


--LEFT OUTER ==> Es gibt Projekte ohne Tabelleninhalte
LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per_2 v04
ON v01.projekt_id = v04.projekt_id
AND v04.dat_bis = '9999-12-31'
AND v04.spr_id = 22

--LEFT OUTER ==> Es gibt Phasen ohne Tabelleninhalte
LEFT JOIN dbp_view.v_cpr_phase_spr_zu_per_2 v05
ON v02.projekt_phase_id = v05.projekt_phase_id
AND v05.dat_bis = '9999-12-31'
AND v05.spr_id = 22

--hier muss ein LEFT rein (kkai0912 160921)
LEFT JOIN dbp_view.v_cpr_aufgabe_spr_zu_per_2 v06
ON v03.cpr_aufgabe_id = v06.cpr_aufgabe_id
AND v06.dat_bis = '9999-12-31'
AND v06.spr_id = 22


LEFT JOIN KFL_PRODUCTION.DBP_MSI_VIEW_IOS_MATERIALIZED.mv_bauabschnitt_2 KK
ON  KK.projekt_nr       = v01.cpr_ext_id
AND KK.projekt_id       = v01.projekt_id
--AND KK.bauabschnitt_id  = bauabschnitt_id
AND KK.bauabschnitt_id_  = v02.projekt_id || '0000'



--WHERE v01.dat_bis = '9999-12-31'
);