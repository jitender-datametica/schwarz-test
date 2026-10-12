CREATE TABLE p_lew_mart_lead.t_miss_itm_wh_day_asis_1 (
	client_id NUMBER(38,0) NOT NULL,
	wh_loc_sid NUMBER(38,0) NOT NULL,
	wh_id NUMBER(38,0) NOT NULL,
	item_sid NUMBER(38,0) NOT NULL,
	dat_formdate DATE NOT NULL,
	cy_month NUMBER(38,0),
	cy_partial_week_id NUMBER(38,0),
	cy_week NUMBER(38,0),
	busyear NUMBER(38,0),
	miss_itm_wh_fg NUMBER(38,0),
	miss_itm_store_15_fg NUMBER(38,0),
	miss_item_fg NUMBER(38,0)
)
;