CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_TOURART(
	TOURART_ID,
	TOURART_BEZ
) AS
--AP0230823,SPEC0266004, dknop, initial
--AP0230823,SPEC0266004, dknop, removing 'Fleischwerk Shuttle'
--AP0230823,SPEC0266004, nwag, rename manual tour to zusatztour
--nw, add 7 for Int. Transport
SELECT 
 1 AS tourart_id
, 'Filialbelieferung' AS tourart_bez
UNION
SELECT 
 2 AS tourart_id
, 'Shuttle' AS tourart_bez
UNION
SELECT 
 3 AS tourart_id
, 'Hofverkehr' AS tourart_bez
UNION
SELECT 
 4 AS tourart_id
, 'Industrieabholung' AS tourart_bez
UNION
SELECT 
 5 AS tourart_id
, 'Zusatztour' AS tourart_bez
UNION
SELECT 
 6 AS tourart_id
, 'Fleischwerktour' AS tourart_bez
UNION
SELECT 
 7 AS tourart_id
, 'Int. Transport' AS tourart_bez
;