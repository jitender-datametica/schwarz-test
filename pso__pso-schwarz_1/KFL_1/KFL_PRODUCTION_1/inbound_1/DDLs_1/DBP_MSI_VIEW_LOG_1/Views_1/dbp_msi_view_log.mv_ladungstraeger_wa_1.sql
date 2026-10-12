CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_LADUNGSTRAEGER_WA_1(
	MANDANT_ID,
	LAGERNUMMER_ID,
	LAGERSORTIMENT_ID,
	ARTIKELSORTIMENT_ID,
	DAT_LIEF_SOLL,
	LIEF_PAL_TYP_ID,
	LIEF_PAL_TYP_DWH_ID,
	WERBEWARE_ID,
	WG_VERKETT_LIEF,
	LIEF_TYP_ID,
	LIEF_BELEG_ID,
	KUNDE_ID,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
	HU_STATUS_ID,
	HANDLING_UNIT_ID,
	HANDLING_UNIT_ID_EXT,
	HU_TYP_ID,
	ART_ID,
	ANZ_PACK_HILFSMITTEL
) AS
-- 20.09.2021, AP0081637, SPEC0123461, dknop, initial based on the logic from N.Wagner
-- 18.20.2021, AP0081637, SPEC0123461, dknop, adding lief_beleg_id
-- 26.10.2021, AP0081637, SPEC0123461, dknop, join to v_fremd_lagerort_artikelsortiment_zu_1 for artikelsortiment
-- 10.11.2021, INC3829726, dknop, workaround for artikelsortiment
--2024-07-19,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
SELECT
 t0.mandant_id
,t0.lagernummer_id
,t0.lagersortiment_id
--,t3.artikelsortiment_id
,CASE WHEN LEFT(RIGHT(t0.VERSANDSTELLE_ID,2),1) = '5' THEN '1'WHEN LEFT(RIGHT(t0.VERSANDSTELLE_ID,2),1) = '7' THEN '2'ELSE LEFT(RIGHT(t0.VERSANDSTELLE_ID,2),1) END AS ARTIKELSORTIMENT_ID
,t0.dat_lief_soll
,t0.lief_pal_typ_id
,t0.lief_pal_typ_dwh_id
,t0.werbeware_id
,t0.wg_verkett_lief
,t0.lief_typ_id
,t0.lief_beleg_id
--,CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END kunde_id
--,t0.kunde_id
,t3.aktuell_wup_id AS kunde_id
,t0.transportation_unit_id
,YEAR(t0.DAT_TOUR) AS KJ_TRANSPORTATION_UNIT
,t2.hu_status_id
,t0.handling_unit_id
,t0.handling_unit_id_ext
,t1.hu_typ_id
,t1.art_id
,t1.anz_pack_hilfsmittel
FROM dbp_view.v_besch_lief_wa_hu_sum_1 t0

INNER JOIN dbp_view.v_wup_1 t3
   ON t3.mandant_id = CASE WHEN t0.mandant_id_kunde IS NULL OR t0.mandant_id_kunde = 0 THEN t0.mandant_id ELSE t0.mandant_id_kunde END
  -- AND t3.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND t3.wup_id = t0.kunde_id
   AND ((t3.nb_id IN (2, 0, -111) AND t3.wup_id > 0) OR (t3.nb_id = -1 AND t3.wup_id = 0))

JOIN dbp_view.v_handling_unit_det_1 t1_1 ON 
    t0.mandant_id=t1.mandant_id 
AND t0.wup_id=t1.wup_id 
AND t0.nb_id=t1.nb_id 
AND t0.handling_unit_id=t1.handling_unit_id 
AND t1.hu_typ_id=2

JOIN dbp_view.v_handling_unit_1 t2 ON
    t2.mandant_id=t1.mandant_id  
AND t2.wup_id=t1.wup_id 
AND t2.nb_id=t1.nb_id 
AND t2.handling_unit_id=t1.handling_unit_id

WHERE YEAR(t0.DAT_TOUR) >= YEAR(CURRENT_DATE) -2
;