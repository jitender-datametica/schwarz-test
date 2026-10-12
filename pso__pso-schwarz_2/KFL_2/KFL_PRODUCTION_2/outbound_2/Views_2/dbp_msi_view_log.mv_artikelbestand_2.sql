-- 2024-04-22, dknop, updating logic for menge_pal
 -- 2024-01-30,AP0185506, SPEC0234078, dknop, initial

-- 2024-07-01, dknop, adding HANDLING_UNIT_ID_TOP

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_artikelbestand_2 (mandant_id, dat, dauer_bestand_zu_we_datum,
lagernummer_id, art_id, artikelsortiment_id, lagersortiment_id, lagertyp_id, lagerbereich_id, lagerplatz_id, gang_id,
saeule_id, ebene_id, lagerplatz_typ_id, handling_unit_id_top, handling_unit_id, dat_wareneingang, dat_mhd, charge_id,
lagerbestand_typ_id, gew_einh_id, vol_einh_id, gewicht_netto, volumen_netto, menge_altnv, menge_pal,
lagereinheitentyp_id, lagereinheitentyp_dwh_id) AS SELECT L_EWM_T.mandant_id,
 L_EWM_T.dat,
 DATE_DIFF(L_EWM_T.dat, L_EWM_T.dat_wareneingang, DAY) AS dauer_bestand_zu_we_datum,
 L_EWM_T.lagernummer_id,
 L_EWM_T.art_id,
 COALESCE(A_SORT.artikelsortiment_id, '-1') AS artikelsortiment_id,
 LEFT(L_EWM_T.lagertyp_id, 1) AS lagersortiment_id,
 L_EWM_T.lagertyp_id,
 L_EWM_T.lagerbereich_id,
 L_EWM_T.lagerplatz_id,
 L_EWM_T.gang_id,
 L_EWM_T.saeule_id,
 L_EWM_T.ebene_id,
 L_EWM_T.lagerplatz_typ_id,
 COALESCE(CASE
   WHEN L_EWM_T.handling_unit_id_top = ''
   THEN NULL
   ELSE L_EWM_T.handling_unit_id_top
   END, '-1') AS handling_unit_id_top,
 COALESCE(CASE
   WHEN L_EWM_T.handling_unit_id = ''
   THEN NULL
   ELSE L_EWM_T.handling_unit_id
   END, '-1') AS handling_unit_id,
 L_EWM_T.dat_wareneingang,
 L_EWM_T.dat_mhd,
 L_EWM_T.charge_id,
 L_EWM_T.lagerbestand_typ_id,
 L_EWM_T.gew_einh_id,
 L_EWM_T.vol_einh_id,
 L_EWM_T.gewicht_netto,
 L_EWM_T.volumen_netto,
 L_EWM_T.menge_altnv -- orig
,
 ROUND(CAST(L_EWM_T.menge * COALESCE(PAL.umrech_faktor, 1) AS NUMERIC), 7) AS menge_pal,
 L_EWM_T.lagereinheitentyp_id,
 LEFT(L_EWM_T.lagereinheitentyp_id, 3) AS lagereinheitentyp_dwh_id
FROM kfl_production_dbp_view.v_lagerbestand_ewm_tag_2 AS L_EWM_T
 INNER JOIN kfl_production_dbp_view.v_l_lagernummer_2 AS T001L ON L_EWM_T.mandant_id = T001L.mandant_id AND L_EWM_T.lagernummer_id
    = T001L.lagernummer_id
 INNER JOIN kfl_production_dbp_data.art_2 AS ART_2 ON L_EWM_T.art_id = ART.art_id AND L_EWM_T.mandant_id = ART.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_2 AS MAW1_2 ON L_EWM_T.mandant_id = MAW1.mandant_id AND L_EWM_T
    .art_id = MAW1.art_id AND MAW1.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS PAL ON L_EWM_T.art_id = PAL.art_id AND L_EWM_T.mandant_id
      = PAL.mandant_id AND MAW1.paletten_faktor_einh_id = PAL.altnv_menge_einh_id AND PAL.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS KOL ON L_EWM_T.art_id = KOL.art_id AND L_EWM_T.mandant_id
      = KOL.mandant_id AND MAW1.ausg_menge_einh_id = KOL.altnv_menge_einh_id AND KOL.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_wup_status_per_2 AS MARC_2 ON L_EWM_T.mandant_id = MARC.mandant_id AND L_EWM_T.art_id
      = MARC.art_id AND T001L.wup_id = MARC.wup_id AND MARC.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_fremd_lagerort_artikelsortiment_zu_2 AS A_SORT ON MARC.fremd_lagerort_id = A_SORT.fremd_lagerort_id
     AND MARC.mandant_id = A_SORT.mandant_id AND PAL.dat_bis = PARSE_DATE('%F', '9999-12-31');