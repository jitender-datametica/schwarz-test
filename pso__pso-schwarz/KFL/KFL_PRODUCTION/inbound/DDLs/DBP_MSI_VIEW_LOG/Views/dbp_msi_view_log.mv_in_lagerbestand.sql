CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_LAGERBESTAND(
	IN_ART_ID,
	MANDANT_ID,
	DAT,
	BEWERTUNGSKREIS_ID,
	GLD,
	MENGE_FREI,
	WERT_FREI,
	WERT_FREI_EURO,
	MENGE_UNFREI,
	WERT_UNFREI,
	WERT_UNFREI_EURO,
	WERT_FREI_EURO_LDOM,
	WERT_UNFREI_EURO_LDOM,
	WRG_ID,
	IN_LAGERORT_ID,
	WERK_ID
) AS

--AP0133256_SPEC0166769, dknop, initial
--2023-03-22,AP0162037, dknop, adding wert_unfrei_euro and wert_frei_euro for last day of month
--2024-03-04, dknop, updating logic for currency conversion
SELECT 
 in_a_bew.in_art_id
,in_a_bew.mandant_id
,in_a_bew.dat
,in_a_bew.bewertungskreis_id
,in_a_bew.betrag_preis_bestand / NULLIFZERO(in_a_bew.menge_bestand_bme) AS gld
,in_lag_per.menge_lgbest_frei_bme AS menge_frei
,gld * in_lag_per.menge_lgbest_frei_bme AS wert_frei
,CASE WHEN m_wrg.wrg_typ_id=0 THEN wert_frei * kurs.umrechnungskurs ELSE wert_frei END AS wert_frei_euro
,(in_lag_per.menge_lgbest_umlag_bme + in_lag_per.menge_lgbest_qual_bme + in_lag_per.menge_lgbest_nf_charge_bme + in_lag_per.menge_lgbest_gesp_bme + in_lag_per.menge_lgbest_ret_gesp_bme) AS menge_unfrei
,gld * (in_lag_per.menge_lgbest_umlag_bme + in_lag_per.menge_lgbest_qual_bme + in_lag_per.menge_lgbest_nf_charge_bme + in_lag_per.menge_lgbest_gesp_bme + in_lag_per.menge_lgbest_ret_gesp_bme) AS wert_unfrei
,CASE WHEN m_wrg.wrg_typ_id=0 THEN (wert_unfrei*kurs.umrechnungskurs) ELSE wert_unfrei END AS wert_unfrei_euro
,CASE WHEN in_a_bew.dat = LAST_DAY(in_a_bew.dat) THEN wert_frei_euro ELSE NULL END AS wert_frei_euro_ldom
,CASE WHEN in_a_bew.dat = LAST_DAY(in_a_bew.dat) THEN wert_unfrei_euro ELSE NULL END AS wert_unfrei_euro_ldom
,m_wrg.wrg_id
,in_lag_per.in_lagerort_id
,in_lag_per.werk_id

FROM dbp_view.v_in_art_bewertungskreis_tag in_a_bew

LEFT JOIN dbp_view.v_in_lagerbestand_per in_lag_per
ON in_a_bew.in_art_id=in_lag_per.in_art_id
AND in_a_bew.mandant_id=in_lag_per.mandant_id
AND in_a_bew.dat BETWEEN in_lag_per.dat_von AND in_lag_per.dat_bis
AND in_a_bew.bewertungskreis_id = in_lag_per.werk_id

 LEFT JOIN dbp_msi_view_log.mv_kurs kurs
   ON in_a_bew.wrg_id = kurs.von_wrg_id
   INNER JOIN dbp_view.v_mandant_wrg_typ_zu m_wrg ON in_a_bew.mandant_id=m_wrg.mandant_id  
   INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU wrg_user ON m_wrg.wrg_typ_id = wrg_user.wrg_typ_id

;
