create or replace view DBP_MSI_VIEW_LOG.MV_RUECKFUEHRUNG_LADUNGSTRAGER_2(
	DAT_BUCH,
	DAT_TOUR,
	TRANSPORTATION_UNIT_ID,
	NB_ID_LAGER,
	WUP_ID_LAGER,
	WUP_ID,
	MANDANT_ID,
	WERTSTOFFTURM_NR,
	ART_ID,
	LAGERBEW_BELEG_ID,
	RUECK_GRUND_ID,
	LFNR,
	IPN_ID,
	MENGE_BME,
	ANZ_STP,
	VOL,
	POSITIONEN
) as
 SELECT 
 rueck_lt.dat_buch
,COALESCE(tour.dat_tour, tu_akt.dat_tour) AS dat_tour
,rueck_lt.tour_id AS transportation_unit_id
,rueck_lt.nb_id_lager
,rueck_lt.wup_id_lager
,rueck_lt.wup_id
,rueck_lt.mandant_id
,COALESCE(rueck_lt.wertstoffturm_nr,NULL) AS wertstoffturm_nr
,rueck_lt.art_id
,rueck_lt.lagerbew_beleg_id
,COALESCE(rueck_lt_gr.rueck_grund_id,NULL) AS rueck_grund_id
,rueck_lt.lfnr
,art.ipn_id
,rueck_lt.menge_bme
,rueck_lt.anz_stp
,faktor.vol
,CONCAT(rueck_lt.tour_id,rueck_lt.wup_id,rueck_lt.lagerbew_beleg_id,rueck_lt.lfnr,rueck_lt.art_id) AS positionen
FROM DBP_VIEW.V_RUECKFUEHRUNG_LT_2 rueck_lt

LEFT JOIN DBP_VIEW.V_RUECKFUEHRUNG_LT_GRUND_2 rueck_lt_gr
ON rueck_lt.mandant_id=rueck_lt_gr.mandant_id
AND rueck_lt.tour_id=rueck_lt_gr.tour_id
AND rueck_lt.lfnr=rueck_lt_gr.lfnr
AND rueck_lt_gr.lagerbew_beleg_id=rueck_lt.lagerbew_beleg_id
AND rueck_lt.art_id=rueck_lt_gr.art_id

LEFT JOIN DBP_VIEW.V_TOUR_2 tour_2
ON rueck_lt.wup_id_lager=tour.wup_id
AND rueck_lt.mandant_id=tour.mandant_id
AND rueck_lt.tour_id=tour.tour_id

LEFT JOIN DBP_VIEW.V_TRANSPORTATION_UNIT_AKTIVITAET_2 tu_akt
ON rueck_lt.tour_id=tu_akt.transportation_unit_id
AND rueck_lt.mandant_id=tu_akt.mandant_id
AND tu_akt.aktivitaet_richtung_id=2

LEFT JOIN DBP_VIEW.V_ART_2 art_2
ON rueck_lt.art_id=art.art_id
AND rueck_lt.mandant_id=art.mandant_id

LEFT JOIN  (SELECT
      v01.mandant_id
     ,v01.art_id
     ,COALESCE (NULLIFZERO(v02.stellplatz_faktor), NULL) AS vol
   FROM dbp_view.v_art_2 v01
   LEFT JOIN dbp_msi_view_log.ts_art_stellplatz_faktor_2 v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   INNER JOIN dbp_view.v_art_wg_zu_per_2 v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.art_id = v03.art_id
   WHERE v01.dat_bis = '9999-12-31'
   AND v03.wg_id IN (980, 981, 982, 983)) faktor
ON  rueck_lt.art_id=faktor.art_id
AND rueck_lt.mandant_id=faktor.mandant_id;