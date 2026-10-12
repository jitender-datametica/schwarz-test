CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_RICHTUNG(
	RICHTUNG_ID,
	RICHTUNG_BEZ
) AS
--AP0230823,SPEC0266004, dknop, initial

SELECT 
 1 AS richtung_id
, 'OneWay' AS richtung_bez
UNION
SELECT 
 2 AS richtung_id
, 'Rundlauf' AS richtung_bez
UNION
SELECT 
 3 AS richtung_id
, 'Sonstige' AS richtung_bez
UNION
SELECT 
 4 AS richtung_id
, 'Industrieabholung' AS richtung_bez

;