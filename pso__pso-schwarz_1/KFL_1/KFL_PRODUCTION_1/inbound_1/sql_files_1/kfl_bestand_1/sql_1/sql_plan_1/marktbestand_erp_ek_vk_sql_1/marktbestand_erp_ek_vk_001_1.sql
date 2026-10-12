--[OK]-----------------------------------------------------------------
UPDATE DBP_ETL.marktbestand_erp_tmp_1

SET      bezugsweg_id   = _bezugsweg_id
        ,vk_netto       = CAST(_vk_netto AS DECIMAL(18,3))
        ,listung_id     = _listung_id
        ,kdis           = coalesce(_kdis,-1)
        ,wrg_id         = _wrg_id

FROM (SELECT
        t01.mandant_id _mandant_id
        ,t01.wup_id _wup_id
        ,t01.art_id _art_id
        ,t02.bezugsweg_id _bezugsweg_id
        ,t02.listung_id _listung_id
        ,t02.kdis _kdis
        ,CASE WHEN t04.mwst  IS NOT NULL THEN CAST(t02.vk_brutto / (1+(t04.mwst/100)) AS DECIMAL(18,6)) ELSE t02.vk_brutto END AS _vk_netto
        ,t02.wrg_id as _wrg_id 
      FROM DBP_ETL.marktbestand_erp_tmp_1 t01
      INNER JOIN DBP_DATA.art_wup_zu_per_1 t02
      ON t01.mandant_id = t02.mandant_id
      AND t01.art_id = t02.art_id
      AND t01.wup_id = t02.wup_id
      LEFT JOIN DBP_DATA.art_1 t03
      ON t01.mandant_id = t03.mandant_id
      AND t01.art_id  = t03.art_id
      LEFT JOIN DBP_DATA.mwst_per_1 t04
      ON t03.mandant_id = t04.mandant_id
      AND t03.mwst_id   = t04.mwst_id
      AND CURRENT_DATE- ${LOOP_ID} BETWEEN t04.dat_von AND t04.dat_bis
      WHERE CURRENT_DATE- ${LOOP_ID} BETWEEN t02.dat_von AND t02.dat_bis
) t1_1
 WHERE mandant_id=_mandant_id
AND       wup_id = _wup_id
AND       art_id=_art_id
;

--[OK]-----------------------------------------------------------------
UPDATE DBP_ETL.marktbestand_erp_tmp_1

SET ek_netto = _ek_netto
    ,ek_netto_bnk = _ek_netto_bnk
    ,vz_wup_id = _vz_wup_id
    ,wrg_id = _wrg_id
FROM
(
SELECT t01.mandant_id _mandant_id
      ,t01.wup_id _wup_id
      ,t01.art_id _art_id
      ,max(coalesce(e.ek_netto,ee.ek_netto,0)) as _ek_netto
      ,max(coalesce(e.ek_netto_bnk,ee.ek_netto_bnk,0)) as _ek_netto_bnk
      ,max(coalesce(z.vz_wup_id,6907)) AS _vz_wup_id
      ,'EUR' as _wrg_id
FROM DBP_ETL.marktbestand_erp_tmp_1 t01

LEFT JOIN DBP_DATA.art_gp_nm_zu_per_1 z
  ON t01.mandant_id = z.mandant_id AND 
     z.mandant_id = 1 AND 
     t01.wup_id = z.wup_id AND 
     t01.art_id = z.art_id AND 
     CURRENT_DATE- ${LOOP_ID} BETWEEN z.dat_von AND z.dat_bis

LEFT JOIN DBP_DATA.art_gp_wup_zu_per_1 e
  ON z.mandant_id = e.mandant_id AND 
     z.vz_wup_id  = e.wup_id AND 
     z.art_id = e.art_id AND 
     z.gp_id = e.gp_id AND 
     z.bq_findung_id <> 25 AND 
     CURRENT_DATE- ${LOOP_ID} BETWEEN e.dat_von AND e.dat_bis AND 
     e.mandant_id = 1

LEFT JOIN DBP_DATA.art_gp_wup_zu_per_1 ee
  ON z.mandant_id = ee.mandant_id AND 
     -1 = ee.wup_id AND 
     z.art_id = ee.art_id AND 
     z.gp_id = ee.gp_id AND
     CURRENT_DATE- ${LOOP_ID} BETWEEN ee.dat_von AND ee.dat_bis AND 
     ee.mandant_id = 1

WHERE t01.mandant_id=1
group by 1,2,3
)dt1 WHERE mandant_id=_mandant_id
AND   wup_id = _wup_id
AND   art_id=_art_id
AND   mandant_id=1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
-- not updating wrg_id as update from itself
UPDATE DBP_ETL.marktbestand_erp_tmp_1

SET ek_nettonetto = _ek_nettonetto
    ,einstandspreis = _einstandspreis
    ,gp_id = _gp_id
FROM
(
SELECT distinct
 t01.mandant_id _mandant_id
,t01.wup_id _wup_id
,t01.art_id _art_id
,CASE WHEN ma_mep.ek_faktor IS NOT NULL THEN ( CAST ( t01.vk_netto * ma_mep.ek_faktor AS DECIMAL(18,4)) )
             WHEN ma_ein.ek_faktor IS NOT NULL THEN  ( CAST ( t01.vk_netto * ma_ein.ek_faktor AS DECIMAL(18,4)) )
             WHEN ms_mep.ek_faktor IS NOT NULL THEN  ( CAST ( t01.vk_netto * ms_mep.ek_faktor AS DECIMAL(18,4)) )
       WHEN ms_ein.ek_faktor IS NOT NULL THEN  ( CAST ( t01.vk_netto * ms_ein.ek_faktor AS DECIMAL(18,4)) )
        WHEN e.ek_nettonetto IS NOT NULL THEN e.ek_nettonetto
        WHEN  ee.ek_nettonetto  IS NOT NULL THEN ee.ek_nettonetto
        ELSE  ( CAST ( t01.vk_netto AS DECIMAL(18,4)) )
  END AS _ek_nettonetto
,CASE WHEN ma_ein.ek_faktor IS NOT NULL THEN  ( CAST ( t01.vk_netto * ma_ein.ek_faktor AS DECIMAL(18,4)) )
             WHEN ms_ein.ek_faktor IS NOT NULL THEN  ( CAST ( t01.vk_netto * ms_ein.ek_faktor AS DECIMAL(18,4)) )
        WHEN e.einstandspreis IS NOT NULL THEN e.einstandspreis
        WHEN  ee.einstandspreis  IS NOT NULL THEN ee.einstandspreis
        ELSE  ( CAST ( t01.vk_netto AS DECIMAL(18,4)) )
  END AS _einstandspreis
,COALESCE (z.gp_id, -1)   AS _gp_id 
FROM DBP_ETL.marktbestand_erp_tmp_1 t01
-- Lieferant und Ausstiegspunkt ermitteln
LEFT OUTER JOIN DBP_DATA.art_gp_nm_zu_per_1 z
ON t01.mandant_id = z.mandant_id
AND z.mandant_id NOT IN (1)
AND t01.wup_id = z.wup_id
AND t01.art_id = z.art_id
AND CURRENT_DATE- ${LOOP_ID}  BETWEEN z.dat_von AND z.dat_bis
-- Betriebsspezifischer EK Preis
LEFT OUTER JOIN DBP_DATA.art_gp_wup_zu_per_1 e
ON z.mandant_id = e.mandant_id
AND z.vz_wup_id  = e.wup_id
AND z.art_id = e.art_id
AND z.gp_id = e.gp_id
AND MOD(z.bq_findung_id , 2) = 1 /*ungerade BQ Findung ID Zugriff mit Wup_1*/
AND z.bq_findung_id <> 25
AND CURRENT_DATE- ${LOOP_ID}  BETWEEN e.dat_von AND e.dat_bis
AND e.mandant_id NOT IN (1)
-- Betriebsuebergreifender EK Preis
LEFT OUTER JOIN DBP_DATA.art_gp_wup_zu_per_1 ee
ON z.mandant_id = ee.mandant_id
AND -1 = ee.wup_id
AND z.art_id = ee.art_id
AND z.gp_id = ee.gp_id
AND MOD(z.bq_findung_id, 2) = 0 /*gerade BQ Findung ID Zugriff ohne Wup_1*/
AND CURRENT_DATE- ${LOOP_ID}  BETWEEN ee.dat_von AND ee.dat_bis
AND ee.mandant_id NOT IN (1)
-- Zuerst betriebsuebergreifenden manuellen Spannenfaktoren (einstandspreis)
LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_1 ms_ein
ON  z.mandant_id = ms_ein.mandant_id
AND z.art_id = ms_ein.art_id
AND z.bq_findung_id = 27
AND ms_ein.mandant_id NOT IN (1)
AND CURRENT_DATE- ${LOOP_ID}  BETWEEN ms_ein.dat_von AND  ms_ein.dat_bis
AND ms_ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
AND ms_ein.loesch_fg = 0
-- Zuerst betriebsuebergreifenden manuellen Spannenfaktoren (mep)
LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_1 ms_mep
ON  z.mandant_id = ms_mep.mandant_id
AND z.art_id = ms_mep.art_id
AND z.bq_findung_id = 27
AND ms_mep.mandant_id NOT IN (1)
AND CURRENT_DATE- ${LOOP_ID}  BETWEEN ms_mep.dat_von AND  ms_mep.dat_bis
AND ms_mep.konditionsart_id = 'ZWGM' /*mep*/
AND ms_mep.loesch_fg = 0
-- Ermittlung Betriebsspezifischer manuelle Spannefaktoren (einstandspreis)
LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_1 ma_ein
ON  z.mandant_id = ma_ein.mandant_id
AND z.art_id = ma_ein.art_id
AND z.wup_id = ma_ein.wup_id
AND z.bq_findung_id = 26
AND ma_ein.mandant_id NOT IN (1)
AND CURRENT_DATE- ${LOOP_ID}  BETWEEN ma_ein.dat_von AND  ma_ein.dat_bis
AND ma_ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
AND ma_ein.loesch_fg = 0
-- Ermittlung Betriebsspezifischer manuelle Spannefaktoren  (mep)
LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_1 ma_mep
ON  z.mandant_id = ma_mep.mandant_id
AND z.art_id = ma_mep.art_id
AND z.wup_id = ma_mep.wup_id
AND z.bq_findung_id = 26
AND ma_mep.mandant_id NOT IN (1)
AND CURRENT_DATE- ${LOOP_ID}  BETWEEN ma_mep.dat_von AND  ma_mep.dat_bis
AND ma_mep.konditionsart_id = 'ZWGM' /*mep*/
AND ma_mep.loesch_fg = 0
WHERE  t01.mandant_id NOT IN (1)
)dt1 WHERE mandant_id=_mandant_id
AND       wup_id = _wup_id
AND       art_id=_art_id
AND mandant_id NOT IN (1);

