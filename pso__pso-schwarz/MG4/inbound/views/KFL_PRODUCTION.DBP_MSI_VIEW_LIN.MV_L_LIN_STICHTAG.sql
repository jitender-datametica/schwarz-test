create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_L_LIN_STICHTAG(
	KJMO
) as
   SELECT kjmo
   FROM dbp_view.v_monat
   
   WHERE akt_mo_komplett BETWEEN -11 AND 0
   GROUP BY kjmo
;