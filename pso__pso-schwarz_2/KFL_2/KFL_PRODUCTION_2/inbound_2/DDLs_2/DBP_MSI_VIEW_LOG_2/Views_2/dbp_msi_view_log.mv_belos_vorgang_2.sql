CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BELOS_VORGANG_2(
	MANDANT_ID,
	BELOS_VORGANG_ID,
	KOMPLETTLIEFERUNG_FG,
	TRANSPORTSORTIMENT_ID,
	LOESCH_FG,
	IN_TIME_FG,
	AV_FG,
	SAMMEL_LADUNG_FG,
	NB_ID,
	SENDUNG_GEW_EINH_ID,
	SENDUNG_VOL_EINH_ID,
	DAT_LEISTUNG,
	DAT_ZUSTELLUNG,
	SENDUNG_ID,
	WUP_ID,
	LAGERORT_ID,
	GP_ID,
	GEWICHT_SENDUNG,
	ZUSTELLART_ID,
	BELOS_VORGANGART_ID,
	TRANSPORTAUFTRAG_ID,
	BELOS_ADRESSE_ABSENDER_NUM_ID,
	BELOS_ADRESSE_ABHOLUNG_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	BELOS_ADRESSE_EMPFAENGER_ID_NUM,
	BELOS_ADRESSE_SPEDITION_ID,
	VOL_STAURAUM,
	DEBITOR_ID,
	ANZ_UNTERVERPACKUNG,
	UNTERVERPACKUNG_MENGE_EINH_ID,
	LAGERNUMMER_ID,
	SYSTEM_ID,
	TOUR_ID,
	KJ_TRANSPORTATION_UNIT,
	BELOSART_FG,
	LEERGUT_ABH_FG,
	RETOUREN_FG,
	INDUSTRIE_ABH_FG,
	ANZ_STELLPLATZ,
	ANZ_KOLLI,
	BELOS_SENDUNGSSTATUS_ID,
	DISTRIBUTION_ABR_FG,
	BRTGEW_SENDUNG,
	BRTVOL_STAURAUM,
	ANZ_STELLPLATZ_BELOS,
	K_NA_FG,
	BELOS_AUFTRAG_ID_EXTERN,
	BELOS_LIEFERSCHEIN_ID,
	BELOS_SENDUNG_ID_EXTERN,
	BELOS_BESTELL_BELEG_ID_EXTERN,
	MANDANT_ID_DEBITOR,
	REFERENZ,
	BELOS_ADRESSE_STEUERUNG_ID
) AS
--03.02.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_2
--23.02.2021, SPEC0091861, AP0073899, dknop, adding tourart and tourstatus based on logic from Nicolas Wagner
--01.03.2021, SPEC0091861, AP0073899, dknop,  adding logic for rundlauf_transport_fg 
--15.03.2021, SPEC0091861, AP0073899, nwag2310, deduplication of sonderabwicklung_id
--15.04.2021, SPEC0091861, AP0073899, dknop, changing lagernummer to char(4)
--11.05.2021, SPEC0091861, AP0073899, dknop, correcting join to l_lagernummer_2
--03.12.2021, SPEC0091861, AP0073899, dknop,removing tourart, tourstatus and sonderabwicklung_id, moved to TRANSPORTATION_UNIT_AKTIVITAET_2
--09.12.2021, SPEC0091861, AP0073899, dknop, adding Transportsortiment
-- 2022-04-01, adding belos_adresse_steuerung_id 
--2023-07-21, dknop, setting colaesce for lagernummer to -1
--2024-08-01, AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-18, dknop, limiting to t_unit.dat_tour >= 01.01.2022 because of transportation_unit_2 duplication
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
--2025-02-25, nwag, <= WANKO
SELECT
 v01.mandant_id
,v01.belos_vorgang_id
,v01.komplettlieferung_fg
,v05.transportsortiment_id
,v01.loesch_fg
,v01.in_time_fg
,v01.av_fg
,v01.sammel_ladung_fg
,v01.nb_id
,v01.sendung_gew_einh_id
,v01.sendung_vol_einh_id
,v01.dat_leistung
,v01.dat_zustellung
,v01.sendung_id
,v01.wup_id
,v01.lagerort_id
,v01.gp_id
,v01.gewicht_sendung
,v01.zustellart_id
,v01.belos_vorgangart_id
,v01.transportauftrag_id
,v01.belos_adresse_absender_num_id
,v01.belos_adresse_abholung_id
,COALESCE (CAST(aktuell_wup_id AS VARCHAR), v01.belos_adresse_empfaenger_id) AS belos_adresse_empfaenger_id_
,COALESCE(CASE WHEN TRY_CAST(v01.belos_adresse_empfaenger_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END, TRY_CAST(LEFT(v01.belos_adresse_empfaenger_id,4) AS NUMBER(38,0)))  AS belos_adresse_empfaenger_id_num
--,CAST(LEFT(v01.belos_adresse_empfaenger_id,4) AS NUMBER(38,0)) AS belos_adresse_empfaenger_id_num
,v01.belos_adresse_spedition_id
,v01.vol_stauraum
,v01.debitor_id
,v01.anz_unterverpackung
,v01.unterverpackung_menge_einh_id
,COALESCE(CASE WHEN v04.lagernummer_id='' THEN NULL ELSE v04.lagernummer_id END,'-1') AS lagernummer_id
,v01.system_id
,v01.tour_id
,YEAR(v01.dat_leistung) AS KJ_TRANSPORTATION_UNIT
,v01.belosart_fg
,v01.leergut_abh_fg
,v01.retouren_fg
,v01.industrie_abh_fg
,v01.anz_stellplatz
,v01.anz_kolli
,v01.belos_sendungsstatus_id
,v01.distribution_abr_fg
,v01.brtgew_sendung
,v01.brtvol_stauraum
,v01.anz_stellplatz_belos
,v01.k_na_fg
,v01.belos_auftrag_id_extern
,v01.belos_lieferschein_id
,v01.belos_sendung_id_extern
,v01.belos_bestell_beleg_id_extern
,v01.mandant_id_debitor
,v01.referenz
,MAX(v03.belos_adresse_steuerung_id)

FROM dbp_view.v_belos_vorgang_2 v01

LEFT JOIN dbp_view.v_wup_2 v02
ON v02.mandant_id = v01.mandant_id
AND v02.wup_id = CASE WHEN TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) END
AND ((v02.nb_id IN (2, 0, -111) AND v02.wup_id > 0) OR (v02.nb_id = -1 AND v02.wup_id = 0))

LEFT JOIN dbp_view.v_verrechfall_2 v03
ON  v01.mandant_id = v03.mandant_id
AND v01.belos_vorgang_id = v03.belos_vorgang_id
AND v03.storno_fg = 0

JOIN dbp_view.v_l_lagernummer_2 v04
ON  v01.mandant_id=v04.mandant_id
AND v01.lagernummer_id = LEFT(v04.lagernummer_id,3)

LEFT JOIN 
(SELECT 
  belos_vorgang_id
 ,mandant_id
 ,MAX(transportsortiment_id)AS transportsortiment_id
 FROM dbp_view.v_besch_lief_wa_hu_sum_2
 GROUP BY
 belos_vorgang_id
,mandant_id) v05
 ON v01.belos_vorgang_id=v05.belos_vorgang_id
 AND v01.mandant_id=v05.mandant_id

LEFT JOIN (SELECT mandant_id, wup_id, MIN(COALESCE(dat_tms_wanko, DATE'9999-12-31')) AS dat_wanko_von FROM DBP_MSI_data.TS_LAGERNUMMER_SORTIERUNG_SCM_2 GROUP BY mandant_id, wup_id) dw
ON v01.belos_adresse_absender_num_id = dw.wup_id
AND v01.mandant_id = dw.mandant_id

WHERE YEAR(v01.dat_leistung)  >= YEAR(CURRENT_DATE)-2
AND NOT (v03.belos_adresse_steuerung_id IN (6921,6922) AND v01.dat_leistung >= '2025-02-17')
AND   v01.dat_leistung < COALESCE(dw.dat_wanko_von, DATE'9999-12-31')

GROUP BY
 v01.mandant_id
,v01.belos_vorgang_id
,v01.komplettlieferung_fg
,v05.transportsortiment_id
,v01.loesch_fg
,v01.in_time_fg
,v01.av_fg
,v01.sammel_ladung_fg
,v01.nb_id
,v01.sendung_gew_einh_id
,v01.sendung_vol_einh_id
,v01.dat_leistung
,v01.dat_zustellung
,v01.sendung_id
,v01.wup_id
,v01.lagerort_id
,v01.gp_id
,v01.gewicht_sendung
,v01.zustellart_id
,v01.belos_vorgangart_id
,v01.transportauftrag_id
,v01.belos_adresse_absender_num_id
,v01.belos_adresse_abholung_id
,belos_adresse_empfaenger_id_
,belos_adresse_empfaenger_id_num
,v01.belos_adresse_spedition_id
,v01.vol_stauraum
,v01.debitor_id
,v01.anz_unterverpackung
,v01.unterverpackung_menge_einh_id
,v04.lagernummer_id
,v01.system_id
,v01.tour_id
,v01.belosart_fg
,v01.leergut_abh_fg
,v01.retouren_fg
,v01.industrie_abh_fg
,v01.anz_stellplatz
,v01.anz_kolli
,v01.belos_sendungsstatus_id
,v01.distribution_abr_fg
,v01.brtgew_sendung
,v01.brtvol_stauraum
,v01.anz_stellplatz_belos
,v01.k_na_fg
,v01.belos_auftrag_id_extern
,v01.belos_lieferschein_id
,v01.belos_sendung_id_extern
,v01.belos_bestell_beleg_id_extern
,v01.mandant_id_debitor
,v01.referenz
;