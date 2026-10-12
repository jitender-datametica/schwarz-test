CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_RUECKFUEHRUNG_LADUNGSTRAEGER(
	DAT_BUCH,
	DAT_TOUR,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
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
) AS
 -- 27.09.2021, AP0081637,SPEC0123461, dknop, initial
 -- 18.11.2021, AP0081637,SPEC0123461, dknop, updating join to V_RUECKFUEHRUNG_LT_GRUND to rueck_lt_gr.lagerbew_beleg_id=rueck_lt.lagerbew_beleg_id, COALESCE(...,null) instead of COALESCE(...,'-1')
 -- 22.11.2021, AP0081637,SPEC0123461, dknop, COALESCE (NULLIFZERO(v02.stellplatz_faktor), NULL)
 -- 18.01.2022, AP0081637,SPEC0123461, dknop adding v_art_wg_zu_per.dat_bis='9999-12-31' in part for faktor
 -- 21.01.2022, AP0081637,SPEC0123461, dknop, removing rueck_lt.wup_id_lager=tour.wup_idfrom join to v_tour
 -- 26.01.2022, AP0081637,SPEC0123461, dknop, adding wg_id in (984, 985) in part for faktor
 -- 2022.03.03, AP0081637,SPEC0123461, dknop, adding COALESCE(art.ipn_id,0)
 -- 2024.06.14, nwag2310 COALESCE for Stellplatzfaktor
 -- 2024-07-22,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
 -- 2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
 -- 2024-11-26, nwag, branch to limit on >= 2023 as an interim solution
 -- 2024-12-03, nwag, merge + change WG Filter for TS
 SELECT 
 rueck_lt.dat_buch
,COALESCE(tour.dat_tour, tu_akt.dat_tour) AS dat_tour_
,rueck_lt.tour_id AS transportation_unit_id
,YEAR(COALESCE(tour.dat_tour, tu_akt.dat_tour)) AS KJ_TRANSPORTATION_UNIT
,rueck_lt.nb_id_lager
,rueck_lt.wup_id_lager
,COALESCE(aktuell_wup_id,rueck_lt.wup_id) AS wup_id
,rueck_lt.mandant_id
,COALESCE(rueck_lt.wertstoffturm_nr,NULL) AS wertstoffturm_nr
,rueck_lt.art_id
,rueck_lt.lagerbew_beleg_id
,COALESCE(rueck_lt_gr.rueck_grund_id,NULL) AS rueck_grund_id
,rueck_lt.lfnr
,COALESCE(art.ipn_id,0) AS ipn_id
,rueck_lt.menge_bme
,rueck_lt.anz_stp
,COALESCE(faktor.vol,0) AS vol
,CONCAT(rueck_lt.tour_id,rueck_lt.wup_id,rueck_lt.lagerbew_beleg_id,rueck_lt.lfnr,rueck_lt.art_id) AS positionen
FROM DBP_VIEW.V_RUECKFUEHRUNG_LT rueck_lt

LEFT JOIN dbp_view.v_wup w
ON w.mandant_id = rueck_lt.mandant_id
AND w.wup_id = rueck_lt.wup_id
AND w.nb_id = 0

LEFT JOIN DBP_VIEW.V_RUECKFUEHRUNG_LT_GRUND rueck_lt_gr
ON rueck_lt.mandant_id=rueck_lt_gr.mandant_id
AND rueck_lt.tour_id=rueck_lt_gr.tour_id
AND rueck_lt.lfnr=rueck_lt_gr.lfnr
AND rueck_lt_gr.lagerbew_beleg_id=rueck_lt.lagerbew_beleg_id
AND rueck_lt.art_id=rueck_lt_gr.art_id

LEFT JOIN DBP_VIEW.V_TOUR tour
ON rueck_lt.mandant_id=tour.mandant_id
AND rueck_lt.wup_id_lager=tour.wup_id
AND rueck_lt.tour_id=tour.tour_id

LEFT JOIN DBP_VIEW.V_TRANSPORTATION_UNIT_AKTIVITAET tu_akt
ON rueck_lt.tour_id=tu_akt.transportation_unit_id
AND rueck_lt.mandant_id=tu_akt.mandant_id
AND tu_akt.aktivitaet_richtung_id='2'
--AND tu_akt.kj_transportation_unit = YEAR(rueck_lt.dat_buch)

LEFT JOIN DBP_VIEW.V_ART art
ON rueck_lt.art_id=art.art_id
AND rueck_lt.mandant_id=art.mandant_id

LEFT JOIN  (SELECT
      v01.mandant_id
     ,v01.art_id
     ,COALESCE (NULLIFZERO(v02.stellplatz_faktor), NULL) AS vol
   FROM dbp_view.v_art v01
   LEFT JOIN dbp_msi_view_log.ts_art_stellplatz_faktor v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   INNER JOIN dbp_view.v_art_wg_zu_per v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.art_id = v03.art_id
   AND v03.dat_bis = '9999-12-31'
   AND v03.arthiertyp_id = 2   
    --switch to wg filter [will be maintained if product groups change]:
    INNER JOIN dbp_view.v_wg_filter_zu v04
    ON v04.mandant_id = v03.mandant_id
    AND v04.wg_id = v03.wg_id
    AND v04.wg_filter_id=4

   WHERE v01.dat_bis = '9999-12-31'
   --AND v03.wg_id IN (980, 981, 982, 983, 984, 985)
   ) faktor
ON  rueck_lt.art_id=faktor.art_id
  AND rueck_lt.mandant_id=faktor.mandant_id
WHERE --interim fix for prod - to be remove later when KJ_TRANSPORTATION_UNIT is on prod in MSTR!
dat_tour_ >= '2023-01-01';