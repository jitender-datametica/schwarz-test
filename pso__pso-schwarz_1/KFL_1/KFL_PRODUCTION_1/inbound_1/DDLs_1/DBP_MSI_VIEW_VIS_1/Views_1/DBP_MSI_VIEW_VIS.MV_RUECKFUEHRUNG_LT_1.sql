CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_RUECKFUEHRUNG_LT_1(
      MANDANT_ID,
	TOUR_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	LAGERBEW_BELEG_ID,
	KJ,
	LFNR,
	DAT_BUCH,
	WUP_ID_LAGER,
	NB_ID_LAGER,
	RUECK_GRUND_ID,
	MENGE_BME,
	MANDANT_ID_LAGER
) AS

      -- snik1809 02.12.2020 - SPEC0093458 - AP0061849 - creating view in vis, copy from lis
      -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
SELECT
      v01.mandant_id
      , v01.tour_id
      , wup.aktuell_wup_id AS wup_id
      , v01.nb_id
      , v01.art_id
      , v01.lagerbew_beleg_id
      , v01.kj
      , v01.lfnr
      , v01.dat_buch
      , v01.wup_id_lager
      , v01.nb_id_lager
      , COALESCE(v02.rueck_grund_id, -1) AS rueck_grund_id
      , CASE 
            WHEN ROW_NUMBER() OVER(PARTITION BY v01.mandant_id, v01.tour_id, aktuell_wup_id, v01.nb_id, v01.art_id, v01.lagerbew_beleg_id, v01.kj, v01.lfnr, v01.dat_buch ORDER BY v02.rueck_grund_id) = 1
            THEN v01.menge_bme 
            ELSE 0 
      END AS menge_bme
      , v01.mandant_id_lager
FROM dbp_view.v_rueckfuehrung_lt_1 v01
LEFT JOIN dbp_view.v_rueckfuehrung_lt_grund_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.tour_id = v02.tour_id
AND v01.wup_id = v02.wup_id
AND v01.nb_id = v02.nb_id
AND v01.art_id = v02.art_id
AND v01.lagerbew_beleg_id = v02.lagerbew_beleg_id
AND v01.kj = v02.kj
AND v01.lfnr = v02.lfnr
AND v01.dat_buch = v02.dat_buch
INNER JOIN dbp_view.v_wup_1 wup_1
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;


