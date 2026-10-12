create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MANDANT(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ,
	MANDANT_SORT_ID
) as
--02.01.2023 twie: NSR3425817 mandant_sort_id hinzugefügt

   SELECT
     mandant_id
   , mandant_bez
   , mandant_kbez
   ,mandant_sort_id
   FROM dbp_view.v_mandant;