CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_ENTRY_MONAT_AUS_2(
	KJMO,
	E_MONAT,
	DAT_E
) AS
--2025-04-08, AP0183652 initial
 
SELECT
 
   refer.KJMO,
   actual.KJMO AS E_MONAT,
   actual.dat AS dat_e         
FROM dbp_view.v_tag_2 refer 
JOIN dbp_view.v_tag_2 actual
   ON actual.dat BETWEEN LAST_DAY(DATEADD(MONTH, -6, refer.dat)) AND LAST_DAY(refer.dat)
  
    WHERE  
    actual.dat<>LAST_DAY(refer.dat)
GROUP BY
actual.dat,
refer.KJMO,
actual.KJMO;
