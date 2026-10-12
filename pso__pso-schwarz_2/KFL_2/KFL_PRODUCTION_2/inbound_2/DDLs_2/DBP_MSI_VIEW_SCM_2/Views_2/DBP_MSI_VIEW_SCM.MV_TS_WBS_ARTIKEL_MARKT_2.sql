create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_TS_WBS_ARTIKEL_MARKT_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	AUSLIEFERGRUPPE_ID,
	KJWO,
	KJWO_WW,
	ANGEBOT_ID,
	AKTION_ID,
	BONUSKAUF_PROMOTIONSTYP,
	DAT_AB,
	DAT_BIS,
	ANZ_TAGE_WERBUNG,
	ART_ID,
	WUP_ID_VZ,
	GP_ID,
	NB_ID_VZ,
	MANDANT_ID_VZ,
	GK_FG,
	TOP_GK_FG,
	MAX_KAPA_FG,
	FIXMENGE_WFL_BME,
	FAKTOR_REST_VON_NORMALBESTAND,
	FAKTOR_MAX_KAPA_ENDBESTAND,
	MENGE_MINDESTPLATZIERUNG_BME,
	ADJUSTMENT_ID,
	DAT_LETZTE_NACHVERSORGUNG,
	NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ,
	NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ
) as
















WITH DAT_Eingrezung AS (
SELECT MANDANT_ID, ART_ID, DAT_AB, DAT_BIS, MAX(DAT_Beladung) AS max_dat_beladung 
FROM DBP_VIEW.v_wbs_werbeaenderungen_2
GROUP BY MANDANT_ID, ART_ID, DAT_AB, DAT_BIS
),
Angebot_Artikel AS (
SELECT DISTINCT
 aw.mandant_id
,aw.wup_id
,aw.nb_id AS nb_id
,agw.mandant_id AS mandant_id_vz
,CASE WHEN LENGTH(TO_VARCHAR(ABS(agw.gp_id))) <= 4 THEN agw.gp_id ELSE -9 END AS wup_id_vz
,CASE WHEN agw.auslieferungsgruppe_id = 'VEN' THEN a_gp.gp_id ELSE agw.gp_id END AS gp_id 
,-111 AS nb_id_vz

,CASE WHEN a_gp.BEZUGSWEG_ID = 1 THEN 'VEN' ELSE  COALESCE(aus_art.auslieferungsgruppe_id, COALESCE(aus_wg_1.auslieferungsgruppe_id, aus_wg_2.auslieferungsgruppe_id)) END AS ausliefergruppe_id
,t.kjwo AS kjwo
,ww.kjwo_ww 
,aw.ANGEBOT_NR AS angebot_id
,a.AKTION_ID
,a.ANGEBOT_TYP_CD AS BONUSKAUF_PROMOTIONSTYP
,aw.art_id
,a.dat_angebot_gueltig_von AS dat_von
,a.dat_angebot_gueltig_bis AS dat_bis
,DATEDIFF(DAY, a.dat_angebot_gueltig_von, a.dat_angebot_gueltig_bis) +1 AS anz_tage_werbung
,AA.gondelkopf_fg AS gk_fg
,AA.TOPARTIKEL_FG AS top_gk_fg
,AA.MINDESTMENGE_BME AS menge_mindestplatzierung_bme

FROM dbp_view.v_ANGEBOT_ART_WUP_ZU_2 AW
JOIN dbp_view.v_ANGEBOT_2 A
 ON AW.ANGEBOT_NR = A.ANGEBOT_NR 
AND AW.mandant_id = A.mandant_id 
AND A.angebot_geloescht_fg = 0

JOIN dbp_view.v_werbewoche_kl_2 ww
ON A.mandant_id = ww.mandant_id
AND A.dat_angebot_gueltig_von = ww.dat

JOIN dbp_view.v_tag_2 t
ON a.dat_angebot_gueltig_von = t.dat

JOIN dbp_view.v_art_gp_wup_dts_zu_per_2 agw
ON CASE WHEN aw.mandant_id = 4 THEN 7 ELSE aw.mandant_id END = agw.mandant_id
AND aw.art_id = agw.art_id
AND aw.wup_id = agw.wup_id
AND aw.nb_id = COALESCE(agw.nb_id, 0)
AND agw.dat_bis='9999-12-31'

LEFT JOIN dbp_view.v_art_vorschlagswert_per_2 av_p
ON aw.art_id= av_p.art_id
AND aw.mandant_id = av_p.mandant_id
AND av_p.dat_bis='9999-12-31'

LEFT JOIN dbp_view.v_art_gp_nm_zu_per_2 a_gp
ON aw.art_id = a_gp.art_id
AND aw.mandant_id = a_gp.mandant_id
AND aw.wup_id = a_gp.wup_id
AND aw.nb_id = a_gp.nb_id
AND a_gp.dat_bis='9999-12-31'

LEFT JOIN dbp_view.v_art_wg_zu_per_2 a_wg
ON aw.art_id = a_wg.art_id
AND aw.mandant_id = a_wg.mandant_id
AND a_wg.dat_bis='9999-12-31'
AND a_wg.arthiertyp_id = 2

LEFT JOIN dbp_view.v_wg_auslieferungsgruppe_per_2 aus_wg_1
ON a_wg.wg_id = aus_wg_1.wg_id
AND a_wg.mandant_id = aus_wg_1.mandant_id
AND aus_wg_1.dat_bis='9999-12-31'
AND aus_wg_1.sortimentslistenart_id = av_p.sortimentslistenart_id

LEFT JOIN dbp_view.v_wg_auslieferungsgruppe_per_2 aus_wg_2
ON a_wg.wg_id = aus_wg_2.wg_id
AND a_wg.mandant_id = aus_wg_2.mandant_id
AND aus_wg_2.dat_bis='9999-12-31'
AND aus_wg_2.sortimentslistenart_id =''

LEFT JOIN dbp_view.v_art_auslieferungsgruppe_per_2 aus_art
ON aw.art_id = aus_art.art_id
AND aw.mandant_id = aus_art.mandant_id
AND aus_art.dat_bis='9999-12-31'

LEFT JOIN (
    SELECT mandant_id, angebot_nr,
           MAX(CASE WHEN angebot_attribut_id = 42 THEN TRY_CAST(angebot_attribut_txt AS NUMBER) END) AS MINDESTMENGE_BME,
           MAX(CASE WHEN angebot_attribut_id = 49 THEN TRY_CAST(angebot_attribut_txt AS NUMBER) END) AS GONDELKOPF_FG,
           MAX(CASE WHEN angebot_attribut_id = 46 THEN TRY_CAST(angebot_attribut_txt AS NUMBER) END) AS TOPARTIKEL_FG
FROM dbp_view.v_angebot_attribut_zu_2
WHERE angebot_attribut_id BETWEEN 40 AND 53
GROUP BY mandant_id, angebot_nr)AA
ON AW.angebot_nr = AA.angebot_nr
AND AW.mandant_id = AA.mandant_id

WHERE aw.art_id NOT IN (0, -1)  AND loesch_fg=0 AND EXISTS (SELECT 1
FROM DBP_VIEW.V_ART_LIST_WUP_ZU_PER_2 V02
WHERE CURRENT_DATE-1 BETWEEN V02.DAT_VON-7 AND V02.DAT_BIS
AND AW.MANDANT_ID=V02.MANDANT_ID
AND AW.WUP_ID=V02.WUP_ID
AND AW.ART_ID=V02.ART_ID)
AND angebot_status_id IN (4,6) AND
transfer_status_id IN (0,3,5,6) AND
angebot_geloescht_fg IN ( 0) AND
 CASE WHEN AW.mandant_id = 7 AND angebot_typ_cd NOT IN  ('ZAI','ZAIR','ZAIM') THEN 1
      WHEN AW.mandant_id = 1 AND angebot_typ_cd NOT IN  ('ZAI','ZAIR','ZAIM') THEN 1
      WHEN angebot_typ_cd NOT IN ('0009','ZAI','ZAIR','ZAIM','0010','ZB09','ZB10') THEN 1 ELSE 0 END= 1
)

SELECT 
	v00.mandant_id
    ,v00.wup_id
    ,v00.nb_id
    ,v00.ausliefergruppe_id
    ,v00.kjwo
    ,v00.kjwo_ww
    ,COALESCE(CASE WHEN v00.angebot_id = '' THEN NULL ELSE v00.angebot_id END,'n/a')
    ,COALESCE(CASE WHEN v00.aktion_id = '' THEN NULL ELSE v00.aktion_id END ,'n/a')  
    ,v00.bonuskauf_promotionstyp
    ,v00.dat_von
    ,v00.dat_bis
    ,v00.anz_tage_werbung
    ,v00.art_id
    ,v00.wup_id_vz
    ,v00.gp_id
    ,v00.nb_id_vz
    ,v00.mandant_id_vz
    ,v00.gk_fg 
    ,v00.top_gk_fg
    ,MAX(COALESCE(COALESCE(v01.max_kapa_fg,v02.max_kapa_fg),0)) AS max_kapa_fg
    ,MAX(v01.fixmenge_wfl_bme) AS fixmenge_wfl_bme
    ,MAX(v01.rest_von_normalbestand_proz) AS faktor_rest_von_normalbestand
    ,MAX(v01.max_kapa_endbestand_proz) AS faktor_max_kapa_endbestand
    ,MAX(v01.menge_mindestplatzierung_bme) AS menge_mindestplatzierung_bme
    ,MAX(COALESCE(COALESCE(COALESCE(COALESCE(COALESCE(COALESCE(COALESCE(v01.adjustment_id,v02.adjustment_id),v001.adjustment_id),wg.adjustment_id),wg_ST.adjustment_id),wg_std.adjustment_id),wg_std_ST.adjustment_id),0)) AS adjustment_id
    ,MAX(COALESCE(v01.dat_letzte_nachversorgung,v02.dat_letzte_nachversorgung)) AS dat_letzte_nachversorgung
    ,MAX(COALESCE(v01.nachversorgung_schwellwert_pal_abrundung_proz, v02.nachversorgung_schwellwert_pal_abrundung_proz)) AS nachversorgung_schwellwert_pal_abrundung_proz
    ,MAX(COALESCE(v01.nachversorgung_schwellwert_pal_aufrundung_proz, v02.nachversorgung_schwellwert_pal_aufrundung_proz)) AS nachversorgung_schwellwert_pal_aufrundung_proz
FROM Angebot_Artikel v00	 
LEFT JOIN (
SELECT 
v001.mandant_id,
v001.art_id,
v001.dat_ab,
v001.dat_bis,
v001.aktion_id,
v001.ausliefergruppe_id,
CASE WHEN v001.ausliefergruppe_id = 'VEN' THEN v001.gp_id ELSE v001.wup_id_vz END AS gp_id_,
TO_VARCHAR(v001.offer_id),
MAX(v001.estimation_id) AS estimation_id,
MAX(v001.adjustment_id) AS adjustment_id
FROM dbp_view.v_wbs_werbeaenderungen_2 v001
JOIN DAT_Eingrezung v99
ON v001.mandant_id = v99.mandant_id 
AND v001.dat_beladung = v99.max_dat_beladung
AND v001.MANDANT_ID = v99.MANDANT_ID
AND v001.ART_ID = v99.ART_ID
AND v001.DAT_AB = v99.DAT_AB
AND v001.DAT_BIS = v99.DAT_BIS
GROUP BY 1,2,3,4,5,6,7,8
)v001
ON v00.mandant_id = v001.mandant_id AND v00.ausliefergruppe_id = v001.ausliefergruppe_id 
		AND v00.dat_von= v001.dat_ab AND v00.dat_bis = v001.dat_bis
		AND v00.art_id = v001.art_id 
        AND v00.gp_id = gp_id_
        
LEFT JOIN dbp_data.ts_wbs_art_aktion_markt_2 v01
	ON (v00.mandant_id = v01.mandant_id 
	AND v00.dat_von = v01.dat_von
    AND v00.dat_bis = v01.dat_bis 
    AND v00.angebot_id = v01.angebot_nr   
	AND v00.art_id = v01.art_id 
    AND v00.wup_id = v01.wup_id 
    AND v00.nb_id = v01.nb_id
	AND v00.mandant_id = v01.mandant_id)
    
LEFT JOIN dbp_data.ts_wbs_artikel_vz_2 v02
	ON v00.mandant_id_vz = v02.mandant_id_vz 
	AND v00.kjwo = v02.kjwo
    AND v00.angebot_id = v02.angebot_nr   
	AND v00.art_id = v02.art_id 
   

JOIN dbp_view.v_werbewoche_kl_2 ww
ON v00.mandant_id = ww.mandant_id
AND v00.dat_von = ww.dat

JOIN dbp_view.v_art_wg_zu_per_2 wg_zu
ON wg_zu.mandant_id = v00.mandant_id
AND wg_zu.art_id = v00.art_id
AND wg_zu.arthiertyp_id=2
AND wg_zu.dat_bis = '9999-12-31'

LEFT JOIN  DBP_MSI_DATA.TS_WBS_WARENGRUPPE_2 wg                         
ON wg_zu.MANDANT_ID = wg.MANDANT_ID
AND wg_zu.WG_ID = wg.WG_ID
AND v00.kjwo = wg.kjwo
AND v00.BONUSKAUF_PROMOTIONSTYP = wg.BONUSKAUF_PROMOTIONSTYP

LEFT JOIN  DBP_MSI_DATA.TS_WBS_WARENGRUPPE_STANDARD_2 wg_std                         
ON wg_zu.MANDANT_ID = wg_std.MANDANT_ID
AND wg_zu.WG_ID = wg_std.WG_ID
AND v00.BONUSKAUF_PROMOTIONSTYP = wg_std.BONUSKAUF_PROMOTIONSTYP

LEFT JOIN  DBP_MSI_DATA.TS_WBS_WARENGRUPPE_2 wg_ST                         
ON wg_zu.MANDANT_ID = wg_ST.MANDANT_ID
AND wg_zu.WG_ID = wg_ST.WG_ID
AND v00.kjwo = wg_ST.kjwo
AND wg_ST.BONUSKAUF_PROMOTIONSTYP = '-1'

LEFT JOIN  DBP_MSI_DATA.TS_WBS_WARENGRUPPE_STANDARD_2 wg_std_ST                         
ON wg_zu.MANDANT_ID = wg_std_ST.MANDANT_ID
AND wg_zu.WG_ID = wg_std_ST.WG_ID
AND wg_std_ST.BONUSKAUF_PROMOTIONSTYP = '-1'
  
GROUP BY 	
	v00.mandant_id
    ,v00.wup_id
    ,v00.nb_id
    ,v00.ausliefergruppe_id
    ,v00.kjwo
    ,v00.kjwo_ww
    ,v00.angebot_id
    ,v00.aktion_id
    ,v00.dat_von
    ,v00.dat_bis
    ,v00.anz_tage_werbung
    ,v00.bonuskauf_promotionstyp
    ,v00.art_id
    ,v00.wup_id_vz
    ,v00.gp_id
    ,v00.nb_id_vz
    ,v00.mandant_id_vz
    ,v00.gk_fg
    ,v00.top_gk_fg
;
