CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_NACHSCHUBZEITEN_1(
	MANDANT_ID,
	LAGERAUFTRAG_ID,
	DATZEIT_ERSTELLUNG,
	DAT_ERSTELLUNG,
	LAGERPROZESSART_ID_BELEGKOPF,
	NACHSCHUB_OPTION_ID,
	LSD_BERECHNUNGSART_ID,
	AKTIVITAETSBEREICH_ID,
	QUEUE_ID,
	DATZEIT_LSD_BERECHNUNG,
	DATZEIT_START_MAX,
	DATZEIT_LSD,
	LAGERAUFTRAG_STATUS_ID,
	LAGERTYP_ID_NACH,
	LAGERPLATZ_ID_NACH,
	LAGERSORTIMENT_ID,
	FREMD_LAGERORT_ID,
	ARTIKELSORTIMENT_ID,
	LAGERNUMMER_ID,
	ART_ID,
	LAGERTYP_ID_VON,
	LAGERPLATZ_ID_VON,
	LAGERAUFGABE_ID_STEP1,
	LAGERAUFGABE_POS_ID_STEP1,
	DATZEIT_QUITTIERUNG_STEP1,
	LAGERAUFGABE_ID_STEP2,
	LAGERAUFGABE_POS_ID_STEP2,
	DATZEIT_QUITTIERUNG_STEP2,
	LAGERAUFGABE_ID_STEP3,
	LAGERAUFGABE_POS_ID_STEP3,
	DATZEIT_QUITTIERUNG_STEP3,
	EWM_GV_ID
) AS
-- 2022-02-09, dknop, adding ordim_c.lagernummer_id = who.lagernummer_id
-- 2022-02-09, dknop, adding OR ordim_c.lagertyp_id_von LIKE '%4FHP'
-- 2023-05-16, dknop, updating definition of nachschub_prozessschritt_id (removing '4' from '%4EHP' and '%4FHP')
-- 2024-03-19, dknop, adding %B%% to nachschub_prozessschritt_id
-- 2024-05-23,        adding lagerplatz_id_von, lagerplatz_id_nach
-- 2024-08-15, snik,  adding 4N01 in ordim_c.lagerprozessart_id  IN ('0N01','0N02','4N01')
--2024-09-06,NSR4744664, dknop, changing filter for lagerprozessart_id to  like '%N0%''
--2024-09-06,NSR4744664, dknop, correcting filter for lagerprozessart_id  to IN ('0N01','0N02', '4N02')
--2025-01-24, INC10171521, dknop, datzeit_lsd_berechnung +1 hour for mandant_id in (4,7,8)
--2025-04-07, dknop, adding ordim_c.lagertyp_id_von LIKE '%2R53%'
--2025-05-08, dknop, INC10785730, datzeit_lsd_berechnung +1 hour only if datzeit_lsd_berechnung is >= 30 minutes BEFORE datzeit_erstellung for mandant_id in (4,7,8) 
WITH t0 (mandant_id
    ,lagerauftrag_id
    ,dat_erstellung
    ,datzeit_erstellung
    ,lagerauftrag_status_id        
    ,lagerprozessart_id
    ,lagerprozessart_id_belegkopf  
    ,lagertyp_id_von
    ,lagerplatz_id_von
    ,lagertyp_id_nach
    ,lagerplatz_id_nach
    ,nachschub_option_id
    ,lsd_berechnungsart_id
    ,aktivitaetsbereich_id
    ,queue_id
    ,datzeit_lsd_berechnung
    ,datzeit_start_max
    ,nachschub_prozessschritt_id
    ,datzeit_quittierung  
    ,datzeit_start
    ,relevant
    ,lageraufgabe_id
    ,lageraufgabe_pos_id
    ,handling_unit_id_nach
    ,art_guid
    ,lagernummer_id
    ,ewm_gv_id)
AS (
 SELECT
      who.mandant_id
    ,who.lagerauftrag_id
    ,CAST(who.datzeit_erstellung AS DATE) AS dat_erstellung
    ,who.datzeit_erstellung
    ,who.lagerauftrag_status_id        
    ,ordim_c.lagerprozessart_id
    ,who.lagerprozessart_id_belegkopf  
    ,ordim_c.lagertyp_id_von
    ,ordim_c.lagerplatz_id_von
    ,ordim_c.lagertyp_id_nach
    ,ordim_c.lagerplatz_id_nach
    ,who.nachschub_option_id
    ,who.lsd_berechnungsart_id
    ,who.aktivitaetsbereich_id
    ,who.queue_id  
     ,CASE WHEN who.mandant_id IN (4,7,8) AND DATEDIFF(MINUTE, who.datzeit_lsd_berechnung,who.datzeit_erstellung)>=30 THEN TIMEADD ('hour', 1, who.datzeit_lsd_berechnung) 
          ELSE who.datzeit_lsd_berechnung END AS datzeit_lsd_berechnung
      ,who.datzeit_start_max
    --nachschub prozess-schritt:
    ,CASE 
        WHEN (ordim_c.lagertyp_id_von LIKE '%R03' OR ordim_c.lagertyp_id_von LIKE '%R13' OR ordim_c.lagertyp_id_von LIKE '%FAP'
              OR ordim_c.lagertyp_id_von LIKE '%EHP' OR ordim_c.lagertyp_id_von LIKE '%FHP' OR ordim_c.lagertyp_id_von LIKE '%B0%'OR ordim_c.lagertyp_id_von LIKE '%B1%' OR ordim_c.lagertyp_id_von LIKE '%2R53%') AND TRIM(COALESCE(ordim_c.lagertyp_id_nach,'')) = '' THEN 1
        WHEN ordim_c.lagertyp_id_nach LIKE '%G%' THEN 2
        WHEN ordim_c.lagertyp_id_nach LIKE '%R%' THEN 3
    END AS nachschub_prozessschritt_id
    ,ordim_c.datzeit_quittierung 
    ,ordim_c.datzeit_start
    ,ROW_NUMBER() OVER (PARTITION BY ordim_c.mandant_id, lageraufgabe_id, nachschub_prozessschritt_id ORDER BY datzeit_quittierung ASC) AS relevant
    ,ordim_c.lageraufgabe_id
    ,ordim_c.lageraufgabe_pos_id
    ,ordim_c.handling_unit_id_nach
    ,ordim_c.art_guid
    ,ordim_c.lagernummer_id
    ,ordim_c.ewm_gv_id
    FROM dbp_view.v_lagerauftrag_1 who
     JOIN dbp_view.v_lageraufgabe_1 ordim_c
     ON ordim_c.mandant_id = who.mandant_id
     AND ordim_c.lagerauftrag_id = who.lagerauftrag_id
     AND ordim_c.lagernummer_id = who.lagernummer_id
       WHERE ordim_c.status_id = 'C' AND ordim_c.lagerprozessart_id IN ('0N01','0N02', '4N02')
  --AND ordim_c.lagerprozessart_id  LIKE '%N0%'  --  

) 
SELECT 
     t0.mandant_id
    ,t0.lagerauftrag_id
    ,t0.datzeit_erstellung
    ,t0.dat_erstellung
    ,t0.lagerprozessart_id_belegkopf
    ,t0.nachschub_option_id
    ,t0.lsd_berechnungsart_id
    ,t0.aktivitaetsbereich_id
    ,t0.queue_id
    ,t0.datzeit_lsd_berechnung
    ,t0.datzeit_start_max
    ,CASE WHEN t0.datzeit_start_max = '9999-12-30 01:00:00' THEN NULL ELSE t0.datzeit_start_max END AS datzeit_lsd
    ,t0.lagerauftrag_status_id
    ,t01.lagertyp_id_nach
    ,t01.lagerplatz_id_nach --from step2 as specified
    ,LEFT(t01.lagertyp_id_nach,1) AS lagersortiment_id
    ,marc.fremd_lagerort_id
    ,a_sort.artikelsortiment_id
    ,t0.lagernummer_id
    ,art_guid.art_id
    ,t0.lagertyp_id_von
    ,t0.lagerplatz_id_von
    ,t0.lageraufgabe_id AS lageraufgabe_id_step1
    ,t0.lageraufgabe_pos_id AS lageraufgabe_pos_id_step1
    ,t0.datzeit_start AS datzeit_quittierung_step1
    ,t01.lageraufgabe_id AS lageraufgabe_id_step2
    ,t01.lageraufgabe_pos_id AS lageraufgabe_pos_id_step2
    ,t01.datzeit_quittierung AS datzeit_quittierung_step2
    ,t02.lageraufgabe_id AS lageraufgabe_id_step3
    ,t02.lageraufgabe_pos_id AS lageraufgabe_pos_id_step3
    ,t02.datzeit_quittierung AS datzeit_quittierung_step3
-- (datzeit_quittierung_step2 - t0.datzeit_lsd_berechnung) day to second as nachschubzeit,
-- (extract(day from nachschubzeit)*24*60)+(extract(hour from nachschubzeit)*60)+extract(minute from nachschubzeit)+(extract(second from nachschubzeit)/60) 
--  as nachschubzeit_minutes,
--  (datzeit_quittierung_step1 - datzeit_lsd ) day(4) to second as delta_startzeitpunkt,
-- (extract(day from delta_startzeitpunkt)*24*60)+(extract(hour from delta_startzeitpunkt)*60)+extract(minute from delta_startzeitpunkt)+(extract(second from delta_startzeitpunkt)/60) 
--  as delta_startzeitpunkt_minutes,
	,t0.ewm_gv_id
FROM t0 --step1 data
JOIN dbp_view.v_art_guid_zu_1 art_guid
ON t0.mandant_id = art_guid.mandant_id
AND t0.art_guid = art_guid.art_guid
JOIN dbp_view.v_l_lagernummer_1 t001l
ON t0.mandant_id = t001l.mandant_id
AND t0.lagernummer_id = t001l.lagernummer_id
JOIN dbp_view.v_art_wup_status_per_1 marc_1 
ON t0.mandant_id = marc.mandant_id 
AND art_guid.art_id = marc.art_id
AND t001l.wup_id = marc.wup_id
AND marc.dat_bis='9999-12-31'
JOIN  dbp_view.v_fremd_lagerort_artikelsortiment_zu_1 a_sort
ON marc.fremd_lagerort_id = a_sort.fremd_lagerort_id
AND marc.mandant_id=a_sort.mandant_id
LEFT JOIN  t0 AS t01 
ON t0.mandant_id = t01.mandant_id --step2 data
AND t0.lagerauftrag_id = t01.lagerauftrag_id
AND t0.lagernummer_id = t01.lagernummer_id
AND (t0.handling_unit_id_nach =COALESCE(t01.handling_unit_id_nach,t0.handling_unit_id_nach) 
    OR t0.handling_unit_id_nach =(CASE WHEN t0.handling_unit_id_nach = '' THEN t01.handling_unit_id_nach ELSE t0.handling_unit_id_nach END))
AND t0.relevant = t01.relevant
AND t01.nachschub_prozessschritt_id=2
LEFT JOIN t0 AS t02 
ON t0.mandant_id = t02.mandant_id --step3 data
AND t0.lagerauftrag_id = t02.lagerauftrag_id
AND t0.lagernummer_id = t02.lagernummer_id
AND (t0.handling_unit_id_nach =COALESCE(t01.handling_unit_id_nach,t0.handling_unit_id_nach) 
    OR t0.handling_unit_id_nach =(CASE WHEN t0.handling_unit_id_nach = '' THEN t01.handling_unit_id_nach ELSE t0.handling_unit_id_nach END))
AND t0.relevant = t02.relevant
AND t02.nachschub_prozessschritt_id=3
WHERE t0.relevant=1 AND t0.nachschub_prozessschritt_id=1

;