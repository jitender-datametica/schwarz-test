create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_L_LIN_KURS_2(
	MANDANT_ID,
	LIN_KURS_ID,
	LIN_KURSGRUPPE_ID,
	SORTKZ,
	LIN_BERICHT
) as
SELECT v01.mandant_id
      ,v01.lin_kurs_id
      ,v01.lin_kursgruppe_id
      ,v01.sortkz
   ,v01.lin_bericht
FROM dbp_view.v_l_lin_kurs_2 v01
WHERE lin_bericht IN ('EWL', 'GSL')
   OR lin_bericht IS NULL;