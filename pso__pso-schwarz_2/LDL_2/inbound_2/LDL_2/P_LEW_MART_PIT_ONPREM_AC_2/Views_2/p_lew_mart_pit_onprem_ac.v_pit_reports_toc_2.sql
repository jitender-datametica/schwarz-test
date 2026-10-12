CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_REPORTS_TOC_2
AS
SELECT
report_id
,client_id
,adv_week_sid
,adv_week_rltd_sid
,dwh_valid_from
,dwh_valid_to
,report_sorting_val
,report_name
,report_guid
,report_annotation
,report_visible_fg
,report_teaser_fg
,report_type_fg
,report_panel_name
,report_panel_pskey
,report_panel_pkey
,_count
,html_web_link_image
,html_web_link
,html_web_link_list
,html_web_link_native
FROM p_lew_mart_pit_onprem.v_pit_reports_toc_2;