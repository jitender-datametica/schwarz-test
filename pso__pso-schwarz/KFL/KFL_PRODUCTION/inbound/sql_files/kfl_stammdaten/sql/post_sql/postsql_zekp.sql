 --[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.zekp
WHERE  CAST(werks AS INTEGER) IN(5920,6911,6912,6914,6916)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.zekp
WHERE CAST(matnr AS INTEGER)IN(SELECT CAST(zekp.matnr AS INTEGER)
FROM DBP_ETL.zekp zekp

LEFT OUTER JOIN DBP_DATA.art art
   ON CAST(zekp.matnr AS INTEGER) = art.kl_art_id
  AND mandant_id = 1
WHERE art.kl_art_id IS NULL
  AND CAST(SUBSTR(zekp.matnr,1,2) AS INTEGER) IN (96,97)
GROUP BY CAST(zekp.matnr AS INTEGER))
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.zekp
WHERE CAST(lifnr AS INTEGER)IN
(
SELECT CAST(zekp.lifnr AS INTEGER)
FROM DBP_ETL.zekp zekp
LEFT OUTER JOIN DBP_DATA.gp gp
ON CAST(zekp.lifnr AS INTEGER) = gp.gp_id
AND mandant_id = 1

WHERE gp.gp_id IS NULL
AND CAST(zekp.lifnr AS INTEGER) IN (9731)

GROUP BY CAST(zekp.lifnr AS INTEGER)
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
--original statement
--CREATE MULTISET VOLATILE TABLE #dup_check AS (
--SELECT 
-- matnr
--,lifnr
--,werks
--,datab
--,MAX(abrut) AS abrut
--,MAX(abrna) AS abrna
--,MAX(abonba) AS abonba
--,MAX(aknet) AS aknet
--,MAX(aknb) AS aknb
--,MAX(aknbs) AS aknbs
--,MAX(aknne) AS aknne
--,MAX(ekkba) AS ekkba
--,MAX(mepre) AS mepre
--,MAX(lsein) AS lsein
--,MAX(lokau) AS lokau
--,MAX(bnk) AS bnk
--,MAX(zollba) AS zollba
--,MAX(konwa) AS konwa
--,MAX(kompmeng) AS kompmeng
--FROM DBX_LOAD.zekp
--WHERE (matnr, lifnr, werks, datab) IN (SELECT matnr
--,lifnr
--,werks
--,datab
--FROM DBX_LOAD.zekp
--HAVING COUNT(*) > 1
--GROUP BY 1,2,3,4)
--GROUP BY 3,4,5,6
--) WITH DATA
--PRIMARY INDEX (matnr,lifnr,werks)
--ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--error line 23 at position 39 unexpected 'SELECT'.
--syntax error line 27 at position 0 unexpected 'FROM'.
--syntax error line 29 at position 0 unexpected 'GROUP'.
--translated statement
CREATE OR REPLACE TRANSIENT TABLE _dup_check AS (
SELECT 
 matnr
,lifnr
,werks
,datab
,MAX(abrut) AS abrut
,MAX(abrna) AS abrna
,MAX(abonba) AS abonba
,MAX(aknet) AS aknet
,MAX(aknb) AS aknb
,MAX(aknbs) AS aknbs
,MAX(aknne) AS aknne
,MAX(ekkba) AS ekkba
,MAX(mepre) AS mepre
,MAX(lsein) AS lsein
,MAX(lokau) AS lokau
,MAX(bnk) AS bnk
,MAX(zollba) AS zollba
,MAX(konwa) AS konwa
,MAX(kompmeng) AS kompmeng
FROM DBP_ETL.zekp
WHERE (matnr, lifnr, werks, datab) IN (SELECT matnr
,lifnr
,werks
,datab
FROM DBP_ETL.zekp
HAVING COUNT(*) > 1
GROUP BY 1,2,3,4)
GROUP BY 3,4,5,6
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.zekp
WHERE (matnr,lifnr,werks,datab) IN (SELECT matnr,lifnr,werks,datab FROM _dup_check)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_LOAD.zekp
--(matnr
--,lifnr
--,werks
--,datab
--,abrut
--,abrna
--,abonba
--,aknet
--,aknb
--,aknbs
--,aknne
--,ekkba
--,mepre
--,lsein
--,lokau
--,bnk
--,zollba
--,konwa
--,kompmeng)
--SELECT 
-- matnr
--,lifnr
--,werks
--,datab
--,abrut
--,abrna
--,abonba
--,aknet
--,aknb
--,aknbs
--,aknne
--,ekkba
--,mepre
--,lsein
--,lokau
--,bnk
--,zollba
--,konwa
--,kompmeng
--FROM #dup_check
--;
--
--Comment from validation checker
--error line 23 at position 1
--invalid identifier 'LIFNR'
--translated statement
INSERT INTO DBP_ETL.zekp
(matnr
,lifnr
,werks
,datab
,abrut
,abrna
,abonba
,aknet
,aknb
,aknbs
,aknne
,ekkba
,mepre
,lsein
,lokau
,bnk
,zollba
,konwa
,kompmeng)
SELECT 
 matnr
,lifnr
,werks
,datab
,abrut
,abrna
,abonba
,aknet
,aknb
,aknbs
,aknne
,ekkba
,mepre
,lsein
,lokau
,bnk
,zollba
,konwa
,kompmeng
FROM _dup_check
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--DELETE FROM DBX_LOAD.zekp t1
--WHERE
--EXISTS
--(
--SELECT * FROM
--(
--SELECT
--a.kl_art_id AS matnr
--,gp_id AS lifnr
--,CASE WHEN wup_id = -1 THEN '' ELSE wup_id END AS werks
--,l.dat_von
--FROM DBX_DATA.art_gp_wup_zu_per l
--
--INNER JOIN DBX_DATA.art a
--ON a.art_id = l.art_id
--AND a.mandant_id = 1
--
--WHERE l.mandant_id = 1
--
--)dt1
--WHERE dt1.matnr = t1.matnr
--AND dt1.lifnr = t1.lifnr
--AND TRIM(dt1.werks) = TRIM(t1.werks)
--AND dt1.dat_von <= CAST(t1.datab AS DATE FORMAT 'YYYYMMDD')
--AND 0 = 1
--);
--
--Comment from validation checker
--error line 24 at position 41 unexpected 'FORMAT'.
--syntax error line 26 at position 0 unexpected ')'.
--translated statement
DELETE FROM DBP_ETL.zekp t1
WHERE
EXISTS
(
SELECT * FROM
(
SELECT
a.kl_art_id AS matnr
,gp_id AS lifnr
,CASE WHEN wup_id = -1 THEN '' ELSE wup_id END AS werks
,l.dat_von
FROM DBP_DATA.art_gp_wup_zu_per l

INNER JOIN DBP_DATA.art a
ON a.art_id = l.art_id
AND a.mandant_id = 1

WHERE l.mandant_id = 1

)dt1
WHERE dt1.matnr = t1.matnr
AND dt1.lifnr = t1.lifnr
AND TRIM(dt1.werks) = TRIM(t1.werks)
AND dt1.dat_von <= CAST(t1.datab AS DATE FORMAT 'YYYYMMDD')
AND 0 = 1
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_LOAD.art_gp_wup_zu_per_tmp
--(
-- mandant_id
--,art_id
--,gp_id
--,wup_id
--,nb_id
--,einkaufsorganisation_id
--,dat_von
--,dat_bis
--,ek_brutto
--,ek_netto
--,ek_nettonetto
--,ek_kal_basis
--,ek_mep
--,einstandspreis
--,logistikkostenzuschlag
--,bezugsweg_id
--,wrg_id
--,komponentenmenge
--,ek_brutto_nrfb_rab
--,bonusbasis
--,bezugsnebenkosten
--,zollwert
--,ek_netto_bnk
--,ek_netto_bnk_sachk
--)
--SELECT
-- mandant_id
--,art_id
--,gp_id_
--,wup_id_
--,nb_id_
--,einkaufsorganisation_id_
--,dat_von
--,dat_bis
--,  (ek_brutto       )
--,  (ek_netto        )
--,  (ek_nettonetto   )
--,  (ek_kal_basis    )
--,  (ek_mep          )
--,  (einstandspreis  )
--,logistikkostenzuschlag
--,bezugsweg_id
--,wrg_id
--,komponentenmenge
--,  (ek_brutto_nrfb_rab  )
--,  (bonusbasis          )
--,  (bezugsnebenkosten   )
--,zollwert
--,  (ek_netto_bnk        )
--,  (ek_netto_bnk_sachk  )
--FROM
--(
--SELECT
--a.mandant_id
--,a.art_id
--,lifnr AS gp_id_
--,CASE WHEN werks = '' THEN -1 ELSE werks END AS wup_id_
--,CASE WHEN werks ='' THEN NULL ELSE wp.nb_id END AS nb_id_
--,COALESCE(gp.einkaufsorganisation_id,1000) AS einkaufsorganisation_id_
--,CAST (datab AS DATE FORMAT 'YYYYMMDD') AS  dat_von
--,CAST(80991231 AS DATE) AS dat_bis
--,CASE WHEN INDEX (abrut, '.') > 1
--THEN CAST (CAST (abrut AS FLOAT) * 1000  AS DECIMAL(18,4))
--ELSE CAST (CAST (abrut AS FLOAT) / 10000 AS DECIMAL (18,4))
--END as ek_brutto
--,CASE WHEN INDEX (aknet, '.') > 1
--THEN CAST (CAST (aknet AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (aknet AS FLOAT) / 10000 AS DECIMAL (18,4))
--END as ek_netto
--,CASE WHEN INDEX (aknne, '.') > 1
--THEN CAST (CAST (aknne AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (aknne AS FLOAT) / 10000 AS DECIMAL (18,4))
--END as ek_nettonetto
--,CASE WHEN INDEX (ekkba, '.') > 1
--THEN CAST (CAST (ekkba AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (ekkba AS FLOAT) / 10000 AS DECIMAL (18,4))
--END AS ek_kal_basis
--,CASE WHEN INDEX (mepre, '.') > 1
--THEN CAST (CAST (mepre AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (mepre AS FLOAT) / 10000 AS DECIMAL (18,4))
--END AS ek_mep
--,CASE WHEN INDEX ( lsein , '.') > 1
--THEN CAST (CAST (lsein  AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (lsein  AS FLOAT) / 10000 AS DECIMAL (18,4))
--END  AS einstandspreis
--,COALESCE(
--CASE WHEN werks = '' OR (abrut = 0 AND aknet = 0 AND aknne = 0 AND
--ekkba= 0 AND mepre = 0 AND lsein = 0)
--THEN 0
--ELSE (CASE WHEN INDEX (lokau , '.') > 1
--THEN CAST (CAST (lokau AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (lokau AS FLOAT) / 10000 AS DECIMAL (18,4))
--END)
--END, 0
--) AS logistikkostenzuschlag
--,CASE WHEN werks = ''
--THEN 1
--ELSE 4
--END AS bezugsweg_id  /* 1 fuer dezentral  4 fuer zentral */
--,konwa AS wrg_id
--,CASE WHEN INDEX (kompmeng, '.') > 1
--THEN CAST (CAST (kompmeng AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (kompmeng AS FLOAT) / 10000 AS DECIMAL (18,4))
--END  AS komponentenmenge
--,CASE WHEN INDEX (abrna, '.') > 1
--THEN CAST (CAST (abrna AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (abrna AS FLOAT) / 10000 AS DECIMAL (18,4))
--END  AS ek_brutto_nrfb_rab
--,CASE WHEN INDEX (abonba, '.') > 1
--THEN CAST (CAST (abonba AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (abonba AS FLOAT) / 10000 AS DECIMAL (18,4))
--END  AS bonusbasis
--,CASE WHEN INDEX (bnk, '.') > 1
--THEN CAST (CAST (bnk AS FLOAT) * 1000  AS DECIMAL (9,4))
--ELSE CAST (CAST (bnk AS FLOAT) / 10000 AS DECIMAL (9,4))
--END  AS bezugsnebenkosten
--,CASE WHEN INDEX (zollba, '.') > 1
--THEN CAST (CAST (zollba AS FLOAT) * 1000  AS DECIMAL (9,4))
--ELSE CAST (CAST (zollba AS FLOAT) / 10000 AS DECIMAL (9,4))
--END  AS zollwert
--,CASE WHEN INDEX (aknb, '.') > 1
--THEN CAST (CAST (aknb AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (aknb AS FLOAT) / 10000 AS DECIMAL (18,4))
--END  AS ek_netto_bnk
--,CASE WHEN INDEX (aknbs, '.') > 1
--THEN CAST (CAST (aknbs AS FLOAT) * 1000  AS DECIMAL (18,4))
--ELSE CAST (CAST (aknbs AS FLOAT) / 10000 AS DECIMAL (18,4))
--END  AS ek_netto_bnk_sachk
--
--FROM
--(
--SELECT
-- matnr
--,lifnr
--,werks
--,datab
--,  (abrut  ) AS abrut
--,  (aknet  ) AS aknet
--,  (aknne  ) AS aknne
--,  (ekkba  ) AS ekkba
--,  (mepre  ) AS mepre
--,  (lsein  ) AS lsein
--,konwa
--,CASE WHEN (kompmeng IS NULL OR CAST(kompmeng AS INTEGER) = 0 OR TRIM(kompmeng) = '')
--THEN 1
--ELSE kompmeng
--END AS kompmeng
--,lokau
--,  (abrna   ) AS abrna
--,  (abonba  ) AS abonba
--,  (bnk     ) AS bnk
--,zollba
--,  (aknb    ) AS aknb
--,  (aknbs   ) AS aknbs
--FROM DBX_LOAD.zekp
--
--/*Unsinnige Olap Funktion damit Entschluesselung nur in derived Table ausgefuehrt wird*/
--GROUP BY
--matnr
--,lifnr
--,werks
--,datab
--
--QUALIFY CSUM(1, 1) = 1
--) zk
--
--INNER JOIN
--(
--SELECT
--kl_art_id
--,art_id
--,mandant_id
--FROM DBX_DATA.art
--GROUP BY kl_art_id
--QUALIFY CSUM(1, art_id DESC) = 1
--WHERE mandant_id=1
--) a
--ON zk.matnr = a.kl_art_id
--AND a.mandant_id = 1
--
--INNER JOIN
--(
--SELECT
--gp_id
--,einkaufsorganisation_id
--,mandant_id
--FROM DBX_DATA.gp
--GROUP BY gp_id
--QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
--) gp
--ON zk.lifnr = gp.gp_id
--AND gp.mandant_id = 1
--
--LEFT OUTER JOIN
--(
--SELECT
--wup_id
--,mandant_id
--,nb_id
--FROM DBX_DATA.wup
--) wp
--ON (CASE WHEN werks = '' THEN -1 ELSE werks END) = wp.wup_id
--AND wp.mandant_id = 1
--) a
--;
--
--Comment from validation checker
--error line 62 at position 21 unexpected 'FORMAT'.
--syntax error line 62 at position 28 unexpected ''YYYYMMDD''.
--syntax error line 63 at position 8 unexpected '('.
--syntax error line 63 at position 34 unexpected ')'.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_tmp
(
 mandant_id
,art_id
,gp_id
,wup_id
,nb_id
,einkaufsorganisation_id
,dat_von
,dat_bis
,ek_brutto
,ek_netto
,ek_nettonetto
,ek_kal_basis
,ek_mep
,einstandspreis
,logistikkostenzuschlag
,bezugsweg_id
,wrg_id
,komponentenmenge
,ek_brutto_nrfb_rab
,bonusbasis
,bezugsnebenkosten
,zollwert
,ek_netto_bnk
,ek_netto_bnk_sachk
)
SELECT
 mandant_id
,art_id
,gp_id_
,wup_id_
,nb_id_
,einkaufsorganisation_id_
,dat_von
,dat_bis
,  (ek_brutto       )
,  (ek_netto        )
,  (ek_nettonetto   )
,  (ek_kal_basis    )
,  (ek_mep          )
,  (einstandspreis  )
,logistikkostenzuschlag
,bezugsweg_id
,wrg_id
,komponentenmenge
,  (ek_brutto_nrfb_rab  )
,  (bonusbasis          )
,  (bezugsnebenkosten   )
,zollwert
,  (ek_netto_bnk        )
,  (ek_netto_bnk_sachk  )
FROM
(
SELECT
a.mandant_id
,a.art_id
,lifnr AS gp_id_
,CASE WHEN werks = '' THEN -1 ELSE werks END AS wup_id_
,CASE WHEN werks ='' THEN NULL ELSE wp.nb_id END AS nb_id_
,COALESCE(gp.einkaufsorganisation_id,1000) AS einkaufsorganisation_id_
,CAST (datab AS DATE FORMAT 'YYYYMMDD') AS  dat_von
,to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
,CASE WHEN POSITION( '.' IN abrut) > 1
THEN CAST (CAST (abrut AS FLOAT) * 1000  AS DECIMAL(18,4))
ELSE CAST (CAST (abrut AS FLOAT) / 10000 AS DECIMAL (18,4))
END as ek_brutto
,CASE WHEN POSITION( '.' IN aknet) > 1
THEN CAST (CAST (aknet AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (aknet AS FLOAT) / 10000 AS DECIMAL (18,4))
END as ek_netto
,CASE WHEN POSITION( '.' IN aknne) > 1
THEN CAST (CAST (aknne AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (aknne AS FLOAT) / 10000 AS DECIMAL (18,4))
END as ek_nettonetto
,CASE WHEN POSITION( '.' IN ekkba) > 1
THEN CAST (CAST (ekkba AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (ekkba AS FLOAT) / 10000 AS DECIMAL (18,4))
END AS ek_kal_basis
,CASE WHEN POSITION( '.' IN mepre) > 1
THEN CAST (CAST (mepre AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (mepre AS FLOAT) / 10000 AS DECIMAL (18,4))
END AS ek_mep
,CASE WHEN POSITION( '.' IN  lsein ) > 1
THEN CAST (CAST (lsein  AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (lsein  AS FLOAT) / 10000 AS DECIMAL (18,4))
END  AS einstandspreis
,COALESCE(
CASE WHEN werks = '' OR (abrut = 0 AND aknet = 0 AND aknne = 0 AND
ekkba= 0 AND mepre = 0 AND lsein = 0)
THEN 0
ELSE (CASE WHEN POSITION( '.' IN lokau ) > 1
THEN CAST (CAST (lokau AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (lokau AS FLOAT) / 10000 AS DECIMAL (18,4))
END)
END, 0
) AS logistikkostenzuschlag
,CASE WHEN werks = ''
THEN 1
ELSE 4
END AS bezugsweg_id  /* 1 fuer dezentral  4 fuer zentral */
,konwa AS wrg_id
,CASE WHEN POSITION( '.' IN kompmeng) > 1
THEN CAST (CAST (kompmeng AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (kompmeng AS FLOAT) / 10000 AS DECIMAL (18,4))
END  AS komponentenmenge
,CASE WHEN POSITION( '.' IN abrna) > 1
THEN CAST (CAST (abrna AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (abrna AS FLOAT) / 10000 AS DECIMAL (18,4))
END  AS ek_brutto_nrfb_rab
,CASE WHEN POSITION( '.' IN abonba) > 1
THEN CAST (CAST (abonba AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (abonba AS FLOAT) / 10000 AS DECIMAL (18,4))
END  AS bonusbasis
,CASE WHEN POSITION( '.' IN bnk) > 1
THEN CAST (CAST (bnk AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (bnk AS FLOAT) / 10000 AS DECIMAL (9,4))
END  AS bezugsnebenkosten
,CASE WHEN POSITION( '.' IN zollba) > 1
THEN CAST (CAST (zollba AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (zollba AS FLOAT) / 10000 AS DECIMAL (9,4))
END  AS zollwert
,CASE WHEN POSITION( '.' IN aknb) > 1
THEN CAST (CAST (aknb AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (aknb AS FLOAT) / 10000 AS DECIMAL (18,4))
END  AS ek_netto_bnk
,CASE WHEN POSITION( '.' IN aknbs) > 1
THEN CAST (CAST (aknbs AS FLOAT) * 1000  AS DECIMAL (18,4))
ELSE CAST (CAST (aknbs AS FLOAT) / 10000 AS DECIMAL (18,4))
END  AS ek_netto_bnk_sachk

FROM
(
SELECT
 matnr
,lifnr
,werks
,datab
,  (abrut  ) AS abrut
,  (aknet  ) AS aknet
,  (aknne  ) AS aknne
,  (ekkba  ) AS ekkba
,  (mepre  ) AS mepre
,  (lsein  ) AS lsein
,konwa
,CASE WHEN (kompmeng IS NULL OR CAST(kompmeng AS INTEGER) = 0 OR TRIM(kompmeng) = '')
THEN 1
ELSE kompmeng
END AS kompmeng
,lokau
,  (abrna   ) AS abrna
,  (abonba  ) AS abonba
,  (bnk     ) AS bnk
,zollba
,  (aknb    ) AS aknb
,  (aknbs   ) AS aknbs
FROM DBP_ETL.zekp

/*Unsinnige Olap Funktion damit Entschluesselung nur in derived Table ausgefuehrt wird*/
GROUP BY
matnr
,lifnr
,werks
,datab

QUALIFY CSUM(1, 1) = 1
) zk

INNER JOIN
(
SELECT
kl_art_id
,art_id
,mandant_id
FROM DBP_DATA.art
GROUP BY kl_art_id
QUALIFY CSUM(1, art_id DESC) = 1
WHERE mandant_id=1
) a
ON zk.matnr = a.kl_art_id
AND a.mandant_id = 1

INNER JOIN
(
SELECT
gp_id
,einkaufsorganisation_id
,mandant_id
FROM DBP_DATA.gp
GROUP BY gp_id
QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
) gp
ON zk.lifnr = gp.gp_id
AND gp.mandant_id = 1

LEFT OUTER JOIN
(
SELECT
wup_id
,mandant_id
,nb_id
FROM DBP_DATA.wup
) wp
ON (CASE WHEN werks = '' THEN -1 ELSE werks END) = wp.wup_id
AND wp.mandant_id = 1
) a
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.art_gp_wup_zu_per
WHERE (mandant_id, art_id, gp_id, wup_id, einkaufsorganisation_id, dat_von, COALESCE(nb_id,-999), bezugsweg_id) IN
(
SELECT
agp.mandant_id
,agp.art_id
,agp.gp_id
,agp.wup_id
,agp.einkaufsorganisation_id
,agp.dat_von
,COALESCE(agp.nb_id,-999)
,agp.bezugsweg_id
FROM DBP_DATA.art_gp_wup_zu_per agp

INNER JOIN DBP_ETL.art_gp_wup_zu_per_tmp ag
ON agp.mandant_id = ag.mandant_id AND agp.art_id = ag.art_id AND agp.gp_id = ag.gp_id AND agp.wup_id = ag.wup_id
AND agp.einkaufsorganisation_id = ag.einkaufsorganisation_id AND COALESCE(agp.nb_id,-999) = COALESCE(ag.nb_id,-999)
AND agp.bezugsweg_id = ag.bezugsweg_id AND  agp.dat_von >= ag.dat_von

AND agp.mandant_id = 1
GROUP BY 1,2,3,4,5,6,7,8
)
AND 0 = 0
AND mandant_id = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.art_gp_wup_zu_per_tmp
WHERE ek_brutto =   (0  )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_gp_wup_zu_per
(
 mandant_id
,art_id
,gp_id
,wup_id
,nb_id
,einkaufsorganisation_id
,dat_von
,dat_bis
,ek_brutto
,ek_netto
,ek_nettonetto
,ek_kal_basis
,ek_mep
,einstandspreis
,logistikkostenzuschlag
,bezugsweg_id
,wrg_id
,komponentenmenge
,ek_brutto_nrfb_rab
,bonusbasis
,bezugsnebenkosten
,zollwert
,ek_netto_bnk
,ek_netto_bnk_sachk
)
SELECT
 mandant_id
,art_id
,gp_id
,wup_id
,nb_id
,einkaufsorganisation_id
,dat_von
,dat_bis
,ek_brutto
,ek_netto
,ek_nettonetto
,ek_kal_basis
,ek_mep
,einstandspreis
,logistikkostenzuschlag
,bezugsweg_id
,wrg_id
,komponentenmenge
,ek_brutto_nrfb_rab
,bonusbasis
,bezugsnebenkosten
,zollwert
,ek_netto_bnk
,ek_netto_bnk_sachk
FROM DBP_ETL.art_gp_wup_zu_per_tmp
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
--original statement
--UPDATE DBX_DATA.art_gp_wup_zu_per
--FROM
--(
--SELECT
--mandant_id
--,wup_id
--,nb_id
--,art_id
--,dat_von
--,gp_id
--,bezugsweg_id
--,einkaufsorganisation_id
--,CASE WHEN (MSUM(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) = 0
--THEN CAST(80991231 AS DATE)
--ELSE CAST((MSUM(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) AS DATE) -1
--END AS dat_bis
--FROM DBX_DATA.art_gp_wup_zu_per
--WHERE mandant_id = 1
--GROUP BY mandant_id, wup_id, nb_id, art_id,gp_id, bezugsweg_id, einkaufsorganisation_id
--) dt1
--SET   dat_bis = dt1.dat_bis
--WHERE DBX_DATA.art_gp_wup_zu_per.mandant_id = dt1.mandant_id
--AND DBX_DATA.art_gp_wup_zu_per.wup_id  = dt1.wup_id
--AND COALESCE(DBX_DATA.art_gp_wup_zu_per.nb_id, -999) = COALESCE(dt1.nb_id, -999)
--AND DBX_DATA.art_gp_wup_zu_per.art_id  = dt1.art_id
--AND DBX_DATA.art_gp_wup_zu_per.dat_von = dt1.dat_von
--AND DBX_DATA.art_gp_wup_zu_per.gp_id = dt1.gp_id
--AND DBX_DATA.art_gp_wup_zu_per.einkaufsorganisation_id = dt1.einkaufsorganisation_id
--AND DBX_DATA.art_gp_wup_zu_per.bezugsweg_id = dt1.bezugsweg_id
--AND DBX_DATA.art_gp_wup_zu_per.dat_bis <> dt1.dat_bis
--;
--
--Comment from validation checker
--error line 15 at position 54 unexpected 'desc'.
--syntax error line 15 at position 86 unexpected ')'.
--syntax error line 15 at position 88 unexpected '='.
--syntax error line 16 at position 38 unexpected ')'.
--translated statement
UPDATE DBP_DATA.art_gp_wup_zu_per

SET   dat_bis = dt1.dat_bis
FROM
(
SELECT
mandant_id
,wup_id
,nb_id
,art_id
,dat_von
,gp_id
,bezugsweg_id
,einkaufsorganisation_id
,CASE WHEN (MSUM(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) = 0
THEN to_date('9999-12-31','YYYY-MM-DD')
ELSE CAST((MSUM(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) AS DATE) -1
END AS dat_bis
FROM DBP_DATA.art_gp_wup_zu_per
WHERE mandant_id = 1
GROUP BY mandant_id, wup_id, nb_id, art_id,gp_id, bezugsweg_id, einkaufsorganisation_id
) dt1 WHERE DBP_DATA.art_gp_wup_zu_per.mandant_id = dt1.mandant_id
AND DBP_DATA.art_gp_wup_zu_per.wup_id  = dt1.wup_id
AND COALESCE(DBP_DATA.art_gp_wup_zu_per.nb_id, -999) = COALESCE(dt1.nb_id, -999)
AND DBP_DATA.art_gp_wup_zu_per.art_id  = dt1.art_id
AND DBP_DATA.art_gp_wup_zu_per.dat_von = dt1.dat_von
AND DBP_DATA.art_gp_wup_zu_per.gp_id = dt1.gp_id
AND DBP_DATA.art_gp_wup_zu_per.einkaufsorganisation_id = dt1.einkaufsorganisation_id
AND DBP_DATA.art_gp_wup_zu_per.bezugsweg_id = dt1.bezugsweg_id
AND DBP_DATA.art_gp_wup_zu_per.dat_bis <> dt1.dat_bis
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO DBX_LOAD.art_herst_tmp
--(
--art_id
--,herst_id
--,gp_art_id
--,mhd_zeitraum_dz
--)
--SELECT
--art_id
--,CASE
--WHEN (herst_id=0)
--THEN '-2'
--ELSE herst_id
--END AS _herst_id
--,gp_art_id
--,mhd_zeitraum_dz
--FROM DBX_DATA.art_gp_zu_per
--WHERE mandant_id = 1
--AND (herst_id IS NOT NULL OR gp_art_id IS NOT NULL OR mhd_zeitraum_dz IS NOT NULL)
---- nur die aktuellen Saetze
--AND dat_bis = 80991231
--
--GROUP BY art_id
--QUALIFY CSUM(1, art_id) = 1
--;
--
--Comment from validation checker
--MESSAGE: SQL compilation error:
--Unknown function CSUM
--translated statement
INSERT INTO DBP_ETL.art_herst_tmp
(
art_id
,herst_id
,gp_art_id
,mhd_zeitraum_dz
)
SELECT
art_id
,CASE
WHEN (herst_id=0)
THEN '-2'
ELSE herst_id
END AS _herst_id
,gp_art_id
,mhd_zeitraum_dz
FROM DBP_DATA.art_gp_zu_per
WHERE mandant_id = 1
AND (herst_id IS NOT NULL OR gp_art_id IS NOT NULL OR mhd_zeitraum_dz IS NOT NULL)
-- nur die aktuellen Saetze
AND dat_bis = to_date('9999-12-31','YYYY-MM-DD')

GROUP BY art_id
QUALIFY CSUM(1, art_id) = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_muki_tmp
(
art_id
,gp_id
,mutter_ek_id
)
SELECT
art_id
,gp_id
,mutter_ek_id
FROM DBP_DATA.art_gp_zu_per
WHERE mandant_id = 1
AND mutter_ek_id IS NOT NULL
-- nur die aktuellen Saetze
AND dat_bis = to_date('9999-12-31','YYYY-MM-DD')
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DATA.art_gp_zu_per
--WHERE dat_von >= 1120101
--AND mandant_id = 1
--;
--
--Comment from validation checker
--MESSAGE: SQL compilation error:
--Can not convert parameter '1120101' of type [NUMBER(7,0)] into expected type [DATE]
--translated statement
DELETE FROM DBP_DATA.art_gp_zu_per
WHERE dat_von >= 1120101
AND mandant_id = 1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--UPDATE DBX_DATA.art_gp_zu_per
--FROM
--( SELECT
--mandant_id
--,art_id
--,dat_von
--,CASE WHEN (msum(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) = 0
--THEN CAST('99991231' AS DATE FORMAT 'YYYYMMDD')
--ELSE CAST((msum(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) AS DATE) -1
--END AS dat_bis
--FROM DBX_DATA.art_gp_zu_per
--WHERE mandant_id = 1
--GROUP BY mandant_id, art_id
--) dt1
--SET dat_bis = dt1.dat_bis
--WHERE DBX_DATA.art_gp_zu_per.mandant_id = dt1.mandant_id
--AND DBX_DATA.art_gp_zu_per.art_id  = dt1.art_id
--AND DBX_DATA.art_gp_zu_per.dat_von = dt1.dat_von
--AND DBX_DATA.art_gp_zu_per.dat_bis <> dt1.dat_bis
--;
--
--Comment from validation checker
--error line 9 at position 54 unexpected 'desc'.
--syntax error line 9 at position 86 unexpected ')'.
--syntax error line 9 at position 88 unexpected '='.
--syntax error line 11 at position 42 unexpected '2'.
--syntax error line 11 at position 57 unexpected ')'.
--translated statement
UPDATE DBP_DATA.art_gp_zu_per

SET dat_bis = dt1.dat_bis
FROM
( SELECT
mandant_id
,art_id
,dat_von
,CASE WHEN (msum(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) = 0
THEN CAST('99991231' AS DATE FORMAT 'YYYYMMDD')
ELSE CAST((msum(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) AS DATE) -1
END AS dat_bis
FROM DBP_DATA.art_gp_zu_per
WHERE mandant_id = 1
GROUP BY mandant_id, art_id
) dt1 WHERE DBP_DATA.art_gp_zu_per.mandant_id = dt1.mandant_id
AND DBP_DATA.art_gp_zu_per.art_id  = dt1.art_id
AND DBP_DATA.art_gp_zu_per.dat_von = dt1.dat_von
AND DBP_DATA.art_gp_zu_per.dat_bis <> dt1.dat_bis
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_LOAD.art_gp_zu_per_tmp
--(
--art_id
--,mandant_id
--,gp_id
--,dat_von
--,herst_id
--,einkaufsorganisation_id
--,gp_art_id
--,mhd_zeitraum_dz
--,dat_bis
--)
--SELECT
--art_id
--,mandant_id
--,gp_id
--,_dat_von
--,herst_id
--,einkaufsorganisation_id
--,gp_art_id
--,mhd_zeitraum_dz
--,CAST('99991231' AS DATE FORMAT 'YYYYMMDD') AS dat_bis
--FROM
--(
--SELECT
--mandant_id
--,art_id
--,gp_id
---- wenn der Datensatz ein dat_von < 1.1.2004 hat, dat_bis aber >= 1.1.2004 ist,
---- wird dat_von auf 1.1.2004 gesetzt.
--,CASE WHEN CAST(1120101 AS DATE) BETWEEN dat_von and dat_bis THEN CAST(1120101 AS DATE) ELSE dat_von END AS _dat_von
--,'-2' AS herst_id   -- Defaultwert -2
--,einkaufsorganisation_id
--,dat_bis
--,'-1' AS gp_art_id  -- Defaultwert -1
--,'-1' AS mhd_zeitraum_dz -- Defaultwert -1
--FROM DBX_DATA.art_gp_wup_zu_per
--
--WHERE (_dat_von >= 1120101 OR 1120101 BETWEEN _dat_von and dat_bis)
---- nur die Datensaetze die in den Zeitraum nach 2003 fallen, werden beruecksichtigt,
---- dabei darf es pro Artikel und dat_von nur einen geben, dies ist der Satz mit
---- dem hoeheren ek_brutto.
--AND mandant_id = 1
--
--GROUP BY art_id, _dat_von
--QUALIFY CSUM (1, dat_von DESC,  (ek_brutto ) DESC, gp_id) = 1
--) dt1
--GROUP BY art_id, mandant_id
---- Erklaerung: es muessen alle Lieferantenwechsel ermittelt werden. Wenn sich aber nur der
---- EK aendert, so ist das fuer diese Verarbeitung irrelevant.
--QUALIFY MSUM(gp_id, 2, _dat_von) - 2 * gp_id <> 0
--;
--
--Comment from validation checker
--error line 22 at position 25 unexpected 'FORMAT'.
--syntax error line 22 at position 32 unexpected ''YYYYMMDD''.
--translated statement
INSERT INTO DBP_ETL.art_gp_zu_per_tmp
(
art_id
,mandant_id
,gp_id
,dat_von
,herst_id
,einkaufsorganisation_id
,gp_art_id
,mhd_zeitraum_dz
,dat_bis
)
SELECT
art_id
,mandant_id
,gp_id
,_dat_von
,herst_id
,einkaufsorganisation_id
,gp_art_id
,mhd_zeitraum_dz
,CAST('99991231' AS DATE FORMAT 'YYYYMMDD') AS dat_bis
FROM
(
SELECT
mandant_id
,art_id
,gp_id
-- wenn der Datensatz ein dat_von < 1.1.2004 hat, dat_bis aber >= 1.1.2004 ist,
-- wird dat_von auf 1.1.2004 gesetzt.
,CASE WHEN CAST(1120101 AS DATE) BETWEEN dat_von and dat_bis THEN CAST(1120101 AS DATE) ELSE dat_von END AS _dat_von
,'-2' AS herst_id   -- Defaultwert -2
,einkaufsorganisation_id
,dat_bis
,'-1' AS gp_art_id  -- Defaultwert -1
,'-1' AS mhd_zeitraum_dz -- Defaultwert -1
FROM DBP_DATA.art_gp_wup_zu_per

WHERE (_dat_von >= 1120101 OR 1120101 BETWEEN _dat_von and dat_bis)
-- nur die Datensaetze die in den Zeitraum nach 2003 fallen, werden beruecksichtigt,
-- dabei darf es pro Artikel und dat_von nur einen geben, dies ist der Satz mit
-- dem hoeheren ek_brutto.
AND mandant_id = 1

GROUP BY art_id, _dat_von
QUALIFY CSUM (1, dat_von DESC,  (ek_brutto ) DESC, gp_id) = 1
) dt1
GROUP BY art_id, mandant_id
-- Erklaerung: es muessen alle Lieferantenwechsel ermittelt werden. Wenn sich aber nur der
-- EK aendert, so ist das fuer diese Verarbeitung irrelevant.
QUALIFY MSUM(gp_id, 2, _dat_von) - 2 * gp_id <> 0
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.art_gp_zu_per_tmp
WHERE (mandant_id, art_id, gp_id) IN
(
SELECT
mandant_id
,art_id
,gp_id
FROM DBP_DATA.art_gp_zu_per
WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND mandant_id = 1
)
AND (mandant_id, art_id, dat_von) IN
-- es wird nur der aelteste Stand der Zwischentablle DBP_ETL.art_gp_zu_per_tmp
-- beruecksichtigt
(
SELECT
mandant_id
,art_id
,MIN(dat_von)
FROM DBP_ETL.art_gp_zu_per_tmp
GROUP BY mandant_id, art_id
);

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_gp_zu_per
(
art_id
,mandant_id
,gp_id
,dat_von
,herst_id
,einkaufsorganisation_id
,gp_art_id
,mhd_zeitraum_dz
,dat_bis
)
SELECT
art_id
,mandant_id
,gp_id
,dat_von
,herst_id
,einkaufsorganisation_id
,gp_art_id
,mhd_zeitraum_dz
,dat_bis
FROM DBP_ETL.art_gp_zu_per_tmp
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--UPDATE DBX_DATA.art_gp_zu_per
--FROM
--(
--SELECT
--mandant_id
--,art_id
--,dat_von
--,CASE WHEN (msum(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) = 0
--THEN CAST('99991231' AS DATE FORMAT 'YYYYMMDD')
--ELSE CAST((msum(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) AS DATE) -1
--END AS dat_bis
--FROM DBX_DATA.art_gp_zu_per
--WHERE mandant_id = 1
--GROUP BY mandant_id, art_id
--) dt1
--SET dat_bis = dt1.dat_bis
--WHERE DBX_DATA.art_gp_zu_per.mandant_id = dt1.mandant_id
--AND DBX_DATA.art_gp_zu_per.art_id  = dt1.art_id
--AND DBX_DATA.art_gp_zu_per.dat_von = dt1.dat_von
--AND DBX_DATA.art_gp_zu_per.dat_bis <> dt1.dat_bis
--;
--
--Comment from validation checker
--error line 10 at position 54 unexpected 'desc'.
--syntax error line 10 at position 86 unexpected ')'.
--syntax error line 10 at position 88 unexpected '='.
--syntax error line 12 at position 42 unexpected '2'.
--syntax error line 12 at position 57 unexpected ')'.
--translated statement
UPDATE DBP_DATA.art_gp_zu_per

SET dat_bis = dt1.dat_bis
FROM
(
SELECT
mandant_id
,art_id
,dat_von
,CASE WHEN (msum(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) = 0
THEN CAST('99991231' AS DATE FORMAT 'YYYYMMDD')
ELSE CAST((msum(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) AS DATE) -1
END AS dat_bis
FROM DBP_DATA.art_gp_zu_per
WHERE mandant_id = 1
GROUP BY mandant_id, art_id
) dt1 WHERE DBP_DATA.art_gp_zu_per.mandant_id = dt1.mandant_id
AND DBP_DATA.art_gp_zu_per.art_id  = dt1.art_id
AND DBP_DATA.art_gp_zu_per.dat_von = dt1.dat_von
AND DBP_DATA.art_gp_zu_per.dat_bis <> dt1.dat_bis
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.art_gp_zu_per

SET
herst_id = dt1._herst_id
,mhd_zeitraum_dz = _mhd_zeitraum_dz
,gp_art_id = _gp_art_id

FROM
(
SELECT
art_id _art_id
,herst_id _herst_id
,mhd_zeitraum_dz _mhd_zeitraum_dz
,gp_art_id _gp_art_id
FROM DBP_ETL.art_herst_tmp
) dt1 WHERE art_id  = dt1._art_id
AND mandant_id = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.art_gp_zu_per

SET
mutter_ek_id = dt1._mutter_ek_id

FROM
(
SELECT
art_id _art_id
,mutter_ek_id _mutter_ek_id
,gp_id _gp_id
FROM DBP_ETL.art_muki_tmp
) dt1 WHERE art_id  = dt1._art_id
AND gp_id=dt1._gp_id
AND dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND mandant_id = 1
;

