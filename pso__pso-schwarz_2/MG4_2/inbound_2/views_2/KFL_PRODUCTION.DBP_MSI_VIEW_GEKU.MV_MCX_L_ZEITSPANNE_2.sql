create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MCX_L_ZEITSPANNE_2(
	ZEITSPANNE_ID,
	ZEITSPANNE_SORT_KEY
) as
--lsvi0303: AP0043627, SPEC0055162 Atributt Einkaufszeit

SELECT 

zeitspanne_id
,zeitspanne_sort_key

FROM dbp_view.v_mcx_l_zeitspanne_2;