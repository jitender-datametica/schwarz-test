create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_INT.MV_OUG_BEST_WE_2(
	MANDANT_ID,
	DAT_LIEF_SOLL,
	WUP_ID,
	NB_ID,
	ART_ID,
	GP_ID,
	LIEF_BELEG_ID,
	EINSTANDSPREIS,
	EK_MEP,
	LOGISTIKKOSTENZUSCHLAG,
	BESTELLUNG_MENGE_KOLLI,
	BESTELLUNG_MENGE_BME,
	WE_MENGE_KOLLI,
	WE_MENGE_BME,
	FREITEXT_PRODUZENT_IST,
	FREITEXT_MARKE_IST,
	FREITEXT_PRIMAERVERPACKUNG_IST,
	FREITEXT_TRANSPORT_VERPACKUNG_DE_IST,
	TRANSPORT_VERPACKUNG_KMO_IST_KZ,
	TRANSPORTVERPACKUNG_IST,
	URSPRUNGSLAND_KBEZ_IST,
	ZUS_URSPRUNGSLAENDER_KBEZ_IST,
	HANDELSKLASSE_IST_KZ,
	UNBEHANDELT_IST_KZ,
	VERTRAGSANBAU_IST_FG,
	NATIONALE_PRODUKTION_IST_FG,
	FREITEXT_HINWEIS_FUER_QA_IST,
	KONTROLLNOTWENDIGKEIT_VORERNTENUMMER_IST_FG,
	FREITEXT_QA_KOMMENTAR_IST,
	FREITEXT_BESONDERHEITEN_IST,
	FREITEXT_SPEZIFIKATION_IST,
	FREITEXT_LIEFERANTEN_KOMMENTAR_IST,
	FREITEXT_TEMPERATUR_CHECK_IST,
	FREITEXT_FRUCHTFLEISCHDRUCK_IST,
	FREITEXT_FRUCHTGEHALT_IST,
	FREITEXT_SAFTGEHALT_IST,
	LAGERNUMMER_ID,
	ZEIT_ANTWORT,
	GTIN_VORHANDEN_FG,
	QA_STATUS,
	KALIBER_KZ_IST,
	KALIBER_VON_IST,
	KALIBER_BIS_IST,
	PALETTENFAKTOR_IST,
	NETTOINHALT_KOLLI_IST,
	ANZ_KOLLI,
	ANZ_GEPRUEFTE_KOLLI,
	ANZ_DEFEKTE_KOLLI,
	MENGE_STRICHPROBE_FRISCHEMAENGEL,
	MENGE_STRICHPROBE_SONSTIGES,
	ANZ_KOLLI_IST,
	CHARGE_ID_IST,
	CHARGE_VORHANDEN_IST_FG,
	CHARGE_NR_QA,
	QA_MANGEL_ID,
	QA_DEKLARATIONSFEHLER_ID,
	KOMMENTAR_QA_TXT,
	KOMMENTAR_EK_TXT,
	DATZEIT_EINGANG,
	DAT_ANTWORT,
	DATZEIT_ABW,
	CHARGE_ID,
	GP_CHARGE_NR,
	CHARGE_VORHANDEN_SOLL_FG,
	KALIBER_KZ_SOLL,
	KALIBER_VON_SOLL,
	KALIBER_BIS_SOLL,
	PALETTENFAKTOR_SOLL,
	KOLLIFAKTOR,
	NETTOINHALT_KOLLI_SOLL,
	FREITEXT_MARKE_SOLL,
	FREITEXT_PRIMAERVERPACKUNG_SOLL,
	FREITEXT_TRANSPORT_VERPACKUNG_DE_SOLL,
	TRANSPORT_VERPACKUNG_KMO_SOLL_KZ,
	TRANSPORTVERPACKUNG_SOLL,
	GTIN_FG,
	URSPRUNGSLAND_KBEZ_SOLL,
	ZUS_URSPRUNGSLAENDER_KBEZ_SOLL,
	HANDELSKLASSE_SOLL_KZ,
	UNBEHANDELT_SOLL_KZ,
	VERTRAGSANBAU_SOLL_FG,
	NATIONALE_PRODUKTION_SOLL_FG,
	KONTROLLNOTWENDIGKEIT_VORERNTENUMMER_SOLL_FG,
	FREITEXT_QA_KOMMENTAR_SOLL,
	FREITEXT_BESONDERHEITEN_SOLL,
	FREITEXT_SPEZIFIKATION_SOLL,
	FREITEXT_LIEFERANTEN_KOMMENTAR_SOLL,
	FREITEXT_TEMPERATUR_CHECK_SOLL,
	FREITEXT_FRUCHTFLEISCHDRUCK_SOLL,
	FREITEXT_FRUCHTGEHALT_SOLL,
	FREITEXT_SAFTGEHALT_SOLL,
	URSPRUNGSLAENDER_KBEZ_ABW,
	PALETTENFAKTOR_ABW,
	VERTRAGSANBAU_ABW,
	NATIONALE_PRODUKTION_FG_ABW,
	URSPRUNGSLAND_KBEZ_ABW,
	HANDELSKLASSE_KZ_ABW,
	UNBEHANDELT_KZ_ABW,
	TRANSPORTVERPACKUNG_ABW,
	KALIBER_VON_ABW,
	KALIBER_BIS_ABW,
	ANZ_KOLLI_ABW,
	GTIN_ABW,
	FREITEXT_BESONDERHEITEN_ABW,
	FREITEXT_SPEZIFIKATION_ABW,
	FREITEXT_TEMPERATUR_CHECK_ABW,
	FREITEXT_FRUCHTFLEISCHDRUCK_ABW,
	FREITEXT_SAFTGEHALT_ABW,
	FREITEXT_LIEFERANTEN_KOMMENTAR_ABW,
	NETTOINHALT_KOLLI_ABW,
	FREITEXT_PRIMAERVERPACKUNG_ABW,
	FREITEXT_QA_KOMMENTAR_ABW,
	KONTROLLNEINTWENDIGKEIT_VORERNTENUMMER_FG_ABW,
	FREITEXT_MARKE_ABW,
	CHARGE_VORHANDEN_FG_ABW,
	FREITEXT_FRUCHTGEHALT_ABW,
	QA_DEKLARATIONSFEHLER_BEZ,
	QA_DEKLARATIONSFEHLER_BEZ_DE,
	QA_DEKLARATIONSFEHLER_BEZ_CZ,
	QA_DEKLARATIONSFEHLER_BEZ_SK,
	QA_DEKLARATIONSFEHLER_BEZ_HR,
	QA_DEKLARATIONSFEHLER_BEZ_PL,
	QA_DEKLARATIONSFEHLER_BEZ_RO,
	QA_DEKLARATIONSFEHLER_BEZ_BG,
	QA_MANGEL_BEZ,
	QA_MANGEL_BEZ_DE,
	QA_MANGEL_BEZ_CZ,
	QA_MANGEL_BEZ_SK,
	QA_MANGEL_BEZ_HR,
	QA_MANGEL_BEZ_PL,
	QA_MANGEL_BEZ_RO,
	QA_MANGEL_BEZ_BG
) as
SELECT
v01.mandant_id
,v01.dat_lief_soll
,v011.wup_id
,v011.nb_id
,v011.art_id
,v01.gp_id
,v01.lief_beleg_id

,CAST((CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v03.einstandspreis,v04.einstandspreis)
            WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v03.einstandspreis,v04.einstandspreis) * v300.umrechnungskurs
            WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v03.einstandspreis,v04.einstandspreis) * v400.umrechnungskurs END) AS NUMBER(38,5)) AS einstandspreis







,CAST((CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v03.ek_mep,v04.ek_mep) 
            WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v03.ek_mep,v04.ek_mep) * v300.umrechnungskurs  
            WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v03.ek_mep,v04.ek_mep) * v400.umrechnungskurs END) AS NUMBER(38,5)) AS ek_mep

,CAST((CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v03.logistikkostenzuschlag,v04.logistikkostenzuschlag)
            WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v03.logistikkostenzuschlag,v04.logistikkostenzuschlag) * v300.umrechnungskurs
            WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v03.logistikkostenzuschlag,v04.logistikkostenzuschlag) * v400.umrechnungskurs END) AS NUMBER(38,5)) AS logistikkostenzuschlag

,v05.anz_kolli_ist AS Bestellung_Menge_Kolli
,v05.Anz_Kolli * v05.anz_kolli_ist AS Bestellung_Menge_BME

,CAST(CASE
WHEN v05.qa_status = 'Verweigerung' THEN 0
WHEN v056. qa_status_count > 1 AND v055.anzahl_kolli_ist IS NOT NULL AND v055.anzahl_kolli_ist > 0 
THEN (v011.WE_Menge_Kolli / v055.anzahl_kolli_ist) * v05.anz_kolli_ist
ELSE v011.WE_Menge_Kolli END AS NUMBER(18,3)) AS WE_Menge_Kolli

,CAST(CASE 
WHEN v05.qa_status = 'Verweigerung' THEN 0
WHEN v056. qa_status_count > 1 AND v055.anzahl_kolli_ist IS NOT NULL AND v055.anzahl_kolli_ist > 0  
THEN (v011.WE_Menge_BME / v055.anzahl_kolli_ist) * v05.anz_kolli_ist 
ELSE v011.WE_Menge_BME END AS NUMBER(18,3)) AS WE_Menge_BME


,v05.freitext_produzent_ist
,v05.freitext_marke_ist
,v05.freitext_primaerverpackung_ist
,v05.freitext_transport_verpackung_de_ist
,v05.transport_verpackung_kmo_ist_kz
,v05.transportverpackung_ist
,v05.ursprungsland_kbez_ist
,v05.zus_ursprungslaender_kbez_ist
,v05.handelsklasse_ist_kz
,v05.unbehandelt_ist_kz
,v05.vertragsanbau_ist_fg
,v05.nationale_produktion_ist_fg
,v05.freitext_hinweis_fuer_qa_ist
,v05.kontrollnotwendigkeit_vorerntenummer_ist_fg
,v05.freitext_qa_kommentar_ist
,v05.freitext_besonderheiten_ist
,v05.freitext_spezifikation_ist
,v05.freitext_lieferanten_kommentar_ist
,v05.freitext_temperatur_check_ist
,v05.freitext_fruchtfleischdruck_ist
,v05.freitext_fruchtgehalt_ist
,v05.freitext_saftgehalt_ist
,v05.lagernummer_id
,v05.zeit_antwort
,v05.gtin_vorhanden_fg
,v05.qa_status
,v05.kaliber_kz_ist
,v05.kaliber_von_ist
,v05.kaliber_bis_ist
,v05.palettenfaktor_ist
,v05.nettoinhalt_kolli_ist
,v05.Anz_Kolli
,v05.Anz_gepruefte_Kolli
,v05.Anz_defekte_Kolli
,v05.Menge_Strichprobe_Frischemaengel
,v05.Menge_Strichprobe_Sonstiges
,v05.Anz_Kolli_Ist
,v05.charge_id AS charge_id_ist
,v05.charge_vorhanden_ist_fg
,v05.charge_nr_qa
,v50.qa_mangel_id
,v50.qa_deklarationsfehler_id
,v50.kommentar_qa_txt
,v50.kommentar_ek_txt
,v50.datzeit_eingang
,v50.dat_antwort
,CASE WHEN COALESCE(v50.datzeit_eingang,v05.zeit_antwort) IS NOT NULL
THEN (
LPAD(MOD(DATEDIFF('day', v50.datzeit_eingang,v05.zeit_antwort), 24), 2, '0') || ':' ||
LPAD(MOD(DATEDIFF('hour', v50.datzeit_eingang,v05.zeit_antwort), 24), 2, '0') || ':' ||
LPAD(MOD(DATEDIFF('minute', v50.datzeit_eingang,v05.zeit_antwort), 60), 2, '0') || ':' ||
LPAD(MOD(DATEDIFF('second', v50.datzeit_eingang,v05.zeit_antwort), 60), 2, '0')
) ELSE NULL
END AS datzeit_abw


,v06.charge_id
,v06.gp_charge_nr
,CASE WHEN v06.charge_vorhanden_soll_fg = 1 THEN 'X' ELSE '' END AS charge_vorhanden_soll_fg1
,v06.kaliber_kz_soll
,v06.kaliber_von_soll
,v06.kaliber_bis_soll
,v06.palettenfaktor_soll
,v06.kollifaktor
,v06.nettoinhalt_kolli_soll
,v06.freitext_marke_soll
,v06.freitext_primaerverpackung_soll
,v06.freitext_transport_verpackung_de_soll
,v06.transport_verpackung_kmo_soll_kz



, CASE          
  WHEN v01.mandant_id = 1 THEN v06.freitext_transport_verpackung_de_soll
  ELSE v06.transport_verpackung_kmo_soll_kz END AS transportverpackung_soll
,v06.gtin_fg
,v06.ursprungsland_kbez_soll
,v06.zus_ursprungslaender_kbez_soll
,v06.handelsklasse_soll_kz
,v06.unbehandelt_soll_kz
,v06.vertragsanbau_soll_fg
,v06.nationale_produktion_soll_fg
,v06.kontrollnotwendigkeit_vorerntenummer_soll_fg
,v06.freitext_qa_kommentar_soll
,v06.freitext_besonderheiten_soll
,v06.freitext_spezifikation_soll
,v06.freitext_lieferanten_kommentar_soll
,v06.freitext_temperatur_check_soll
,v06.freitext_fruchtfleischdruck_soll
,v06.freitext_fruchtgehalt_soll
,v06.freitext_saftgehalt_soll

,CASE WHEN v05.zus_ursprungslaender_kbez_ist != v06.zus_ursprungslaender_kbez_soll THEN 'Ja' ELSE 'Nein' END AS ursprungslaender_kbez_abw
,CASE WHEN v05.palettenfaktor_ist != v06.palettenfaktor_soll THEN 'Ja' ELSE 'Nein' END AS palettenfaktor_abw
,CASE WHEN v05.vertragsanbau_ist_fg != v06.vertragsanbau_soll_fg THEN 'Ja' ELSE 'Nein' END AS vertragsanbau_abw
,CASE WHEN v05.nationale_produktion_ist_fg != v06.nationale_produktion_soll_fg THEN 'Ja' ELSE 'Nein' END AS nationale_produktion_fg_abw
,CASE WHEN v05.ursprungsland_kbez_ist != v06.ursprungsland_kbez_soll THEN 'Ja' ELSE 'Nein' END AS ursprungsland_kbez_abw
,CASE WHEN v05.handelsklasse_ist_kz!= v06.handelsklasse_soll_kz THEN 'Ja' ELSE 'Nein' END AS handelsklasse_kz_abw
,CASE WHEN v05.unbehandelt_ist_kz != v06.unbehandelt_soll_kz THEN  'Ja' ELSE 'Nein' END AS unbehandelt_kz_abw
,CASE WHEN v05.transportverpackung_ist != transportverpackung_soll THEN  'Ja' ELSE 'Nein' END AS transportverpackung_abw
,CASE WHEN v05.kaliber_von_ist != v06.kaliber_von_soll THEN  'Ja' ELSE 'Nein' END AS kaliber_von_abw
,CASE WHEN v05.kaliber_bis_ist != v06.kaliber_bis_soll THEN  'Ja' ELSE 'Nein' END AS kaliber_bis_abw
,CASE WHEN v05.anz_kolli != v06.kollifaktor THEN  'Ja' ELSE 'Nein' END AS anz_kolli_abw
,CASE WHEN v05.gtin_vorhanden_fg != v06.gtin_fg THEN 'Ja' ELSE 'Nein' END AS gtin_abw
,CASE WHEN v05.freitext_besonderheiten_ist != v06.freitext_besonderheiten_soll THEN 'Ja' ELSE 'Nein' END AS freitext_besonderheiten_abw
,CASE WHEN v05.freitext_spezifikation_ist != v06.freitext_spezifikation_soll THEN 'Ja' ELSE 'Nein' END AS freitext_spezifikation_abw
,CASE WHEN v05.freitext_temperatur_check_ist != v06.freitext_temperatur_check_soll THEN 'Ja' ELSE 'Nein' END AS freitext_temperatur_check_abw
,CASE WHEN v05.freitext_fruchtfleischdruck_ist != v06.freitext_fruchtfleischdruck_soll THEN 'Ja' ELSE 'Nein' END AS freitext_fruchtfleischdruck_abw
,CASE WHEN v05.freitext_saftgehalt_ist != v06.freitext_saftgehalt_soll THEN 'Ja' ELSE 'Nein' END AS freitext_saftgehalt_abw
,CASE WHEN v05.freitext_lieferanten_kommentar_ist != v06.freitext_lieferanten_kommentar_soll THEN 'Ja' ELSE 'Nein' END AS freitext_lieferanten_kommentar_abw
,CASE WHEN v05.nettoinhalt_kolli_ist != v06.nettoinhalt_kolli_soll THEN 'Ja' ELSE 'Nein' END AS nettoinhalt_kolli_abw
,CASE WHEN v05.freitext_primaerverpackung_ist != v06.freitext_primaerverpackung_soll THEN 'Ja' ELSE 'Nein' END AS freitext_primaerverpackung_abw
,CASE WHEN v05.freitext_qa_kommentar_ist != v06.freitext_qa_kommentar_soll THEN 'Ja' ELSE 'Nein' END AS freitext_qa_kommentar_abw
,CASE WHEN v05.kontrollnotwendigkeit_vorerntenummer_ist_fg != v06.kontrollnotwendigkeit_vorerntenummer_soll_fg THEN 'Ja' ELSE 'Nein' END AS kontrollNeintwendigkeit_vorerntenummer_fg_abw
,CASE WHEN v05.freitext_marke_ist!= v06.freitext_marke_soll THEN 'Ja' ELSE 'Nein' END AS freitext_marke_abw
,CASE WHEN v05.charge_vorhanden_ist_fg != charge_vorhanden_soll_fg1 THEN 'Ja' ELSE 'Nein' END AS charge_vorhanden_fg_abw
,CASE WHEN v05.freitext_fruchtgehalt_ist != v06.freitext_fruchtgehalt_soll THEN 'Ja' ELSE 'Nein' END AS freitext_fruchtgehalt_abw
,v07.qa_deklarationsfehler_bez
,v07.qa_deklarationsfehler_bez_de
,v07.qa_deklarationsfehler_bez_cz
,v07.qa_deklarationsfehler_bez_sk
,v07.qa_deklarationsfehler_bez_hr
,v07.qa_deklarationsfehler_bez_pl
,v07.qa_deklarationsfehler_bez_ro
,v07.qa_deklarationsfehler_bez_bg
,v08.qa_mangel_bez 
,v08.qa_mangel_bez_de
,v08.qa_mangel_bez_cz
,v08.qa_mangel_bez_sk
,v08.qa_mangel_bez_hr
,v08.qa_mangel_bez_pl
,v08.qa_mangel_bez_ro
,v08.qa_mangel_bez_bg


FROM dbp_view.v_besch_lief_2 v01


JOIN (SELECT
s1.mandant_id
,s1.lief_beleg_id
,s1.kj
,s1.art_id
,s1.wup_id
,s1.nb_id
,s1.vorlage_beleg_id
,s1.dat_lief_soll
,SUM(s1.menge_lief_ist_kolli ) AS WE_Menge_Kolli
,SUM(s1.menge_lief_ist_bme ) AS WE_Menge_BME
FROM dbp_view.v_besch_lief_det_2 s1
JOIN dbp_view.v_tag_2 s2
ON s1.dat_lief_soll = s2.dat
WHERE s2.akt_kj BETWEEN -2 AND 0
GROUP BY 1,2,3,4,5,6,7,8) v011
ON v01.mandant_id = v011.mandant_id
AND v01.lief_beleg_id = v011.lief_beleg_id
AND v01.kj = v011.kj
AND v01.dat_lief_soll = v011.dat_lief_soll



JOIN (SELECT
s1.mandant_id
,s1.best_beleg_id
,s1.art_id
,s1.wup_id
,s1.nb_id
,s1.dat_best_beleg
,SUM(s1.menge_best_kolli) AS Bestellung_Menge_Kolli
,SUM(s1.menge_best_bme) AS Bestellung_Menge_BME
FROM dbp_view.v_besch_best_det_2 s1
JOIN dbp_view.v_tag_2 s2
ON s1.dat_best_beleg = s2.dat
WHERE s2.akt_kj BETWEEN -2 AND 0
GROUP BY 1,2,3,4,5,6) v022
ON v011.vorlage_beleg_id = v022.best_beleg_id

AND v011.mandant_id = v022.mandant_id
AND v011.art_id = v022.art_id

JOIN dbp_view.v_besch_best_2 v02
ON v02.best_beleg_id = v022.best_beleg_id
AND v02.mandant_id = v022.mandant_id
AND v02.dat_best_beleg = v022.dat_best_beleg


LEFT JOIN (SELECT
mandant_id
,lief_beleg_id
,art_id
,wup_id
,nb_id
,gp_id
,charge_id
,freitext_produzent_ist
,freitext_marke_ist
,freitext_primaerverpackung_ist
,freitext_transport_verpackung_de_ist
,transport_verpackung_kmo_ist_kz



, CASE           
  WHEN mandant_id = 1 THEN freitext_transport_verpackung_de_ist
  ELSE transport_verpackung_kmo_ist_kz END AS transportverpackung_ist
,ursprungsland_kbez_ist
,zus_ursprungslaender_kbez_ist
,handelsklasse_ist_kz
,unbehandelt_ist_kz
,vertragsanbau_ist_fg
,nationale_produktion_ist_fg
,freitext_hinweis_fuer_qa_ist
,kontrollnotwendigkeit_vorerntenummer_ist_fg
,freitext_qa_kommentar_ist
,freitext_besonderheiten_ist
,freitext_spezifikation_ist
,freitext_lieferanten_kommentar_ist
,freitext_temperatur_check_ist
,freitext_fruchtfleischdruck_ist
,freitext_fruchtgehalt_ist
,freitext_saftgehalt_ist
,lagernummer_id
,zeit_antwort
,gtin_vorhanden_fg
,CASE
WHEN qa_status IN ('Q') THEN 'Query'
WHEN qa_status IN ('R') THEN 'Verweigerung'
WHEN qa_status IN ('S') THEN 'Annahme'
WHEN qa_status IN ('K') THEN 'Annahme mit Abweichung'
WHEN qa_status IN ('A') THEN 'Konzession'
ELSE ' ' END AS qa_status
,kaliber_kz_ist
,kaliber_von_ist
,kaliber_bis_ist
,palettenfaktor_ist
,nettoinhalt_kolli_ist
,charge_nr_qa
,CASE WHEN charge_vorhanden_ist_fg = 1 THEN 'X' ELSE '' END AS charge_vorhanden_ist_fg
,SUM(anz_kolli) AS Anz_Kolli
,SUM(anz_kolli_geprueft_ist) AS Anz_gepruefte_Kolli
,SUM(defekte_kolli_ist) AS Anz_defekte_Kolli
,SUM(menge_stichprobe_frischemaengel) AS Menge_Strichprobe_Frischemaengel
,SUM(menge_stichprobe_sonstiges) AS Menge_Strichprobe_Sonstiges
,SUM(anz_kolli_ist) AS Anz_Kolli_Ist
FROM dbp_view.v_charge_ist_qa_check_2
GROUP BY ALL) AS v05


ON v05.mandant_id = v011.mandant_id
AND v05.lief_beleg_id = v011.lief_beleg_id
AND v05.art_id = v011.art_id

AND v05.wup_id = v011.wup_id
AND v05.nb_id = v011.nb_id



LEFT JOIN (
 SELECT 
  a.charge_nr_qa
 ,a.mandant_id
 ,a.wup_id 
 ,a.nb_id
 ,a.lief_beleg_id
 ,a.datzeit_eingang
 ,a.dat_antwort
 ,LISTAGG(DISTINCT a.qa_mangel_id, ' , ') WITHIN GROUP (ORDER BY qa_mangel_id) AS qa_mangel_id
 ,LISTAGG(DISTINCT  a.qa_deklarationsfehler_id,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_id) AS qa_deklarationsfehler_id
 ,LISTAGG(DISTINCT a.kommentar_qa_txt , ' |,| ') AS kommentar_qa_txt
 ,LISTAGG(DISTINCT a.kommentar_ek_txt , ' |,| ') AS kommentar_ek_txt
 FROM(
 SELECT
  v001.charge_nr_qa
 ,v001.mandant_id
 ,v001.wup_id 
 ,v001.nb_id
 ,v001.lief_beleg_id
 ,v001.datzeit_eingang
 ,v001.dat_antwort
 ,v001.qa_mangel_id AS qa_mangel_id
 ,v001.qa_deklarationsfehler_id AS qa_deklarationsfehler_id
 ,v001.kommentar_qa_txt  AS kommentar_qa_txt
 ,v001.kommentar_ek_txt AS kommentar_ek_txt

 FROM(
 SELECT
 v01.charge_nr_qa
,v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.lief_beleg_id
,v01.datzeit_eingang
,v01.dat_antwort
,COALESCE (v04.qa_mangel_id,'-1') AS qa_mangel_id
,COALESCE (v04.qa_deklarationsfehler_id,'-1') AS qa_deklarationsfehler_id
,v04.kommentar_qa_txt
,v04.kommentar_ek_txt
  FROM dbp_view.v_charge_ist_qa_check_2 v01
  LEFT JOIN dbp_view.v_charge_ist_qa_check_det_2 v04
  ON v01.charge_nr_qa = v04.charge_nr_qa
  AND v01.mandant_id = v04.mandant_id
  )v001
GROUP BY 
 charge_nr_qa
,mandant_id
,wup_id
,nb_id
,lief_beleg_id
,datzeit_eingang
,dat_antwort
,qa_mangel_id
,qa_deklarationsfehler_id
,kommentar_qa_txt
,kommentar_ek_txt)a
GROUP BY ALL
)v50 
ON v05.mandant_id = v50.mandant_id AND v05.charge_nr_qa = v50.charge_nr_qa AND v05.wup_id = v50.wup_id AND v05.nb_id = v50.nb_id  AND v05.lief_beleg_id = v50.lief_beleg_id


LEFT JOIN ( SELECT 
mandant_id,
lief_beleg_id,
art_id,
wup_id,
nb_id,
SUM(anz_kolli_ist) AS anzahl_kolli_ist
FROM dbp_view.v_charge_ist_qa_check_2
GROUP BY
mandant_id,
lief_beleg_id,
art_id,
wup_id,
nb_id) v055
ON v055.mandant_id = v011.mandant_id
AND v055.lief_beleg_id = v011.lief_beleg_id
AND v055.art_id = v011.art_id
AND v055.wup_id = v011.wup_id
AND v055.nb_id = v011.nb_id

LEFT JOIN (SELECT 
mandant_id,
lief_beleg_id,
art_id,
wup_id,
nb_id,
COUNT(qa_status) AS qa_status_count
FROM dbp_view.v_charge_ist_qa_check_2
WHERE qa_status <> 'R'
GROUP BY
mandant_id,
lief_beleg_id,
art_id,
wup_id,
nb_id
HAVING qa_status_count > 1
) v056
 ON v056.mandant_id = v011.mandant_id
AND v056.lief_beleg_id = v011.lief_beleg_id
AND v056.art_id = v011.art_id
AND v056.wup_id = v011.wup_id
AND v056.nb_id = v011.nb_id

LEFT JOIN dbp_view.v_charge_soll_2 v06

ON v06.mandant_id = v05.mandant_id
AND v06.charge_id = v05.charge_id
AND v06.gp_id = v05.gp_id
AND v06.art_id = v05.art_id

LEFT OUTER JOIN

(
SELECT
mandant_id
,art_id
,gp_id
,wup_id
,dat_von
,dat_bis
,CASE
WHEN mandant_id = 1 THEN 'EUR'
ELSE wrg_id END AS wrg_id
,einstandspreis
,ek_nettonetto
,ek_mep
,logistikkostenzuschlag
FROM dbp_view.v_art_gp_wup_zu_per_2
WHERE wup_id > -1


) v03
ON v01.mandant_id = v02.mandant_id AND
v011.wup_id  = v03.wup_id        AND
v01.gp_id = v03.gp_id          AND
v011.art_id =  v03.art_id AND
v01.dat_lief_soll BETWEEN v03.dat_von AND v03.dat_bis

LEFT OUTER JOIN

(
SELECT
mandant_id
,art_id
,gp_id
,wup_id
,dat_von
,dat_bis
,CASE
WHEN mandant_id = 1 THEN 'EUR'
ELSE wrg_id END AS wrg_id
,einstandspreis
,ek_nettonetto
,ek_mep
,logistikkostenzuschlag
FROM dbp_view.v_art_gp_wup_zu_per_2
WHERE  wup_id = -1


) v04
ON v01.mandant_id = v04.mandant_id
AND v01.gp_id = v04.gp_id
AND v011.art_id  = v04.art_id AND
v01.dat_lief_soll BETWEEN v04.dat_von AND v04.dat_bis



LEFT OUTER JOIN
(
SELECT
v05.mandant_id, 
v05.charge_nr_qa, 
v05.wup_id, 
v05.nb_id, 
v05.lief_beleg_id, 
listagg(DISTINCT v05.qa_deklarationsfehler_id,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_id) AS qa_deklarationsfehler_id, 
listagg(DISTINCT v05.qa_deklarationsfehler_bez,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_bez) AS qa_deklarationsfehler_bez,
listagg(DISTINCT v05.qa_deklarationsfehler_bez_de,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_bez_de) AS qa_deklarationsfehler_bez_de,
listagg(DISTINCT v05.qa_deklarationsfehler_bez_cz,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_bez_cz) AS qa_deklarationsfehler_bez_cz,
listagg(DISTINCT v05.qa_deklarationsfehler_bez_sk,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_bez_sk) AS qa_deklarationsfehler_bez_sk,
listagg(DISTINCT v05.qa_deklarationsfehler_bez_hr,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_bez_hr) AS qa_deklarationsfehler_bez_hr,
listagg(DISTINCT v05.qa_deklarationsfehler_bez_pl,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_bez_pl) AS qa_deklarationsfehler_bez_pl,
listagg(DISTINCT v05.qa_deklarationsfehler_bez_ro,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_bez_ro) AS qa_deklarationsfehler_bez_ro,
listagg(DISTINCT v05.qa_deklarationsfehler_bez_bg,' , ') WITHIN GROUP (ORDER BY qa_deklarationsfehler_bez_bg) AS qa_deklarationsfehler_bez_bg

FROM(

SELECT 
v02.mandant_id, 
v02.charge_nr_qa, 
v02.wup_id, 
v02.nb_id, 
v02.lief_beleg_id, 
v02.qa_deklarationsfehler_id, 
 COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.qa_deklarationsfehler_bez END),'N/A') AS qa_deklarationsfehler_bez     
,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.qa_deklarationsfehler_bez END),'N/A') AS qa_deklarationsfehler_bez_de    
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.qa_deklarationsfehler_bez END), qa_deklarationsfehler_bez_de) AS qa_deklarationsfehler_bez_cz  
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.qa_deklarationsfehler_bez END), qa_deklarationsfehler_bez_de) AS qa_deklarationsfehler_bez_sk 
,COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.qa_deklarationsfehler_bez END), qa_deklarationsfehler_bez_de) AS qa_deklarationsfehler_bez_hr    
,COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.qa_deklarationsfehler_bez END), qa_deklarationsfehler_bez_de) AS qa_deklarationsfehler_bez_pl    
,COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.qa_deklarationsfehler_bez END), qa_deklarationsfehler_bez_de) AS qa_deklarationsfehler_bez_ro   
,COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.qa_deklarationsfehler_bez END), qa_deklarationsfehler_bez_de) AS qa_deklarationsfehler_bez_bg  
FROM dbp_view.v_qa_deklarationsfehler_spr_zu_2 v01
RIGHT JOIN (
  SELECT v03.mandant_id, 
	   COALESCE(v04.qa_deklarationsfehler_id,'-1') AS qa_deklarationsfehler_id,
	   v04.charge_nr_qa, 
	   v03.wup_id, 
	   v03.nb_id, 
	   v03.lief_beleg_id
  FROM dbp_view.v_charge_ist_qa_check_2 v03
  LEFT JOIN dbp_view.v_charge_ist_qa_check_det_2 v04
  ON v03.charge_nr_qa = v04.charge_nr_qa
  AND v03.mandant_id = v04.mandant_id
  GROUP BY ALL
)v02

ON v01.mandant_id = v02.mandant_id AND v01.qa_deklarationsfehler_id = v02.qa_deklarationsfehler_id
GROUP BY ALL
)v05
GROUP BY ALL

) v07
ON v01.mandant_id =v07.mandant_id
AND v011.wup_id=v07.wup_id
AND v011.nb_id=v07.nb_id
AND v01.lief_beleg_id=v07.lief_beleg_id
AND v05.charge_nr_qa=v07.charge_nr_qa
AND v50.qa_deklarationsfehler_id=v07.qa_deklarationsfehler_id 


LEFT OUTER JOIN
(
SELECT 
v05.mandant_id, 
v05.charge_nr_qa, 
v05.wup_id, 
v05.nb_id, 
v05.lief_beleg_id, 
listagg(DISTINCT v05.qa_mangel_id,' , ')  WITHIN GROUP(ORDER BY qa_mangel_id) AS qa_mangel_id, 
listagg(DISTINCT v05.qa_mangel_bez,' , ') WITHIN GROUP(ORDER BY qa_mangel_bez) AS qa_mangel_bez,
listagg(DISTINCT v05.qa_mangel_bez_de,' , ') WITHIN GROUP (ORDER BY qa_mangel_bez_de ) AS qa_mangel_bez_de,
listagg(DISTINCT v05.qa_mangel_bez_cz,' , ') WITHIN GROUP (ORDER BY qa_mangel_bez_cz) AS qa_mangel_bez_cz,
listagg(DISTINCT v05.qa_mangel_bez_sk,' , ') WITHIN GROUP (ORDER BY qa_mangel_bez_sk) AS qa_mangel_bez_sk,
listagg(DISTINCT v05.qa_mangel_bez_hr,' , ') WITHIN GROUP (ORDER BY qa_mangel_bez_hr) AS qa_mangel_bez_hr,
listagg(DISTINCT v05.qa_mangel_bez_pl,' , ') WITHIN GROUP (ORDER BY qa_mangel_bez_pl) AS qa_mangel_bez_pl,
listagg(DISTINCT v05.qa_mangel_bez_ro,' , ') WITHIN GROUP (ORDER BY qa_mangel_bez_ro ) AS qa_mangel_bez_ro,
listagg(DISTINCT v05.qa_mangel_bez_bg,' , ') WITHIN GROUP (ORDER BY qa_mangel_bez_bg) AS qa_mangel_bez_bg

FROM(
SELECT 
v02.mandant_id, 
v02.charge_nr_qa, 
v02.wup_id, 
v02.nb_id, 
v02.lief_beleg_id, 
v02.qa_mangel_id,  
 COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.qa_mangel_bez END),'N/A')AS qa_mangel_bez  
,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.qa_mangel_bez END),'N/A') AS qa_mangel_bez_de    
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.qa_mangel_bez END), qa_mangel_bez_de) AS qa_mangel_bez_cz  
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.qa_mangel_bez END), qa_mangel_bez_de) AS qa_mangel_bez_sk 
,COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.qa_mangel_bez END), qa_mangel_bez_de) AS qa_mangel_bez_hr    
,COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.qa_mangel_bez END), qa_mangel_bez_de) AS qa_mangel_bez_pl    
,COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.qa_mangel_bez END), qa_mangel_bez_de) AS qa_mangel_bez_ro   
,COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.qa_mangel_bez END), qa_mangel_bez_de) AS qa_mangel_bez_bg  
FROM dbp_view.v_qa_mangel_spr_zu_2 v01
RIGHT JOIN (
SELECT v03.mandant_id, 
       COALESCE(v04.qa_mangel_id,'-1') AS qa_mangel_id,  
       v04.charge_nr_qa, 
       v03.wup_id, 
       v03.nb_id, 
       v03.lief_beleg_id
  FROM dbp_view.v_charge_ist_qa_check_2 v03
  LEFT JOIN dbp_view.v_charge_ist_qa_check_det_2 v04
  ON v03.charge_nr_qa = v04.charge_nr_qa
  AND v03.mandant_id = v04.mandant_id
  GROUP BY ALL
  )v02
ON v01.mandant_id = v02.mandant_id AND v01.qa_mangel_id = v02.qa_mangel_id
GROUP BY ALL)v05
GROUP BY ALL
)v08
ON v01.mandant_id =v08.mandant_id
AND v011.wup_id=v08.wup_id
AND v011.nb_id=v08.nb_id
AND v01.lief_beleg_id=v08.lief_beleg_id
AND v05.charge_nr_qa=v08.charge_nr_qa
AND v50.qa_mangel_id=v08.qa_mangel_id 



CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200







   
   JOIN dbp_view.v_kurs_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND COALESCE(v03.wrg_id, v04.wrg_id) = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   
   JOIN dbp_view.v_kurs_2 v400
   ON v01.dat_lief_soll BETWEEN v400.dat_von AND v400.dat_bis
   AND COALESCE(v03.wrg_id, v04.wrg_id) = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'


JOIN
dbp_view.v_art_wg_zu_per_2 f1
ON v01.mandant_id = f1.mandant_id
AND v011.art_id = f1.art_id

JOIN dbp_view.v_wg_per_2 f2
ON f1.mandant_id = f2.mandant_id
AND f1.wg_id = f2.wg_id
AND f1.arthiertyp_id = f2.arthiertyp_id
AND f2.dat_bis = '9999-12-31'

JOIN dbp_view.v_owg_per_2 f3
ON f2.mandant_id = f3.mandant_id
AND f2.owg_id = f3.owg_id
AND f2.arthiertyp_id = f3.arthiertyp_id
AND f3.dat_bis = '9999-12-31'

WHERE f3.hwg_id = 64
AND f3.arthiertyp_id = 2
AND f1.dat_bis = '9999-12-31';
