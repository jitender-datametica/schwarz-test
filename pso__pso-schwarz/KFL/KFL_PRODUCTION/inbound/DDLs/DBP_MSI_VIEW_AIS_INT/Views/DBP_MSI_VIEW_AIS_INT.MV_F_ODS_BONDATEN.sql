CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_F_ODS_BONDATEN
(
 mandant_id
,bon_dat
,bon_booking
,wup_id
,nb_id
,wrg_id
,turnover_fg
,kunde_fg
,suspended_fg
,kl_art_id
,art_id
,wg_id
,letzter_bon
,menge_vk
,umsatz_brutto_vk
,menge_ret
,umsatz_brutto_ret
,menge_vk_af
,menge_vk_sa
,menge_ret_af
,menge_ret_sa
,umsatz_brutto_vk_af
,umsatz_brutto_vk_sa
,umsatz_brutto_ret_af
,umsatz_brutto_ret_sa
)
AS

SELECT -- Neuanlage AP0221989/SPEC0256295 sschuecke 26.06.2024
	bon.mandant_id,
	bon.bon_dat,
	bon.bon_booking,
	bon.wup_id,
	0 AS nb_id,
	CASE WHEN v100.wrg_typ_id = 0 THEN v200.nach_wrg_id ELSE v102.default_wrg END AS wrg_id,
	bon.turnover_fg,
	bon.kunde_fg,
	bon.suspended_fg,
	bon.kl_art_id,
	v99.art_id,
	bon.wg_id,
	/*bon._sa_tracker,
    bon._af_tracker,
    bon._sa_tracker_ret,
    bon._af_tracker_ret,*/
	MAX (bon.bon_booking) AS letzter_bon,
	SUM (ZEROIFNULL(bon.menge_vk)) menge_vk,
	-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
	CASE WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 0 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_vk)) * v200.umrechnungskurs
         WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 1 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_vk)) * v300.umrechnungskurs
		 ELSE SUM (ZEROIFNULL(bon.umsatz_brutto_vk))
	     END AS umsatz_brutto_vk,
	SUM (ZEROIFNULL(bon.menge_ret)) menge_ret,
	CASE WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 0 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_ret)) * v200.umrechnungskurs
         WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 1 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_ret)) * v300.umrechnungskurs
		 ELSE SUM (ZEROIFNULL(bon.umsatz_brutto_ret))
	     END AS umsatz_brutto_ret,
	SUM (ZEROIFNULL(bon.menge_vk_af)) menge_vk_af,
	SUM (ZEROIFNULL(bon.menge_vk_sa)) menge_vk_sa,
	SUM (ZEROIFNULL(bon.menge_ret_af)) menge_ret_af,
	SUM (ZEROIFNULL(bon.menge_ret_sa)) menge_ret_sa,
	CASE WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 0 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_vk_af)) * v200.umrechnungskurs
         WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 1 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_vk_af)) * v300.umrechnungskurs
		 ELSE SUM (ZEROIFNULL(bon.umsatz_brutto_vk_af))
	     END AS umsatz_brutto_vk_af,
	CASE WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 0 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_vk_sa)) * v200.umrechnungskurs
         WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 1 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_vk_sa)) * v300.umrechnungskurs
		 ELSE SUM (ZEROIFNULL(bon.umsatz_brutto_vk_sa))
	     END AS umsatz_brutto_vk_sa,
	CASE WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 0 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_ret_af)) * v200.umrechnungskurs
         WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 1 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_ret_af)) * v300.umrechnungskurs
		 ELSE SUM (ZEROIFNULL(bon.umsatz_brutto_ret_af))
	     END AS umsatz_brutto_ret_af,
	CASE WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 0 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_ret_sa)) * v200.umrechnungskurs
         WHEN v100.wrg_typ_id = 0 AND v100.berichtskurs_typ_id = 1 THEN SUM (ZEROIFNULL(bon.umsatz_brutto_ret_sa)) * v300.umrechnungskurs
		 ELSE SUM (ZEROIFNULL(bon.umsatz_brutto_ret_sa))
	     END AS umsatz_brutto_ret_sa
	--Abverkauf
FROM
	(
	SELECT
		ok.bon_id,
		ok.bon_dat,
		ok.wup_id,
		ok.mandant_id,
		ok.wrg_id,
		ok.turnover_fg,
		ok.suspended_fg,
		ok.kunde_fg,
		vk.kl_art_id kl_art_id,
		vk.wg_id wg_id,
		ok.bon_booking,
		CASE WHEN (po_sa.tracker = 'sa_bby' AND vk.tracker = 'sa' AND (po_af.tracker IS NULL OR po_af.tracker = 'unique' 
                OR po_af.tracker LIKE 'bonrabatt%' OR po_af.tracker LIKE 'mhd%' OR po_af.tracker LIKE 'smp%'))
			    OR (po_sa.tracker = 'sa_bby' AND vk.tracker = 'af' AND (po_af.tracker IS NULL OR po_af.tracker = 'unique'
			    OR po_af.tracker LIKE 'bonrabatt%' OR po_af.tracker LIKE 'mhd%' OR po_af.tracker LIKE 'smp%'))
			    OR (po_sa.tracker IS NULL AND vk.tracker = 'sa' AND (po_af.tracker IS NULL OR po_af.tracker = 'unique'
			    OR po_af.tracker LIKE 'bonrabatt%' OR po_af.tracker LIKE 'mhd%' OR po_af.tracker LIKE 'smp%')) THEN 'sa'
				
			    ELSE NULL END AS _sa_tracker,
		CASE WHEN vk.tracker = 'af' AND po_sa.tracker IS NULL AND (po_af.tracker IS NULL OR po_af.tracker = 'unique'
			    OR po_af.tracker LIKE 'bonrabatt%' OR po_af.tracker LIKE 'mhd%' OR po_af.tracker LIKE 'smp%') THEN 'af'
				
			    ELSE NULL END AS _af_tracker,
		NULL AS _af_tracker_ret,
		NULL AS _sa_tracker_ret,
		SUM (vk.menge) menge_vk,
		SUM (vk.umsatz_brutto) umsatz_brutto_vk,
		NULL AS menge_ret,
		NULL AS umsatz_brutto_ret,
		--AF/SA Logik
        CASE WHEN _af_tracker = 'af' THEN SUM (vk.menge) ELSE 0 END AS menge_vk_af,
		  
						  
		CASE WHEN _sa_tracker = 'sa' THEN SUM (vk.menge) ELSE 0 END AS menge_vk_sa,
		  
						  
		NULL AS menge_ret_af,
		NULL AS menge_ret_sa,
		CASE WHEN _af_tracker = 'af' THEN SUM (vk.umsatz_brutto) ELSE 0 END AS umsatz_brutto_vk_af,
		  
								  
		CASE WHEN _sa_tracker = 'sa' THEN SUM (vk.umsatz_brutto) ELSE 0 END AS umsatz_brutto_vk_sa,
		  
								  
		NULL AS umsatz_brutto_ret_af,
		NULL AS umsatz_brutto_ret_sa,
	FROM
		(
		SELECT *
		FROM dbp_v_ods.v_ods_bon_kopf
		WHERE bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE) ok
	FULL OUTER JOIN 
    (
		SELECT
			mandant_id,
			wup_id,
			bon_dat,
			bon_id,
			bon_zeile,
			kl_art_id,
			wg_id,
			CASE WHEN aktion_id IN ('0', '0000000000', '') THEN 'af' ELSE 'sa' END AS tracker,
			  
					   
			menge,
			umsatz_brutto
		FROM dbp_v_ods.v_ods_bon_verkauf
		WHERE bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE
		--AP0242994/SPEC0276113 Filtern von wg_id = 961 / sschuecke 18.10.2024
        AND wg_id <> 961
		GROUP BY ALL) vk
    
        ON 	ok.mandant_id = vk.mandant_id
		AND ok.bon_dat = vk.bon_dat
		AND ok.bon_id = vk.bon_id
		AND ok.wup_id = vk.wup_id
	--beinhaltet SA Promo	
	FULL OUTER JOIN 
    (
		SELECT
			po.mandant_id,
			po.wup_id,
			po.bon_dat,
			po.bon_id,
			po.bon_zeile,
			po.kl_art_id,
			'sa_bby' AS tracker
		FROM dbp_v_ods.v_ods_promotion po
		-- AP0261549/SPEC0303458 Erweiterung JOIN und WHERE NOT / sschuecke 30.04.2025
		FULL OUTER JOIN dbp_v_ods.v_ods_bon_verkauf vk 
        ON  po.mandant_id = vk.mandant_id 
        AND po.wup_id = vk.wup_id 
        AND po.bon_dat = vk.bon_dat 
        AND po.bon_id = vk.bon_id 
        AND po.bon_zeile = vk.bon_zeile
		WHERE 	po.konditionsart_id NOT IN ('ZRT3', 'ZBON', 'ZBOV')
				AND po.promotion_art != 'PERSONAL_SMP'
				AND po.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE
                AND NOT(
                 vk.wg_id = 822 AND vk.aktion_id IN ('0', '0000000000', '') AND po.promotion_art = 'PERSONAL')
            GROUP BY ALL) po_sa
        ON  vk.mandant_id = po_sa.mandant_id
								  
		AND vk.wup_id = po_sa.wup_id
		AND vk.bon_dat = po_sa.bon_dat
		AND vk.bon_id = po_sa.bon_id
		AND vk.bon_zeile = po_sa.bon_zeile
		AND vk.kl_art_id = po_sa.kl_art_id
		--beinhaltet unique AF Promo
	FULL OUTER JOIN
    (
		SELECT
			po.mandant_id mandant_id,
			po.wup_id wup_id,
			po.bon_dat bon_dat,
			po.bon_id bon_id,
			po.bon_zeile bon_zeile,
			po.kl_art_id kl_art_id,
			'unique' AS tracker
		FROM dbp_v_ods.v_ods_promotion po
		WHERE po.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE
			AND 
            (po.mandant_id,
			po.wup_id,
			po.bon_dat,
			po.bon_id,
			po.bon_zeile,
			po.kl_art_id) 
            IN 
            (
			SELECT
				po.mandant_id mandant_id,
				po.wup_id wup_id,
				po.bon_dat bon_dat,
				po.bon_id bon_id,
				po.bon_zeile bon_zeile,
				po.kl_art_id kl_art_id,
			FROM
				(
				SELECT
					po.mandant_id mandant_id,
					po.wup_id wup_id,
					po.bon_dat bon_dat,
					po.bon_id bon_id,
					po.bon_zeile bon_zeile,
					po.kl_art_id kl_art_id,
					COUNT (*) dist
				FROM dbp_v_ods.v_ods_promotion po
				WHERE po.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE
				GROUP BY ALL
				HAVING dist = 1) po
			GROUP BY ALL)
            
			AND (po.konditionsart_id IN ('ZRT3', 'ZBON', 'ZBOV')
				OR po.promotion_art = 'PERSONAL_SMP')
-- AP0261549/SPEC0303458 Erweiterung UNION / sschuecke 30.04.2025
        UNION 

        SELECT
			po.mandant_id mandant_id,
			po.wup_id wup_id,
			po.bon_dat bon_dat,
			po.bon_id bon_id,
			po.bon_zeile bon_zeile,
			po.kl_art_id kl_art_id,
			'unique' AS tracker
        FROM dbp_v_ods.v_ods_bon_verkauf vk
        JOIN dbp_v_ods.v_ods_promotion po
        ON  vk.mandant_id = po.mandant_id 
		AND vk.bon_id = po.bon_id 
		AND vk.wup_id = po.wup_id 
		AND vk.bon_dat = po.bon_dat 
		AND vk.bon_zeile = po.bon_zeile
        WHERE vk.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE
        AND vk.wg_id = 822 
		AND vk.aktion_id IN ('0', '0000000000', '') AND po.promotion_art = 'PERSONAL'
        AND 
            (po.mandant_id,
			po.wup_id,
			po.bon_dat,
			po.bon_id,
			po.bon_zeile,
			po.kl_art_id) 
            IN 
            (
			SELECT
				po.mandant_id mandant_id,
				po.wup_id wup_id,
				po.bon_dat bon_dat,
				po.bon_id bon_id,
				po.bon_zeile bon_zeile,
				po.kl_art_id kl_art_id,
			FROM
				(
				SELECT
					po.mandant_id mandant_id,
					po.wup_id wup_id,
					po.bon_dat bon_dat,
					po.bon_id bon_id,
					po.bon_zeile bon_zeile,
					po.kl_art_id kl_art_id,
					COUNT (*) dist
				FROM dbp_v_ods.v_ods_promotion po
				WHERE po.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE
				GROUP BY ALL
				HAVING dist = 1) po
			GROUP BY ALL)
        

	UNION ALL
		
		SELECT
			a.mandant_id mandant_id,
			a.wup_id wup_id,
			a.bon_dat bon_dat,
			a.bon_id bon_id,
			a.bon_zeile bon_zeile,
			a.kl_art_id kl_art_id,
			LISTAGG (DISTINCT a.tracker,
			',') WITHIN GROUP (
			ORDER BY a.tracker) _tracker
		FROM
			(
			SELECT
				b.mandant_id mandant_id,
				b.wup_id wup_id,
				b.bon_dat bon_dat,
				b.bon_id bon_id,
				b.bon_zeile bon_zeile,
				a.kl_art_id kl_art_id,
				a.konditionsart_id konditionsart_id
,
				CASE WHEN a.konditionsart_id IN('ZBON', 'ZBOV') THEN 'bonrabatt'
					 WHEN a.promotion_art IN ('PERSONAL_SMP') THEN 'smp'
					 WHEN a.konditionsart_id IN ('ZRT3') THEN 'mhd'
				
					 ELSE 'bby' END AS tracker
			FROM dbp_v_ods.v_ods_promotion a
			JOIN(
				SELECT
					po.mandant_id mandant_id,
					po.wup_id wup_id,
					po.bon_dat bon_dat,
					po.bon_id bon_id,
					po.bon_zeile bon_zeile,
					po.kl_art_id kl_art_id,
					COUNT (*) dist
				FROM dbp_v_ods.v_ods_promotion po
				WHERE po.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE
				GROUP BY ALL
				HAVING dist > 1 )b

                ON 	a.mandant_id = b.mandant_id
				AND a.bon_dat = b.bon_Dat
				AND a.wup_id = b.wup_id
				AND a.bon_id = b.bon_id
				AND a.bon_zeile = b.bon_zeile
				AND a.kl_art_id = b.kl_art_id
			GROUP BY ALL
			ORDER BY
				1,
				2,
				3,
				4)a
		GROUP BY ALL
		HAVING _tracker NOT LIKE 'bby%' )po_af

        ON 	vk.mandant_id = po_af.mandant_id
		AND vk.wup_id = po_af.wup_id
		AND vk.bon_dat = po_af.bon_dat
		AND vk.bon_id = po_af.bon_id
		AND vk.bon_zeile = po_af.bon_zeile
		AND vk.kl_art_id = po_af.kl_art_id
	GROUP BY ALL
		
UNION ALL
	SELECT
		ok.bon_id bon_id,
		ok.bon_dat,
		ok.wup_id wup_id,
		ok.mandant_id,
		ok.wrg_id,
		ok.turnover_fg,
		ok.suspended_fg,
		ok.kunde_fg,
		ret.kl_art_id kl_art_id,
		ret.wg_id wg_id,
		ok.bon_booking,
		NULL AS _sa_tracker,
		NULL AS _af_tracker,
		CASE WHEN ret.tracker_ret = 'af_ret' THEN 'af_ret' ELSE NULL END AS _af_tracker_ret,
			 
							  
		CASE WHEN ret.tracker_ret = 'sa_ret' THEN 'sa_ret' ELSE NULL END AS _sa_tracker_ret,
			 
							  
		NULL AS menge_vk,
		NULL AS umsatz_brutto_vk,
		SUM (ret.menge) menge_ret,
		SUM (ret.umsatz_brutto) umsatz_brutto_ret,
		
        NULL AS menge_vk_af,
		NULL AS menge_vk_sa,
		CASE WHEN _af_tracker_ret = 'af_ret' THEN SUM (ret.menge) ELSE 0 END AS menge_ret_af,
		  
						   
		CASE WHEN _sa_tracker_ret = 'sa_ret' THEN SUM (ret.menge) ELSE 0 END AS menge_ret_sa,
		 
						  
		NULL AS umsatz_brutto_vk_af,
		NULL AS umsatz_brutto_sa_sa,
		CASE WHEN _af_tracker_ret = 'af_ret' THEN SUM (ret.umsatz_brutto) ELSE 0 END AS umsatz_brutto_ret_af,
		  
								   
		CASE WHEN _sa_tracker_ret = 'sa_ret' THEN SUM (ret.umsatz_brutto) ELSE 0 END AS umsatz_brutto_ret_sa
		  
								  
	FROM dbp_v_ods.v_ods_bon_kopf ok
	JOIN (
		SELECT
			ret.mandant_id,
			ret.wup_id,
			ret.bon_dat,
			ret.bon_id,
			ret.bon_zeile,
			ret.kl_art_id,
			ret.wg_id,
		-- AP0261549/SPEC0303458 Erweiterung CASE WHEN / sschuecke 30.04.2025
		CASE WHEN 
            (ret.aktion_id NOT IN ('0', '0000000000', '')) 
            OR
            (po.bonuskauf_id NOT IN ('0', '0000000000', '') AND po.konditionsart_id NOT IN ('ZRT3', 'ZBON', 'ZBOV') AND po.promotion_art != 'PERSONAL_SMP')
            OR (ret.wg_id = 822 AND ret.aktion_id NOT IN ('0', '0000000000', '') AND po.promotion_art != 'PERSONAL')
            THEN 'sa_ret' ELSE 'af_ret' END AS tracker_ret,
						   
			ret.menge,
			ret.umsatz_brutto
		FROM  dbp_v_ods.v_ods_bon_retoure ret
        FULL OUTER JOIN dbp_v_ods.v_ods_promotion po
        ON ret.bon_id = po.bon_id 
        AND ret.mandant_id = po.mandant_id 
        AND ret.wup_id = po.wup_id 
        AND ret.bon_dat = po.bon_dat 
        AND ret.bon_zeile = po.bon_zeile
		WHERE ret.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE
  --AP0242994/SPEC0276113 Filtern von wg_id = 961 / sschuecke 18.10.2024
        AND ret.wg_id <> 961
        GROUP BY ALL)ret
        ON  ok.mandant_id = ret.mandant_id
		AND ok.wup_id = ret.wup_id
		AND ok.bon_id = ret.bon_id
		AND ok.bon_dat = ret.bon_dat
	GROUP BY ALL )bon
JOIN dbp_view.v_art v99
    ON bon.kl_art_id = v99.kl_art_id
	AND bon.mandant_id = v99.mandant_id
    AND bon.bon_dat BETWEEN v99.dat_von AND v99.dat_bis
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v100

/*JOIN dbp_view.v_kurs v101
    ON bon.bon_dat BETWEEN v101.dat_von AND v101.dat_bis
	AND bon.wrg_id = v101.von_wrg_id
	AND v101.kurstyp_id = 9
	AND v101.nach_wrg_id = 'EUR'*/

-- JOIN aktueller Berichtskurs
JOIN dbp_view.v_kurs v200
ON v200.dat_bis = '9999-12-31'
AND bon.wrg_id = v200.von_wrg_id
AND v200.kurstyp_id = 3
AND v200.nach_wrg_id ='EUR'

-- JOIN historischer Berichtskurs
JOIN dbp_view.v_kurs v300
ON bon.bon_dat BETWEEN v300.dat_von AND v300.dat_bis
AND bon.wrg_id = v300.von_wrg_id
AND v300.kurstyp_id = 3
AND v300.nach_wrg_id ='EUR'

-- Join auf mandant zwecks Ermittlung default_wrg	
JOIN dbp_view.v_mandant v102
    ON bon.mandant_id = v102.mandant_id
WHERE (bon.bon_id, bon.wup_id, bon.mandant_id) 
NOT IN(
	SELECT
		bon_id,
		wup_id,
		mandant_id
	FROM dbp_v_ods.v_ods_bon_storno)

GROUP BY
	bon.mandant_id,
	bon.bon_dat,
	bon.bon_booking,
	bon.wup_id,
	nb_id,
	bon.wrg_id,
	bon.turnover_fg,
	bon.kunde_fg,
	bon.suspended_fg,
	bon.kl_art_id,
	v99.art_id,
	bon.wg_id,
	v100.wrg_typ_id,
	v100.berichtskurs_typ_id,
	v200.nach_wrg_id,
	v102.default_wrg,
	v200.umrechnungskurs,
    v300.umrechnungskurs
ORDER BY
	bon.mandant_id,
	bon.bon_dat,
	bon_booking,
	bon.wup_id,
	bon.kl_art_id,
	bon.turnover_fg;