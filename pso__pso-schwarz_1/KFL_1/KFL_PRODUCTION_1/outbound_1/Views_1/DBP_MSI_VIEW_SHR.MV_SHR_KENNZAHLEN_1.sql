CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_shr_kennzahlen_1 (mandant_id, kjmo, hr_objekt_id, anz_kopf_ist,
anz_kopf_vj, anz_kopf_gjkum_ist, anz_kopf_gjkum_vj, anz_aller_koepfe_ist, anz_aller_koepfe_ist_kum,
anz_aller_koepfe_vj_kum, abr_stunden_mo_ist, abr_stunden_mo_vj, abwesenheit_tage_ist, abwesenheit_tage_vj,
abwesenheit_tage_gjkum_ist, abwesenheit_tage_gjkum_vj, soll_stunden_mo_ist, soll_stunden_mo_vj, soll_stunden_mo_an_ist,
soll_stunden_mo_an_vj, soll_stunden_mo_ag_ist, soll_stunden_mo_ag_vj, soll_stunden_mo_gjkum_ist,
soll_stunden_mo_gjkum_vj, soll_stunden_mo_an_gjkum_ist, soll_stunden_mo_an_gjkum_vj, soll_stunden_mo_ag_gjkum_ist,
soll_stunden_mo_ag_gjkum_vj, shr_freigabe_fg, dat_freigabe_kennzahlen, anz_austritt_extern_neu_kum,
anz_eintritt_extern_kum, anz_kopf_sdl_kum_gj, anz_kopf_sdl_kum, anz_austritt_extern_kum_gj, genommen_urlaub_kum_kj,
anz_eintritt_extern_minus6, anz_austritt_extern_neu, ueberstunden_kum_gj, arb_stunden_tag_kum_gj,
soll_arbeitstage_kum_gj, krank_arbeitstage_kum_gj, anz_stunden_mvst_kum_gj, anz_teilzeit_kum_gj, anspruch_urlaub_kum_gj
, genommen_urlaub_kum_gj, anz_frau_kum_gj, anz_frau_fuehrungskraft_kum_gj, anz_monate_gearbeitet,
anz_monate_gearbeitet_kum) AS SELECT V01.mandant_id,
 V01.kjmo,
 V01.hr_objekt_id,
 V01.anz_kopf_ist,
 V01.anz_kopf_vj,
 V01.anz_kopf_gjkum_ist,
 V01.anz_kopf_gjkum_vj,
  EXTRACT(DAY FROM V04.max_dat) * V01.anz_kopf_ist AS anz_aller_koepfe_ist_,
 SUM(EXTRACT(DAY FROM V04.max_dat) * V01.anz_kopf_ist) OVER (PARTITION BY V02.gj, CAST(V01.mandant_id AS STRING), V01.hr_objekt_id
    ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS anz_aller_koepfe_ist_kum,
 SUM(EXTRACT(DAY FROM V05.max_dat) * V03.anz_kopf_ist) OVER (PARTITION BY V02.gj, CAST(V03.mandant_id AS STRING), V03.hr_objekt_id
    ORDER BY V03.kjmo IS NULL, V03.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS anz_aller_koepfe_vj_kum,
 V01.abr_stunden_mo_ist,
 V01.abr_stunden_mo_vj,
 V01.abwesenheit_tage_ist,
 V01.abwesenheit_tage_vj,
 V01.abwesenheit_tage_gjkum_ist,
 V01.abwesenheit_tage_gjkum_vj,
 V01.soll_stunden_mo_ist,
 V01.soll_stunden_mo_vj,
 V01.soll_stunden_mo_an_ist,
 V01.soll_stunden_mo_an_vj,
 V01.soll_stunden_mo_ag_ist,
 V01.soll_stunden_mo_ag_vj,
 V01.soll_stunden_mo_gjkum_ist,
 V01.soll_stunden_mo_gjkum_vj,
 V01.soll_stunden_mo_an_gjkum_ist,
 V01.soll_stunden_mo_an_gjkum_vj,
 V01.soll_stunden_mo_ag_gjkum_ist,
 V01.soll_stunden_mo_ag_gjkum_vj,
 V01.shr_freigabe_fg,
 xx.dat_freigabe_kennzahlen,
 V01.anz_austritt_extern_neu_kum,
 V01.anz_eintritt_extern_kum,
 V01.anz_kopf_sdl_kum_gj,
 V01.anz_kopf_sdl_kum,
 V01.anz_austritt_extern_kum_gj,
 V01.genommen_urlaub_kum_kj,
 V01.anz_eintritt_extern_minus6,
 V01.anz_austritt_extern_neu,
 V01.ueberstunden_kum_gj,
 V01.arb_stunden_tag_kum_gj,
 V01.soll_arbeitstage_kum_gj,
 V01.krank_arbeitstage_kum_gj,
 V01.anz_stunden_mvst_kum_gj,
 V01.anz_teilzeit_kum_gj,
 V01.anspruch_urlaub_kum_gj,
 V01.genommen_urlaub_kum_gj,
 V01.anz_frau_kum_gj,
 V01.anz_frau_fuehrungskraft_kum_gj,
  CASE
  WHEN V01.soll_stunden_mo_ist > 0
  THEN 1
  ELSE 0
  END AS anz_monate_gearbeitet,
 SUM(CASE
   WHEN V01.soll_stunden_mo_ist > 0
   THEN 1
   ELSE 0
   END) OVER (PARTITION BY V02.gj, CAST(V01.mandant_id AS STRING), V01.hr_objekt_id ORDER BY V01.kjmo IS NULL, V01.kjmo
  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS anz_monate_gearbeitet_kum
FROM kfl_production_dbp_view.v_monat_1 AS V02
 INNER JOIN kfl_production_dbp_view.v_shr_kennzahlen_1 AS V01 ON V02.kjmo = V01.kjmo AND V02.akt_gj <= 0
 LEFT JOIN kfl_production_dbp_view.v_shr_kennzahlen_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.kjmo = V03.kjmo +
     100 AND V01.hr_objekt_id = V03.hr_objekt_id
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS V04 ON V01.kjmo = V04.kjmo
 LEFT JOIN kfl_production_dbp_view.v_monat_1 AS V05 ON V03.kjmo = V05.kjmo
 LEFT JOIN (SELECT mandant_id,
   kjmo,
   MAX(dat_freigabe_kennzahlen) AS dat_freigabe_kennzahlen
  FROM kfl_production_dbp_msi_v_view.v_shr_datenfreigabe_1
  GROUP BY mandant_id,
   kjmo) AS xx ON V01.kjmo = xx.kjmo AND V01.mandant_id = xx.mandant_id;