CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_ARTIKELBESTAND(
	MANDANT_ID,
	DAT,
	DAUER_BESTAND_ZU_WE_DATUM,
	LAGERNUMMER_ID,
	ART_ID,
	ARTIKELSORTIMENT_ID,
	LAGERSORTIMENT_ID,
	LAGERTYP_ID,
	LAGERBEREICH_ID,
	LAGERPLATZ_ID,
	GANG_ID,
	SAEULE_ID,
	EBENE_ID,
	LAGERPLATZ_TYP_ID,
	HANDLING_UNIT_ID_TOP,
	HANDLING_UNIT_ID,
	DAT_WARENEINGANG,
	DAT_MHD,
	CHARGE_ID,
	LAGERBESTAND_TYP_ID,
	GEW_EINH_ID,
	VOL_EINH_ID,
	GEWICHT_NETTO,
	VOLUMEN_NETTO,
	MENGE_ALTNV,
	MENGE_PAL,
	LAGEREINHEITENTYP_ID,
	LAGEREINHEITENTYP_DWH_ID
) AS
--2024-01-30,AP0185506, SPEC0234078, dknop, initial
--2024-04-22, dknop, updating logic for menge_pal
--2024-07-01, dknop, adding HANDLING_UNIT_ID_TOP

  SELECT
l_ewm_t.mandant_id
,l_ewm_t.dat
,DATEDIFF('DAY', l_ewm_t.dat_wareneingang, dat) AS dauer_bestand_zu_we_datum
,l_ewm_t.lagernummer_id
,l_ewm_t.art_id
,COALESCE (a_sort.artikelsortiment_id, '-1') AS artikelsortiment_id
,LEFT(l_ewm_t.lagertyp_id, 1) AS lagersortiment_id
,l_ewm_t.lagertyp_id
,l_ewm_t.lagerbereich_id
,l_ewm_t.lagerplatz_id
,l_ewm_t.gang_id
,l_ewm_t.saeule_id
,l_ewm_t.ebene_id
,l_ewm_t.lagerplatz_typ_id
,COALESCE(CASE WHEN l_ewm_t.handling_unit_id_top='' THEN NULL ELSE l_ewm_t.handling_unit_id_top END,'-1') AS handling_unit_id_top
,COALESCE(CASE WHEN l_ewm_t.handling_unit_id='' THEN NULL ELSE l_ewm_t.handling_unit_id END,'-1') AS handling_unit_id
,l_ewm_t.dat_wareneingang
,l_ewm_t.dat_mhd
,l_ewm_t.charge_id
,l_ewm_t.lagerbestand_typ_id
,l_ewm_t.gew_einh_id
,l_ewm_t.vol_einh_id
,l_ewm_t.gewicht_netto
,l_ewm_t.volumen_netto
,l_ewm_t.menge_altnv --orig
,(l_ewm_t.menge * COALESCE(pal.umrech_faktor,1)) :: NUMBER(13,7) AS menge_pal
,l_ewm_t.lagereinheitentyp_id
,LEFT(l_ewm_t.lagereinheitentyp_id,3) AS lagereinheitentyp_dwh_id
FROM dbp_view.v_lagerbestand_ewm_tag l_ewm_t
 
JOIN dbp_view.v_l_lagernummer t001l
ON l_ewm_t.mandant_id = t001l.mandant_id
AND l_ewm_t.lagernummer_id = t001l.lagernummer_id
 
JOIN dbp_data.art art
ON l_ewm_t.art_id = art.art_id
AND l_ewm_t.mandant_id = art.mandant_id
 
JOIN dbp_view.v_art_vorschlagswert_per maw1 
ON l_ewm_t.mandant_id = maw1.mandant_id 
AND l_ewm_t.art_id = maw1.art_id
AND maw1.dat_bis='9999-12-31'
 
LEFT JOIN dbp_view.v_art_umrechnung_faktor_per pal
ON l_ewm_t.art_id = pal.art_id
AND l_ewm_t.mandant_id = pal.mandant_id
AND maw1.paletten_faktor_einh_id = pal.altnv_menge_einh_id
AND pal.dat_bis='9999-12-31'
 
LEFT JOIN dbp_view.v_art_umrechnung_faktor_per kol
ON l_ewm_t.art_id = kol.art_id
AND l_ewm_t.mandant_id = kol.mandant_id
AND maw1.ausg_menge_einh_id = kol.altnv_menge_einh_id
AND kol.dat_bis='9999-12-31'
 
LEFT JOIN dbp_view.v_art_wup_status_per marc 
ON l_ewm_t.mandant_id = marc.mandant_id 
AND l_ewm_t.art_id = marc.art_id
AND t001l.wup_id = marc.wup_id
AND marc.dat_bis='9999-12-31'
 
LEFT JOIN  dbp_view.v_fremd_lagerort_artikelsortiment_zu a_sort
ON marc.fremd_lagerort_id = a_sort.fremd_lagerort_id
AND marc.mandant_id=a_sort.mandant_id													   
AND pal.dat_bis = TO_DATE('9999-12-31', 'YYYY-MM-DD')
;