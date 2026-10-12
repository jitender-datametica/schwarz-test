CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_RUECKFUEHRUNG_LT_GRUND
(
	MANDANT_ID,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
	TOUR_ID,
	RUCKFUHRUNG_FG
) AS
--03.02.2021, SPEC0091861, AP0073899, dknop, initiale Anlage
--03.03.2021, SPEC0091861, AP0073899, nwag2310, initiale filter on richtung=2 + deduplication rueckfuherung
--2024-09-28, dknop, limiting to t_unit.dat_tour >= 01.01.2022 because of transportation_unit duplication
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
SELECT
 v01.mandant_id
,v01.transportation_unit_id
,v01.KJ_TRANSPORTATION_UNIT
,v02.tour_id
,CASE WHEN v02.tour_id IS NOT NULL THEN  '1' ELSE '0' END AS ruckfuhrung_fg
FROM
(SELECT
 v01.mandant_id
,v01.transportation_unit_id
,v01.KJ_TRANSPORTATION_UNIT
,v01.dat_tour
,SUM(v01.menge_gefahrgut) AS menge_gefahrgut
FROM dbp_view.v_transportation_unit_aktivitaet v01
WHERE v01.aktivitaet_richtung_id = '2'
GROUP BY v01.mandant_id
,v01.transportation_unit_id, v01.KJ_TRANSPORTATION_UNIT
,v01.dat_tour)v01
LEFT JOIN (SELECT
mandant_id
,tour_id
,YEAR(dat_buch) AS KJ_TRANSPORTATION_UNIT
FROM dbp_view.v_rueckfuehrung_lt 
   GROUP BY  mandant_id, tour_id,YEAR(dat_buch)) v02 ON v01.transportation_unit_id = v02.tour_id AND v01.mandant_id=v02.mandant_id AND v01.KJ_TRANSPORTATION_UNIT=v02.KJ_TRANSPORTATION_UNIT
 WHERE v01.KJ_TRANSPORTATION_UNIT >= YEAR(CURRENT_DATE)-2
 ;