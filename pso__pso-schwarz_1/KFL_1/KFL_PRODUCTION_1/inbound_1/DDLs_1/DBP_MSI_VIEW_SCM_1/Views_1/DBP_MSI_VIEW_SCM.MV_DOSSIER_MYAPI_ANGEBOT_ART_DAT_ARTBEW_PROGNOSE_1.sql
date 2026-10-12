create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_DOSSIER_MYAPI_ANGEBOT_ART_DAT_ARTBEW_PROGNOSE_1(
	MANDANT_ID,
	AKTUELL_WUP_ID,
	NB_ID,
	ART_ID,
	ANGEBOT_NR,
	DAT_ANGEBOT_GUELTIG_VON,
	DAT_ANGEBOT_GUELTIG_BIS,
	DAT,
	DAT_PROGNOSELAUF,
	VK_MENGE_UDF,
	VK_MENGE_SA_UDF,
	VK_MENGE_AF_UDF,
	UMSATZ_NETTO,
	ABSATZ_AF_N_LOYALTY_SCHM_BBY,
	ABSATZ_AF_LOYALTY_SCHM_BBY,
	ABSATZ_AF_N_LOYALTY_BBY,
	ABSATZ_AF_LOYALTY_BBY,
	ABSATZ_SA_N_LOYALTY,
	ABSATZ_SA_LOYALTY,
	ABSATZ_SA_N_LOYALTY_BBY,
	ABSATZ_SA_LOYALTY_BBY,
	ABSATZ_SA_LOYALTY_KK_BBY,
	ABSATZ_SA_LOYALTY_KK_C_BBY,
	MENGE_PROGNOSE_SA_UDF,
	MENGE_PROGNOSE_AF_UDF,
	MENGE_PROGNOSE_UDF,
	MENGE_PROGNOSE_SA_UDF_GESTEUERT,
	MENGE_PROGNOSE_AF_UDF_GESTEUERT,
	MENGE_PROGNOSE_UDF_GESTEUERT
) as 
SELECT
 A_ART_WUP.mandant_id
,v05.aktuell_wup_id
,A_ART_WUP.nb_id
,A_ART_WUP.art_id
,A_ART_WUP.ANGEBOT_NR
,A.DAT_ANGEBOT_GUELTIG_VON
,A.DAT_ANGEBOT_GUELTIG_BIS
,t.dat
,p_udf_aktion.dat_prognoselauf
,COALESCE(artbew.vk_menge, 0) AS vk_menge_udf
,COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_udf
,COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_udf
,COALESCE(umsatz_netto, 0) AS umsatz_netto
,COALESCE(absatz_af_n_loyalty_schM_BBY, 0) AS absatz_af_n_loyalty_schM_BBY
,COALESCE(absatz_af_loyalty_schM_BBY, 0) AS absatz_af_loyalty_schM_BBY
,COALESCE(absatz_af_n_loyalty_BBY, 0) AS absatz_af_n_loyalty_BBY
,COALESCE(absatz_af_loyalty_BBY, 0) AS absatz_af_loyalty_BBY
,COALESCE(absatz_sa_n_loyalty, 0) AS absatz_sa_n_loyalty
,COALESCE(absatz_sa_loyalty, 0) AS absatz_sa_loyalty
,COALESCE(absatz_sa_n_loyalty_BBY, 0) AS absatz_sa_n_loyalty_BBY
,COALESCE(absatz_sa_loyalty_BBY, 0) AS absatz_sa_loyalty_BBY
,COALESCE(absatz_sa_loyalty_KK_BBY, 0) AS absatz_sa_loyalty_KK_BBY
,COALESCE(absatz_sa_loyalty_KK_C_BBY, 0) AS absatz_sa_loyalty_KK_C_BBY
,p_udf_aktion.menge_prognose_sa_udf
,p_udf_aktion.menge_prognose_af_udf
,p_udf_aktion.menge_prognose AS menge_prognose_udf
,p_udf_aktion.menge_prognose_sa_udf_gesteuert
,p_udf_aktion.menge_prognose_af_udf_gesteuert
,p_udf_aktion.menge_prognose_gesteuert AS menge_prognose_udf_gesteuert

FROM DBP_DATA.ANGEBOT_ART_WUP_ZU_1 A_ART_WUP 
JOIN DBP_DATA.ANGEBOT_1 A
ON A_ART_WUP.mandant_id = A.mandant_id
AND A_ART_WUP.ANGEBOT_NR = A.ANGEBOT_NR

LEFT JOIN(
SELECT
p_udf.mandant_id
,p_udf.wup_id
,p_udf.nb_id
,p_udf.art_id
,p_udf.dat
,p_udf.dat_prognoselauf
,p_udf.diagnose_id
,SUM(p_udf.menge_prognose_sa) AS menge_prognose_sa_udf
,SUM(p_udf.menge_prognose_af) AS menge_prognose_af_udf
,SUM(CASE WHEN p_udf.menge_prognose_sa IS NULL AND menge_prognose_af IS NULL THEN NULL ELSE COALESCE(menge_prognose_sa, 0) + COALESCE(menge_prognose_af, 0) END) AS menge_prognose
,SUM(CASE WHEN aktionslistung_fg = 1 THEN menge_prognose_gesteuert END) AS menge_prognose_sa_udf_gesteuert
,SUM(CASE WHEN aktionslistung_fg IS NULL THEN menge_prognose_gesteuert END) AS menge_prognose_af_udf_gesteuert
,SUM(p_udf.menge_prognose_gesteuert) AS menge_prognose_gesteuert
FROM dbp_view.v_udf_prognose_1 p_udf  
LEFT JOIN (
        SELECT DISTINCT
            aaw.mandant_id
            ,aaw.wup_id
            ,aaw.art_id
            ,t.dat
            ,1 AS aktionslistung_fg
        FROM
            dbp_view.v_aktion_art_wup_zu_1 aaw
            JOIN dbp_view.v_aktion_1 a ON a.aktion_id = aaw.aktion_id
                AND a.mandant_id = aaw.mandant_id
            JOIN dbp_view.v_tag_1 t ON t.dat BETWEEN a.dat_von
                AND a.dat_bis
        WHERE((a.mandant_id <> 1 AND aaw.dat_preisaktiviert <> '1900-01-01' AND aaw.vk_aktion_brutto > 0)
              OR (a.mandant_id = 1 AND aaw.dat_sperrung IS NULL)))aktion_list 
ON aktion_list.mandant_id = p_udf.mandant_id
AND aktion_list.wup_id = p_udf.wup_id
AND aktion_list.art_id = p_udf.art_id
AND aktion_list.dat = p_udf.dat 

WHERE
    diagnose_id = ''
GROUP BY
    p_udf.mandant_id
    ,p_udf.wup_id
    ,p_udf.nb_id
    ,p_udf.art_id
    ,p_udf.dat
    ,p_udf.dat_prognoselauf 
    ,p_udf.diagnose_id 
) p_udf_aktion

ON A_ART_WUP.mandant_id = p_udf_aktion.mandant_id
AND A_ART_WUP.wup_id = p_udf_aktion.wup_id
AND A_ART_WUP.art_id = p_udf_aktion.art_id
AND p_udf_aktion.dat BETWEEN a.DAT_ANGEBOT_GUELTIG_VON AND a.DAT_ANGEBOT_GUELTIG_BIS
   
LEFT JOIN (
SELECT
ab.dat,
ab.wup_id,
ab.nb_id,
ab.art_id,
ab.mandant_id,
SUM(ab.menge) AS vk_menge,
SUM(ab.umsatz_netto) AS umsatz_netto,
SUM(CASE WHEN ab.bewart_id = 1002 THEN ab.menge END) AS vk_menge_sa,
SUM(CASE WHEN ab.bewart_id = 1001 THEN ab.menge END) AS vk_menge_af,
SUM(CASE WHEN ab.bewart_det_id = 100110 THEN ab.menge ELSE 0 END) AS absatz_af_n_loyalty_schM_BBY,
SUM(CASE WHEN ab.bewart_det_id = 100111 THEN ab.menge ELSE 0 END) AS absatz_af_loyalty_schM_BBY,
SUM(CASE WHEN ab.bewart_det_id = 100130 THEN ab.menge ELSE 0 END) AS absatz_af_n_loyalty_BBY,
SUM(CASE WHEN ab.bewart_det_id = 100131 THEN ab.menge ELSE 0 END) AS absatz_af_loyalty_BBY,
SUM(CASE WHEN ab.bewart_det_id = 100210 THEN ab.menge ELSE 0 END) AS absatz_sa_n_loyalty,
SUM(CASE WHEN ab.bewart_det_id = 100211 THEN ab.menge ELSE 0 END) AS absatz_sa_loyalty,
SUM(CASE WHEN ab.bewart_det_id = 100220 THEN ab.menge ELSE 0 END) AS absatz_sa_n_loyalty_BBY,
SUM(CASE WHEN ab.bewart_det_id = 100221 THEN ab.menge ELSE 0 END) AS absatz_sa_loyalty_BBY,
SUM(CASE WHEN ab.bewart_det_id = 100231 THEN ab.menge ELSE 0 END) AS absatz_sa_loyalty_KK_BBY,
SUM(CASE WHEN ab.bewart_det_id = 100241 THEN ab.menge ELSE 0 END) AS absatz_sa_loyalty_KK_C_BBY
FROM dbp_view.v_artbew_1 ab
GROUP BY
ab.dat,ab.art_id,ab.mandant_id,ab.nb_id,ab.wup_id
) artbew_1 
ON A_ART_WUP.mandant_id = artbew.mandant_id
AND A_ART_WUP.wup_id = artbew.wup_id
AND A_ART_WUP.art_id = artbew.art_id
AND artbew.dat BETWEEN a.DAT_ANGEBOT_GUELTIG_VON AND a.DAT_ANGEBOT_GUELTIG_BIS

INNER JOIN dbp_view.v_wup_1 v05
ON v05.mandant_id = A_ART_WUP.mandant_id
AND v05.wup_id = A_ART_WUP.wup_id
AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

JOIN dbp_view.v_tag_1 t
 ON t.dat BETWEEN a.dat_angebot_gueltig_von AND a.dat_angebot_gueltig_bis
 AND p_udf_aktion.dat = t.dat
AND artbew.dat       = t.dat

WHERE CURRENT_DATE BETWEEN DAT_ANGEBOT_GUELTIG_VON AND DAT_ANGEBOT_GUELTIG_BIS  AND t.akt_kj = 0 
;
