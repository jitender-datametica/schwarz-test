CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TMS_TOUR_SERVICE_1(
	TOUR_SERVICE_ID,
	TOUR_SERVICE_BEZ
) AS
--AP0230823,SPEC0266004, dknop, initial
SELECT
 'TK' AS tour_service_id
,'Tiko' AS tour_service_bez
UNION
SELECT
 'GK' AS tour_service_id
,'Gekühlt' AS tour_service_bez
UNION
SELECT
 'TE' AS tour_service_id
,'Temperaturgeführt' AS tour_service_bez
UNION
SELECT
 'UK' AS tour_service_id
,'Ungekühlt' AS tour_service_bez
;