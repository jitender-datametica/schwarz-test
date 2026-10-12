create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_LINBEW_NONMAKS_2(
	MANDANT_ID,
	LIN_KURS_ID,
	HR_OBJEKT_ID,
	KJMO,
	KI_FG,
	ANZAHL_KURSE_GESAMT,
	ANZAHL_KURSE_ABGESCHLOSSEN
) as
SELECT
 v01.mandant_id
,v01.lin_kurs_id
,v01.hr_objekt_id
,v02.kjmo
--,unternehmens_bereich_id
,v01.ki_fg
,v01.anzahl_kurse_gesamt
,v01.anzahl_kurse_abgeschlossen

FROM dbp_view.v_linbew_nonmaks_2 v01
INNER JOIN dbp_view.v_tag_2 v02
   ON v02.dat = v01.dat
WHERE v01.hr_objekt_id > 0
QUALIFY Row_Number() Over (PARTITION BY v01.mandant_id, v01.lin_kurs_id, v01.hr_objekt_id, v02.kjmo, v01.ki_fg ORDER BY v02.dat DESC) = 1;