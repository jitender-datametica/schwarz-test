----# neu mv_f_kondit_det_
CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_KONDIT_DET_NOTIERUNG AS
-- 20220317 SPEC0054764 richternic: Neuanlage
SELECT 
v01.mandant_id
,v01.werk_id
,v01.flw_lief_id 
,v01.flw_art_id 
,v01.loesch_fg
,v02.konditionsart_id
,v02.dat_von
,t.dat AS dat
,v02.kondition_id
,v100.default_wrg

,v03.KONDITION_EINH_ID 
,v03.betrag_kondition
---Fleisch_art
,CASE WHEN v01.flw_art_id IN (74460,238620,2531,2537,2541,2553,2555,2557,2561,2563,2572,2577,2840,2755,2689,2682,2684) THEN 1
WHEN v01.flw_art_id IN (74462,238621,74462,3385,3317,45314,234036,234046,3382,3360,43015,206934,3401,3326,3368,3993,4039) THEN 2
WHEN v01.flw_art_id IN (238627,238633) THEN 3
WHEN v01.flw_art_id IN (237492,237492,233472,233487,235772,235782,233482,235770,235780,233478) THEN 4
WHEN v01.flw_art_id IN (2840,2755,2689,2682,2684) THEN 5
ELSE 6
END AS Fleisch_Kategorie_ID
/*,CASE WHEN v01.flw_art_id IN (74460,238620,2531,2537,2541,2553,2555,2557,2561,2563,2572,2577,2840,2755,2689,2682,2684) THEN 'Schwein'
WHEN v01.flw_art_id IN (74462,238621,74462,3385,3317,45314,234036,234046,3382,3360,43015,206934,3401,3326,3368,3993,4039) THEN 'Rind'
WHEN v01.flw_art_id IN (238627,238633) THEN 'Kuh'
WHEN v01.flw_art_id IN (237492,237492,233472,233487,235772,235782,233482,235770,235780,233478) THEN 'Faerse'
WHEN v01.flw_art_id IN (2840,2755,2689,2682,2684) THEN 'Verarbeitungsware'
ELSE 'nicht zugeordnet'
END AS Fleisch_Kategorie*/
---Prüfen um was es sich handelt 
,CASE WHEN v01.flw_art_id IN (74460,74462,238627,238633,237492) THEN 1
WHEN v01.flw_art_id IN (238620,238621) THEN 2
ELSE 3 END AS KPI_Kategorie_ID
/*,CASE WHEN v01.flw_art_id IN (74460,74462,238627,238633,237492) THEN 'Notierung'
WHEN v01.flw_art_id IN (238620,238621) THEN 'Notierung - Plan'
ELSE 'Preis' END AS KPI_Kategorie*/
                             
-- Notierungen -- hier noch ueber die Nr & separiert - jedoch Probleme bei der Darstellung im Frontend
/*,CASE WHEN v04.flw_art_nr = 5084862 THEN v03.betrag_kondition END AS betrag_notierung_schwein
,CASE WHEN v04.flw_art_nr = 5103605 THEN v03.betrag_kondition END AS betrag_notierung_schwein_plan
,CASE WHEN v04.flw_art_nr = 5084863 THEN v03.betrag_kondition END AS betrag_notierung_rind
,CASE WHEN v04.flw_art_nr = 5103606 THEN v03.betrag_kondition END AS betrag_notierung_rind_plan
,CASE WHEN v04.flw_art_nr = 5103615 THEN v03.betrag_kondition END AS betrag_notierung_kuh
,CASE WHEN v04.flw_art_nr = 5102955 THEN v03.betrag_kondition END AS betrag_notierung_faerse
-- Preise 
,CASE WHEN v04.flw_art_nr in ('5024273','5024315','5024349','5024547','5024570','5024620','5024687',
'5024711','5024828','5024901','5080088','5034884','5027052','5027011','5027029') THEN v03.betrag_kondition END AS betrag_preis_schwein
,CASE WHEN v04.flw_art_nr in ('5084863','5081288','5081103','5083943','5101425','5081286','5081268','5083502',
'5085535','5081305','5081109','5081275','5082591','5082723') THEN v03.betrag_kondition END AS betrag_preis_rind
,CASE WHEN v04.flw_art_nr in ('5080088','5034884','5027052','5027011','5027029') THEN v03.betrag_kondition END AS betrag_preis_verarbeitungsware
,CASE WHEN v04.flw_art_nr in ('5102955','5101136','5101151','5102237','5101146','5102235','5101142') THEN v03.betrag_kondition END AS betrag_preis_faerse*/


FROM dbp_view.v_flw_art_gp_wup_zu v01
JOIN dbp_view.v_flw_art_gp_kondit_wup_zu_per v02
    ON v01.werk_id = v02.werk_id
        AND v01.flw_lief_id = v02.flw_lief_id
        AND v01.flw_art_id = v02.flw_art_id
        AND v01.mandant_id = v02.mandant_id
JOIN dbp_view.v_flw_kondit_det v03
    ON  v02.mandant_id = v03.mandant_id
        AND v02.kondition_id = v03.kondition_id
        AND v02.konditionsart_id = v03.konditionsart_id
/*JOIN dbp_view.v_flw_art v04
    ON v04.flw_art_id = v01.flw_art_id
        AND  v04.mandant_id = v01.mandant_id*/
JOIN dbp_view.v_tag t ON t.dat BETWEEN v02.dat_von
         AND v02.dat_bis

JOIN dbp_view.v_mandant v100 ON v01.mandant_id = v100.mandant_id
;