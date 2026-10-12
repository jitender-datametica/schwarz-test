/* AW check 2021-05-17*/
DROP TABLE IF EXISTS DBP_ETL.marktabschrift_aktion_tmp_2;

CREATE TABLE DBP_ETL.marktabschrift_aktion_tmp_2  (
        wup_id INTEGER,
        nb_id SMALLINT,
        aktion_id CHAR(10) COLLATE 'en-ci',
        mandant_id BYTEINT,
        dat DATE,
        art_id INTEGER,
        menge_abschrift DECIMAL(18,3),
        vk_aktion_brutto DECIMAL(9,3),
        vk_vor_aktion_brutto DECIMAL(9,2),
        mwst_id BYTEINT,
        abschriftbetrag_netto DECIMAL(18,4),
        abschriftbetrag_brutto DECIMAL(18,2),
        wrg_id CHAR(3) COLLATE 'en-ci',
        vk_aktion_netto DECIMAL(9,4),
        vk_vor_aktion_netto DECIMAL(9,4),
        aktion_relevant_fg BYTEINT
) 
;

INSERT INTO DBP_ETL.marktabschrift_aktion_tmp_2 (wup_id
                                                             ,nb_id
                                                             ,aktion_id
                                                             ,mandant_id
                                                             ,dat
                                                             ,art_id
                                                             ,menge_abschrift
                                                             ,vk_aktion_brutto
                                                             ,vk_vor_aktion_brutto
                                                             ,mwst_id
                                                             ,abschriftbetrag_netto
                                                             ,abschriftbetrag_brutto
                                                             ,wrg_id
                                                             ,vk_aktion_netto
                                                             ,vk_vor_aktion_netto
                                                             ,aktion_relevant_fg)
SELECT  a.wup_id,
        a.nb_id,
        b.aktion_id,
        a.mandant_id,
        a.dat,
        a.art_id,
        SUM(a.menge) AS menge_abschrift,
        b.vk_aktion_brutto,
        b.vk_vor_aktion_brutto,
        c.mwst_id,
        0 AS abschriftbetrag_netto,
        0 AS abschriftbetrag_brutto,
        a.wrg_2 AS wrg_id,
        0 AS vk_aktion_netto,
        0 AS vk_vor_aktion_netto,
        b.aktion_relevant_fg
FROM DBP_DATA.artbew_2 a
JOIN DBP_ETL_PROCESS.marktabschriften_stamm_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.dat = b.dat
JOIN DBP_DATA.art_2 c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
WHERE a.mandant_id > 1 AND
      a.dat BETWEEN CURRENT_DATE-45 AND CURRENT_DATE AND
      a.bewart_id = 1002
GROUP BY 1,2,3,4,5,6,8,9,10,11,12,13,16
;

UPDATE DBP_ETL.marktabschrift_aktion_tmp_2 
SET abschriftbetrag_brutto = (vk_vor_aktion_brutto-vk_aktion_brutto)*menge_abschrift
;

UPDATE DBP_ETL.marktabschrift_aktion_tmp_2 

SET abschriftbetrag_netto = (CAST(vk_vor_aktion_brutto/(1.00 + (mwst_ / 100.00)) AS DECIMAL(9,2))  - CAST(vk_aktion_brutto/(1.00 + (mwst_ / 100.00)) AS DECIMAL(9,2))) * DBP_ETL.marktabschrift_aktion_tmp.menge_abschrift,
    vk_aktion_netto = vk_aktion_brutto/(1.00 + (mwst_ / 100.00)) ,
	vk_vor_aktion_netto = vk_vor_aktion_brutto/(1.00 + (mwst_ / 100.00)) 
FROM    (SELECT  mandant_id AS mandant_id_
                ,mwst_id AS mwst_id_
                ,dat_von AS dat_von_
                ,mwst AS mwst_
                ,dat_bis AS dat_bis_
	FROM 	DBP_DATA.mwst_per_2
	WHERE 	mandant_id > 1
	) dt1 WHERE dat BETWEEN dat_von_ AND dat_bis_
AND   mwst_id = mwst_id_
AND   mandant_id = mandant_id_
;

DELETE FROM DBP_DATA.marktabschriften_kmo_aktion_2
WHERE dat BETWEEN CURRENT_DATE-45 AND CURRENT_DATE
;

INSERT INTO DBP_DATA.marktabschriften_kmo_aktion_2 
(	 wup_id
	,nb_id
	,aktion_id
	,mandant_id
	,dat
	,art_id
	,menge_abschrift
	,abschriftbetrag_netto
	,abschriftbetrag_brutto
	,wrg_id
	,vk_aktion_netto
	,vk_vor_aktion_netto
	,aktion_relevant_fg)
SELECT
	 wup_id
	,nb_id
	,aktion_id
	,mandant_id
	,dat
	,art_id
	,menge_abschrift
	,abschriftbetrag_netto
	,abschriftbetrag_brutto
	,wrg_id
	,vk_aktion_netto
	,vk_vor_aktion_netto
	,aktion_relevant_fg
FROM    DBP_ETL.marktabschrift_aktion_tmp_2
;

CREATE OR REPLACE TRANSIENT TABLE _upd_$_2{TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.art_id,
       a.dat,
       a.menge_abschrift,
       a.vk_aktion_netto,
       b.vk_aktion_netto_faktura,
       a.vk_vor_aktion_netto,
       b.vk_vor_aktion_netto_faktura
FROM DBP_DATA.marktabschriften_kmo_aktion_2 a
JOIN (SELECT a.mandant_id,
             a.art_id,
             a.wup_id,
             a.dat_faktura_sap,
             round((a.vk_aktion_brutto     / (1.00 + (b.mwst / 100.00))),2) AS vk_aktion_netto_faktura,
             round((a.vk_vor_aktion_brutto / (1.00 + (b.mwst / 100.00))),2) AS vk_vor_aktion_netto_faktura
      FROM (select mandant_id,
                   art_id,
                   wup_id,
                   dat_faktura_sap,
                   vk_aktion_brutto,
                   vk_vor_aktion_brutto,
                   aktion_id,
                   max(sap_mwst_id) as sap_mwst_id
             from DBP_DATA.besch_faktura_det_kmo_2
             group by 1,2,3,4,5,6,7) a
      JOIN DBP_DATA.mwst_per_2 b
        ON a.mandant_id = b.mandant_id AND 
           a.sap_mwst_id = b.sap_mwst_id AND 
           a.dat_faktura_sap BETWEEN b.dat_von AND b.dat_bis
      WHERE a.aktion_id <> '' AND
            a.dat_faktura_sap BETWEEN CURRENT_DATE-45 AND CURRENT_DATE
      GROUP BY 1,2,3,4,5,6) b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat_faktura_sap
WHERE a.dat BETWEEN CURRENT_DATE-45 AND CURRENT_DATE AND
      a.aktion_relevant_fg = 1 AND
     (a.vk_aktion_netto <> b.vk_aktion_netto_faktura OR
      a.vk_vor_aktion_netto <> b.vk_vor_aktion_netto_faktura)
);

UPDATE DBP_DATA.marktabschriften_kmo_aktion_2 
SET vk_aktion_netto = b.vk_aktion_netto_faktura,
    vk_vor_aktion_netto = b.vk_vor_aktion_netto_faktura,
    abschriftbetrag_netto = (b.vk_vor_aktion_netto_faktura-b.vk_aktion_netto_faktura)*b.menge_abschrift

FROM (SELECT *
      FROM _upd_$_2{TRANSIENT_TABLE_SUFFIX}) b
WHERE DBP_DATA.marktabschriften_kmo_aktion.mandant_id = b.mandant_id AND
      DBP_DATA.marktabschriften_kmo_aktion.wup_id = b.wup_id AND
      DBP_DATA.marktabschriften_kmo_aktion.art_id = b.art_id AND
      DBP_DATA.marktabschriften_kmo_aktion.dat = b.dat AND
      DBP_DATA.marktabschriften_kmo_aktion.aktion_relevant_fg = 1
;
