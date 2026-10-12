CREATE OR REPLACE VIEW s_conl.v_brand_2
AS
SELECT
 client_id
    , brand_sid
    , src_brand_cd
    , brand_name
    , brand_type_cd
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_core_ac.v_brand_2
	WHERE client_id IN
		(SELECT
client_id
FROM s_conl.t_user_mapping_2 WHERE lower(user_name) = lower(current_user));

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_core_ac.v_wawi_cal_busyear_cum_2" ***/

