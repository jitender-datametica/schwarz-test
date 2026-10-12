CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_zb_dim_projekt_per_2 (mandant_id, projekt_nr, wup_id, nb_id,
psp_art, psp_nr, psp_status_id, psp_status_bez, psp_status_bez_de, psp_status_bez_en, projekt_status_id,
projekt_status_bez, projekt_status_bez_de, projekt_status_bez_en, projektart_cd, projektart_bez, projektart_bez_de,
projektart_bez_en, projekttyp_id, projekttyp_bez, projekttyp_bez_de, projekttyp_bez_en, projektphase_id,
projektphase_bez, projektphase_bez_de, projektphase_bez_en, projektphase_status_id, projektphase_status_bez,
projektphase_status_bez_de, projektphase_status_bez_en, projekt_name, projekt_land_id, projekt_region_name,
projekt_plz_nr, projekt_standort_name, projekt_stadtteil_name, projekt_strasse_name, projekt_haus_nr,
projekt_bemerkung_txt, immobilienentwickler_name, objektplaner_name, bauprojektmanager_name, vertrieb_mitarbeiter_name,
dat_storno, dat_a1_budget, a1_budget_version_name, dat_a2_budget, a2_budget_version_name, dat_aktuelle_kostenprognose,
aktuelle_kostenprognose_version_nr, dat_objekt_freigegeben, objekt_freigegeben_dat_typ_cd, objekt_freigegeben_desc,
dat_standortsicherung_durchgefuehrt, standortsicherung_durchgefuehrt_dat_typ_cd, standortsicherung_durchgefuehrt_desc,
dat_baurecht_geschaffen, baurecht_geschaffen_dat_typ_cd, baurecht_geschaffen_desc, dat_baubeginn, baubeginn_dat_typ_cd,
baubeginn_desc, dat_beginn_kaelte, beginn_kaelte_dat_typ_cd, beginn_kaelte_desc, dat_beginn_einrichtung,
beginn_einrichtung_dat_typ_cd, beginn_einrichtung_desc, dat_eroeffnung, eroeffnung_dat_typ_cd, eroeffnung_desc,
dat_projekt_abgeschlossen, projekt_abgeschlossen_dat_typ_cd, projekt_abgeschlossen_desc, gj_plan_eroeffnung, td_update,
td_insert) AS SELECT mandant_id,
 projekt_nr,
 wup_id,
 nb_id,
 SUBSTR(psp_nr, 0, 1) AS psp_art,
 psp_nr,
 psp_status_id,
 psp_status_bez_de AS psp_status_bez,
 psp_status_bez_de,
 psp_status_bez_en,
 projekt_status_id,
 projekt_status_bez_de AS projekt_status_bez,
 projekt_status_bez_de,
 projekt_status_bez_en,
 projektart_cd,
 projektart_bez_de AS projektart_bez,
 projektart_bez_de,
 projektart_bez_en,
 projekttyp_id,
 projekttyp_bez_de AS projekttyp_bez,
 projekttyp_bez_de,
 projekttyp_bez_en,
 projektphase_id,
 projektphase_bez_de AS projektphase_bez,
 projektphase_bez_de,
 projektphase_bez_en,
 projektphase_status_id,
 projektphase_status_bez_de AS projektphase_status_bez,
 projektphase_status_bez_de,
 projektphase_status_bez_en,
 projekt_name,
 projekt_land_id,
 projekt_region_name,
 projekt_plz_nr,
 projekt_standort_name,
 projekt_stadtteil_name,
 projekt_strasse_name,
 projekt_haus_nr,
 projekt_bemerkung_txt,
 immobilienentwickler_name,
 objektplaner_name,
 bauprojektmanager_name,
 vertrieb_mitarbeiter_name,
 dat_storno,
 dat_a1_budget,
 a1_budget_version_name,
 dat_a2_budget,
 a2_budget_version_name,
 dat_aktuelle_kostenprognose,
 aktuelle_kostenprognose_version_nr,
 dat_objekt_freigegeben,
 objekt_freigegeben_dat_typ_cd,
 CONCAT(FORMAT_DATE('%d.%m.%Y', dat_objekt_freigegeben), CASE
   WHEN objekt_freigegeben_dat_typ_cd = 'I'
   THEN '| '
   WHEN objekt_freigegeben_dat_typ_cd = 'P'
   THEN '|'
   ELSE NULL
   END, objekt_freigegeben_dat_typ_cd) AS objekt_freigegeben_desc,
 dat_standortsicherung_durchgefuehrt,
 standortsicherung_durchgefuehrt_dat_typ_cd,
 CONCAT(FORMAT_DATE('%d.%m.%Y', dat_standortsicherung_durchgefuehrt), CASE
   WHEN standortsicherung_durchgefuehrt_dat_typ_cd = 'I'
   THEN '| '
   WHEN standortsicherung_durchgefuehrt_dat_typ_cd = 'P'
   THEN '|'
   ELSE NULL
   END, standortsicherung_durchgefuehrt_dat_typ_cd) AS standortsicherung_durchgefuehrt_desc,
 dat_baurecht_geschaffen,
 baurecht_geschaffen_dat_typ_cd,
 CONCAT(FORMAT_DATE('%d.%m.%Y', dat_baurecht_geschaffen), CASE
   WHEN baurecht_geschaffen_dat_typ_cd = 'I'
   THEN '| '
   WHEN baurecht_geschaffen_dat_typ_cd = 'P'
   THEN '|'
   ELSE NULL
   END, baurecht_geschaffen_dat_typ_cd) AS baurecht_geschaffen_desc,
 dat_baubeginn,
 baubeginn_dat_typ_cd,
 CONCAT(FORMAT_DATE('%d.%m.%Y', dat_baubeginn), CASE
   WHEN baubeginn_dat_typ_cd = 'I'
   THEN '| '
   WHEN baubeginn_dat_typ_cd = 'P'
   THEN '|'
   ELSE NULL
   END, baubeginn_dat_typ_cd) AS baubeginn_desc,
 dat_beginn_kaelte,
 beginn_kaelte_dat_typ_cd,
 CONCAT(FORMAT_DATE('%d.%m.%Y', dat_beginn_kaelte), CASE
   WHEN beginn_kaelte_dat_typ_cd = 'I'
   THEN '| '
   WHEN beginn_kaelte_dat_typ_cd = 'P'
   THEN '|'
   ELSE NULL
   END, beginn_kaelte_dat_typ_cd) AS beginn_kaelte_desc,
 dat_beginn_einrichtung,
 beginn_einrichtung_dat_typ_cd,
 CONCAT(FORMAT_DATE('%d.%m.%Y', dat_beginn_einrichtung), CASE
   WHEN beginn_einrichtung_dat_typ_cd = 'I'
   THEN '| '
   WHEN beginn_einrichtung_dat_typ_cd = 'P'
   THEN '|'
   ELSE NULL
   END, beginn_einrichtung_dat_typ_cd) AS beginn_einrichtung_desc,
 dat_eroeffnung,
 eroeffnung_dat_typ_cd,
 CONCAT(FORMAT_DATE('%d.%m.%Y', dat_eroeffnung), CASE
   WHEN eroeffnung_dat_typ_cd = 'I'
   THEN '| '
   WHEN eroeffnung_dat_typ_cd = 'P'
   THEN '|'
   ELSE NULL
   END, eroeffnung_dat_typ_cd) AS eroeffnung_desc,
 dat_projekt_abgeschlossen,
 projekt_abgeschlossen_dat_typ_cd,
 CONCAT(FORMAT_DATE('%d.%m.%Y', dat_projekt_abgeschlossen), CASE
   WHEN projekt_abgeschlossen_dat_typ_cd = 'I'
   THEN '| '
   WHEN projekt_abgeschlossen_dat_typ_cd = 'P'
   THEN '|'
   ELSE NULL
   END, projekt_abgeschlossen_dat_typ_cd) AS projekt_abgeschlossen_desc,
 gj_plan_eroeffnung,
 td_update,
 td_insert
FROM kfl_production_dbp_msi_data.zb_dim_projekt_2;