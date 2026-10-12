CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ADVERT_MEDIUM_GRP

AS
   SELECT
   amg.client_id
,   TO_DATE('1900-01-01','YYYY-MM-DD')                                                    AS DATE_valid_from
,   TO_DATE('9999-12-31','YYYY-MM-DD')                                                    AS DATE_valid_to
,   amg.adv_medium_grp_sid
,   amg.adv_medium_grp_descr                                                              AS advert_medium_grp_descr
,   amg.adv_medium_grp_sort_val                                                           AS adv_medium_grp_disp_order_nbr
,   0::SMALLINT                                                                           AS adv_medium_ignore_fg
,   0::SMALLINT                                                                           AS adv_medium_delete_fg
,   0::SMALLINT                                                                           AS adv_medium_grp_LidlPlus_fg
,   amg.dwh_created
,   CAST( ( amg.adv_medium_grp_sid *100::INTEGER ) +  amg.client_id AS INTEGER)           AS adv_medium_grp_mstr_sid
   FROM p_lew_mart_pit_onprem.t_advert_medium_group amg;