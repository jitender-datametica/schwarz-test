CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_PLANTOUR(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	PLANTOUR_ID,
	TOUR_ID,
	TRAILER_FG,
	TRAILER_ID,
	DAT_TRAILER,
	ZEIT_TRAILER,
	AUSFAHRT_PFORTE_DT,
	ZEITSTEMPEL_TRAILER
) AS
--2022-04-27, AP0119377, SPEC0152763, dknop, initial
SELECT 
tour_pl.mandant_id,
tour_pl.wup_id,
tour_pl.nb_id,
tour_pl.plantour_id,
tour_pl.tour_id,
tour_pl.trailer_fg,
tour_pl.trailer_id,
tour_pl.dat_trailer,
tour_pl.zeit_trailer,
tour_p_s.ausfahrt_pforte_dt,
CASE WHEN tour_pl.zeit_trailer IS NULL THEN NULL ELSE TIMESTAMP_FROM_PARTS(tour_pl.dat_trailer,COALESCE(tour_pl.zeit_trailer,'00:00:00')) END AS zeitstempel_trailer
--TIMESTAMP_FROM_PARTS(tour.dat_ausfahrt_pforte,COALESCE(tour.zeit_ausfahrt_pforte,'00:00:00')) AS zeitstempel_ausfahrt_pforte
FROM dbp_view.v_plantour tour_pl

JOIN dbp_view.v_tour tour
ON tour_pl.mandant_id=tour.mandant_id
AND tour_pl.tour_id=tour.tour_id

LEFT JOIN (
                -- v02
                SELECT mandant_id,
                    tour_id,
                    MIN(
                        (
                            CAST(
                                CAST(dat_erfasst AS CHAR(11)) || ' ' || zeit_erfasst AS TIMESTAMP
                            )
                        )
                    ) AS ausfahrt_pforte_dt
                FROM dbp_view.v_tour_plombe_start
                WHERE plombe_vorgang_id = 'B'
                    AND storno_fg = 0
                    AND nb_id = -111
                GROUP BY mandant_id,
                    tour_id
            ) tour_p_s ON tour.mandant_id = tour_p_s.mandant_id
            AND tour.tour_id = tour_p_s.tour_id 
        WHERE tour.transportart_id IN ('Z001', 'ZF01', 'ZF02', 'ZF03') 
   
 -- and  tour_pl.tour_id=26400292


;