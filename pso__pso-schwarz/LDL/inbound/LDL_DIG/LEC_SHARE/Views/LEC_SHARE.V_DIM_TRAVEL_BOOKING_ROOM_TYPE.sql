CREATE OR REPLACE VIEW lec_share.v_dim_travel_booking_room_type
AS
SELECT
	*
FROM
	core.t_dim_travel_booking_room_type
;