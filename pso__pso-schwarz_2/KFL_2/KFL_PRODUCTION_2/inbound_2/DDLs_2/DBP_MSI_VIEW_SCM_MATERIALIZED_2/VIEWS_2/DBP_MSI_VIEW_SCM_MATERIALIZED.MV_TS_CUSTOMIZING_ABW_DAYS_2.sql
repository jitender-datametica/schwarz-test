create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_CUSTOMIZING_ABW_DAYS_2(
	MANDANT_ID,
	WERBE_TYP_ID,
	KJWO,
	DAT,
	STD_DAT_FG,
	ABW_DAT_FG,
	ADJ_DAT_FG
) as
-- 20220719 SPEC0158746 richternic - Einschraenkung auf die Vorwoche und eine_2 Nachwoche 
-- 20230818 NSR3857733 steablern - Standardwerbetype MD von 6 auf 5 aendern 
SELECT
	v03.mandant_id,
	v03.werbe_typ_id AS werbe_typ_id,
	v01.kjwo,
	v02.dat,
CASE
		WHEN (v032.dat IS NOT NULL) THEN 1
		ELSE 0
	END AS std_dat_fg,
CASE
		WHEN (v04.mandant_id IS NOT NULL) THEN 1
		ELSE 0
	END AS abw_dat_fg,
CASE
		WHEN (v05.dat IS NOT NULL) THEN 1
		ELSE 0
	END AS adj_dat_fg
FROM
	DBP_VIEW.v_woche_2 v01
	JOIN DBP_VIEW.v_tag_2 v02 ON v02.dat BETWEEN v01.wo_dat_von - 7
	AND v01.wo_dat_bis + 7
	JOIN DBP_VIEW.v_werbe_typ_spr_zu_2 v03 ON (
		(
			v03.mandant_id IN (2, 6, 7)
			AND v03.werbe_typ_id = 6
		)
		OR (
			v03.mandant_id IN (1)
			AND v03.werbe_typ_id = 2
		)
		OR (
			v03.mandant_id IN (3, 4, 5)
			AND v03.werbe_typ_id = 5
		)
		OR (
			v03.mandant_id IN (8)
			AND v03.werbe_typ_id = 7
		)
	)
    -- Standard Promotion 
	LEFT JOIN DBP_VIEW.v_werbewoche_kl_2 v032 ON v032.mandant_id = v03.mandant_id
	AND v032.kjwo_ww = v01.kjwo
	AND v032.dat = v02.dat
    -- Abweichende Standard Promotion 
	LEFT JOIN 
        (SELECT abw.mandant_id, abw.dat_von, abw.dat_bis, abw.werbe_typ_id, t1.kjwo
            FROM DBP_VIEW.v_ts_avq_werbezeitraum_abw_2 abw
            JOIN dbp_view.v_tag_2 t1_2 ON abw.dat_von=t1.dat        
        )
         v04 
    ON v04.mandant_id = v03.mandant_id
        AND v02.dat BETWEEN v04.dat_von AND v04.dat_bis
        AND v01.kjwo = v04.kjwo
        AND v04.werbe_typ_id = v03.werbe_typ_id
    
	LEFT JOIN DBP_VIEW.v_ts_wbs_vz_tag_2 v05 ON v05.mandant_id = v03.mandant_id
	AND v05.dat = v02.dat;