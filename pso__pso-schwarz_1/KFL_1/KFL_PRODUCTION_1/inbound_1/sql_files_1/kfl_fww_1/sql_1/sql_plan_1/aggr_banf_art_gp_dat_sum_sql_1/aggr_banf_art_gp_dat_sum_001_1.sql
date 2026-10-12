DROP TABLE IF EXISTS DBP_ETL.banf_agg_tmp_1;

CREATE TABLE DBP_ETL.banf_agg_tmp_1  (
      mandant_id BYTEINT NOT NULL,
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_kalk DATE NOT NULL,
      dat_lief_soll DATE NOT NULL,
      in_aktion_fg BYTEINT NOT NULL DEFAULT 0  ,
      vk_brutto DECIMAL(9,2) NOT NULL,
      banf_menge_kolli DECIMAL(18,3) NOT NULL,
      forecast_menge_kolli DECIMAL(18,3),
      menge_best_kolli DECIMAL(18,3) NOT NULL ,
      banf_menge_kg DECIMAL(18,3) NOT NULL,
      forecast_menge_kg DECIMAL(18,3),
      menge_best_kg DECIMAL(18,3) NOT NULL )
;

DROP TABLE IF EXISTS DBP_ETL.best_agg_tmp_1;

CREATE TABLE DBP_ETL.best_agg_tmp_1  (
      mandant_id BYTEINT NOT NULL,
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_kalk DATE NOT NULL,
      dat_lief_soll DATE NOT NULL,
      in_aktion_fg BYTEINT NOT NULL DEFAULT 0  ,
      vk_brutto DECIMAL(9,2) NOT NULL,
      banf_menge_kolli DECIMAL(18,3) NOT NULL,
      forecast_menge_kolli DECIMAL(18,3),
      menge_best_kolli DECIMAL(18,3) NOT NULL ,
      banf_menge_kg DECIMAL(18,3) NOT NULL,
      forecast_menge_kg DECIMAL(18,3),
      menge_best_kg DECIMAL(18,3) NOT NULL )
;

DROP TABLE IF EXISTS DBP_ETL.ofc_agg_tmp_1;

CREATE TABLE DBP_ETL.ofc_agg_tmp_1  (
      mandant_id BYTEINT NOT NULL,
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_kalk DATE NOT NULL,
      dat_lief_soll DATE NOT NULL,
      in_aktion_fg BYTEINT NOT NULL DEFAULT 0  ,
      vk_brutto DECIMAL(9,2) NOT NULL,
      banf_menge_kolli DECIMAL(18,3) NOT NULL,
      forecast_menge_kolli DECIMAL(18,3),
      menge_best_kolli DECIMAL(18,3) NOT NULL ,
      banf_menge_kg DECIMAL(18,3) NOT NULL,
      forecast_menge_kg DECIMAL(18,3),
      menge_best_kg DECIMAL(18,3) NOT NULL )
;

DROP TABLE IF EXISTS DBP_ETL.banf_art_gp_dat_sum_tmp_1;

CREATE TABLE DBP_ETL.banf_art_gp_dat_sum_tmp_1  (
      mandant_id BYTEINT NOT NULL,
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      gp_id INTEGER NOT NULL,
      dat_kalk DATE NOT NULL,
      dat_lief_soll DATE NOT NULL,
      in_aktion_fg BYTEINT NOT NULL DEFAULT 0  ,
      vk_brutto DECIMAL(9,2) NOT NULL,
      banf_menge_kolli DECIMAL(18,3) NOT NULL,
      forecast_menge_kolli DECIMAL(18,3),
      menge_best_kolli DECIMAL(18,3) NOT NULL ,
      banf_menge_kg DECIMAL(18,3) NOT NULL,
      forecast_menge_kg DECIMAL(18,3),
      menge_best_kg DECIMAL(18,3) NOT NULL )
;


INSERT INTO DBP_ETL.banf_agg_tmp_1 
(
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id 
,dat_kalk 
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,banf_menge_kolli
,forecast_menge_kolli
,menge_best_kolli
,banf_menge_kg
,forecast_menge_kg 
,menge_best_kg
)

SELECT 
eo.mandant_id,
eo.wup_id,
eo.nb_id,
eo.art_id,
eo.gp_id,
tag.dat AS  dat_kalk_,
COALESCE(bd.dat_lief_soll, DATE('1900-01-01')) AS  dat_lief_soll_,
0 AS in_aktion_fg,  
0 AS vk_brutto,
ROUND(SUM(CAST( COALESCE(bd.banf_menge,0) / COALESCE(CAST(auei.umrech_zaehler AS FLOAT) / CAST(auei.umrech_nenner AS FLOAT),1) AS DECIMAL(18,3))),0) AS banf_menge_kolli,
0 AS forecast_menge_kolli,
0 AS menge_best_kolli,
SUM(CAST( COALESCE(bd.banf_menge,0) * CAST(COALESCE(aukg.umrech_faktor, 1) AS FLOAT) AS DECIMAL(18,3))) AS banf_menge_kg,
0 AS forecast_menge_kg,
0 AS menge_best_kg
FROM DBP_DATA.tag_1 tag_1
  
INNER JOIN DBP_DATA.ek_orderbuch_1 eo
ON tag.dat BETWEEN eo.dat_von AND eo.dat_bis

-- keine Artikel_1 mit loesch_id = 'L' bzw. loesch_id = 'R'
INNER JOIN DBP_DATA.art_1 a
ON eo.mandant_id = a.mandant_id
AND eo.art_id = a.art_id
AND a.mandant_id = 1
AND (a.loesch_id <> 'L' AND a.loesch_id <> 'R') 

-- 'nur' Artikel_1 bestimmter Lieferanten duerfen ausgewertet werden  
INNER JOIN  DBP_DATA.banf_prognose_gp_filter_1 bpgf
ON eo.mandant_id = bpgf.mandant_id
AND eo.gp_id = bpgf.gp_id

-- MengenEinheit fuer die Mengenumrechnung einholen
INNER JOIN DBP_DATA.ek_infosatz_1 ei
ON eo.mandant_id = ei.mandant_id
AND eo.art_id = ei.art_id
AND eo.gp_id = ei.gp_id
AND tag.dat BETWEEN ei.dat_von AND ei.dat_bis

-- als Basis dienen die MARA_1 & EORD_1 (EK_ORDERBUCH_1) Daten, eine_1 entspr. BANF kann, muß es aber nicht geben
LEFT JOIN DBP_DATA.banf_det_1 bd
ON eo.mandant_id = bd.mandant_id
AND eo.wup_id = bd.wup_id
AND eo.nb_id = bd.nb_id
AND eo.art_id = bd.art_id
AND tag.dat = bd.dat_banf_beleg
AND bd.dat_lief_soll BETWEEN DATE(${DAT_KALK}) AND DATE(${DAT_KALK})+10

-- Umrechnungsfaktor fuer Menge in 'KG' holen
LEFT JOIN DBP_DATA.art_umrechnung_faktor_per_1 aukg
ON eo.art_id      = aukg.art_id
AND eo.mandant_id = aukg.mandant_id
AND 'KG' = trim(aukg.altnv_menge_einh_id)
AND tag.dat BETWEEN aukg.dat_von AND aukg.dat_bis

-- Umrechnungsfaktor fuer Menge in'Kolli' holen
LEFT JOIN DBP_DATA.art_umrechnung_faktor_per_1 auei
ON eo.art_id      = auei.art_id
AND eo.mandant_id = auei.mandant_id
AND ei.menge_einh_id = trim(auei.altnv_menge_einh_id)
AND tag.dat BETWEEN auei.dat_von AND auei.dat_bis

-- es werden lediglich DE Daten betrachtet
WHERE eo.mandant_id=1
AND tag.dat = DATE(${DAT_KALK})
AND (eo.mandant_id,eo.wup_id) NOT IN (SELECT mandant_id,wup_id FROM DBP_DATA.wup_instanz_autodispo_1 WHERE instanz = '001' AND modus = 'VPD')

GROUP BY 
eo.mandant_id,
eo.wup_id,
eo.nb_id,
eo.art_id,
eo.gp_id,
dat_kalk_,
dat_lief_soll_,
in_aktion_fg,
vk_brutto
;

INSERT INTO DBP_ETL.best_agg_tmp_1 
(
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id 
,dat_kalk 
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,banf_menge_kolli
,forecast_menge_kolli
,menge_best_kolli
,banf_menge_kg
,forecast_menge_kg 
,menge_best_kg
)

SELECT 
eo.mandant_id,
eo.wup_id,
eo.nb_id,
eo.art_id,
eo.gp_id,
tag.dat AS  dat_kalk_,
COALESCE( best.dat_lief_wunsch, DATE('1900-01-01')) AS  dat_lief_soll_,
0 AS in_aktion_fg,  
0 AS vk_brutto,
 0 AS banf_menge_kolli,
0 AS forecast_menge_kolli,   
SUM(CAST( COALESCE(best.menge_best_kolli,0) AS DECIMAL(18,3))) AS menge_best_kolli,
0 AS banf_menge_kg,
0 AS forecast_menge_kg,
SUM(CAST(COALESCE(best.menge_best_kolli,0) * ( (COALESCE(CAST(auei.umrech_zaehler AS FLOAT )/CAST(auei.umrech_nenner AS FLOAT ),1))/( COALESCE(CAST(aukg.umrech_zaehler AS FLOAT )/CAST(aukg.umrech_nenner AS FLOAT ),1)))AS DECIMAL(18,3))) AS menge_best_kg
FROM DBP_DATA.tag_1 tag_1
  
INNER JOIN DBP_DATA.ek_orderbuch_1 eo
ON tag.dat BETWEEN eo.dat_von AND eo.dat_bis

-- keine Artikel_1 mit loesch_id = 'L' bzw. loesch_id = 'R'
INNER JOIN DBP_DATA.art_1 a
ON eo.mandant_id = a.mandant_id
AND eo.art_id = a.art_id
AND a.mandant_id = 1
AND (a.loesch_id <> 'L' AND a.loesch_id <> 'R') 

-- 'nur' Artikel_1 bestimmter Lieferanten duerfen ausgewertet werden  
INNER JOIN  DBP_DATA.banf_prognose_gp_filter_1 bpgf
ON eo.mandant_id = bpgf.mandant_id
AND eo.gp_id = bpgf.gp_id

-- MengenEinheit fuer die Mengenumrechnung einholen
INNER JOIN DBP_DATA.ek_infosatz_1 ei
ON eo.mandant_id = ei.mandant_id
AND eo.art_id = ei.art_id
AND eo.gp_id = ei.gp_id
AND tag.dat BETWEEN ei.dat_von AND ei.dat_bis

-- als Basis dienen die MARA_1 & EORD_1 (EK_ORDERBUCH_1) Daten, eine_1 entspr. BESTELLUNG  kann, muß es aber nicht geben
LEFT OUTER JOIN
(
SELECT
bb.mandant_id
,bbd.best_beleg_id
,bbd.best_beleg_pos_id
,bbd.wup_id
,bbd.nb_id
,bbd.art_id
,bb.gp_id
,bbest.dat_lief_wunsch
,bbd.menge_best_kolli
,bbd.menge_best_bme

FROM DBP_DATA.besch_best_det_1 bbd
INNER JOIN DBP_DATA.besch_best_1 bb
ON bb.mandant_id = bbd.mandant_id
AND bb.best_beleg_id = bbd.best_beleg_id
AND bb.dat_best_beleg = bbd.dat_best_beleg
AND bbd.mandant_id = 1
AND bb.loesch_fg <> 1     --geloeschte Koepfe sollen ausgeschlossen werden
AND bbd.loesch_fg <> 1     --geloeschte Positionen sollen ausgeschlossen werden
AND bbd.dat_best_beleg BETWEEN DATE(${DAT_KALK})-180 AND DATE(${DAT_KALK})+15       --wurde konzeptionell nicht definiert, beruht auf Erfahrungswerten-- 

INNER JOIN DBP_DATA.lief_einteilung_1 bbest      --lief_einteilung_1
ON bbest.mandant_id = bbd.mandant_id
AND bbest.best_beleg_id = bbd.best_beleg_id
AND bbest.best_beleg_pos_id = bbd.best_beleg_pos_id
AND bbest.dat_lief_wunsch IN (SELECT dat FROM DBP_DATA.tag_1 WHERE dat BETWEEN DATE(${DAT_KALK})-3 AND DATE(${DAT_KALK}) +15)
)best
ON eo.mandant_id = best.mandant_id
AND eo.wup_id = best.wup_id
AND eo.nb_id = best.nb_id
AND eo.art_id = best.art_id
--AND tag.dat =  best.dat_lief_wunsch
AND best.dat_lief_wunsch BETWEEN DATE(${DAT_KALK}) AND DATE(${DAT_KALK})+10

-- Umrechnungsfaktor fuer Menge in 'KG' holen
LEFT JOIN DBP_DATA.art_umrechnung_faktor_per_1 aukg
ON eo.art_id      = aukg.art_id
AND eo.mandant_id = aukg.mandant_id
AND 'KG' = trim(aukg.altnv_menge_einh_id)
AND tag.dat BETWEEN aukg.dat_von AND aukg.dat_bis

-- Umrechnungsfaktor fuer Menge in'Kolli' holen
LEFT JOIN DBP_DATA.art_umrechnung_faktor_per_1 auei
ON eo.art_id      = auei.art_id
AND eo.mandant_id = auei.mandant_id
AND ei.menge_einh_id = trim(auei.altnv_menge_einh_id)
AND tag.dat BETWEEN auei.dat_von AND auei.dat_bis

-- es werden lediglich DE Daten betrachtet
WHERE eo.mandant_id=1
AND tag.dat = DATE(${DAT_KALK})
AND (eo.mandant_id,eo.wup_id) NOT IN (SELECT mandant_id,wup_id FROM DBP_DATA.wup_instanz_autodispo_1 WHERE instanz = '001' AND modus = 'VPD')
GROUP BY 
eo.mandant_id,
eo.wup_id,
eo.nb_id,
eo.art_id,
eo.gp_id,
dat_kalk_,
dat_lief_soll_,
in_aktion_fg,
vk_brutto
;

INSERT INTO DBP_ETL.ofc_agg_tmp_1 
(
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id 
,dat_kalk 
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,banf_menge_kolli
,forecast_menge_kolli
,menge_best_kolli
,banf_menge_kg
,forecast_menge_kg 
,menge_best_kg
)

SELECT 
eo.mandant_id,
eo.wup_id,
eo.nb_id,
eo.art_id,
eo.gp_id,
tag.dat AS  dat_kalk_,
COALESCE(bf.dat_lief_soll, DATE('1900-01-01')) AS  dat_lief_soll_,
0 AS in_aktion_fg,  
0 AS vk_brutto,
0 AS banf_menge_kolli,
ROUND(SUM(CAST( COALESCE(bf.forecast_menge_kolli,0) AS DECIMAL(18,3))),0) AS forecast_menge_kolli,   
0 AS menge_best_kolli,
0 AS banf_menge_kg,
SUM(CAST(COALESCE(bf.forecast_menge_kolli,0) * ( (COALESCE(CAST(auei.umrech_zaehler AS FLOAT )/CAST(auei.umrech_nenner AS FLOAT ),1))/( COALESCE(CAST(aukg.umrech_zaehler AS FLOAT )/CAST(aukg.umrech_nenner AS FLOAT ),1)) ) AS DECIMAL(18,3)))  AS forecast_menge_kg,
0 AS menge_best_kg
FROM DBP_DATA.tag_1 tag_1
  
INNER JOIN DBP_DATA.ek_orderbuch_1 eo
ON tag.dat BETWEEN eo.dat_von AND eo.dat_bis

-- keine Artikel_1 mit loesch_id = 'L' bzw. loesch_id = 'R'
INNER JOIN DBP_DATA.art_1 a
ON eo.mandant_id = a.mandant_id
AND eo.art_id = a.art_id
AND a.mandant_id = 1
AND (a.loesch_id <> 'L' AND a.loesch_id <> 'R') 

-- 'nur' Artikel_1 bestimmter Lieferanten duerfen ausgewertet werden  
INNER JOIN  DBP_DATA.banf_prognose_gp_filter_1 bpgf
ON eo.mandant_id = bpgf.mandant_id
AND eo.gp_id = bpgf.gp_id

-- MengenEinheit fuer die Mengenumrechnung einholen
INNER JOIN DBP_DATA.ek_infosatz_1 ei
ON eo.mandant_id = ei.mandant_id
AND eo.art_id = ei.art_id
AND eo.gp_id = ei.gp_id
AND tag.dat BETWEEN ei.dat_von AND ei.dat_bis

-- als Basis dienen die MARA_1 & EORD_1 (EK_ORDERBUCH_1) Daten, einen entspr. Forecast kann, muß es aber nicht geben
LEFT OUTER JOIN DBP_DATA.banf_forecast_1 bf  
ON eo.mandant_id = bf.mandant_id
AND eo.wup_id = bf.wup_id
AND eo.nb_id = bf.nb_id
AND eo.art_id = bf.art_id
AND tag.dat = bf.dat_plan
--variabel:
--AND ofc.art_id IN (2841501, 5105200, 1278100, 1134601)
--AND eo.gp_id = 6912
AND bf.dat_lief_soll BETWEEN DATE(${DAT_KALK}) AND DATE(${DAT_KALK})+10

-- Umrechnungsfaktor fuer Menge in 'KG' holen
LEFT JOIN DBP_DATA.art_umrechnung_faktor_per_1 aukg
ON eo.art_id      = aukg.art_id
AND eo.mandant_id = aukg.mandant_id
AND 'KG' = trim(aukg.altnv_menge_einh_id)
AND tag.dat BETWEEN aukg.dat_von AND aukg.dat_bis

-- Umrechnungsfaktor fuer Menge in'Kolli' holen
LEFT JOIN DBP_DATA.art_umrechnung_faktor_per_1 auei
ON eo.art_id      = auei.art_id
AND eo.mandant_id = auei.mandant_id
AND ei.menge_einh_id = trim(auei.altnv_menge_einh_id)
AND tag.dat BETWEEN auei.dat_von AND auei.dat_bis

-- es werden lediglich DE Daten betrachtet
WHERE eo.mandant_id=1
AND tag.dat = DATE(${DAT_KALK})
AND (eo.mandant_id,eo.wup_id) NOT IN (SELECT mandant_id,wup_id FROM DBP_DATA.wup_instanz_autodispo_1 WHERE instanz = '001' AND modus = 'VPD')

GROUP BY 
eo.mandant_id,
eo.wup_id,
eo.nb_id,
eo.art_id,
eo.gp_id,
dat_kalk_,
dat_lief_soll_,
in_aktion_fg,
vk_brutto
;

INSERT INTO DBP_ETL.banf_art_gp_dat_sum_tmp_1
(
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id 
,dat_kalk 
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,banf_menge_kolli
,forecast_menge_kolli
,menge_best_kolli
,banf_menge_kg
,forecast_menge_kg 
,menge_best_kg
)

SELECT
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id 
,dat_kalk 
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,SUM(banf_menge_kolli) AS banf_menge_kolli
,SUM(forecast_menge_kolli) AS forecast_menge_kolli
,SUM(menge_best_kolli) AS menge_best_kolli
,SUM(banf_menge_kg) AS banf_menge_kg
,SUM(forecast_menge_kg ) AS forecast_menge_kg
,SUM(menge_best_kg) AS menge_best_kg
FROM 
(
SELECT
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id 
,dat_kalk 
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,banf_menge_kolli
,forecast_menge_kolli
,menge_best_kolli
,banf_menge_kg
,forecast_menge_kg 
,menge_best_kg
FROM DBP_ETL.banf_agg_tmp_1

UNION ALL

SELECT
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id 
,dat_kalk 
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,banf_menge_kolli
,forecast_menge_kolli
,menge_best_kolli
,banf_menge_kg
,forecast_menge_kg 
,menge_best_kg
FROM DBP_ETL.best_agg_tmp_1

UNION ALL

SELECT
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id 
,dat_kalk 
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,banf_menge_kolli
,forecast_menge_kolli
,menge_best_kolli
,banf_menge_kg
,forecast_menge_kg 
,menge_best_kg
FROM DBP_ETL.ofc_agg_tmp_1
) x
GROUP BY 1,2,3,4,5,6,7,8,9
;

DELETE from DBP_ETL.banf_art_gp_dat_sum_tmp_1
WHERE (banf_menge_kolli = 0
AND forecast_menge_kolli = 0
AND menge_best_kolli = 0
AND banf_menge_kg = 0
AND forecast_menge_kg = 0
AND menge_best_kg  =0)
;


UPDATE DBP_ETL.banf_art_gp_dat_sum_tmp_1
SET  vk_brutto = vk_brutto_
    ,in_aktion_fg = in_aktion_fg_

FROM
(
SELECT
a.mandant_id         AS mandant_id_
,a.wup_id                AS  wup_id_
,a.nb_id                AS nb_id_
,a.dat_lief_soll       AS dat_lief_soll_
,a.art_id                  AS art_id_
,0 as in_aktion_fg_  
,coalesce(awvp.vk_brutto,0) AS vk_brutto_

FROM DBP_ETL.banf_art_gp_dat_sum_tmp_1 a

INNER JOIN DBP_DATA.art_1 art_1
ON   a.art_id      = art.art_id
AND  a.mandant_id  = art.mandant_id

-- Auflösung Normalpreise Markt--
LEFT OUTER JOIN DBP_DATA.art_wup_vk_per_1 awvp   --2019.10.09, AALB Umstieg auf art_wup_vk_per_1 (von art_wup_zu_per_1), damit wir auch die zukuenftigen VKP-Aenderungen erhalten--
ON  a.mandant_id = awvp.mandant_id
AND a.art_id     = awvp.art_id
AND a.wup_id     = awvp.wup_id
AND a.nb_id      = awvp.nb_id
AND a.dat_lief_soll BETWEEN awvp.dat_von AND awvp.dat_bis

where a.mandant_id = 1
and a.nb_id = 0  -- hier werden nur die Filialen (keine VZ's) mit vk_brutto versorgt --

) x
 WHERE  mandant_id = mandant_id_
AND    wup_id     = wup_id_
AND    nb_id      = nb_id_
AND    dat_lief_soll   = dat_lief_soll_
AND    art_id     = art_id_
;

UPDATE DBP_ETL.banf_art_gp_dat_sum_tmp_1
SET  vk_brutto = vk_brutto_

FROM
(
SELECT
a.mandant_id             AS mandant_id_
,a.dat_lief_soll                AS dat_lief_soll_
,a.art_id                 AS art_id_
,COALESCE(ap.vk_brutto,0) AS vk_brutto_

FROM DBP_ETL.banf_art_gp_dat_sum_tmp_1 a

INNER JOIN DBP_DATA.art_1 art_1
ON   a.art_id      = art.art_id
AND  a.mandant_id  = art.mandant_id

LEFT OUTER JOIN DBP_DATA.art_pm_vw_zu_per_1 ap
ON  ap.mandant_id = 1
AND a.art_id      = ap.art_id
AND a.dat_lief_soll BETWEEN ap.dat_von AND ap.dat_bis

AND preistyp_id = 0
AND pm_id       = 1
AND vw_id       = 6

where a.mandant_id = 1
and a.nb_id = -111  -- hier werden nur die VZ's mit vk_brutto versorgt --

QUALIFY row_number() over (partition by a.mandant_id, a.dat_lief_soll, a.art_id order by ABS(ap.vk_brutto) DESC) = 1
) x
 WHERE  mandant_id = mandant_id_
AND    dat_lief_soll    = dat_lief_soll_
AND    art_id     = art_id_
;

DROP TABLE IF EXISTS DBP_ETL.wupcal_zukunft_1;

CREATE TABLE DBP_ETL.wupcal_zukunft_1 AS
(
SELECT 
w.mandant_id, 
w.wup_id,
t.dat, 
COALESCE(we.offen,1) AS offen
FROM DBP_DATA.wup_1 w
CROSS JOIN DBP_DATA.tag_1 t
LEFT OUTER JOIN DBP_DATA.wupcal_ereignis_zu_1 we
ON w.mandant_id=we.mandant_id 
AND w.wup_id=we.wup_id 
AND t.dat=we.dat
WHERE t.dat BETWEEN DATE(${DAT_KALK})-7 AND DATE(${DAT_KALK})+14
AND w.mandant_id=1
) ;

DROP TABLE IF EXISTS DBP_ETL.wupcal_letzter_naechster_1;

CREATE TABLE DBP_ETL.wupcal_letzter_naechster_1 AS
(
SELECT w.mandant_id, 
w.wup_id, 
w.dat, 
w.offen , 
Min(w1.dat) AS naechster_offener_tag, 
Max(w2.dat) AS letzter_offener_tag, 
Coalesce(naechster_offener_tag - w.dat,0) AS diff_tage_naechster
FROM DBP_ETL.wupcal_zukunft_1 w
LEFT OUTER JOIN DBP_ETL.wupcal_zukunft_1 w1 
ON w.mandant_id=w1.mandant_id 
AND w.wup_id = w1.wup_id 
AND  w1.dat > w.dat 
AND w1.dat < w.dat + 7 
AND w1.offen=1
LEFT OUTER JOIN DBP_ETL.wupcal_zukunft_1 w2 
ON w.mandant_id=w2.mandant_id 
AND w.wup_id = w2.wup_id 
AND  w2.dat < w.dat 
AND w2.dat > w.dat - 7 
AND w2.offen=1
GROUP BY 1,2,3,4
) ;


UPDATE DBP_ETL.banf_art_gp_dat_sum_tmp_1
SET  vk_brutto = vk_brutto_
    ,in_aktion_fg = in_aktion_fg_

FROM
(
SELECT
a.mandant_id         AS mandant_id_
,a.wup_id                AS  wup_id_
,a.dat_lief_soll       AS dat_lief_soll_
,a.art_id                  AS art_id_
,a.nb_id                 AS nb_id_
,1 as in_aktion_fg_  
,COALESCE(dt1.vk_aktion_brutto,0) AS vk_brutto_

FROM DBP_ETL.banf_art_gp_dat_sum_tmp_1 a

INNER JOIN DBP_DATA.art_1 art_1
ON   a.art_id      = art.art_id
AND  a.mandant_id  = art.mandant_id

INNER JOIN DBP_ETL.wupcal_letzter_naechster_1 naechst
ON naechst.mandant_id = a.mandant_id
AND naechst.wup_id = a.wup_id 
AND naechst.dat = a.dat_lief_soll 

-- Auflösung Aktionspreise Markt--
INNER JOIN
(
SELECT
aawz.art_id
, aawz.wup_id
, aawz.mandant_id
, a.dat_von
, a.dat_bis
, aawz.vk_aktion_brutto
, aawz.aktion_id

FROM DBP_DATA.aktion_art_wup_zu_1 aawz

JOIN DBP_DATA.aktion_1 a
ON  aawz.aktion_id  = a.aktion_id
AND aawz.mandant_id = a.mandant_id
AND aawz.bewart_id  = a.bewart_id

WHERE aawz.mandant_id = 1 -- nur MandantDeutschland
and aawz.nb_id = 0 -- nur Maerkte
AND a.bewart_id = 1002 -- Kennzeichen Aktion_1
--AND (UPPER(aawz.grund_sperrung) <> 'X'  OR aawz.grund_sperrung IS NULL) -- Kennzeichen Zuordnung Aktion_1, Artikel_1, Wup_1 aktiv
AND aawz.grund_sperrung IS NULL -- Nach RS_1 / auf Wunsch v. M.Schoettle 

)dt1

ON  a.art_id     = dt1.art_id
AND a.wup_id     = dt1.wup_id
AND a.mandant_id = dt1.mandant_id
AND naechst.naechster_offener_tag BETWEEN dt1.dat_von AND dt1.dat_bis

where a.mandant_id = 1
and a.nb_id = 0  -- hier werden nur die Filialen (keine VZ's) mit vk_brutto versorgt --
   
QUALIFY   RANK() OVER(PARTITION BY a.mandant_id, a.wup_id, a.art_id, a.dat_lief_soll ORDER BY dt1.aktion_id DESC) = 1

) x
 WHERE  mandant_id = mandant_id_
AND    wup_id     = wup_id_
AND    dat_lief_soll    = dat_lief_soll_
AND    art_id     = art_id_
;

UPDATE DBP_ETL.banf_art_gp_dat_sum_tmp_1
SET  vk_brutto = vk_brutto_
    ,in_aktion_fg = in_aktion_fg_

FROM
(
SELECT
a.mandant_id         AS mandant_id_
,a.wup_id                AS  wup_id_
,a.dat_lief_soll       AS dat_lief_soll_
,a.art_id                  AS art_id_
,1 as in_aktion_fg_  
,COALESCE(dt1.vk_aktion_brutto,0) AS vk_brutto_

FROM DBP_ETL.banf_art_gp_dat_sum_tmp_1 a

INNER JOIN DBP_DATA.art_1 art_1
ON   a.art_id      = art.art_id
AND  a.mandant_id  = art.mandant_id


-- Auflösung Aktionspreise Markt--
INNER JOIN
(
SELECT
aawz.art_id
, aawz.wup_id
, aawz.mandant_id
, a.dat_von
, a.dat_bis
, aawz.vk_aktion_brutto
, aawz.aktion_id

FROM DBP_DATA.aktion_art_wup_zu_1 aawz

JOIN DBP_DATA.aktion_1 a
ON  aawz.aktion_id  = a.aktion_id
AND aawz.mandant_id = a.mandant_id
AND aawz.bewart_id  = a.bewart_id

WHERE aawz.mandant_id = 1 -- nur MandantDeutschland
and aawz.nb_id = 0 -- nur Maerkte
AND a.bewart_id = 1002 -- Kennzeichen Aktion_1
--AND (UPPER(aawz.grund_sperrung) <> 'X'  OR aawz.grund_sperrung IS NULL) -- Kennzeichen Zuordnung Aktion_1, Artikel_1, Wup_1 aktiv
AND aawz.grund_sperrung IS NULL -- Nach RS_1 / auf Wunsch v. M.Schoettle 

)dt1

ON  a.art_id     = dt1.art_id
AND a.wup_id     = dt1.wup_id
AND a.mandant_id = dt1.mandant_id
AND a.dat_lief_soll BETWEEN dt1.dat_von AND dt1.dat_bis

where a.mandant_id = 1
and a.nb_id = 0  -- hier werden nur die Filialen (keine VZ's) mit vk_brutto versorgt --

QUALIFY   RANK() OVER(PARTITION BY a.mandant_id, a.wup_id, a.art_id, a.dat_lief_soll ORDER BY dt1.aktion_id DESC) = 1

) x
 WHERE  mandant_id = mandant_id_
AND    wup_id     = wup_id_
AND    dat_lief_soll    = dat_lief_soll_
AND    art_id     = art_id_
AND    (in_aktion_fg = 0  OR (in_aktion_fg = 1 and vk_brutto_ < vk_brutto))
;

UPDATE DBP_ETL.banf_art_gp_dat_sum_tmp_1
SET gp_id = dt.gp_id_new

FROM 
(
SELECT
agg.mandant_id AS mandant_id_
,agg.wup_id AS wup_id_
,agg.nb_id AS nb_id_
,agg.art_id AS art_id_
,agg.dat_lief_soll AS dat_lief_soll_
,agg.gp_id AS gp_id_old
,eord.gp_id AS gp_id_new
,agg.dat_kalk AS dat_kalk_
,agg.in_aktion_fg AS in_aktion_fg_
 FROM DBP_ETL.banf_art_gp_dat_sum_tmp_1 agg
JOIN DBP_DATA.ek_orderbuch_1 eord_1 
 ON agg.mandant_id=eord.mandant_id 
 AND agg.wup_id=eord.wup_id 
 AND agg.art_id=eord.art_id 
 AND agg.dat_lief_soll BETWEEN eord.dat_von AND eord.dat_bis 
WHERE agg.gp_id <> eord.gp_id
GROUP BY 1,2,3,4,5,6,7,8,9
)dt
 WHERE DBP_ETL.banf_art_gp_dat_sum_tmp.mandant_id = mandant_id_
AND DBP_ETL.banf_art_gp_dat_sum_tmp.wup_id = wup_id_
AND DBP_ETL.banf_art_gp_dat_sum_tmp.nb_id = nb_id_
AND DBP_ETL.banf_art_gp_dat_sum_tmp.art_id = art_id_
AND DBP_ETL.banf_art_gp_dat_sum_tmp.dat_lief_soll = dat_lief_soll_
AND DBP_ETL.banf_art_gp_dat_sum_tmp.dat_kalk = dat_kalk_
AND DBP_ETL.banf_art_gp_dat_sum_tmp.in_aktion_fg = in_aktion_fg_
AND DBP_ETL.banf_art_gp_dat_sum_tmp.gp_id = gp_id_old
;

DELETE FROM DBP_DATA.banf_art_gp_dat_sum_1
WHERE (mandant_id, wup_id, nb_id, art_id, gp_id, dat_lief_soll, dat_kalk, in_aktion_fg) IN
(
SELECT
mandant_id, wup_id, nb_id, art_id, gp_id, dat_lief_soll, dat_kalk, in_aktion_fg
FROM DBP_ETL.banf_art_gp_dat_sum_tmp_1
)
;

INSERT INTO DBP_DATA.banf_art_gp_dat_sum_1
(
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id
,dat_kalk 
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,banf_menge_kolli
,forecast_menge_kolli
,menge_best_kolli
,banf_menge_kg
,forecast_menge_kg 
,menge_best_kg
)
SELECT
mandant_id 
,wup_id
,nb_id 
,art_id 
,gp_id 
,dat_kalk
,dat_lief_soll 
,in_aktion_fg
,vk_brutto 
,banf_menge_kolli
,forecast_menge_kolli
,menge_best_kolli
,banf_menge_kg
,forecast_menge_kg 
,menge_best_kg

FROM DBP_ETL.banf_art_gp_dat_sum_tmp_1 d
;
