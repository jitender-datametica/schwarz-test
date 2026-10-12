CREATE OR REPLACE VIEW lec_share.v_fact_travel_booking_passenger
AS
SELECT
	*
FROM
	core.t_fact_travel_booking_passenger
;