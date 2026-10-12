create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_ENTRY_MONAT_AUS_1(
	KJMO,
	E_MONAT,
	DAT_E
) as
--2025-04-08, AP0183652 initial
 
SELECT
 
   refer.KJMO,
   actual.KJMO AS E_MONAT,
   actual.dat AS dat_e         
FROM dbp_view.v_tag_1 refer 
JOIN dbp_view.v_tag_1 actual
   ON actual.dat BETWEEN LAST_DAY(DATEADD(MONTH, -6, refer.dat)) AND LAST_DAY(refer.dat)
  
    WHERE  
    actual.dat<>LAST_DAY(refer.dat)
GROUP BY
actual.dat,
refer.KJMO,
actual.KJMO;