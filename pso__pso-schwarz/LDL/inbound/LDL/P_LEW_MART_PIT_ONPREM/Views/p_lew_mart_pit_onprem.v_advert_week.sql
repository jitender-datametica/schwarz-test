CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_ADVERT_WEEK
(
     client_id
,          adv_week_id
,          adv_week_sid
,          adv_week_seq
,          adv_week_descr
,          adv_week_long_descr
,          adv_week_year_num
,          adv_week_week_num
,          adv_week_start_dt
,          adv_week_end_dt
,          dwh_created
,          dwh_upDATEd
)
AS
(SELECT
Awk.client_id              AS client_id
,Awk.adv_week_id            AS adv_week_id
,Awk.adv_week_sid           AS adv_week_sid
,Awk.adv_week_seq           AS adv_week_seq
,Awk.adv_week_descr         AS adv_week_descr
,Awk.adv_week_long_descr    AS adv_week_long_descr
,Awk.adv_week_year_num      AS adv_week_year_num
,Awk.adv_week_week_num      AS adv_week_week_num
,Awk.adv_week_start_dt      AS adv_week_start_dt
,Awk.adv_week_end_dt        AS adv_week_end_dt
,Awk.dwh_created            AS dwh_created
,Awk.dwh_upDATEd            AS dwh_upDATEd
FROM p_lew_mart_pit_onprem.t_advert_week        AS Awk
);