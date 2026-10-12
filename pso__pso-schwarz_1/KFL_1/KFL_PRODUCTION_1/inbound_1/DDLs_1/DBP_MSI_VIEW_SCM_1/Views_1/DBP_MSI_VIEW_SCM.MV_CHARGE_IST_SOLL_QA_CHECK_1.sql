CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_CHARGE_IST_SOLL_QA_CHECK_1(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	DAT_LIEF_SOLL,
	ART_ID,
	GP_ID,
	CHARGE_ID,
	GTIN_VORHANDEN_FG,
	GP_CHARGE_NR,
	LAGERNUMMER_ID,
	TOUR_ID,
	LIEF_BELEG_ID,
	CHARGE_NR_QA,
	DAT_AENDERUNG,
	ANZ_KOLLI_IST,
	QA_STATUS,
	FREITEXT_HINWEIS_FUER_QA_IST,
	FREITEXT_PRODUZENT_IST,
	URSPRUNGSLAND_KBEZ_SOLL,
	URSPRUNGSLAND_KBEZ_IST,
	URSPRUNGSLAND_KBEZ_DEV,
	HANDELSKLASSE_SOLL_KZ,
	HANDELSKLASSE_IST_KZ,
	HANDELSKLASSE_KZ_DEV,
	UNBEHANDELT_SOLL_KZ,
	UNBEHANDELT_IST_KZ,
	UNBEHANDELT_KZ_DEV,
	TRANSPORT_VERPACKUNG_KMO_SOLL_KZ,
	TRANSPORT_VERPACKUNG_KMO_IST_KZ,
	TRANSPORT_VERPACKUNG_KM_DEV,
	KALIBER_VON_SOLL,
	KALIBER_VON_IST,
	KALIBER_VON_DEV,
	KALIBER_BIS_SOLL,
	KALIBER_BIS_IST,
	KALIBER_BIS_DEV,
	KOLLIFAKTOR,
	ANZ_KOLLI,
	KOLLIFAKTOR_DEV,
	FREITEXT_BESONDERHEITEN_SOLL,
	FREITEXT_BESONDERHEITEN_IST,
	FREITEXT_BESONDERHEITEN_DEV,
	FREITEXT_SPEZIFIKATION_SOLL,
	FREITEXT_SPEZIFIKATION_IST,
	FREITEXT_SPEZIFIKATION_DEV,
	CHARGE_VORHANDEN_SOLL_FG,
	CHARGE_VORHANDEN_IST_FG,
	CHARGE_VORHANDEN_FG_DEV,
	FREITEXT_TEMPERATUR_CHECK_SOLL,
	FREITEXT_TEMPERATUR_CHECK_IST,
	FREITEXT_TEMPERATUR_CHECK_DEV,
	FREITEXT_FRUCHTFLEISCHDRUCK_SOLL,
	FREITEXT_FRUCHTFLEISCHDRUCK_IST,
	FREITEXT_FRUCHTFLEISCHDRUCK_DEV,
	FREITEXT_SAFTGEHALT_SOLL,
	FREITEXT_SAFTGEHALT_IST,
	FREITEXT_SAFTGEHALT_DEV,
	FREITEXT_LIEFERANTEN_KOMMENTAR_SOLL,
	FREITEXT_LIEFERANTEN_KOMMENTAR_IST,
	FREITEXT_LIEFERANTEN_KOMMENTAR_DEV,
	NETTOINHALT_KOLLI_SOLL,
	NETTOINHALT_KOLLI_IST,
	NETTOINHALT_KOLLI_DEV,
	FREITEXT_PRIMAERVERPACKUNG_SOLL,
	FREITEXT_PRIMAERVERPACKUNG_IST,
	FREITEXT_PRIMAERVERPACKUNG_DEV,
	FREITEXT_QA_KOMMENTAR_SOLL,
	FREITEXT_QA_KOMMENTAR_IST,
	FREITEXT_QA_KOMMENTAR_DEV,
	KONTROLLNOTWENDIGKEIT_VORERNTENUMMER_SOLL_FG,
	KONTROLLNOTWENDIGKEIT_VORERNTENUMMER_IST_FG,
	KONTROLLNOTWENDIGKEIT_VORERNTENUMMER_FG_DEV,
	FREITEXT_MARKE_SOLL,
	FREITEXT_MARKE_IST,
	FREITEXT_MARKE_DEV,
    FREITEXT_FRUCHTGEHALT_SOLL,
    FREITEXT_FRUCHTGEHALT_IST,
    FREITEXT_FRUCHTGEHALT_DEV,
	DAT_EMPFANG,
	DATZEIT_EINGANG,
	DAT_ANTWORT,
	DATZEIT_ANTWORT,
	ANZ_KOLLI_GEPRUEFT_IST,
	DEFEKTE_KOLLI_IST,
	MENGE_STICHPROBE_FRISCHEMAENGEL,
	MENGE_STICHPROBE_SONSTIGES,
    DEV_FG
) AS
--2025-03-06,AP0205147, dknop, initial
--2025-03-17, sknop, adding FREITEXT_FRUCHTGEHALT_DEV,FREITEXT_FRUCHTGEHALT_IST, FREITEXT_FRUCHTGEHALT_SOLL
--2025-03-20, dknop, adding definition od dev_fg
SELECT
 v011.wup_id
,v011.nb_id
,v011.mandant_id
,v01.dat_lief_soll
,v011.art_id
,v01.gp_id
,v02.charge_id
,v02.gtin_vorhanden_fg
,v03.gp_charge_nr

,v02.lagernummer_id
,v02.tour_id
,v01.lief_beleg_id
,v02.charge_nr_qa
,v02.dat_aenderung
,v02.anz_kolli_ist
,v02.qa_status
,v02.freitext_hinweis_fuer_qa_ist
,v02.freitext_produzent_ist

,v03.ursprungsland_kbez_soll
,v02.ursprungsland_kbez_ist
,CASE WHEN v03.ursprungsland_kbez_soll<>v02.ursprungsland_kbez_ist THEN 'YES' ELSE 'NO' END ursprungsland_kbez_dev
,v03.handelsklasse_soll_kz
,v02.handelsklasse_ist_kz
,CASE WHEN v03.handelsklasse_soll_kz<>v02.handelsklasse_ist_kz THEN 'YES' ELSE 'NO' END handelsklasse_kz_dev
,v03.unbehandelt_soll_kz
,v02.unbehandelt_ist_kz
,CASE WHEN v03.unbehandelt_soll_kz<>v02.unbehandelt_ist_kz THEN 'YES' ELSE 'NO' END unbehandelt_kz_dev
,v03.transport_verpackung_kmo_soll_kz
,v02.transport_verpackung_kmo_ist_kz
,CASE WHEN v03.transport_verpackung_kmo_soll_kz<>v02.transport_verpackung_kmo_ist_kz THEN 'YES' ELSE 'NO' END transport_verpackung_km_dev
,v03.kaliber_von_soll
,v02.kaliber_von_ist
,CASE WHEN v03.kaliber_von_soll<>v02.kaliber_von_ist THEN 'YES' ELSE 'NO' END kaliber_von_dev
,v03.kaliber_bis_soll
,v02.kaliber_bis_ist
,CASE WHEN v03.kaliber_bis_soll<>v02.kaliber_bis_ist THEN 'YES' ELSE 'NO' END kaliber_bis_dev
,v03.kollifaktor

,SUM (v02.anz_kolli) OVER (PARTITION BY v011.wup_id,v011.nb_id,v011.mandant_id,v01.dat_lief_soll,v011.art_id,v01.gp_id,v02.charge_id,v02.charge_nr_qa)

,CASE WHEN v03.kollifaktor<>v02.anz_kolli THEN 'YES' ELSE 'NO' END kollifaktor_dev
,v03.freitext_besonderheiten_soll
,v02.freitext_besonderheiten_ist
,CASE WHEN v03.freitext_besonderheiten_soll<>v02.freitext_besonderheiten_ist THEN 'YES' ELSE 'NO' END freitext_besonderheiten_dev
,v03.freitext_spezifikation_soll
,v02.freitext_spezifikation_ist
,CASE WHEN v03.freitext_spezifikation_soll<>v02.freitext_spezifikation_ist THEN 'YES' ELSE 'NO' END freitext_spezifikation_dev
,v03.charge_vorhanden_soll_fg
,v02.charge_vorhanden_ist_fg
,CASE WHEN v03.charge_vorhanden_soll_fg<>v02.charge_vorhanden_ist_fg THEN 'YES' ELSE 'NO' END charge_vorhanden_fg_dev
,v03.freitext_temperatur_check_soll
,v02.freitext_temperatur_check_ist
,CASE WHEN v03.freitext_temperatur_check_soll<>v02.freitext_temperatur_check_ist THEN 'YES' ELSE 'NO' END freitext_temperatur_check_dev
,v03.freitext_fruchtfleischdruck_soll
,v02.freitext_fruchtfleischdruck_ist
,CASE WHEN v03.freitext_fruchtfleischdruck_soll<>v02.freitext_fruchtfleischdruck_ist THEN 'YES' ELSE 'NO' END freitext_fruchtfleischdruck_dev
,v03.freitext_saftgehalt_soll
,v02.freitext_saftgehalt_ist
,CASE WHEN v03.freitext_saftgehalt_soll<>v02.freitext_saftgehalt_ist THEN 'YES' ELSE 'NO' END freitext_saftgehalt_dev
,v03.freitext_lieferanten_kommentar_soll
,v02.freitext_lieferanten_kommentar_ist
,CASE WHEN v03.freitext_lieferanten_kommentar_soll<>v02.freitext_lieferanten_kommentar_ist THEN 'YES' ELSE 'NO' END freitext_lieferanten_kommentar_dev
,v03.nettoinhalt_kolli_soll
,v02.nettoinhalt_kolli_ist
,CASE WHEN v03.nettoinhalt_kolli_soll<>v02.nettoinhalt_kolli_ist THEN 'YES' ELSE 'NO' END nettoinhalt_kolli_dev
,v03.freitext_primaerverpackung_soll
,v02.freitext_primaerverpackung_ist
,CASE WHEN v03.freitext_primaerverpackung_soll<>v02.freitext_primaerverpackung_ist THEN 'YES' ELSE 'NO' END freitext_primaerverpackung_dev
,v03.freitext_qa_kommentar_soll
,v02.freitext_qa_kommentar_ist
,CASE WHEN v03.freitext_qa_kommentar_soll<>v02.freitext_qa_kommentar_ist THEN 'YES' ELSE 'NO' END freitext_qa_kommentar_dev
,v03.kontrollnotwendigkeit_vorerntenummer_soll_fg
,v02.kontrollnotwendigkeit_vorerntenummer_ist_fg
,CASE WHEN v03.kontrollnotwendigkeit_vorerntenummer_soll_fg<>v02.kontrollnotwendigkeit_vorerntenummer_ist_fg THEN 'YES' ELSE 'NO' END kontrollnotwendigkeit_vorerntenummer_fg_dev
,v03.freitext_marke_soll
,v02.freitext_marke_ist
,CASE WHEN v03.freitext_marke_soll<>v02.freitext_marke_ist THEN 'YES' ELSE 'NO' END freitext_marke_dev
,v03.freitext_fruchtgehalt_soll
,v02.freitext_fruchtgehalt_ist
,CASE WHEN v03.freitext_fruchtgehalt_soll<>v02.freitext_fruchtgehalt_ist THEN 'YES' ELSE 'NO' END freitext_fruchtgehalt_dev
,v02.dat_empfang
,v02.datzeit_eingang
,v02.dat_antwort
,v02.zeit_antwort AS datzeit_antwort

,v02.anz_kolli_geprueft_ist
,v02.defekte_kolli_ist
,v02.menge_stichprobe_frischemaengel
,v02.menge_stichprobe_sonstiges

,CASE WHEN GREATEST(
    (CASE WHEN ursprungsland_kbez_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN handelsklasse_kz_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN unbehandelt_kz_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN transport_verpackung_km_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN kaliber_von_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN kaliber_bis_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN kollifaktor_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_besonderheiten_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_spezifikation_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN charge_vorhanden_fg_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_temperatur_check_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_fruchtfleischdruck_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_saftgehalt_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_lieferanten_kommentar_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN nettoinhalt_kolli_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_primaerverpackung_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_qa_kommentar_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN kontrollnotwendigkeit_vorerntenummer_fg_dev = 'yes' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_marke_dev = 'YES' THEN 1 ELSE 0 END),
    (CASE WHEN freitext_fruchtgehalt_dev = 'YES' THEN 1 ELSE 0 END)
  ) = 1 THEN 1 ELSE 0 END AS flag
FROM dbp_view.v_besch_lief_1 v01

JOIN (SELECT
s1.mandant_id
,s1.lief_beleg_id
,s1.kj
,s1.art_id
,s1.wup_id
,s1.nb_id
,s1.dat_lief_soll
,SUM(s1.menge_lief_ist_kolli) AS WE_Menge_Kolli
,SUM(s1.menge_lief_ist_bme) AS WE_Menge_BME

FROM dbp_view.v_besch_lief_det_1 s1

JOIN dbp_view.v_tag_1 s2
ON s1.dat_lief_soll = s2.dat
WHERE s2.akt_kj BETWEEN -2 AND 0
GROUP BY 1,2,3,4,5,6,7) v011

ON v01.mandant_id = v011.mandant_id
AND v01.lief_beleg_id = v011.lief_beleg_id
AND v01.kj = v011.kj
AND v01.dat_lief_soll = v011.dat_lief_soll

JOIN dbp_view.v_charge_ist_qa_check_1  v02
ON v011.mandant_id = v02.mandant_id
AND v011.lief_beleg_id = v02.lief_beleg_id
AND v011.art_id = v02.art_id
AND v011.wup_id = v02.wup_id
AND v011.nb_id = v02.nb_id

LEFT JOIN dbp_view.v_charge_soll_1 v03
ON v02.mandant_id = v03.mandant_id
AND v02.charge_id = v03.charge_id
AND v02.gp_id = v03.gp_id
AND v02.art_id = v03.art_id


;