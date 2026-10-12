create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_STANDZEITEN_WA_PAL_2(
	WUP_ID,
	NB_ID,
	LAGERNUMMER_ID,
	MANDANT_ID,
	LIEF_PAL_TYP_ID,
	TRANSPORT_BELEG_ID,
	REFERENZNUMMER,
	WERBEWARE_ID,
	DAT_ERSTELLUNG,
	ZEIT_ERSTELLUNG,
	ERSTELLUNG_DT,
	DAT_QUITTIERUNG,
	DAT_LIEF_SOLL,
	DAT_BEREITSTELLUNG,
	DATZEIT_BEREITSTELLUNG,
	DATZEIT_START_TA,
	DATZEIT_END_TA,
	KJ_LIEF_BELEG,
	LIEF_BELEG_ID,
	HANDLING_UNIT_ID_EXT,
	DATZEIT_SCAN,
	DAT_AKTION,
	LIEF_TYP_ID,
	KUNDE_ID,
	MANDANT_ID_KUNDE,
	HU_STATUS_ID,
	DISTRIBUTION_ABR_FG,
	WG_VERKETT_LIEF
) as

















SELECT
 trans.wup_id
,trans.nb_id
,trans.lagernummer_id
,trans.mandant_id
,trans.lief_pal_typ_id
,trans.transport_beleg_id
,trans.referenznummer
,trans.werbeware_id
,trans.dat_erstellung
,trans.zeit_erstellung
,TIMESTAMP_FROM_PARTS(trans.dat_erstellung,COALESCE(trans.zeit_erstellung,'00:00:00')) AS erstellung_dt
,trans.dat_quittierung
,trans.dat_lief_soll
,trans.dat_bereitstellung
,TO_TIMESTAMP (trans.datzeit_bereitstellung) AS datzeit_bereitstellung
,TO_TIMESTAMP (trans.datzeit_start_ta) AS datzeit_start_ta
,TO_TIMESTAMP (trans.datzeit_end_ta) AS datzeit_end_ta
,trans.kj_lief_beleg
,trans.lief_beleg_id
,trans_det.handling_unit_id_ext
,prot_ver.datzeit_scan
,bl.dat_aktion
,bl.lief_typ_id

, CASE WHEN TRY_CAST(bl.kunde_id AS INTEGER) IS NULL THEN -3 ELSE w.aktuell_wup_id END kunde_id
,bl.mandant_id_kunde
,hu.hu_status_id
,COALESCE(t.distribution_abr_fg,-1)
,COALESCE(bl.wg_verkett_lief,-1)
FROM dbp_view.v_transportauftrag_2 trans








JOIN (
SELECT 
 mandant_id
,wup_id
,transport_beleg_id
,MAX(handling_unit_id_ext) AS handling_unit_id_ext
FROM dbp_view.v_transportauftrag_det_2
WHERE TRIM(COALESCE(handling_unit_id_ext,'')) <> ''
GROUP BY 
mandant_id
,wup_id
,transport_beleg_id
 ) trans_det

ON trans.mandant_id=trans_det.mandant_id
AND trans.wup_id=trans_det.wup_id
AND trans.transport_beleg_id=trans_det.transport_beleg_id
 
LEFT JOIN (
SELECT 
 mandant_id
,wup_id
,dat_lief_soll
,handling_unit_id_ext
,MAX(TIMESTAMP_NTZ_FROM_PARTS(DAT_SCAN::DATE,ZEIT_SCAN::TIME)) AS datzeit_scan
FROM dbp_view.v_protokoll_verladung_2
WHERE pruef_id='334'
GROUP BY mandant_id, dat_lief_soll, handling_unit_id_ext, wup_id
) prot_ver
ON trans.mandant_id=prot_ver.mandant_id

AND trans_det.handling_unit_id_ext=prot_ver.handling_unit_id_ext
AND trans.kj_lief_beleg=YEAR(prot_ver.dat_lief_soll)
AND trans.wup_id=prot_ver.wup_id

JOIN dbp_view.v_handling_unit_2 hu
ON trans_det.handling_unit_id_ext= hu.handling_unit_id_ext
AND trans_det.mandant_id= hu.mandant_id
AND trans_det.wup_id= hu.wup_id

LEFT JOIN dbp_view.v_besch_lief_2 bl
ON trans.lief_beleg_id=bl.lief_beleg_id
AND trans.mandant_id=bl.mandant_id
AND trans.kj_lief_beleg=bl.kj





LEFT JOIN dbp_view.v_wup_2 w
   ON w.mandant_id = CASE WHEN bl.mandant_id_kunde IS NULL OR bl.mandant_id_kunde = 0 THEN bl.mandant_id ELSE bl.mandant_id_kunde END
   AND w.wup_id = CASE WHEN TRY_CAST(bl.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(bl.kunde_id AS INTEGER) END
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

LEFT JOIN dbp_view.v_tour_2 t
ON trans.mandant_id=t.mandant_id
AND trans.wup_id=t.wup_id
AND trans.nb_id=t.nb_id
AND trans.referenznummer=t.tour_id;