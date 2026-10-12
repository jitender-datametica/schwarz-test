 CREATE OR REPLACE VIEW dbp_msi_view3.mv_tour_we_2
--2.01.2019 aszu1204, new view definition for AP0027269
--30.01.2019 aszu1204, join to dbp_view.v_tour_2 without filter on transportart_id, AP0027269
--1.02.2019 aszu1204, added condition for tor_gruene_wiese_id_id display
--5.02.2019 aszu1204, outer join to mv_anlieferung_management_2  to retrieve datzeit_entl_gebucht
--08.02.2019 nwag2310, tour_2 = left part, tour_we_2 = right part (for 18.04.02 -> tour_ids without VTTKL_GR just VTTK)
--15.01.2020 baranowska, null tor_gruene_wiese_id set to -9999
--07.02.2020 baranowska, null planungsart_id set to 'ZZ'
--10.01.2024 nwag2310, performance (akt_kj >= -2) + formatting
   (
  mandant_id ,
  wup_id ,
  nb_id ,
  lagernummer_id ,
  tour_id ,
  wgvgrp_id ,
  tor_gruene_wiese_id ,
  tor_gruene_wiese_bez ,
  tor_gruene_wiese_datum ,
  tor_gruene_wiese_zeit ,
  tor_best_verfuegbar_id ,
  tor_best_verfuegbar_datum ,
  tor_best_verfuegbar_zeit ,
  tor_verplant_id ,
  tor_verplant_datum ,
  tor_verplant_zeit ,
  planungsart_id ,
  artikeltyp_we ,
  dat_letzte_neuberechnung ,
  zeit_letzte_neuberechnung ,
  kritische_zone_status_id ,
  we_message_status_id ,
  anz_stellplaetze ,
  anz_artikel ,
  lagerplatz_gruene_wiese_id ,
  wgvgrp_gruene_wiese_id ,
  entfernung_tor_gruene_wiese ,
  lagerplatz_best_verfuegbar_id ,
  wgvgrp_best_verfuegbar_id ,
  entfernung_tor_best_verfuegbar ,
  lagerplatz_verplant_id ,
  wgvgrp_verplant_id ,
  entfernung_tor_verplant ,
  mit_anlieferung_fg ,
  mit_blockartikel_fg ,
  mit_blockartikel_kein_lgpla_fg
  -- fields from tour_2
  ,
  anlieferung_id ,
  datzeit_entl_gebucht ,
  dat_ankunft_vz ,
  zeit_ankunft_vz ,
  dat_einfahrt_pforte ,
  zeit_einfahrt_pforte ,
  dat_ausfahrt_pforte ,
  zeit_ausfahrt_pforte ,
  laden_beginn_dt ,
  laden_ende_dt ,
  registrierung_dt ,
  transport_ende_dt ,
  anz_we_pal_abgeladen ,
  queue_id ,
  misch_lkw_nummer ,
  misch_lkw_position ,
  transportstatus_id ,
  text_1 ,
  text_2 ,
  text_3 ,
  text_4 ,
  dauer_verladezeit ,
  dauer_verplanung ,
  verweildauer_im_gelande
   )
AS SELECT       t.mandant_id,
                t.wup_id,
                t.nb_id,
                t.lagernummer_id,
                t.tour_id,
                twe.wgvgrp_id,
                CASE
                                WHEN twe.tor_gruene_wiese_id IS NULL THEN -9999
                                ELSE twe.tor_gruene_wiese_id
                END AS tor_gruene_wiese_id ,
                CASE
                                WHEN To_varchar(twe.tor_gruene_wiese_id) = To_varchar(lg.dummy_tor_id) THEN 'Dummy_2-Tor'
                                WHEN twe.tor_gruene_wiese_id = '0' THEN 'leer'
                                ELSE To_varchar(twe.tor_gruene_wiese_id)
                END AS tor_gruene_wiese_bez ,
                twe.tor_gruene_wiese_datum,
                twe.tor_gruene_wiese_zeit,
                twe.tor_best_verfuegbar_id,
                twe.tor_best_verfuegbar_datum,
                twe.tor_best_verfuegbar_zeit,
                twe.tor_verplant_id,
                twe.tor_verplant_datum,
                twe.tor_verplant_zeit,
                CASE
                                WHEN twe.planungsart_id IS NULL THEN 'ZZ'
                                ELSE twe.planungsart_id
                END AS planungsart_id,
                twe.artikeltyp_we,
                twe.dat_letzte_neuberechnung,
                twe.zeit_letzte_neuberechnung,
                twe.kritische_zone_status_id,
                twe.we_message_status_id,
                twe.anz_stellplaetze,
                twe.anz_artikel,
                twe.lagerplatz_gruene_wiese_id,
                twe.wgvgrp_gruene_wiese_id,
                twe.entfernung_tor_gruene_wiese,
                twe.lagerplatz_best_verfuegbar_id,
                twe.wgvgrp_best_verfuegbar_id,
                twe.entfernung_tor_best_verfuegbar,
                twe.lagerplatz_verplant_id,
                twe.wgvgrp_verplant_id,
                twe.entfernung_tor_verplant,
                t.mit_anlieferung_fg,
                twe.mit_blockartikel_fg,
                twe.mit_blockartikel_kein_lgpla_fg,
                t.anlieferung_id,
                anm.datzeit_entl_gebucht,
                t.dat_ankunft_vz,
                t.zeit_ankunft_vz,
                t.dat_einfahrt_pforte,
                t.zeit_einfahrt_pforte,
                t.dat_ausfahrt_pforte,
                t.zeit_ausfahrt_pforte,
                t.laden_beginn_dt,
                t.laden_ende_dt,
                t.registrierung_dt,
                t.transport_ende_dt,
                t.anz_we_pal_abgeladen,
                t.queue_id,
                t.misch_lkw_nummer,
                t.misch_lkw_position,
                t.transportstatus_id,
                t.text_1,
                t.text_2,
                t.text_3,
                t.text_4,
                CAST(SUM(CASE WHEN T.DAT_LADEN_ENDE < ADD_MONTHS(CURRENT_DATE, 48)
					AND T.DAT_LADEN_BEGINN < ADD_MONTHS(CURRENT_DATE, 48) 
					THEN (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.LADEN_BEGINN_DT, T.LADEN_ENDE_DT)):DAY * 86400 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.LADEN_BEGINN_DT, T.LADEN_ENDE_DT)):HOUR * 3600 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.LADEN_BEGINN_DT, T.LADEN_ENDE_DT)):MINUTE * 60 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.LADEN_BEGINN_DT, T.LADEN_ENDE_DT)):SECOND )
					ELSE NULL  END) AS NUMBER(38,5)) AS DAUER_VERLADEZEIT,
                CAST( CASE WHEN SIGN( SUM( CASE WHEN T.DAT_REGISTRIERUNG < ADD_MONTHS(CURRENT_DATE, 48) 
					THEN (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.REGISTRIERUNG_DT, T.LADEN_BEGINN_DT)):DAY * 86400 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.REGISTRIERUNG_DT, T.LADEN_BEGINN_DT)):HOUR * 3600 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.REGISTRIERUNG_DT, T.LADEN_BEGINN_DT)):MINUTE * 60 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.REGISTRIERUNG_DT, T.LADEN_BEGINN_DT)):SECOND )
					ELSE NULL END)) >=0 THEN SUM( CASE WHEN T.DAT_REGISTRIERUNG < ADD_MONTHS(CURRENT_DATE, 48) 
					THEN (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.REGISTRIERUNG_DT, T.LADEN_BEGINN_DT)):DAY * 86400 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.REGISTRIERUNG_DT, T.LADEN_BEGINN_DT)):HOUR * 3600 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.REGISTRIERUNG_DT, T.LADEN_BEGINN_DT)):MINUTE * 60 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.REGISTRIERUNG_DT, T.LADEN_BEGINN_DT)):SECOND )
					ELSE NULL END) 
					ELSE TIMESTAMPDIFF(SECOND,T.REGISTRIERUNG_DT, T.LADEN_BEGINN_DT) END AS NUMBER(38,5)) AS DAUER_VERPLANUNG,
                CAST( SUM( CASE WHEN T.DAT_EINFAHRT_PFORTE < ADD_MONTHS(CURRENT_DATE, 48) THEN (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.EINFAHRT_PFORTE_DT, T.AUSFAHRT_PFORTE_DT)):DAY * 86400 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.EINFAHRT_PFORTE_DT, T.AUSFAHRT_PFORTE_DT)):HOUR * 3600 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.EINFAHRT_PFORTE_DT, T.AUSFAHRT_PFORTE_DT)):MINUTE * 60 ) + (SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT(TIMESTAMPDIFF(SECOND, T.EINFAHRT_PFORTE_DT, T.AUSFAHRT_PFORTE_DT)):SECOND )
                    ELSE NULL END) AS NUMBER(38,5)) AS VERWEILDAUER_IM_GELANDE
FROM
                -- t view
                (
SELECT          v01.mandant_id,
				v01.nb_id,
				v01.wup_id,
				v01.tour_id,
				v01.lagernummer_id,
				v01.dat_laden_beginn,
				v01.zeit_laden_beginn,
				v01.dat_laden_ende,
				v01.zeit_laden_ende,
				v01.dat_registrierung,
				v01.zeit_registrierung,
				v01.dat_einfahrt_pforte,
				v01.zeit_einfahrt_pforte,
				v01.dat_ausfahrt_pforte,
				v01.zeit_ausfahrt_pforte,
				CASE WHEN v01.dat_laden_beginn IS NOT NULL
				AND             v01.zeit_laden_beginn IS NOT NULL
								--THEN (CAST(CAST(v01.dat_laden_beginn AS CHAR(11))||COALESCE(CAST(v01.zeit_laden_beginn AS CHAR(8)),'00:00:00') AS TIMESTAMP))
				THEN TIMESTAMP_FROM_PARTS(v01.dat_laden_beginn, v01.zeit_laden_beginn)
							ELSE NULL
				END AS laden_beginn_dt ,
				CASE WHEN v01.dat_laden_ende IS NOT NULL
				AND             v01.zeit_laden_ende IS NOT NULL
								--THEN (CAST(CAST(v01.dat_laden_ende AS CHAR(11))||COALESCE(CAST(v01.zeit_laden_ende AS CHAR(8)),'00:00:00') AS TIMESTAMP))
				THEN TIMESTAMP_FROM_PARTS(v01.dat_laden_ende, v01.zeit_laden_ende)
				ELSE NULL
				END AS laden_ende_dt ,
				CASE WHEN v01.dat_registrierung IS NOT NULL
				AND             v01.zeit_registrierung IS NOT NULL
								--THEN (CAST(CAST(v01.dat_registrierung AS CHAR(11))||COALESCE(CAST(v01.zeit_registrierung AS CHAR(8)),'00:00:00') AS TIMESTAMP))
				THEN TIMESTAMP_FROM_PARTS(v01.dat_registrierung,v01.zeit_registrierung)
				ELSE NULL
				END AS registrierung_dt ,
				CASE WHEN v01.dat_einfahrt_pforte IS NOT NULL
				AND             v01.zeit_einfahrt_pforte IS NOT NULL
								--THEN (CAST(CAST(v01.dat_einfahrt_pforte AS CHAR(11))||COALESCE(CAST(v01.zeit_einfahrt_pforte AS CHAR(8)),'00:00:00') AS TIMESTAMP))
				THEN TIMESTAMP_FROM_PARTS(v01.dat_einfahrt_pforte,v01.zeit_einfahrt_pforte)
				ELSE NULL
				END AS einfahrt_pforte_dt ,
				CASE WHEN v01.dat_ausfahrt_pforte IS NOT NULL
				AND             v01.zeit_ausfahrt_pforte IS NOT NULL
								--THEN (CAST(CAST(v01.dat_ausfahrt_pforte AS CHAR(11))||COALESCE(CAST(v01.zeit_ausfahrt_pforte AS CHAR(8)),'00:00:00') AS TIMESTAMP))
				THEN TIMESTAMP_FROM_PARTS(v01.dat_ausfahrt_pforte, v01.zeit_ausfahrt_pforte)
				ELSE NULL
				END AS ausfahrt_pforte_dt ,
				CASE WHEN v01.dat_transport_ende IS NOT NULL
				AND             v01.zeit_transport_ende IS NOT NULL
								--THEN (CAST(CAST(v01.dat_transport_ende AS CHAR(11))||COALESCE(CAST(v01.zeit_transport_ende AS CHAR(8)),'00:00:00') AS TIMESTAMP))
				THEN TIMESTAMP_FROM_PARTS(v01.dat_transport_ende,v01.zeit_transport_ende)
				ELSE NULL
				END AS transport_ende_dt ,
				v01.anlieferung_id,
				v01.dat_ankunft_vz,
				v01.zeit_ankunft_vz,
				v01.anz_we_pal_abgeladen,
				v01.queue_id,
				v01.misch_lkw_nummer,
				v01.misch_lkw_position,
				v01.transportstatus_id,
				v01.text_1,
				v01.text_2,
				v01.text_3,
				v01.text_4,
				COALESCE(v02.mit_anlieferung_fg,0) AS mit_anlieferung_fg
FROM            dbp_view.v_tour_2 v01
JOIN  			dbp_view.v_tag_2 t
ON 				v01.dat_tour = t.dat
AND				t.akt_kj >= -2
LEFT OUTER JOIN
				( SELECT DISTINCT mandant_id,
												tour_id,
												1 AS mit_anlieferung_fg
								FROM            dbp_view.v_tour_det_2
								WHERE           lief_beleg_id > 0) v02
ON              v01.mandant_id=v02.mandant_id
AND             v01.tour_id = v02.tour_id
				--temporarily filter to exclude non valid records
) t
LEFT OUTER JOIN dbp_view.v_tour_we_2 twe
ON              t.tour_id = twe.tour_id
AND             t.mandant_id = twe.mandant_id
AND             t.wup_id = twe.wup_id
JOIN            dbp_view.v_l_lagernummer_2 lg
ON              t.lagernummer_id = lg.lagernummer_id
AND             t.mandant_id = lg.mandant_id
AND             t.wup_id = lg.wup_id
AND             t.nb_id = lg.nb_id
LEFT OUTER JOIN dbp_msi_view3.mv_anlieferung_management_2 anm
ON              ( anm.anlieferung_id = t.anlieferung_id
                AND anm.mandant_id = t.mandant_id)
GROUP BY        t.mandant_id ,
                t.wup_id ,
                t.nb_id ,
                t.lagernummer_id ,
                t.tour_id ,
                twe.wgvgrp_id ,
                twe.tor_gruene_wiese_id ,
                tor_gruene_wiese_bez ,
                twe.tor_gruene_wiese_datum ,
                twe.tor_gruene_wiese_zeit ,
                twe.tor_best_verfuegbar_id ,
                twe.tor_best_verfuegbar_datum ,
                twe.tor_best_verfuegbar_zeit ,
                twe.tor_verplant_id ,
                twe.tor_verplant_datum ,
                twe.tor_verplant_zeit ,
                twe.planungsart_id ,
                twe.artikeltyp_we ,
                twe.dat_letzte_neuberechnung ,
                twe.zeit_letzte_neuberechnung ,
                twe.kritische_zone_status_id ,
                twe.we_message_status_id ,
                twe.anz_stellplaetze ,
                twe.anz_artikel ,
                twe.lagerplatz_gruene_wiese_id ,
                twe.wgvgrp_gruene_wiese_id ,
                twe.entfernung_tor_gruene_wiese ,
                twe.lagerplatz_best_verfuegbar_id ,
                twe.wgvgrp_best_verfuegbar_id ,
                twe.entfernung_tor_best_verfuegbar ,
                twe.lagerplatz_verplant_id ,
                twe.wgvgrp_verplant_id ,
                twe.entfernung_tor_verplant ,
                t.mit_anlieferung_fg ,
                twe.mit_blockartikel_fg ,
                twe.mit_blockartikel_kein_lgpla_fg ,
                t.anlieferung_id ,
                anm.datzeit_entl_gebucht ,
                t.dat_ankunft_vz ,
                t.zeit_ankunft_vz ,
                t.dat_einfahrt_pforte ,
                t.zeit_einfahrt_pforte ,
                t.dat_ausfahrt_pforte ,
                t.zeit_ausfahrt_pforte ,
                t.laden_beginn_dt ,
                t.laden_ende_dt ,
                t.registrierung_dt ,
                t.transport_ende_dt ,
                t.anz_we_pal_abgeladen ,
                t.queue_id ,
                t.misch_lkw_nummer ,
                t.misch_lkw_position ,
                t.transportstatus_id ,
                t.text_1 ,
                t.text_2 ,
                t.text_3 ,
                t.text_4 ; 