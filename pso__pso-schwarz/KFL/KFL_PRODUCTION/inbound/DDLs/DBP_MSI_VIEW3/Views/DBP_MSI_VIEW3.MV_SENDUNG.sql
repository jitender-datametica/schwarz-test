CREATE OR REPLACE VIEW dbp_msi_view3.mv_sendung(
	MANDANT_ID,
	BELOS_VORGANG_ID,
	KOMPLETTLIEFERUNG_FG,
	LOESCH_FG,
	IN_TIME_FG,
	AV_FG,
	DISTRIBUTION_ABR_FG,
	SAMMEL_LADUNG_FG,
	NB_ID,
	SENDUNG_GEW_EINH_ID,
	SENDUNG_VOL_EINH_ID,
	DAT_LIEF_SOLL,
	DAT_ZUSTELLUNG,
	SENDUNG_ID,
	WUP_ID,
	LAGERORT_ID,
	HGP_ID,
	GEWICHT_SENDUNG,
	ZUSTELLART_ID,
	BELOS_VORGANGART_ID,
	TRANSPORTAUFTRAG_ID,
	SONDERABWICKLUNG_ID,
	BELOS_ADRESSE_ABSENDER_NUM_ID,
	BELOS_ADRESSE_ABHOLUNG_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	BELOS_ADRESSE_EMPF_NUM_ID,
	BELOS_ADRESSE_SPEDITION_ID,
	VOL_STAURAUM,
	DEBITOR_ID,
	ANZ_UNTERVERPACKUNG,
	UNTERVERPACKUNG_MENGE_EINH_ID,
	TOUR_ID,
	TOUR_ID_AUFTRAG,
	LEERGUT_ABH_FG,
	RETOUREN_FG,
	INDUSTRIE_ABH_FG,
	LAGERNUMMER_ID,
	ANZ_STELLPLATZ_SAP,
	ANZ_KOLLI,
	ANZ_STELLPLATZ,
	MANDANT_ID_DEBITOR
) AS
-- 13.04.2010 Alex Lipkin neu erstellt
-- 09.08.2011 srom, Anforderung 501447 neue Brutto Felder
-- auf bestehende (Netto-) Felder mappen
-- 13.12.2011 srom, Anforderung 543562
-- 12.03.2012 srom, Anforderung 560127
-- 29.04.2013 kkaiser, Format anz_stellplatz angepasst
-- 13.05.2013 srom, 589416, belos_adresse_num_id
-- 30.07.2014 srom, belos_adresse_empfaenger_id auch als belos_adresse_empf_num_id bereitstellen
-- 18.10.2016 srom, AP0001986 Erweiterung mandant_id_debitor
-- 15.02.2021 nwag, INC2763120, tour_id kann EWM-TU-Nummer enthalten -> typecast auf INT nur wenn LVS-tour
-- 2022-08-05, dknop, AP0129706_SPEC0158100 adding distribution_abr_fg
-- 2023-02-03, dknop, updating wup_id, logic form n.wagner 
-- 2022-08-05, dknop, AP0129706_SPEC0158100 adding distribution_abr_fg
-- 2023-02-03, dknop, updating wup_id, logic form n.wagner
-- 2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
-- 2025-02-25, nwag, <= WANKO go live
-- 2025-02-26, nwag, adding WANKO
-- 2025-03-14, nwag, Bugfix Filialumgliederung
SELECT
 
v01.mandant_id,
v01.belos_vorgang_id,
v01.komplettlieferung_fg,
v01.loesch_fg,
v01.in_time_fg,
v01.av_fg,
v01.distribution_abr_fg,
v01.sammel_ladung_fg,
v01.nb_id,
v01.sendung_gew_einh_id,
v01.sendung_vol_einh_id,
v01.dat_leistung AS dat_lief_soll,
v01.dat_zustellung,
v01.sendung_id,
CASE WHEN v01.wup_id = 0 AND v01.belos_adresse_empfaenger_id = 'DCKP' THEN 9994::NUMBER(38,0)
WHEN v01.wup_id = 0 AND LEFT(v01.BELOS_ADRESSE_EMPFAENGER_ID, 2) = 'DC' THEN TRY_CAST(RIGHT(BELOS_ADRESSE_EMPFAENGER_ID,4) AS NUMBER(38,0)) ELSE COALESCE(v05.aktuell_wup_id,v01.wup_id)
END AS wup_id,
--COALESCE(CASE WHEN TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) = 0 THEN NULL ELSE v05.aktuell_wup_id END, TRY_CAST(belos_adresse_empfaenger_id AS INTEGER)) AS wup_id,
v01.lagerort_id,
v01.gp_id AS hgp_id,
v01.brtgew_sendung AS gewicht_sendung,
v01.zustellart_id,
v01.belos_vorgangart_id,
v01.transportauftrag_id,
v01.sonderabwicklung_id,
v01.belos_adresse_absender_num_id,
/* Falls Abholadresse nicht befüllt ist, ist die mit der Absenderadresse identisch.*/
COALESCE(v01.belos_adresse_abholung_id, v02.belos_adresse_id) AS belos_adresse_abholung_id,
--v01.belos_adresse_empfaenger_id,
COALESCE (CAST(v05.aktuell_wup_id AS VARCHAR), v01.belos_adresse_empfaenger_id)   AS belos_adresse_empfaenger_id,
COALESCE (v04.belos_adresse_num_id,v03.belos_adresse_num_id) AS belos_adresse_empf_num_id,   --> nochmal join auf belos_adresse mit aktuell_wup:
--COALESCE(CASE WHEN TRY_CAST(v03.belos_adresse_num_id AS INTEGER) = 0 THEN NULL ELSE v05.aktuell_wup_id END, v03.belos_adresse_num_id)  AS belos_adresse_empfaenger_num_id,
v01.belos_adresse_spedition_id,
v01.brtvol_stauraum AS vol_stauraum,
v01.debitor_id,
v01.anz_unterverpackung,
v01.unterverpackung_menge_einh_id,
v01.tour_id,
CASE
WHEN v01.tour_id < 0 THEN try_to_numeric(v01.transportauftrag_id)
WHEN v01.tour_id <= 2147483646 THEN CAST(v01.tour_id AS INTEGER) 
ELSE NULL END AS tour_id_auftrag,
v01.leergut_abh_fg,
v01.retouren_fg,
v01.industrie_abh_fg,
v01.lagernummer_id,
v01.anz_stellplatz AS anz_stellplatz_sap,
v01.anz_kolli,
CAST(COALESCE(v01.anz_stellplatz_belos,v01.anz_stellplatz) AS DECIMAL(9,3)) AS anz_stellplatz,
--,COALESCE(anz_stellplatz_belos,anz_stellplatz) AS anz_stellplatz
v01.mandant_id_debitor
FROM dbp_view.v_belos_vorgang v01
 
LEFT JOIN dbp_view.v_wup v05
   ON v05.mandant_id = CASE WHEN v01.mandant_id_debitor IS NULL OR v01.mandant_id_debitor = 0 THEN v01.mandant_id ELSE v01.mandant_id_debitor END
   AND v05.wup_id = CASE WHEN TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) END
   AND v05.nb_id = 0

LEFT JOIN dbp_view.v_belos_adresse v02
ON v01.mandant_id = v02.mandant_id
AND v01.belos_adresse_absender_num_id = v02.belos_adresse_num_id
 
LEFT JOIN dbp_view.v_belos_adresse v03
ON v01.mandant_id = v03.mandant_id
AND v01.belos_adresse_empfaenger_id = v03.belos_adresse_id
 
LEFT JOIN dbp_view.v_belos_adresse v04
ON v05.mandant_id = v04.mandant_id
AND v05.aktuell_wup_id = v04.belos_adresse_num_id

LEFT JOIN (SELECT mandant_id, wup_id, MIN(COALESCE(dat_tms_wanko, DATE'9999-12-31')) AS dat_wanko_von FROM DBP_MSI_data.TS_LAGERNUMMER_SORTIERUNG_SCM GROUP BY mandant_id, wup_id) dw
ON v01.belos_adresse_absender_num_id = dw.wup_id
AND v01.mandant_id = dw.mandant_id
 
WHERE
--   Eingeschränkt auf die Daten der Distributionslogistik
belosart_fg  = 1
AND NOT (v01.belos_adresse_absender_num_id IN (6922) AND v01.dat_leistung >= '2025-02-17')
AND NOT (v01.belos_adresse_absender_num_id IN (6921) AND v01.dat_leistung >= '2025-03-10')
AND   v01.dat_leistung < COALESCE(dw.dat_wanko_von, DATE'9999-12-31')

UNION  --wanko-rudimente

SELECT
DISTINCT

tms_tour.mandant_id AS MANDANT_ID,
	-1000 AS BELOS_VORGANG_ID,
	0 AS KOMPLETTLIEFERUNG_FG,
	0 AS LOESCH_FG,
	0 AS IN_TIME_FG,
	0 AS AV_FG,
	1 AS DISTRIBUTION_ABR_FG,
	0 AS SAMMEL_LADUNG_FG,
	0 AS NB_ID,
	'' AS SENDUNG_GEW_EINH_ID,
	'' AS SENDUNG_VOL_EINH_ID,
	DATE '1900-01-01' AS DAT_LIEF_SOLL,
	DATE '1900-01-01' AS DAT_ZUSTELLUNG,
	0 AS SENDUNG_ID,
	0 AS WUP_ID,
	'' AS LAGERORT_ID,
	0 AS HGP_ID,
	0 AS GEWICHT_SENDUNG,
	'' AS ZUSTELLART_ID,
	'' AS BELOS_VORGANGART_ID,
	'' AS TRANSPORTAUFTRAG_ID,
	'' AS SONDERABWICKLUNG_ID,
	TRY_CAST( tms_tour.startlager_tms_gp_id AS NUMBER) AS BELOS_ADRESSE_ABSENDER_NUM_ID,
	'' AS BELOS_ADRESSE_ABHOLUNG_ID,
	'' AS BELOS_ADRESSE_EMPFAENGER_ID,
	0 AS BELOS_ADRESSE_EMPF_NUM_ID,
	'' AS BELOS_ADRESSE_SPEDITION_ID,
	0 AS VOL_STAURAUM,
	0 AS DEBITOR_ID,
	0 AS ANZ_UNTERVERPACKUNG,
	'' AS UNTERVERPACKUNG_MENGE_EINH_ID,
	TRY_CAST( RIGHT(tms_tour.transportation_unit_id_ext, LENGTH(TRIM(tms_tour.transportation_unit_id_ext) ) -6 ) AS NUMBER) AS TOUR_ID,
	CASE WHEN tms_tour.tms_tourart_detail_id IN (4,5) THEN tms_tour.tms_tour_id -- tms_tour.tms_tour_bez
    -- VARCHAR Anpassung für Snowflake
    ELSE RIGHT(tms_tour.transportation_unit_id_ext, LENGTH(TRIM(tms_tour.transportation_unit_id_ext) ) -6 ) END TOUR_ID_AUFTRAG,
	0 AS LEERGUT_ABH_FG,
	0 AS RETOUREN_FG,
	0 AS INDUSTRIE_ABH_FG,
	'' AS LAGERNUMMER_ID,
	0 AS ANZ_STELLPLATZ_SAP,
	0 AS ANZ_KOLLI,
	0 AS ANZ_STELLPLATZ,
	tms_tour.mandant_id AS MANDANT_ID_DEBITOR

FROM dbp_view.v_tms_tour tms_tour
LEFT JOIN  ( SELECT mandant_id, wup_id, MIN(dat_tms_wanko) AS dat_tms_wanko 
            FROM DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM WHERE dat_tms_wanko IS NOT NULL
            GROUP BY mandant_id, wup_id ) dw
ON dw.mandant_id = tms_tour.mandant_id
AND dw.wup_id = TRY_CAST( tms_tour.startlager_tms_gp_id AS NUMBER)
LEFT JOIN ( SELECT mandant_id, wup_id, MIN(dat) AS dat FROM dbp_msi_data.ts_lagerort_ewm_dat GROUP BY mandant_id, wup_id ) ewm
ON ewm.mandant_id = tms_tour.mandant_id
AND ewm.wup_id = TRY_CAST( tms_tour.startlager_tms_gp_id AS NUMBER)
WHERE tms_tour.dat_tour >= COALESCE(dat_tms_wanko,DATE'9999-12-31')
AND tms_tour.dat_tour < COALESCE(ewm.dat,DATE'9999-12-31')
;