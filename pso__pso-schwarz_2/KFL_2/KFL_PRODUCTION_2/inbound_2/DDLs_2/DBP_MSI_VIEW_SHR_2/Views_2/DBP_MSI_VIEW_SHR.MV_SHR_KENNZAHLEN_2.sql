CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_SHR_KENNZAHLEN_2
-- 140123 - kkaiser beim join auf mv_l_ma_variable_2 raus, stattdessen join auf monat_2
-- 141014 - kkaiser join auf shr_datenfreigabe_2, Datum wird abgegriffen und in der VIEW abgebildet
-- 160112 - sschuecke #AP0003387 neue Felder hinzugefügt
-- 160317 - sschuecke #AP0003387 Feld . v01.anz_eintritt_extern_minus6 hinzugefügt
-- 160608 - kkaiser # Feld Anz_monate_gearbeitet hinzugefügt, weil in CZ eine_2 Zahl nicht stimmt.
-- 20160818 - kkaiser # 4 neue Feler bzgl. kumuliert auf GJ-Ebene #
--           (ueberstunden_quote_sdl_kum_gj,gesundheitsstand_sdl_kum_gj,verhaeltnis_teilzeit_sdl_kum_gj,teilzeit_anteil_gesamt_sdl_kum_gj)
-- 20160908 - kkaiser # 4 neue Feler wieder ausgebaut
--           (ueberstunden_quote_sdl_kum_gj,gesundheitsstand_sdl_kum_gj,verhaeltnis_teilzeit_sdl_kum_gj,teilzeit_anteil_gesamt_sdl_kum_gj)
-- 20160908 - kkaiser # 10 neue Feler bzgl. kumuliert auf GJ-Ebene #
--           (ueberstunden_kum_gj, arb_stunden_tag_kum_gj, soll_arbeitstage_kum_gj, krank_arbeitstage_kum_gj,
--            anz_stunden_mvst_kum_gj,  anz_teilzeit_kum_gj,  anspruch_urlaub_kum_gj, genommen_urlaub_kum_gj, anz_frau_kum_gj,
--            anz_frau_fuehrungskraft_kum_gj)
-- 20170505 - ttez1905 - Neue Spalte "anz_eintritt_extern_kum_minus6" aufgennommen
(
mandant_id
, kjmo
, hr_objekt_id
, anz_kopf_ist
, anz_kopf_vj
, anz_kopf_gjkum_ist
, anz_kopf_gjkum_vj
, anz_aller_koepfe_ist
, anz_aller_koepfe_ist_kum
, anz_aller_koepfe_vj_kum
, abr_stunden_mo_ist
, abr_stunden_mo_vj
, abwesenheit_tage_ist
, abwesenheit_tage_vj
, abwesenheit_tage_gjkum_ist
, abwesenheit_tage_gjkum_vj
, soll_stunden_mo_ist
, soll_stunden_mo_vj
, soll_stunden_mo_an_ist
, soll_stunden_mo_an_vj
, soll_stunden_mo_ag_ist
, soll_stunden_mo_ag_vj
, soll_stunden_mo_gjkum_ist
, soll_stunden_mo_gjkum_vj
, soll_stunden_mo_an_gjkum_ist
, soll_stunden_mo_an_gjkum_vj
, soll_stunden_mo_ag_gjkum_ist
, soll_stunden_mo_ag_gjkum_vj
, shr_freigabe_fg
, dat_freigabe_kennzahlen
, anz_austritt_extern_neu_kum
, anz_eintritt_extern_kum
, anz_kopf_sdl_kum_gj
, anz_kopf_sdl_kum
, anz_austritt_extern_kum_gj
, genommen_urlaub_kum_kj
, anz_eintritt_extern_minus6
, anz_austritt_extern_neu

, ueberstunden_kum_gj
, arb_stunden_tag_kum_gj
, soll_arbeitstage_kum_gj
, krank_arbeitstage_kum_gj
, anz_stunden_mvst_kum_gj
, anz_teilzeit_kum_gj
, anspruch_urlaub_kum_gj
, genommen_urlaub_kum_gj
, anz_frau_kum_gj
, anz_frau_fuehrungskraft_kum_gj
, anz_monate_gearbeitet
, anz_monate_gearbeitet_kum
--,anz_eintritt_extern_kum_minus6

)

AS
   SELECT
   v01.mandant_id, v01.kjmo, v01.hr_objekt_id, v01.anz_kopf_ist, v01.anz_kopf_vj, v01.anz_kopf_gjkum_ist, v01.anz_kopf_gjkum_vj, EXTRACT (DAY FROM v04.max_dat) * V01.anz_kopf_ist  AS anz_aller_koepfe_ist_, SUM(EXTRACT (DAY FROM v04.max_dat) * V01.anz_kopf_ist) OVER (PARTITION BY
   v02.gj, v01.mandant_id, v01.hr_objekt_id
   ORDER BY v01.kjmo
   ROWS UNBOUNDED PRECEDING) AS anz_aller_koepfe_ist_kum, SUM(EXTRACT (DAY FROM v05.max_dat) * V03.anz_kopf_ist) OVER (PARTITION BY
   v02.gj, v03.mandant_id, v03.hr_objekt_id
   ORDER BY v03.kjmo
   ROWS UNBOUNDED PRECEDING) AS anz_aller_koepfe_vj_kum, v01.abr_stunden_mo_ist, v01.abr_stunden_mo_vj, v01.abwesenheit_tage_ist, v01.abwesenheit_tage_vj, v01.abwesenheit_tage_gjkum_ist, v01.abwesenheit_tage_gjkum_vj, v01.soll_stunden_mo_ist, v01.soll_stunden_mo_vj, v01.soll_stunden_mo_an_ist, v01.soll_stunden_mo_an_vj, v01.soll_stunden_mo_ag_ist, v01.soll_stunden_mo_ag_vj, v01.soll_stunden_mo_gjkum_ist, v01.soll_stunden_mo_gjkum_vj, v01.soll_stunden_mo_an_gjkum_ist, v01.soll_stunden_mo_an_gjkum_vj, v01.soll_stunden_mo_ag_gjkum_ist, v01.soll_stunden_mo_ag_gjkum_vj, v01.shr_freigabe_fg, xx.dat_freigabe_kennzahlen, v01.anz_austritt_extern_neu_kum, v01.anz_eintritt_extern_kum, v01.anz_kopf_sdl_kum_gj, v01.anz_kopf_sdl_kum, v01.anz_austritt_extern_kum_gj, v01.genommen_urlaub_kum_kj, v01.anz_eintritt_extern_minus6, v01.anz_austritt_extern_neu, v01.ueberstunden_kum_gj, v01.arb_stunden_tag_kum_gj, v01.soll_arbeitstage_kum_gj, v01.krank_arbeitstage_kum_gj, v01.anz_stunden_mvst_kum_gj, v01.anz_teilzeit_kum_gj, v01.anspruch_urlaub_kum_gj, v01.genommen_urlaub_kum_gj, v01.anz_frau_kum_gj, v01.anz_frau_fuehrungskraft_kum_gj, CASE WHEN v01.soll_stunden_mo_ist > 0  THEN 1
   ELSE 0 END AS anz_monate_gearbeitet, SUM(anz_monate_gearbeitet) OVER (PARTITION BY
   v02.gj, v01.mandant_id, v01.hr_objekt_id
   ORDER BY v01.kjmo
   ROWS UNBOUNDED PRECEDING) AS anz_monate_gearbeitet_kum

   --,v01.anz_eintritt_extern_kum_minus6

   -- das GJ
   FROM
   dbp_view.v_monat_2 v02
   JOIN dbp_view.v_shr_kennzahlen_2 v01
   ON v01.kjmo = v02.kjmo
   AND v02.akt_gj <= 0
   LEFT JOIN dbp_view.v_shr_kennzahlen_2 v03
   ON v01.mandant_id   = v03.mandant_id
   AND v01.kjmo         = v03.kjmo + 100
   AND v01.hr_objekt_id = v03.hr_objekt_id

   -- Kalendertage Vorjahr GJ
   JOIN
   dbp_view.v_monat_2 v04
   ON v01.kjmo       = v04.kjmo
   LEFT OUTER JOIN dbp_view.v_monat_2 v05
   ON v03.kjmo        = v05.kjmo
   LEFT OUTER JOIN
   (SELECT
   mandant_id, kjmo, MAX(dat_freigabe_kennzahlen) AS dat_freigabe_kennzahlen
   FROM dbp_msi_v_view.v_shr_datenfreigabe_2

   GROUP BY 1,2) xx
   ON v01.kjmo        = xx.kjmo
   AND v01.mandant_id = xx.mandant_id;