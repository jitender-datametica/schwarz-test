create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_PROGNOSE_UDF_FUR_ARTBEW_WG_SUM_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	DAT_PROGNOSELAUF,
	KJWO,
	KJMO,
	DIAGNOSE_ID_UDF,
	PROGNOSE_BEZ,
	PROGNOSE_HORIZONT_UDF,
	WG_ID,
	DIAGNOSE_ID_FUR,
	PROGNOSE_HORIZONT_FUR,
	VK_MENGE_UDF,
	VK_MENGE_UDF_OPA,
	VK_MENGE_SA_UDF,
	VK_MENGE_AF_UDF,
	MENGE_PROGNOSE_SA_UDF,
	MENGE_PROGNOSE_AF_UDF,
	MENGE_PROGNOSE_UDF,
	ABS_DIFF_UDF,
	ABS_DIFF_SA_UDF,
	ABS_DIFF_AF_UDF,
	MENGE_PROGNOSE_SA_UDF_GESTEUERT,
	MENGE_PROGNOSE_AF_UDF_GESTEUERT,
	MENGE_PROGNOSE_UDF_GESTEUERT,
	ABS_DIFF_UDF_GESTEUERT,
	ABS_DIFF_SA_UDF_GESTEUERT,
	ABS_DIFF_AF_UDF_GESTEUERT,
	MENGE_PROGNOSE_SA_FUR,
	MENGE_PROGNOSE_AF_FUR,
	MENGE_PROGNOSE_FUR,
	MENGE_PROGNOSE_MAX_FUR,
	VK_MENGE_FUR,
	VK_MENGE_FUR_OPA,
	VK_MENGE_SA_FUR,
	VK_MENGE_AF_FUR,
	ABS_DIFF_FUR,
	ABS_DIFF_SA_FUR,
	ABS_DIFF_AF_FUR
) as




SELECT
    udf_pass_agg.mandant_id
    
    
    ,v05.aktuell_wup_id kunde_id
    ,udf_pass_agg.nb_id
    ,udf_pass_agg.dat
    ,udf_pass_agg.dat_prognoselauf
    ,udf_pass_agg.kjwo
    ,udf_pass_agg.kjmo
    ,udf_pass_agg.diagnose_id_udf
    ,COALESCE(udf_pass_agg.prognose_bez_udf,fur_pass_agg.prognose_bez_fur) AS prognose_bez
    ,udf_pass_agg.prognose_horizont_udf
    ,udf_pass_agg.wg_id
    ,fur_pass_agg.diagnose_id_fur 
    ,fur_pass_agg.prognose_horizont_fur
    
    ,udf_pass_agg.vk_menge_udf
	,udf_pass_agg.vk_menge_udf_opa
    ,udf_pass_agg.vk_menge_sa_udf
    ,udf_pass_agg.vk_menge_af_udf
    ,udf_pass_agg.menge_prognose_sa_udf
    ,udf_pass_agg.menge_prognose_af_udf
    ,udf_pass_agg.menge_prognose_udf
    ,udf_pass_agg.abs_diff_udf
    ,udf_pass_agg.abs_diff_sa_udf
    ,udf_pass_agg.abs_diff_af_udf
    ,udf_pass_agg.menge_prognose_sa_udf_gesteuert
    ,udf_pass_agg.menge_prognose_af_udf_gesteuert
    ,udf_pass_agg.menge_prognose_udf_gesteuert
    ,udf_pass_agg.abs_diff_udf_gesteuert
    ,udf_pass_agg.abs_diff_sa_udf_gesteuert
    ,udf_pass_agg.abs_diff_af_udf_gesteuert
    ,fur_pass_agg.menge_prognose_sa_fur
    ,fur_pass_agg.menge_prognose_af_fur
    ,fur_pass_agg.menge_prognose_fur
    ,fur_pass_agg.menge_prognose_max_fur
    ,fur_pass_agg.vk_menge_fur
	,fur_pass_agg.vk_menge_fur_opa
    ,fur_pass_agg.vk_menge_sa_fur
    ,fur_pass_agg.vk_menge_af_fur
    ,fur_pass_agg.abs_diff_fur
    ,fur_pass_agg.abs_diff_sa_fur
    ,fur_pass_agg.abs_diff_af_fur
FROM
(
    SELECT
        udf_pass.mandant_id
        ,udf_pass.wup_id
        ,udf_pass.nb_id
        ,udf_pass.dat
        ,udf_pass.dat_prognoselauf
        ,udf_pass.kjwo
        ,udf_pass.kjmo
        ,udf_pass.diagnose_id_udf
        ,udf_pass.prognose_bez_udf
        ,MAX(udf_pass.prognose_horizont_udf) AS prognose_horizont_udf
        ,awg.wg_id
        ,SUM(udf_pass.vk_menge_udf) AS vk_menge_udf
		,SUM(udf_pass.vk_menge_udf_opa) AS vk_menge_udf_opa
        ,SUM(udf_pass.vk_menge_sa_udf) AS vk_menge_sa_udf
        ,SUM(udf_pass.vk_menge_af_udf) AS vk_menge_af_udf
        ,SUM(udf_pass.menge_prognose_sa_udf) AS menge_prognose_sa_udf
        ,SUM(udf_pass.menge_prognose_af_udf) AS menge_prognose_af_udf
        ,SUM(udf_pass.menge_prognose_udf) AS menge_prognose_udf
        ,SUM(udf_pass.abs_diff_udf) AS abs_diff_udf
        ,SUM(udf_pass.abs_diff_sa_udf) AS abs_diff_sa_udf
        ,SUM(udf_pass.abs_diff_af_udf) AS abs_diff_af_udf
        ,SUM(udf_pass.menge_prognose_sa_udf_gesteuert) AS menge_prognose_sa_udf_gesteuert
        ,SUM(udf_pass.menge_prognose_af_udf_gesteuert) AS menge_prognose_af_udf_gesteuert
        ,SUM(udf_pass.menge_prognose_udf_gesteuert) AS menge_prognose_udf_gesteuert
        ,SUM(udf_pass.abs_diff_udf_gesteuert) AS abs_diff_udf_gesteuert
        ,SUM(udf_pass.abs_diff_sa_udf_gesteuert) AS abs_diff_sa_udf_gesteuert
        ,SUM(udf_pass.abs_diff_af_udf_gesteuert) AS abs_diff_af_udf_gesteuert
    FROM
        (
            SELECT
                p_udf_aktion.mandant_id
                ,p_udf_aktion.wup_id
                ,p_udf_aktion.nb_id
                ,p_udf_aktion.art_id
                ,p_udf_aktion.dat
                ,p_udf_aktion.dat_prognoselauf
                ,t.kjwo
                ,t.kjmo
                ,p_udf_aktion.diagnose_id AS diagnose_id_udf
                ,'LEGACY_ATTR_DO_NOT_USE' AS prognose_bez_udf
                ,p_udf_aktion.prognose_horizont AS prognose_horizont_udf
                ,COALESCE(artbew.vk_menge, 0) AS vk_menge_udf
				,COALESCE(artbew.vk_menge, 0)- COALESCE(CASE WHEN artbew.mandant_id = 1 THEN absch_de.menge_preisabschriften ELSE absch_kmo.menge_preisabschriften END, 0) AS vk_menge_udf_opa
                ,COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_udf
                ,COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_udf
                ,p_udf_aktion.menge_prognose_sa_udf
                ,p_udf_aktion.menge_prognose_af_udf
                ,p_udf_aktion.menge_prognose AS menge_prognose_udf
                ,ABS(p_udf_aktion.menge_prognose - vk_menge_udf) AS abs_diff_udf
                ,ABS(
                    p_udf_aktion.menge_prognose_sa_udf - vk_menge_sa_udf
                ) AS abs_diff_sa_udf
                ,ABS(
                    p_udf_aktion.menge_prognose_af_udf - vk_menge_af_udf
                ) AS abs_diff_af_udf
                ,p_udf_aktion.menge_prognose_sa_udf_gesteuert
                ,p_udf_aktion.menge_prognose_af_udf_gesteuert
                ,p_udf_aktion.menge_prognose_gesteuert AS menge_prognose_udf_gesteuert
                ,ABS(
                    p_udf_aktion.menge_prognose_gesteuert - vk_menge_udf
                ) AS abs_diff_udf_gesteuert
                ,ABS(
                    p_udf_aktion.menge_prognose_sa_udf_gesteuert - vk_menge_sa_udf
                ) AS abs_diff_sa_udf_gesteuert
                ,ABS(
                    p_udf_aktion.menge_prognose_af_udf_gesteuert - vk_menge_af_udf
                ) AS abs_diff_af_udf_gesteuert
            FROM
                (
                    
                    SELECT
                        p_udf.mandant_id
                        ,p_udf.wup_id
                        ,p_udf.nb_id
                        ,p_udf.art_id
                        ,p_udf.dat
                        ,p_udf.dat_prognoselauf
                        ,p_udf.diagnose_id
                        ,MAX(p_udf.prognose_horizont) AS prognose_horizont
                        ,SUM(p_udf.menge_prognose_sa) AS menge_prognose_sa_udf
                        ,SUM(p_udf.menge_prognose_af) AS menge_prognose_af_udf
                        ,SUM(
                            CASE
                                WHEN p_udf.menge_prognose_sa IS NULL
                                AND p_udf.menge_prognose_af IS NULL THEN NULL
                                ELSE COALESCE(p_udf.menge_prognose_sa, 0) + COALESCE(p_udf.menge_prognose_af, 0)
                            END
                        ) AS menge_prognose
                        ,SUM(
                            CASE
                                WHEN aktion_list.aktionslistung_fg = 1 THEN p_udf.menge_prognose_gesteuert
                                ELSE NULL
                            END
                        ) AS menge_prognose_sa_udf_gesteuert
                        ,SUM(
                            CASE
                                WHEN aktion_list.aktionslistung_fg IS NULL THEN p_udf.menge_prognose_gesteuert
                                ELSE NULL
                            END
                        ) AS menge_prognose_af_udf_gesteuert
                        ,SUM(p_udf.menge_prognose_gesteuert) AS menge_prognose_gesteuert
                    FROM
                        DBP_VIEW.v_udf_prognose_1 p_udf
                    LEFT JOIN (
                        
                        SELECT DISTINCT
                            aaw.mandant_id
                            ,aaw.wup_id
                            ,aaw.art_id
                            ,t.dat
                            ,1 AS aktionslistung_fg
                        FROM
                            DBP_VIEW.v_aktion_art_wup_zu_1 aaw
                            JOIN DBP_VIEW.v_aktion_1 a ON a.aktion_id = aaw.aktion_id
                            AND a.mandant_id = aaw.mandant_id
                            JOIN DBP_VIEW.v_tag_1 t ON t.dat BETWEEN a.dat_von
                            AND a.dat_bis
                        WHERE
                            (
                                (
                                    aaw.mandant_id <> 1
                                    AND aaw.dat_preisaktiviert <> '1900-01-01'
                                    AND aaw.vk_aktion_brutto > 0
                                )
                                OR (
                                    aaw.mandant_id = 1
                                    AND aaw.dat_sperrung IS NULL
                                )
                            )
                    ) aktion_list ON aktion_list.mandant_id = p_udf.mandant_id
                        AND aktion_list.wup_id = p_udf.wup_id
                        AND aktion_list.art_id = p_udf.art_id
                        AND aktion_list.dat = p_udf.dat
                WHERE
                    p_udf.diagnose_id = ''
                GROUP BY
                    p_udf.mandant_id
                    ,p_udf.wup_id
                    ,p_udf.nb_id
                    ,p_udf.art_id
                    ,p_udf.dat
                    ,p_udf.dat_prognoselauf
                    ,p_udf.diagnose_id
                ) p_udf_aktion
            LEFT JOIN (
                
                SELECT
                    v01.dat
                    ,v01.art_id
                    ,v01.mandant_id
                    ,v01.nb_id
                    ,v01.wup_id
                    ,SUM(v01.menge) AS vk_menge
                    ,SUM(
                        CASE
                            WHEN v01.bewart_id = 1002 THEN v01.menge
                            ELSE NULL
                        END
                    ) AS vk_menge_sa
                    ,SUM(
                        CASE
                            WHEN v01.bewart_id = 1001 THEN v01.menge
                            ELSE NULL
                        END
                    ) AS vk_menge_af
                FROM
                    DBP_VIEW.v_artbew_1 v01
                GROUP BY
                    v01.dat
                    ,v01.art_id
                    ,v01.mandant_id
                    ,v01.nb_id
                    ,v01.wup_id
            ) artbew_1 ON p_udf_aktion.mandant_id = artbew.mandant_id
                AND p_udf_aktion.wup_id = artbew.wup_id
                AND p_udf_aktion.dat = artbew.dat
                AND p_udf_aktion.art_id = artbew.art_id
            JOIN DBP_VIEW.v_tag_1 t ON p_udf_aktion.dat = t.dat
			

LEFT JOIN (SELECT
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat
,SUM(CASE WHEN abschrift_menge_einh_id = 'G' THEN menge_abschrift/1000 ELSE menge_abschrift END) menge_preisabschriften 
FROM dbp_view.v_marktabschriften_1 v01 
WHERE v01.MANDANT_ID=1 AND v01.abschriftart_id IN (5,7)
GROUP BY
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat

)absch_de
ON  p_udf_aktion.mandant_id = absch_de.mandant_id
AND p_udf_aktion.wup_id = absch_de.wup_id
AND p_udf_aktion.art_id = absch_de.art_id
AND p_udf_aktion.dat = absch_de.dat



LEFT JOIN (SELECT absch.mandant_id, absch.wup_id, absch.art_id, DAT_UMBEW AS dat, SUM( MENGE_ERF) menge_preisabschriften
FROM dbp_view.v_art_umbewertung_1 absch
   WHERE ( absch.mandant_id= 6 AND PREIS_AEND_GRUND_ID = 2 ) OR
( absch.mandant_id IN (2,4,5,7,8) AND PREIS_AEND_GRUND_ID = 7 ) OR
( absch.mandant_id= 3 AND PREIS_AEND_GRUND_ID = 11 ) 
GROUP BY 1,2,3,4
)absch_kmo
ON  p_udf_aktion.mandant_id = absch_kmo.mandant_id
AND p_udf_aktion.wup_id = absch_kmo.wup_id
AND p_udf_aktion.art_id = absch_kmo.art_id
AND p_udf_aktion.dat = absch_kmo.dat

        ) udf_pass
    JOIN DBP_VIEW.v_art_wg_zu_per_1 awg ON udf_pass.mandant_id = awg.mandant_id
        AND udf_pass.art_id = awg.art_id
    WHERE
        awg.arthiertyp_id = 2
        AND awg.dat_bis = '9999-12-31'
    GROUP BY
        udf_pass.mandant_id
        ,udf_pass.wup_id
        ,udf_pass.nb_id
        ,udf_pass.dat
        ,udf_pass.dat_prognoselauf
        ,udf_pass.kjwo
        ,udf_pass.kjmo
        ,udf_pass.diagnose_id_udf
        ,udf_pass.prognose_bez_udf
        ,awg.wg_id
) udf_pass_agg_1 FULL
OUTER JOIN 
(
    SELECT
        fur_pass.mandant_id
        ,fur_pass.wup_id
        ,fur_pass.nb_id
        ,fur_pass.dat
        ,fur_pass.dat_prognoselauf
        ,fur_pass.kjwo
        ,fur_pass.kjmo
        ,fur_pass.diagnose_id_fur
        ,fur_pass.prognose_bez_fur
        ,MAX(fur_pass.prognose_horizont_fur) AS prognose_horizont_fur
        
        ,awg.wg_id
        ,SUM(fur_pass.menge_prognose_sa_fur) AS menge_prognose_sa_fur
        ,SUM(fur_pass.menge_prognose_af_fur) AS menge_prognose_af_fur
        ,SUM(fur_pass.menge_prognose_fur) AS menge_prognose_fur
        ,SUM(fur_pass.menge_prognose_max_fur) AS menge_prognose_max_fur
        ,SUM(fur_pass.vk_menge_fur) AS vk_menge_fur
		,SUM(fur_pass.vk_menge_fur_opa) AS vk_menge_fur_opa
        ,SUM(fur_pass.vk_menge_sa_fur) AS vk_menge_sa_fur
        ,SUM(fur_pass.vk_menge_af_fur) AS vk_menge_af_fur
        ,SUM(fur_pass.abs_diff_fur) AS abs_diff_fur
        ,SUM(fur_pass.abs_diff_sa_fur) AS abs_diff_sa_fur
        ,SUM(fur_pass.abs_diff_af_fur) AS abs_diff_af_fur
    FROM
        (
            SELECT
                p_fur.mandant_id
                ,p_fur.wup_id
                ,p_fur.nb_id
                ,p_fur.art_id
                ,p_fur.dat
                ,CASE
                    WHEN p_fur.dat <= CURRENT_DATE THEN p_fur.dat - 1
                    ELSE CURRENT_DATE
                END AS dat_prognoselauf
                ,t.kjwo
                ,t.kjmo
                ,'    ' AS diagnose_id_fur
                ,'LEGACY_ATTR_DO_NOT_USE' AS prognose_bez_fur
                ,p_fur.prognose_horizont AS prognose_horizont_fur
                
               
               
               
                ,p_fur.menge_prognose_aktion AS menge_prognose_sa_fur
                ,CASE
                    WHEN p_fur.menge_prognose_aktion > 0 THEN 0
                    ELSE p_fur.menge_prognose
                END AS menge_prognose_af_fur
                ,CASE
                    WHEN p_fur.menge_prognose_aktion > 0 THEN p_fur.menge_prognose_aktion
                    ELSE p_fur.menge_prognose
                END AS menge_prognose_fur
                ,p_fur.menge_prognose_max AS menge_prognose_max_fur
                ,COALESCE(artbew.vk_menge, 0) AS vk_menge_fur
				,COALESCE(artbew.vk_menge, 0)- COALESCE(CASE WHEN artbew.mandant_id = 1 THEN absch_de.menge_preisabschriften ELSE absch_kmo.menge_preisabschriften END, 0) AS vk_menge_fur_opa
                ,COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_fur
                ,COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_fur
                ,ABS(menge_prognose_fur - vk_menge_fur) AS abs_diff_fur
                ,ABS(menge_prognose_sa_fur - vk_menge_sa_fur) AS abs_diff_sa_fur
                ,ABS(menge_prognose_af_fur - vk_menge_af_fur) AS abs_diff_af_fur
            FROM
                DBP_VIEW.v_fur_prognose_1 p_fur
            LEFT JOIN (
                
                SELECT
                    v01.dat
                    ,v01.art_id
                    ,v01.mandant_id
                    ,v01.nb_id
                    ,v01.wup_id
                    ,SUM(v01.menge) AS vk_menge
                    ,SUM(
                        CASE
                            WHEN v01.bewart_id = 1002 THEN v01.menge
                            ELSE NULL
                        END
                    ) vk_menge_sa
                    ,SUM(
                        CASE
                            WHEN v01.bewart_id = 1001 THEN v01.menge
                            ELSE NULL
                        END
                    ) vk_menge_af
                FROM
                    DBP_VIEW.v_artbew_1 v01
                GROUP BY
                    v01.dat
                    ,v01.art_id
                    ,v01.mandant_id
                    ,v01.nb_id
                    ,v01.wup_id
            ) artbew_1 ON p_fur.mandant_id = artbew.mandant_id
                AND p_fur.wup_id = artbew.wup_id
                AND p_fur.dat = artbew.dat
                AND p_fur.art_id = artbew.art_id
            JOIN DBP_VIEW.v_tag_1 t ON p_fur.dat = t.dat
			

LEFT JOIN (SELECT
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat
,SUM(CASE WHEN abschrift_menge_einh_id = 'G' THEN menge_abschrift/1000 ELSE menge_abschrift END) menge_preisabschriften 
FROM dbp_view.v_marktabschriften_1 v01 
WHERE v01.MANDANT_ID=1 AND v01.abschriftart_id IN (5,7)
GROUP BY
 v01.mandant_id
,v01.wup_id
,v01.art_id
,v01.dat

)absch_de
ON  p_fur.mandant_id = absch_de.mandant_id
AND p_fur.wup_id = absch_de.wup_id
AND p_fur.art_id = absch_de.art_id
AND p_fur.dat = absch_de.dat



LEFT JOIN (SELECT absch.mandant_id, absch.wup_id, absch.art_id, DAT_UMBEW AS dat, SUM( MENGE_ERF) menge_preisabschriften
FROM dbp_view.v_art_umbewertung_1 absch
   WHERE ( absch.mandant_id= 6 AND PREIS_AEND_GRUND_ID = 2 ) OR
( absch.mandant_id IN (2,4,5,7,8) AND PREIS_AEND_GRUND_ID = 7 ) OR
( absch.mandant_id= 3 AND PREIS_AEND_GRUND_ID = 11 ) 
GROUP BY 1,2,3,4
)absch_kmo
ON  p_fur.mandant_id = absch_kmo.mandant_id
AND p_fur.wup_id = absch_kmo.wup_id
AND p_fur.art_id = absch_kmo.art_id
AND p_fur.dat = absch_kmo.dat

        ) fur_pass
    JOIN DBP_VIEW.v_art_wg_zu_per_1 awg ON fur_pass.mandant_id = awg.mandant_id
        AND fur_pass.art_id = awg.art_id
    WHERE
        awg.arthiertyp_id = 2
        AND awg.dat_bis = '9999-12-31'
    GROUP BY
        fur_pass.mandant_id
        ,fur_pass.wup_id
        ,fur_pass.nb_id
        ,fur_pass.dat
        ,fur_pass.dat_prognoselauf
        ,fur_pass.kjwo
        ,fur_pass.kjmo
        ,fur_pass.diagnose_id_fur
        ,fur_pass.prognose_bez_fur 
        
        ,awg.wg_id
) fur_pass_agg_1 ON udf_pass_agg.mandant_id = fur_pass_agg.mandant_id
    AND udf_pass_agg.wup_id = fur_pass_agg.wup_id
    AND udf_pass_agg.nb_id = fur_pass_agg.nb_id
    AND udf_pass_agg.dat = fur_pass_agg.dat
    AND udf_pass_agg.wg_id = fur_pass_agg.wg_id 

INNER JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = fur_pass_agg.mandant_id 
   
   AND v05.wup_id = fur_pass_agg.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0));