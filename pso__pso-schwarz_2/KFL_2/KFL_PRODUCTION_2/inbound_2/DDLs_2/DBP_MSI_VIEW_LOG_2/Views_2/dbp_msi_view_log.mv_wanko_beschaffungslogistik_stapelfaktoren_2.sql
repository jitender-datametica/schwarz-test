CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_WANKO_BESCHAFFUNGSLOGISTIK_STAPELFAKTOREN_2(
	MANDANT_ID,
	DAT_LIEF,
	BELADESTELLE_TMS_GP_ID,
	VERSENDER_TMS_GP_ID,
	SYSTEM_ID,
	TMS_GP_PLZ,
	EMPFAENGER_TMS_GP_ID,
	ART_ID,
	HANDLING_UNIT_ID_NACH,
	TMS_AUFTRAG_ID,
	LAGE_FAKTOR_EINH_ID,
	FAKTOR_LAG,
	HOEHE,
	ANZAHL_LAGEN,
	PAL_HOEHE_CM_GERECHNET,
	VORHOLSPEDITION_TMS_GP_TYP_CD,
	HOEHE_STAPELFAKTOR,
	GEWICHT_NETTO,
	GEWICHT_BRUTTO,
	GEWICHT_BRUTTO_GERECHNET,
	MENGE_KOLLI,
	MENGE_IST_BME,
	MENGE_PAL
) AS
--2025-07-30, dknop, AP0284464_SPEC0324632, initial
--2025-08-21, nwag2310, AP0284464_SPEC0324632, kolli height as fallback

SELECT 
 tms_a.mandant_id
,dat_lief
,tms_a.beladestelle_tms_gp_id
,tms_a.versender_tms_gp_id
,tms_a.system_id
,gp.tms_gp_plz
,tms_a.empfaenger_tms_gp_id
,lag_we.art_id
,lag_we.handling_unit_id_nach
,tms_a.tms_auftrag_id
,maw1.lage_faktor_einh_id
,COALESCE(marm_lag.umrech_zaehler/marm_lag.umrech_nenner,1) AS faktor_lag
,CASE WHEN COALESCE(marm_lag.hoehe,0) > 0 THEN marm_lag.hoehe WHEN COALESCE(marm_kolli.hoehe,0) > 0 THEN marm_kolli.hoehe ELSE COALESCE(marm_wausm.hoehe,0) END AS hoehe_
,lag_we.menge_ist_bme/faktor_lag AS anzahl_lagen
,anzahl_lagen * hoehe_ + 15 AS pal_hoehe_cm_gerechnet
,CASE WHEN tms_a.vorholspedition_tms_gp_typ_cd = 'S' THEN 'Quellgebiet' ELSE 'Direkt' END AS vorholspedition_tms_gp_typ_cd
,CASE WHEN pal_hoehe_cm_gerechnet BETWEEN 0 AND 35.99 THEN 5
      WHEN pal_hoehe_cm_gerechnet BETWEEN 36 AND 50.99 THEN 4
      WHEN pal_hoehe_cm_gerechnet BETWEEN 51 AND 80.99 THEN 3
      WHEN pal_hoehe_cm_gerechnet BETWEEN 81 AND 120.99 THEN 2
      --WHEN pal_hoehe_cm_gerechnet > 120 THEN 1
      ELSE 1 END hoehe_stapelfaktor
,lag_we.gewicht_netto
,lag_we.gewicht_brutto
,670/lag_we.gewicht_brutto AS gewicht_brutto_gerechnet
,lag_we.menge_kolli
,lag_we.menge_ist_bme
,lag_we.menge_pal
FROM dbp_view.v_tms_auftrag_2 tms_a

JOIN dbp_view.v_tms_gp_2 gp_2
ON tms_a.beladestelle_tms_gp_id = gp.tms_gp_id
AND tms_a.mandant_id = gp.mandant_id
AND tms_a.system_id = gp.system_id

JOIN dbp_msi_data.lageraufgabe_we_2 lag_we
ON tms_a.tms_auftrag_id = lag_we.best_beleg_id
AND tms_a.mandant_id = lag_we.mandant_id
AND lag_we.lagerprozessart_id = '0LUL'

/*JOIN dbp_view.v_handling_unit_ewm_2 hu_ewm
ON --lag_we.handling_unit_id_nach = hu_ewm.handling_unit_id
 lag_we.mandant_id = hu_ewm.mandant_id
AND lag_we.lageraufgabe_id = hu_ewm.lageraufgabe_id*/

JOIN dbp_view.v_art_vorschlagswert_per_2 maw1_2
ON lag_we.art_id = maw1.art_id
AND lag_we.mandant_id = maw1.mandant_id
AND lag_we.dat_we BETWEEN maw1.dat_von AND maw1.dat_bis

LEFT JOIN dbp_view.v_art_umrechnung_faktor_per_2 marm_lag
ON marm_lag.dat_bis ='9999-12-31'
AND marm_lag.altnv_menge_einh_id = maw1.lage_faktor_einh_id
AND marm_lag.mandant_id = maw1.mandant_id
AND marm_lag.art_id = maw1.art_id

LEFT JOIN dbp_view.v_art_umrechnung_faktor_per_2 marm_kolli
ON marm_kolli.dat_bis ='9999-12-31'
AND marm_kolli.altnv_menge_einh_id = maw1.zl_kolli_menge_einh_id
AND marm_kolli.mandant_id = maw1.mandant_id
AND marm_kolli.art_id = maw1.art_id

LEFT JOIN dbp_view.v_art_umrechnung_faktor_per_2 marm_wausm
ON marm_wausm.dat_bis ='9999-12-31'
AND marm_wausm.altnv_menge_einh_id = maw1.ausg_menge_einh_id
AND marm_wausm.mandant_id = maw1.mandant_id
AND marm_wausm.art_id = maw1.art_id

---where tms_a.tms_auftrag_id = '7067237618'
;