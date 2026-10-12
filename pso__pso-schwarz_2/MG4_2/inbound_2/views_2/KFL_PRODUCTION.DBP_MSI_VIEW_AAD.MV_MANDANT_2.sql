create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_MANDANT_2(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ,
	MANDANT_SORT_ID
) as
--07.06.2023 twie: SPEC0200542 Lookup Mandant_2
SELECT
     mandant_id
   , mandant_bez
   , mandant_kbez
   ,mandant_sort_id
FROM dbp_view.v_mandant_2;