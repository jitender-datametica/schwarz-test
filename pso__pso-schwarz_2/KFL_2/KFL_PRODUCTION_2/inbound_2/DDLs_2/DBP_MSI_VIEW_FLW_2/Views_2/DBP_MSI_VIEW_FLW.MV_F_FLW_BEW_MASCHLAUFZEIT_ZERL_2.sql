CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_BEW_MASCHLAUFZEIT_ZERL_2(
	WERK_ID,
	TERMINAL_ID,
	EXT_TIERNUMMER,
	PRODUKTIONSZYKLUSID,
	IN_ART_ID,
	PRODUKTIONSTAG,
	MANDANT_ID,
	ZEITSTEMPEL_ERFASSSUNG,
	IDENT_FLAG,
	ANZAHL_KOLLI,
	MENGE_BME,
	MENGE_DME,
	NETTOGEW,
	BETRAG_BEW,
	DAUER,
	UNTERBERECHUNGSZEIT,
	UNTERBRECHUNGEN,
	IDENT_WECHSELTIME,
	START_TS,
	END_TS
) AS
--04.10.2023 twie: SPEC0208428 spezielle Logik für Zerlegung, angelehnt an MV_F_FLW_BEW_MASCHLAUFZEIT_2

WITH basic AS (SELECT werk_id,dat_erfasst, zeit_erfasst, 
terminal_id,
ext_tiernummer,
in_art_id,
mandant_id,
betrag_bew, --auszeichnungspreis
CAST ( dat_erfasst || ' ' || zeit_Erfasst AS TIMESTAMP(3)  ) AS new_tss,
CASE WHEN (zeit_erfasst < '04:00:00') THEN dat_erfasst -1 ELSE Dat_Erfasst END AS Produktionstag,
menge_bme, 
menge_dme,
nettogew

 FROM DBP_MSI_VIEW_FLW.MV_F_FLW_BEW_2  
	
WHERE flw_beleg_typ_id = 'WA'
 -- Einschrankung auf die letzten beiden GJ und das aktuelle GJ              
AND dat_erfasst >= to_Date('01.03.' ||CAST( YEAR(CURRENT_DATE)-2 AS VARCHAR), 'dd.mm.yyyy')
)
, wechsel_tab AS (
SELECT basic.*,
--- Zeit_2 davor 
LAG(new_tss) OVER (PARTITION BY werk_id,Produktionstag, terminal_id ORDER BY  werk_id, dat_erfasst, zeit_erfasst,terminal_id) AS time_Davor,
-- Identwechsel
LAG(ext_tiernummer) OVER (PARTITION BY werk_id,Produktionstag, terminal_id ORDER BY  werk_id, dat_erfasst, zeit_erfasst,terminal_id) AS ident_vorher

FROM basic),

tab2 AS (
SELECT    wechsel_tab.*,

TIMESTAMPDIFF('second',time_davor,new_tss) AS Zeitdiff_sec,

--Identwechsel
CASE WHEN ident_vorher <> ext_tiernummer OR ident_vorher IS NULL THEN 1 ELSE 0 END AS ident_flag,

SUM(ident_flag) OVER (PARTITION BY werk_id, Produktionstag ,terminal_id ORDER BY werk_id, dat_erfasst, zeit_erfasst  ROWS UNBOUNDED PRECEDING) AS anz_wechsel
FROM wechsel_tab
 ) 
, tab03 AS(
SELECT tab2.*,
MAX(new_tss) OVER (PARTITION BY anz_wechsel) AS end_time,
---
TRIM(terminal_id) || '_' || TO_CHAR(anz_wechsel, 'fm000') AS ProduktionszyklusID,

-- timegaps 
-- Ident
CASE WHEN ident_flag = 1 AND  Zeitdiff_sec <= 600 THEN Zeitdiff_sec
WHEN ident_flag = 1 AND Zeitdiff_sec > 600 THEN 600.0
ELSE 0.0  END AS ident_wechseltime,

-- Unterbrechung 
-- wenn kein Wechsel vorliegt, dann liegt eine_2 Unterbrechung vor bei einer Dauer ueber 1 min
-- wenn ein Wechsel vorliegt, dann werden 10 min dem Wechsel zu geschrieben und alles darueberhinaus der Unterbrechung
CASE WHEN (Zeitdiff_sec > 60 AND   ident_flag = 0 )
OR (Zeitdiff_sec > 600 AND  ident_flag = 1 )
 THEN 1 ELSE 0 END AS Unterbrechungen,

-- Unterbrechungszeit. 
CASE WHEN Unterbrechungen = 1 AND ( ident_flag = 1)
      THEN Zeitdiff_sec - ident_wechseltime
WHEN Unterbrechungen = 1 AND   ident_flag = 0
      THEN Zeitdiff_sec
ELSE 0 
END AS unterberechungszeit
FROM tab2)

SELECT werk_id,
terminal_id,
ext_tiernummer,
ProduktionszyklusID,
in_art_id, 
Produktionstag,
mandant_id,
new_tss AS Zeitstempel_erfasssung,

SUM(ident_flag) AS ident_flag, 

COUNT(in_art_id) AS Anzahl_Kolli,
SUM(menge_bme) AS menge_bme, 
SUM(menge_dme) AS menge_dme, 
SUM(nettogew) AS nettogew, 
SUM(betrag_bew) AS betrag_bew,
SUM(Zeitdiff_sec) AS dauer,
--unterbrechungen 
SUM(unterberechungszeit) AS unterberechungszeit, 
SUM( Unterbrechungen) AS unterbrechungen, 
--Wechselzeit 
SUM(ident_wechseltime) AS ident_wechseltime,

CASE WHEN time_davor IS NULL THEN new_tss ELSE time_davor END AS Start_ts,
CAST(MAX(new_tss) AS TIME) AS End_ts

FROM Tab03

GROUP BY werk_id,
terminal_id,
ext_tiernummer,
ProduktionszyklusID,
in_art_id, 
Produktionstag, mandant_id, new_tss,
time_davor
;