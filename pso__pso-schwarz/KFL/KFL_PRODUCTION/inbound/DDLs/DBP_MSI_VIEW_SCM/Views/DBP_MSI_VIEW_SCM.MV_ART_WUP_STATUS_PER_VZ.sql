CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_WUP_STATUS_PER_VZ
--09.01.2019, aszu1204, adding aktuelle_listung_fg column
--28.02.2019, mcie1607, adding dat_loesch_id column
--05.07.2019. mcie1607, removing where nb=-111
--02.02.2020, baranowska, SPEC0070027, adding min_restlaufzeit
--22.07.2020, nwag2310, aktuelle listung = nicht in die Zukunft sondern vortagesaktuell --> Bugfix
--05.08.2020, baranowska, adding sollbestand
--11.11.2020, nwag2310, re-added  where nb=-111 for performance because mv_art_wup_status_per_markt is seperate
--06.04.2021, srom0404, AP0077805, SPEC0108204 - Lieferantenmanagement
--14.06.2021, cbru1709, AP0048550, SPEC0112564 - Umbennenung mit Suffix vz um klar zustellen auf welcher Ebene wir uns befinden.
--2025-02-25, nwag2310, switch to EXISTS
AS
SELECT
v01.art_id,
v01.dat_bis,
v01.dat_von,
v01.loesch_id,
v01.mandant_id,
v01.nb_id,
v01.wup_id,
v01.wg_verkett_id,
v01.fremd_lagerort_id,
v01.disponent_id,
v01.system_id,
v01.pps_plan_kalender_id,
v01.disposition_rhythmus_id,
v01.planlieferzeit,
v01.dispomerkmal,
v01.we_bearbeitungszeit,
v01.min_sicherh_bestand,
v01.anliefer_kalender,
v01.kdis,
v01.bezugsweg_id,
v01.terminierungsgruppe_1_id,
v01.terminierungsgruppe_2_id,
v01.terminierungsgruppe_3_id,
v01.sollbestand,
v01.dat_loesch_id,
--Coalesce(v02.aktuelle_listung_fg,0) aktuelle_listung_fg,
CASE WHEN EXISTS (SELECT 1
FROM DBP_VIEW.V_ART_LIST_WUP_ZU_PER V02
WHERE CURRENT_DATE-1 BETWEEN V02.DAT_VON AND V02.DAT_BIS
AND V01.MANDANT_ID=V02.MANDANT_ID
AND V01.WUP_ID=V02.WUP_ID
AND V01.ART_ID=V02.ART_ID) THEN 1 ELSE 0 END AS AKTUELLE_LISTUNG_FG,
v01.min_restlaufzeit,
v01.selbstabholung_fg
--,CASE WHEN v01.mandant_id = 4 AND v01.wup_id in (6100,9100) THEN 7 ELSE v01.mandant_id END AS mandant_id_vz --View ist nur VZ Ebene und deswegen gibt es kein Mandant 4 mit diesen Wup_ids. Kann gelöscht werden.
FROM dbp_view.v_art_wup_status_per v01
/*
LEFT JOIN (SELECT
mandant_id,
wup_id,
nb_id,
art_id,
1 AS aktuelle_listung_fg
FROM dbp_view.v_art_list_wup_zu_per
           WHERE CURRENT_DATE -1 BETWEEN dat_von AND dat_bis
GROUP BY mandant_id
      ,wup_id
      ,nb_id
      ,art_id
) v02 
ON v01.mandant_id = v02.mandant_id
AND v01.wup_id     = v02.wup_id
AND v01.art_id     = v02.art_id */
WHERE v01.dat_bis  = DATE '9999-12-31'
AND v01.nb_id = -111;