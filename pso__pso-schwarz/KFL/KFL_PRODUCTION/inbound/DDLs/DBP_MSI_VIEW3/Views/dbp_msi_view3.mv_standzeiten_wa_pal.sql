CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_STANDZEITEN_WA_PAL (
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
) AS
-- 2021-09-08, AP0092669, SPEC0123436, dknop, initial
-- 2021-09-08, AP0092669, SPEC0123436, dknop, minor formatting
--2022-04-19, AP0092669, SPEC0123436, dknop, updating joins
--2022-04-21, AP0092669, SPEC0123436, dknop, adding timestamp, correcting join to prot_ver
--2022-04-21, AP0092669, SPEC0123436, dknop, adding join to handling_unit, correcting join to prot_ver
--2022-04-27, AP0092669, SPEC0123436, dknop,removing lief_beleg_id from join to prot_ver
-- 2022-04-29, AP0092669, SPEC0123436, dknop, adding kunde_id
--2022-05-05, AP0092669, SPEC0123436, dknop,adding hu_status_id
--2022-05-20, AP0092669, SPEC0123436, dknop, adding lief_beleg_id
--2022-06-01, AP0092669, SPEC0123436 , dknop, adding trans.wup_id=prot_ver.wup_id
--2022-06-22, AP0092669, SPEC0123436 , dknop, adding join to v_wup
--2022-06-28, AP0092669, SPEC0123436 , dknop, adding DISTRIBUTION_ABR_FG
--2022-07-04, AP0092669, SPEC0123436 , dknop, adding wg_verkett_lief
--2024-01-31, INC7963291, dknop, change kunde_id 
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-09, dknop, change to left join with dbp_view.v_wup

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
--,CASE WHEN TRY_CAST(bl.kunde_id AS INTEGER) IS NULL THEN -3 ELSE TRY_CAST(bl.kunde_id AS INTEGER) END AS kunde_id
, CASE WHEN TRY_CAST(bl.kunde_id AS INTEGER) IS NULL THEN -3 ELSE w.aktuell_wup_id END kunde_id
,bl.mandant_id_kunde
,hu.hu_status_id
,COALESCE(t.distribution_abr_fg,-1)
,COALESCE(bl.wg_verkett_lief,-1)
FROM dbp_view.v_transportauftrag trans
/*
	
LEFT JOIN ( SELECT mandant_id, kj_lief_beleg, lief_beleg_id, MAX(handling_unit_id_ext) AS handling_unit_id_ext
FROM dbp_view.v_handling_unit vepo GROUP by mandant_id, kj_lief_beleg, lief_beleg_id) vepo
ON vepo.mandant_id=trans.mandant_id
AND trans.lief_beleg_id=vepo.lief_beleg_id
AND trans.kj_lief_beleg = vepo.kj_lief_beleg
*/
JOIN (
SELECT 
 mandant_id
,wup_id
,transport_beleg_id
,MAX(handling_unit_id_ext) AS handling_unit_id_ext
FROM dbp_view.v_transportauftrag_det
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
FROM dbp_view.v_protokoll_verladung
WHERE pruef_id='334'
GROUP BY mandant_id, dat_lief_soll, handling_unit_id_ext, wup_id
) prot_ver
ON trans.mandant_id=prot_ver.mandant_id
--AND trans.lief_beleg_id=prot_ver.lief_beleg_id
AND trans_det.handling_unit_id_ext=prot_ver.handling_unit_id_ext
AND trans.kj_lief_beleg=YEAR(prot_ver.dat_lief_soll)
AND trans.wup_id=prot_ver.wup_id

JOIN dbp_view.v_handling_unit hu
ON trans_det.handling_unit_id_ext= hu.handling_unit_id_ext
AND trans_det.mandant_id= hu.mandant_id
AND trans_det.wup_id= hu.wup_id

LEFT JOIN dbp_view.v_besch_lief bl
ON trans.lief_beleg_id=bl.lief_beleg_id
AND trans.mandant_id=bl.mandant_id
AND trans.kj_lief_beleg=bl.kj

/*JOIN dbp_view.v_wup w
ON  LPAD(TO_CHAR (w.wup_id),10,'0') = bl.kunde_id
AND bl.mandant_id_kunde=w.mandant_id*/

LEFT JOIN dbp_view.v_wup w
   ON w.mandant_id = CASE WHEN bl.mandant_id_kunde IS NULL OR bl.mandant_id_kunde = 0 THEN bl.mandant_id ELSE bl.mandant_id_kunde END
   AND w.wup_id = CASE WHEN TRY_CAST(bl.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(bl.kunde_id AS INTEGER) END
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

LEFT JOIN dbp_view.v_tour t
ON trans.mandant_id=t.mandant_id
AND trans.wup_id=t.wup_id
AND trans.nb_id=t.nb_id
AND trans.referenznummer=t.tour_id


--where trans.wup_id=9300 and trans.dat_lief_soll='2022-04-28'

;