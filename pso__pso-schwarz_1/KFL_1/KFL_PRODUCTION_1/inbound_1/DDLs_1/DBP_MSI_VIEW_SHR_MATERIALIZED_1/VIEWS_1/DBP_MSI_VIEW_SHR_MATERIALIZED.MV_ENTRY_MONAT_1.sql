create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_ENTRY_MONAT_1(
	KJMO,
	E_MONAT,
	DAT_E
) as
--2024-11-04, SPEC0245316, initial
--2025-04-08, krawczykp: logic completetly changed to fulfill gaps in dat_e column.
 
SELECT 
   refer.KJMO,
   actual.KJMO AS E_MONAT,
   actual.dat AS dat_e         
FROM dbp_view.v_tag_1 refer 
JOIN dbp_view.v_tag_1 actual
   ON actual.dat BETWEEN DATEADD(MONTH, -5, refer.dat) AND LAST_DAY(refer.dat)
GROUP BY 
actual.dat,
refer.KJMO,
actual.KJMO;