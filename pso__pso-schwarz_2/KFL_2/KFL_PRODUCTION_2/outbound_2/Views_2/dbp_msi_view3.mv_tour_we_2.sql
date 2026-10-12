--2.01.2019 aszu1204, new view definition for AP0027269
--30.01.2019 aszu1204, join to dbp_view.v_tour_2 without filter on transportart_id, AP0027269
--1.02.2019 aszu1204, added condition for tor_gruene_wiese_id_id display
--5.02.2019 aszu1204, outer join to mv_anlieferung_management_2  to retrieve datzeit_entl_gebucht
--08.02.2019 nwag2310, tour_2 = left part, tour_we_2 = right part (for 18.04.02 -> tour_ids without VTTKL_GR just VTTK)
--15.01.2020 baranowska, null tor_gruene_wiese_id set to -9999
--07.02.2020 baranowska, null planungsart_id set to 'ZZ'
--10.01.2024 nwag2310, performance (akt_kj >= -2) + formatting
CREATE OR REPLACE VIEW `kfl_production_dbp_msi_view3.mv_tour_we_2`
AS
SELECT
  t.mandant_id,
  t.wup_id,
  t.nb_id,
  t.lagernummer_id,
  t.tour_id,
  twe.wgvgrp_id,
  COALESCE(twe.tor_gruene_wiese_id, -9999) AS tor_gruene_wiese_id,
  CASE
    WHEN CAST(twe.tor_gruene_wiese_id AS STRING) = CAST(lg.dummy_tor_id AS STRING) THEN 'Dummy_2-Tor'
    WHEN CAST(twe.tor_gruene_wiese_id AS STRING) = '0' THEN 'leer'
    ELSE CAST(twe.tor_gruene_wiese_id AS STRING)
  END AS tor_gruene_wiese_bez,
  twe.tor_gruene_wiese_datum,
  twe.tor_gruene_wiese_zeit,
  twe.tor_best_verfuegbar_id,
  twe.tor_best_verfuegbar_datum,
  twe.tor_best_verfuegbar_zeit,
  twe.tor_verplant_id,
  twe.tor_verplant_datum,
  twe.tor_verplant_zeit,
  COALESCE(twe.planungsart_id, 'ZZ') AS planungsart_id,
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

  CAST(SUM(CASE 
    WHEN T.DAT_LADEN_ENDE < DATE_ADD(CURRENT_DATE(), INTERVAL 48 MONTH)
     AND T.DAT_LADEN_BEGINN < DATE_ADD(CURRENT_DATE(), INTERVAL 48 MONTH) 
    THEN TIMESTAMP_DIFF(T.LADEN_ENDE_DT, T.LADEN_BEGINN_DT, SECOND)
    ELSE NULL END) AS NUMERIC) AS DAUER_VERLADEZEIT,

  CAST(SUM(CASE 
    WHEN T.DAT_REGISTRIERUNG < DATE_ADD(CURRENT_DATE(), INTERVAL 48 MONTH) 
    THEN TIMESTAMP_DIFF(T.LADEN_BEGINN_DT, T.REGISTRIERUNG_DT, SECOND)
    ELSE NULL END) AS NUMERIC) AS DAUER_VERPLANUNG,

  CAST(SUM(CASE 
    WHEN T.DAT_EINFAHRT_PFORTE < DATE_ADD(CURRENT_DATE(), INTERVAL 48 MONTH) 
    THEN TIMESTAMP_DIFF(T.AUSFAHRT_PFORTE_DT, T.EINFAHRT_PFORTE_DT, SECOND)
    ELSE NULL END) AS NUMERIC) AS VERWEILDAUER_IM_GELANDE
FROM (
  SELECT 
    v01.*,
    CASE WHEN v01.dat_laden_beginn IS NOT NULL AND v01.zeit_laden_beginn IS NOT NULL 
    --THEN (CAST(CAST(v01.dat_laden_beginn AS CHAR(11))||COALESCE(CAST(v01.zeit_laden_beginn AS CHAR(8)),'00:00:00') AS TIMESTAMP))
         THEN datetime(v01.dat_laden_beginn, v01.zeit_laden_beginn) ELSE NULL END AS laden_beginn_dt,
    CASE WHEN v01.dat_laden_ende IS NOT NULL AND v01.zeit_laden_ende IS NOT NULL 
    --THEN (CAST(CAST(v01.dat_laden_ende AS CHAR(11))||COALESCE(CAST(v01.zeit_laden_ende AS CHAR(8)),'00:00:00') AS TIMESTAMP))
         THEN datetime(v01.dat_laden_ende, v01.zeit_laden_ende) ELSE NULL END AS laden_ende_dt,
    CASE WHEN v01.dat_registrierung IS NOT NULL AND v01.zeit_registrierung IS NOT NULL 
    	--THEN (CAST(CAST(v01.dat_registrierung AS CHAR(11))||COALESCE(CAST(v01.zeit_registrierung AS CHAR(8)),'00:00:00') AS TIMESTAMP))
         THEN datetime(v01.dat_registrierung, v01.zeit_registrierung) ELSE NULL END AS registrierung_dt,
    CASE WHEN v01.dat_einfahrt_pforte IS NOT NULL AND v01.zeit_einfahrt_pforte IS NOT NULL 
    --THEN (CAST(CAST(v01.dat_einfahrt_pforte AS CHAR(11))||COALESCE(CAST(v01.zeit_einfahrt_pforte AS CHAR(8)),'00:00:00') AS TIMESTAMP))
         THEN datetime(v01.dat_einfahrt_pforte, v01.zeit_einfahrt_pforte) ELSE NULL END AS einfahrt_pforte_dt,
    CASE WHEN v01.dat_ausfahrt_pforte IS NOT NULL AND v01.zeit_ausfahrt_pforte IS NOT NULL 
    --THEN (CAST(CAST(v01.dat_ausfahrt_pforte AS CHAR(11))||COALESCE(CAST(v01.zeit_ausfahrt_pforte AS CHAR(8)),'00:00:00') AS TIMESTAMP))
         THEN datetime(v01.dat_ausfahrt_pforte, v01.zeit_ausfahrt_pforte) ELSE NULL END AS ausfahrt_pforte_dt,
    CASE WHEN v01.dat_transport_ende IS NOT NULL AND v01.zeit_transport_ende IS NOT NULL 
    --THEN (CAST(CAST(v01.dat_transport_ende AS CHAR(11))||COALESCE(CAST(v01.zeit_transport_ende AS CHAR(8)),'00:00:00') AS TIMESTAMP))
         THEN datetime(v01.dat_transport_ende, v01.zeit_transport_ende) ELSE NULL END AS transport_ende_dt,
    COALESCE(v02.mit_anlieferung_fg, 0) AS mit_anlieferung_fg
  FROM `kfl_production_dbp_view.v_tour_2` v01
  JOIN `kfl_production_dbp_view.v_tag_2` t ON v01.dat_tour = t.dat AND t.akt_kj >= -2
  LEFT OUTER JOIN (
    SELECT DISTINCT mandant_id, tour_id, 1 AS mit_anlieferung_fg
    FROM `kfl_production_dbp_view.v_tour_det_2`
    WHERE lief_beleg_id > 0
  ) v02 ON v01.mandant_id = v02.mandant_id AND v01.tour_id = v02.tour_id
) t
LEFT OUTER JOIN `kfl_production_dbp_view.v_tour_we_2` twe 
  ON t.tour_id = twe.tour_id AND t.mandant_id = twe.mandant_id AND t.wup_id = twe.wup_id
JOIN `kfl_production_dbp_view.v_l_lagernummer_2` lg 
  ON t.lagernummer_id = lg.lagernummer_id AND t.mandant_id = lg.mandant_id AND t.wup_id = lg.wup_id AND t.nb_id = lg.nb_id
LEFT OUTER JOIN `kfl_production_dbp_msi_view3.mv_anlieferung_management_2` anm 
  ON anm.anlieferung_id = t.anlieferung_id AND anm.mandant_id = t.mandant_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57;