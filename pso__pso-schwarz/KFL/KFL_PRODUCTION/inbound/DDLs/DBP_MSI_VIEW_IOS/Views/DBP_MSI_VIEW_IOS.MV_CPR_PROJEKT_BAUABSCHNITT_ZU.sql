CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_PROJEKT_BAUABSCHNITT_ZU
(
--20170418 hmue2308: Redesign IOS
--AP0004982, SPEC0020558

--20170507 hmue2308:
--cpr_systemstatus1_id INNER JOIN hinzugefüGT und geändert;  cpr_systemstatus1_prj_id und cpr_systemstatus1_bauab_id hinzugefügt
-- SPEC0030509: Internationalisierung, Auskommentieren ausgelagter Felder

projekt_id,
projekt_nr,
cpr_ext_id,
/* cpr_projekt_bez,*/
--cpr_systemstatus1_id,
cpr_systemstatus1_prj_id,
cpr_systemstatus1_bauab_id,
dat_eroeffnung_projekt,
bauabschnitt_id,
/* bauabschnitt_bez,*/
sort_id,
projekt_unter_id,
cpr_suchfeld_id,
/* suchfeld_bez,*/
dat_start_ist,
dat_ende_ist,
dat_start_vorhersage,
dat_ende_vorhersage,
dat_start_einschraenkung,
dat_ende_einschraenkung,
dat_start_ips,
dat_ende_ips,
projekt_existiert_vor_14tage_fg,
dat_start_ist_minus_14,
dat_ende_ist_minus_14,
dat_start_vorhersage_minus_14,
dat_ende_vorhersage_minus_14,
dat_start_einschraenkung_minus_14,
dat_ende_einschraenkung_minus_14,
dat_start_ips_minus_14,
dat_ende_ips_minus_14,
mandant_kbez,
gj,mandant_id
)
AS

   SELECT
   v01.projekt_id,
   v01.cpr_ext_id AS projekt_nr,
   v01.cpr_ext_id,
   /* v02.cpr_projekt_bez,*/
   --v03.cpr_systemstatus1_id,
   v01.cpr_systemstatus1_prj_id,
   v01.cpr_systemstatus1_bauab_id,
   v01.dat_eroeffnung_projekt,
   CAST( v01.bauabschnitt_id AS VARCHAR(64))  AS bauabschnitt_id,
   /* sub01.bauabschnitt_bez, */
   v01.sort_id,
   v01.projekt_unter_id,
   v01.cpr_suchfeld_id,
   /* v04.suchfeld_bez,*/

   CASE
   WHEN v01.dat_start_ist >'1900-01-01'
   THEN v01.dat_start_ist
   ELSE NULL
   END, CASE
   WHEN v01.dat_ende_ist>'1900-01-01'
   THEN v01.dat_ende_ist
   ELSE NULL
   END, CASE
   WHEN v01.dat_start_vorhersage >'1900-01-01'
   THEN v01.dat_start_vorhersage
   ELSE NULL
   END, CASE
   WHEN v01.dat_ende_vorhersage>'1900-01-01'
   THEN v01.dat_ende_vorhersage
   ELSE NULL
   END, CASE
   WHEN v01.dat_start_einschraenkung >'1900-01-01'
   THEN v01.dat_start_einschraenkung
   ELSE NULL
   END, CASE
   WHEN v01.dat_ende_einschraenkung>'1900-01-01'
   THEN v01.dat_ende_einschraenkung
   ELSE NULL
   END, CASE
   WHEN v01.dat_start_ist > '1900-01-01'
   THEN v01.dat_start_ist
   WHEN v01.dat_start_vorhersage > '1900-01-01'
   THEN v01.dat_start_vorhersage
   WHEN v01.dat_start_einschraenkung >'1900-01-01'
   THEN v01.dat_start_einschraenkung
   ELSE NULL
   END AS dat_start_ips, CASE
   WHEN v01.dat_ende_ist>'1900-01-01'
   THEN v01.dat_ende_ist
   WHEN v01.dat_ende_vorhersage>'1900-01-01'
   THEN v01.dat_ende_vorhersage
   WHEN v01.dat_ende_einschraenkung>'1900-01-01'
   THEN v01.dat_ende_einschraenkung
   ELSE NULL
   END AS dat_ende_ips, v01.projekt_existiert_vor_14tage_fg -- Flag
   , CASE
   WHEN v01.dat_start_ist_minus_14 >'1900-01-01'
   THEN v01.dat_start_ist_minus_14
   ELSE NULL
   END, CASE
   WHEN v01.dat_ende_ist_minus_14 >'1900-01-01'
   THEN v01.dat_ende_ist_minus_14
   ELSE NULL
   END, CASE
   WHEN v01.dat_start_vorhersage_minus_14 >'1900-01-01'
   THEN v01.dat_start_vorhersage_minus_14
   ELSE NULL
   END, CASE
   WHEN v01.dat_ende_vorhersage_minus_14 >'1900-01-01'
   THEN v01.dat_ende_vorhersage_minus_14
   ELSE NULL
   END, CASE
   WHEN v01.dat_start_einschraenkung_minus_14 >'1900-01-01'
   THEN v01.dat_start_einschraenkung_minus_14
   ELSE NULL
   END, CASE
   WHEN v01.dat_ende_einschraenkung_minus_14 >'1900-01-01'
   THEN v01.dat_ende_einschraenkung_minus_14
   ELSE NULL
   END, CASE
   WHEN v01.dat_start_ist_minus_14 > '1900-01-01'
   THEN v01.dat_start_ist_minus_14
   WHEN v01.dat_start_vorhersage_minus_14 > '1900-01-01'
   THEN v01.dat_start_vorhersage_minus_14
   WHEN v01.dat_start_einschraenkung_minus_14 >'1900-01-01'
   THEN v01.dat_start_einschraenkung_minus_14
   ELSE NULL
   END AS dat_start_ips_minus_14, CASE
   WHEN v01.dat_ende_ist_minus_14 > '1900-01-01'
   THEN v01.dat_ende_ist_minus_14
   WHEN v01.dat_ende_vorhersage_minus_14 > '1900-01-01'
   THEN v01.dat_ende_vorhersage_minus_14
   WHEN v01.dat_ende_einschraenkung_minus_14 >'1900-01-01'
   THEN v01.dat_ende_einschraenkung_minus_14
   ELSE NULL
   END AS dat_ende_ips_minus_14, SUBSTRING(v01.cpr_ext_id, 1, 2)  AS mandant_kbez, CASE
   WHEN v01.dat_eroeffnung_projekt = '1900-01-01' OR v01.dat_eroeffnung_projekt  IS NULL
   THEN 9999
   ELSE v05.gj
   END AS gj, v99.mandant_id

   FROM dbp_view.v_cpr_projekt_bauabschnitt_zu v01 --SELECT-Ende

   LEFT JOIN dbp_view.v_tag v05
   ON v01.dat_eroeffnung_projekt = v05.dat
   INNER JOIN dbp_view.v_cpr_projekt_per v99
   ON v01.projekt_id = v99.projekt_id
   AND v99.dat_bis = '9999-12-31'



   /*INNER JOIN  -- BauabschnittBezeichnung von Allen Projekten, Phasen und Aufgaben
   (
   SELECT v05.projekt_id AS bauabschnitt_id, v05.cpr_projekt_bez AS bauabschnitt_bez
   FROM dbp_view.v_cpr_projekt_spr_zu_per v05
   JOIN dbp_view.v_cpr_projekt_bauabschnitt_zu v01
   ON v05.projekt_id = v01.projekt_id
   WHERE v05.dat_bis = 80991231
   AND v05.spr_id = 22

   UNION

   SELECT v06.projekt_phase_id AS bauabschnitt_id, v06.cpr_phase_bez AS bauabschnitt_bez
   FROM dbp_view.v_cpr_phase_spr_zu_per v06
   JOIN dbp_view.v_cpr_projekt_bauabschnitt_zu v01
   ON v06.projekt_phase_id = v01.bauabschnitt_id
   WHERE v06.dat_bis = 80991231
   AND v06.spr_id = 22

   UNION

   SELECT v07.cpr_aufgabe_id AS bauabschnitt_id, v07.aufgabe_bez AS bauabschnitt_bez
   FROM dbp_view.v_cpr_aufgabe_spr_zu_per v07
   JOIN dbp_view.v_cpr_projekt_bauabschnitt_zu v01
   ON v07.cpr_aufgabe_id = v01.bauabschnitt_id
   WHERE v07.dat_bis = 80991231
   AND v07.spr_id = 22
   ) sub01
   ON sub01.bauabschnitt_id = v01.bauabschnitt_id;*/
   ;