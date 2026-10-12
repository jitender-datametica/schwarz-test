create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_MANDANT_1(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ,
	MANDANT_SORT_ID,
	DEFAULT_WRG
) as
   SELECT
   v01.mandant_id, v01.mandant_bez, CASE WHEN v01.mandant_id = 1 THEN 'DE' ELSE v01.mandant_kbez END AS mandant_kbez, v01.mandant_sort_id, v01.default_wrg
   FROM dbp_view.v_mandant_1 v01;