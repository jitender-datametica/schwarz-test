DROP TABLE IF EXISTS DBP_ETL.artbew_wg_wechsel_join;
CREATE TABLE DBP_ETL.artbew_wg_wechsel_join  (
	 mandant_id       BYTEINT NOT NULL
	,art_id           INTEGER NOT NULL
	,arthiertyp_id    BYTEINT NOT NULL
	,dat              DATE NOT NULL
	,alt_neu_kz       BYTEINT NOT NULL
	,wg_id            SMALLINT NOT NULL
	,wg_art_fg        BYTEINT
	) ;

DROP TABLE IF EXISTS DBP_ETL.artbew_wg_sum_tmp;
CREATE TABLE DBP_ETL.artbew_wg_sum_tmp  (
      mandant_id BYTEINT NOT NULL ,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      wg_id INTEGER NOT NULL,
      arthiertyp_id SMALLINT NOT NULL ,
      dat DATE,
      bewart_id SMALLINT NOT NULL ,
      posten_id CHAR(2) COLLATE 'en-cs' NOT NULL DEFAULT '  ' ,
      menge DECIMAL(18,4),
      menge_ohne_wg_erf_art DECIMAL(18,4),
      umsatz_netto DECIMAL(18,4),
      diff_umsatz_netto_konz DECIMAL(18,4) ,
      umsatz_mwst_betrag DECIMAL(18,4),
      diff_umsatz_mwst_betrag_konz DECIMAL(18,4) ,
      ek_brutto DECIMAL(18,4),
      diff_ek_brutto_konz DECIMAL(18,4) ,
      ek_netto DECIMAL(18,4),
      diff_ek_netto_konz DECIMAL(18,4) ,
      ek_nettonetto DECIMAL(18,4),
      diff_ek_nettonetto_konz DECIMAL(18,4) ,
      ek_kal_basis DECIMAL(18,4),
      diff_ek_kal_basis_konz DECIMAL(18,4) ,
      ek_mep DECIMAL(18,4),
      diff_ek_mep_konz DECIMAL(18,4) ,
      einstandspreis DECIMAL(18,4),
      diff_einstandspreis_konz DECIMAL(18,4) ,
      logkostenzuschlag DECIMAL(18,4) ,
      diff_logkostenzuschlag_konz DECIMAL(18,4) ,
      ek_netto_bnk DECIMAL(18,4),
      diff_ek_netto_bnk_konz DECIMAL(18,4) ,
      ek_netto_bnk_sachk DECIMAL(18,4),
      diff_ek_netto_bnk_sachk_konz DECIMAL(18,4) )
;

INSERT INTO DBP_ETL.artbew_wg_wechsel_tmp (mandant_id,art_id,arthiertyp_id,alt_neu_kz,wg_id,wg_art_fg)
SELECT mandant_id, art_id, arthiertyp_id, -1, wg_id, wg_art_fg
FROM DBP_ETL_PROCESS.artbew_wg_wechsel
;

INSERT INTO DBP_ETL.artbew_wg_wechsel_tmp (mandant_id,art_id,arthiertyp_id,alt_neu_kz,wg_id,wg_art_fg)
SELECT t01.mandant_id, t01.art_id, t01.arthiertyp_id, 1, t01.wg_id, t02.wg_art_fg
FROM DBP_DATA.art_wg_zu_per t01
JOIN DBP_DATA.art t02
  ON t01.mandant_id = t02.mandant_id
 AND t01.art_id = t02.art_id
WHERE t01.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_ETL.artbew_wg_wechsel_join
(
	art_id
	,mandant_id
	,arthiertyp_id
	,dat
	,alt_neu_kz
	,wg_id
	,wg_art_fg
)
SELECT
	 w1.art_id art_id
	,w1.mandant_id mandant_id
	,w1.arthiertyp_id arthiertyp_id
	,t.dat dat
	,w1.alt_neu_kz
	,w1.wg_id
	,w1.wg_art_fg

 FROM DBP_ETL.artbew_wg_wechsel_tmp w1
 JOIN DBP_ETL.artbew_wg_wechsel_tmp w2
   ON w1.mandant_id = w2.mandant_id
  AND w1.art_id = w2.art_id
  AND w1.arthiertyp_id = w2.arthiertyp_id
  AND ((w1.alt_neu_kz = 1 AND w2.alt_neu_kz = -1)
      OR
       (w1.alt_neu_kz = -1 AND w2.alt_neu_kz = 1))

INNER JOIN DBP_DATA.tag t
   ON t.dat <= CURRENT_DATE
   AND t.dat >= '2000-01-01'

WHERE (w1.wg_id <> w2.wg_id OR w1.wg_art_fg <> w2.wg_art_fg)
;

INSERT INTO DBP_ETL.vis_tag_bestand_wg_wechsel_log
(
	art_id
	,mandant_id
	,arthiertyp_id
	,wg_id
)
SELECT
	 w1.art_id art_id
	,w1.mandant_id mandant_id
	,w1.arthiertyp_id arthiertyp_id
	,w1.wg_id

 FROM DBP_ETL.artbew_wg_wechsel_tmp w1
 JOIN DBP_ETL.artbew_wg_wechsel_tmp w2
   ON w1.mandant_id = w2.mandant_id
  AND w1.art_id = w2.art_id
  AND w1.arthiertyp_id = w2.arthiertyp_id
  AND (w1.alt_neu_kz = -1 AND w2.alt_neu_kz = 1)
WHERE w1.wg_id <> w2.wg_id
  AND w1.arthiertyp_id = 2
  AND (w1.mandant_id, w1.art_id) NOT IN
  (SELECT mandant_id, art_id
   FROM DBP_ETL.vis_tag_bestand_wg_wechsel_log
  )
;

INSERT INTO DBP_ETL.vis_monat_best_wg_wechsel_log
(
	art_id
	,mandant_id
	,arthiertyp_id
	,wg_id
)
SELECT
	 w1.art_id art_id
	,w1.mandant_id mandant_id
	,w1.arthiertyp_id arthiertyp_id
	,w1.wg_id

 FROM DBP_ETL.artbew_wg_wechsel_tmp w1
 JOIN DBP_ETL.artbew_wg_wechsel_tmp w2
   ON w1.mandant_id = w2.mandant_id
  AND w1.art_id = w2.art_id
  AND w1.arthiertyp_id = w2.arthiertyp_id
  AND (w1.alt_neu_kz = -1 AND w2.alt_neu_kz = 1)
WHERE w1.wg_id <> w2.wg_id
  AND w1.arthiertyp_id = 2
  AND (w1.mandant_id, w1.art_id) NOT IN
  (SELECT mandant_id, art_id
   FROM DBP_ETL.vis_monat_best_wg_wechsel_log
  )
;

INSERT INTO DBP_ETL.artbew_wg_sum_tmp 
(
   mandant_id
  ,wup_id
  ,nb_id
  ,wg_id
  ,arthiertyp_id
  ,dat
  ,bewart_id
  ,posten_id
  ,menge
  ,menge_ohne_wg_erf_art
  ,umsatz_netto
  ,diff_umsatz_netto_konz
  ,umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz
  ,ek_brutto
  ,diff_ek_brutto_konz
  ,ek_netto
  ,diff_ek_netto_konz
  ,ek_nettonetto
  ,diff_ek_nettonetto_konz
  ,ek_kal_basis
  ,diff_ek_kal_basis_konz
  ,ek_mep
  ,diff_ek_mep_konz
  ,einstandspreis
  ,diff_einstandspreis_konz
  ,logkostenzuschlag
  ,diff_logkostenzuschlag_konz
  ,ek_netto_bnk
  ,diff_ek_netto_bnk_konz
  ,ek_netto_bnk_sachk
  ,diff_ek_netto_bnk_sachk_konz
)
SELECT
   t01.mandant_id
  ,t01.wup_id
  ,t01.nb_id
  ,t02.wg_id
  ,t02.arthiertyp_id
  ,t01.dat
  ,t01.bewart_id
  ,t01.posten_id
  ,SUM(t01.menge * t02.alt_neu_kz)
  ,SUM((CASE WHEN t02.wg_art_fg = 0 THEN menge ELSE 0 END) * t02.alt_neu_kz)
  ,SUM(t01.umsatz_netto * t02.alt_neu_kz)
  ,SUM(t01.diff_umsatz_netto_konz * t02.alt_neu_kz)
  ,SUM(t01.umsatz_mwst_betrag * t02.alt_neu_kz)
  ,SUM(t01.diff_umsatz_mwst_betrag_konz * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.ek_brutto  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.diff_ek_brutto_konz  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.ek_netto  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.diff_ek_netto_konz  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.ek_nettonetto  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.diff_ek_nettonetto_konz  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.ek_kal_basis  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.diff_ek_kal_basis_konz  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.ek_mep  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.diff_ek_mep_konz  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.einstandspreis  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.diff_einstandspreis_konz  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(t01.logkostenzuschlag * t02.alt_neu_kz)
  ,SUM(t01.diff_logkostenzuschlag_konz * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.ek_netto_bnk  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.diff_ek_netto_bnk_konz  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.ek_netto_bnk_sachk  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
  ,SUM(CAST(  (t01.diff_ek_netto_bnk_sachk_konz  ) AS DECIMAL(18,4)) * t02.alt_neu_kz)
FROM DBP_DATA.artbew t01

JOIN DBP_DATA.tag t00
  ON t01.dat = t00.dat

JOIN DBP_ETL.artbew_wg_wechsel_join t02
ON t01.mandant_id = t02.mandant_id
  AND t01.art_id = t02.art_id
  AND t00.dat = t02.dat

GROUP BY 
   t01.mandant_id
  ,t01.wup_id
  ,t01.nb_id
  ,t02.wg_id
  ,t02.arthiertyp_id
  ,t01.dat
  ,t01.bewart_id
  ,t01.posten_id
;

UPDATE DBP_DATA.artbew_wg_mo_sum

SET
   menge                         = DBP_DATA.artbew_wg_mo_sum.menge                        + X.menge
  ,umsatz_netto                  = DBP_DATA.artbew_wg_mo_sum.umsatz_netto                 + X.umsatz_netto
  ,diff_umsatz_netto_konz        = DBP_DATA.artbew_wg_mo_sum.diff_umsatz_netto_konz       + X.diff_umsatz_netto_konz
  ,umsatz_mwst_betrag            = DBP_DATA.artbew_wg_mo_sum.umsatz_mwst_betrag           + X.umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz  = DBP_DATA.artbew_wg_mo_sum.diff_umsatz_mwst_betrag_konz + X.diff_umsatz_mwst_betrag_konz
  ,ek_brutto                     = DBP_DATA.artbew_wg_mo_sum.ek_brutto                    + X.ek_brutto
  ,diff_ek_brutto_konz           = DBP_DATA.artbew_wg_mo_sum.diff_ek_brutto_konz          + X.diff_ek_brutto_konz
  ,ek_netto                      = DBP_DATA.artbew_wg_mo_sum.ek_netto                     + X.ek_netto
  ,diff_ek_netto_konz            = DBP_DATA.artbew_wg_mo_sum.diff_ek_netto_konz           + X.diff_ek_netto_konz
  ,ek_nettonetto                 = DBP_DATA.artbew_wg_mo_sum.ek_nettonetto                + X.ek_nettonetto
  ,diff_ek_nettonetto_konz       = DBP_DATA.artbew_wg_mo_sum.diff_ek_nettonetto_konz      + X.diff_ek_nettonetto_konz
  ,ek_kal_basis                  = DBP_DATA.artbew_wg_mo_sum.ek_kal_basis                 + X.ek_kal_basis
  ,diff_ek_kal_basis_konz        = DBP_DATA.artbew_wg_mo_sum.diff_ek_kal_basis_konz       + X.diff_ek_kal_basis_konz
  ,ek_mep                        = DBP_DATA.artbew_wg_mo_sum.ek_mep                       + X.ek_mep
  ,diff_ek_mep_konz              = DBP_DATA.artbew_wg_mo_sum.diff_ek_mep_konz             + X.diff_ek_mep_konz
  ,einstandspreis                = DBP_DATA.artbew_wg_mo_sum.einstandspreis               + X.einstandspreis
  ,diff_einstandspreis_konz      = DBP_DATA.artbew_wg_mo_sum.diff_einstandspreis_konz     + X.diff_einstandspreis_konz
  ,logkostenzuschlag             = DBP_DATA.artbew_wg_mo_sum.logkostenzuschlag            + X.logkostenzuschlag
  ,diff_logkostenzuschlag_konz   = DBP_DATA.artbew_wg_mo_sum.diff_logkostenzuschlag_konz  + X.diff_logkostenzuschlag_konz
  ,ek_netto_bnk                  = DBP_DATA.artbew_wg_mo_sum.ek_netto_bnk                 + X.ek_netto_bnk
  ,diff_ek_netto_bnk_konz        = DBP_DATA.artbew_wg_mo_sum.diff_ek_netto_bnk_konz       + X.diff_ek_netto_bnk_konz
  ,ek_netto_bnk_sachk            = DBP_DATA.artbew_wg_mo_sum.ek_netto_bnk_sachk           + X.ek_netto_bnk_sachk
  ,diff_ek_netto_bnk_sachk_konz  = DBP_DATA.artbew_wg_mo_sum.diff_ek_netto_bnk_sachk_konz + X.diff_ek_netto_bnk_sachk_konz
FROM (
	SELECT
		t01.wg_id
		,t01.wup_id
		,t01.nb_id
		,t02.kjmo
		,t01.mandant_id
		,t01.bewart_id
		,t01.arthiertyp_id
		,t01.posten_id
		,SUM(menge) AS menge
		,SUM(umsatz_netto) AS umsatz_netto
		,SUM(diff_umsatz_netto_konz) AS diff_umsatz_netto_konz 
		,SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag
		,SUM(diff_umsatz_mwst_betrag_konz) AS diff_umsatz_mwst_betrag_konz
		,SUM(ek_brutto) AS ek_brutto
		,SUM(diff_ek_brutto_konz) AS diff_ek_brutto_konz
		,SUM(ek_netto) AS ek_netto
		,SUM(diff_ek_netto_konz) AS diff_ek_netto_konz
		,SUM(ek_nettonetto) AS ek_nettonetto
		,SUM(diff_ek_nettonetto_konz) AS diff_ek_nettonetto_konz
		,SUM(ek_kal_basis) AS ek_kal_basis
		,SUM(diff_ek_kal_basis_konz) AS diff_ek_kal_basis_konz
		,SUM(ek_mep) AS ek_mep
		,SUM(diff_ek_mep_konz) AS diff_ek_mep_konz
		,SUM(einstandspreis) AS einstandspreis
		,SUM(diff_einstandspreis_konz) AS diff_einstandspreis_konz
		,SUM(logkostenzuschlag) AS logkostenzuschlag
		,SUM(diff_logkostenzuschlag_konz) AS diff_logkostenzuschlag_konz
		,SUM(ek_netto_bnk) AS ek_netto_bnk
		,SUM(diff_ek_netto_bnk_konz) AS diff_ek_netto_bnk_konz
		,SUM(ek_netto_bnk_sachk) AS ek_netto_bnk_sachk
		,SUM(diff_ek_netto_bnk_sachk_konz) AS diff_ek_netto_bnk_sachk_konz
	FROM DBP_ETL.artbew_wg_sum_tmp t01
	JOIN DBP_DATA.tag t02
	ON t01.dat = t02.dat
	GROUP BY t01.wg_id, t01.wup_id, t01.nb_id, t02.kjmo, t01.mandant_id, t01.bewart_id, t01.arthiertyp_id, t01.posten_id
	) X WHERE
  DBP_DATA.artbew_wg_mo_sum.wg_id         = X.wg_id       AND
  DBP_DATA.artbew_wg_mo_sum.wup_id        = X.wup_id      AND
  DBP_DATA.artbew_wg_mo_sum.nb_id         = X.nb_id       AND
  DBP_DATA.artbew_wg_mo_sum.kjmo          = X.kjmo        AND
  DBP_DATA.artbew_wg_mo_sum.mandant_id    = X.mandant_id  AND
  DBP_DATA.artbew_wg_mo_sum.bewart_id     = X.bewart_id   AND
  DBP_DATA.artbew_wg_mo_sum.arthiertyp_id = X.arthiertyp_id  AND
  DBP_DATA.artbew_wg_mo_sum.posten_id     = X.posten_id
;

INSERT INTO DBP_DATA.artbew_wg_mo_sum (
	 arthiertyp_id
	,bewart_id
	,posten_id
	,wg_id
	,wup_id
	,mandant_id
	,nb_id
	,kjmo
	,menge
	,umsatz_netto
	,diff_umsatz_netto_konz
	,umsatz_mwst_betrag
	,diff_umsatz_mwst_betrag_konz
	,ek_brutto
	,diff_ek_brutto_konz
	,ek_netto
	,diff_ek_netto_konz
	,ek_nettonetto
	,diff_ek_nettonetto_konz
	,ek_kal_basis
	,diff_ek_kal_basis_konz
	,ek_mep
	,diff_ek_mep_konz
	,einstandspreis
	,diff_einstandspreis_konz
	,logkostenzuschlag
	,diff_logkostenzuschlag_konz
	,ek_netto_bnk
	,diff_ek_netto_bnk_konz
	,ek_netto_bnk_sachk
	,diff_ek_netto_bnk_sachk_konz
	)
SELECT
	 t01.arthiertyp_id
	,t01.bewart_id
	,t01.posten_id
	,t01.wg_id
	,t01.wup_id
	,t01.mandant_id
	,t01.nb_id
	,t01.kjmo
	,t01.menge
	,t01.umsatz_netto
	,t01.diff_umsatz_netto_konz
	,t01.umsatz_mwst_betrag
	,t01.diff_umsatz_mwst_betrag_konz
	,t01.ek_brutto
	,t01.diff_ek_brutto_konz
	,t01.ek_netto
	,t01.diff_ek_netto_konz
	,t01.ek_nettonetto
	,t01.diff_ek_nettonetto_konz
	,t01.ek_kal_basis
	,t01.diff_ek_kal_basis_konz
	,t01.ek_mep
	,t01.diff_ek_mep_konz
	,t01.einstandspreis
	,t01.diff_einstandspreis_konz
	,t01.logkostenzuschlag
	,t01.diff_logkostenzuschlag_konz
	,t01.ek_netto_bnk
	,t01.diff_ek_netto_bnk_konz
	,t01.ek_netto_bnk_sachk
	,t01.diff_ek_netto_bnk_sachk_konz
FROM (
	SELECT
		t1.wg_id
		,t1.wup_id
		,t1.nb_id
		,t2.kjmo
		,t1.mandant_id
		,t1.bewart_id
		,t1.arthiertyp_id
		,t1.posten_id
		,SUM(t1.menge) AS menge
		,SUM(t1.umsatz_netto) AS umsatz_netto
		,SUM(t1.diff_umsatz_netto_konz) AS diff_umsatz_netto_konz 
		,SUM(t1.umsatz_mwst_betrag) AS umsatz_mwst_betrag
		,SUM(t1.diff_umsatz_mwst_betrag_konz) AS diff_umsatz_mwst_betrag_konz
		,SUM(t1.ek_brutto) AS ek_brutto
		,SUM(t1.diff_ek_brutto_konz) AS diff_ek_brutto_konz
		,SUM(t1.ek_netto) AS ek_netto
		,SUM(t1.diff_ek_netto_konz) AS diff_ek_netto_konz
		,SUM(t1.ek_nettonetto) AS ek_nettonetto
		,SUM(t1.diff_ek_nettonetto_konz) AS diff_ek_nettonetto_konz
		,SUM(t1.ek_kal_basis) AS ek_kal_basis
		,SUM(t1.diff_ek_kal_basis_konz) AS diff_ek_kal_basis_konz
		,SUM(t1.ek_mep) AS ek_mep
		,SUM(t1.diff_ek_mep_konz) AS diff_ek_mep_konz
		,SUM(t1.einstandspreis) AS einstandspreis
		,SUM(t1.diff_einstandspreis_konz) AS diff_einstandspreis_konz
		,SUM(t1.logkostenzuschlag) AS logkostenzuschlag
		,SUM(t1.diff_logkostenzuschlag_konz) AS diff_logkostenzuschlag_konz
		,SUM(t1.ek_netto_bnk) AS ek_netto_bnk
		,SUM(t1.diff_ek_netto_bnk_konz) AS diff_ek_netto_bnk_konz
		,SUM(t1.ek_netto_bnk_sachk) AS ek_netto_bnk_sachk
		,SUM(t1.diff_ek_netto_bnk_sachk_konz) AS diff_ek_netto_bnk_sachk_konz
	FROM DBP_ETL.artbew_wg_sum_tmp t1
	JOIN DBP_DATA.tag t2
	ON t1.dat = t2.dat
	GROUP BY t1.wg_id, t1.wup_id, t1.nb_id, t2.kjmo, t1.mandant_id, t1.bewart_id, t1.arthiertyp_id, t1.posten_id
	) t01
LEFT OUTER JOIN DBP_DATA.artbew_wg_mo_sum t02
ON t01.arthiertyp_id = t02.arthiertyp_id
AND t01.bewart_id = t02.bewart_id
AND t01.posten_id = t02.posten_id
AND t01.wg_id = t02.wg_id
AND t01.wup_id = t02.wup_id
AND t01.mandant_id = t02.mandant_id
AND t01.nb_id = t02.nb_id
AND t01.kjmo = t02.kjmo
WHERE t02.mandant_id IS NULL
;

UPDATE DBP_DATA.artbew_wg_tp2_sum
FROM DBP_ETL.artbew_wg_sum_tmp X
SET
   menge                         = DBP_DATA.artbew_wg_tp2_sum.menge                        + X.menge
  ,menge_ohne_wg_erf_art         = DBP_DATA.artbew_wg_tp2_sum.menge_ohne_wg_erf_art        + X.menge_ohne_wg_erf_art
  ,umsatz_netto                  = DBP_DATA.artbew_wg_tp2_sum.umsatz_netto                 + X.umsatz_netto
  ,diff_umsatz_netto_konz        = DBP_DATA.artbew_wg_tp2_sum.diff_umsatz_netto_konz       + X.diff_umsatz_netto_konz
  ,umsatz_mwst_betrag            = DBP_DATA.artbew_wg_tp2_sum.umsatz_mwst_betrag           + X.umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz  = DBP_DATA.artbew_wg_tp2_sum.diff_umsatz_mwst_betrag_konz + X.diff_umsatz_mwst_betrag_konz
  ,ek_brutto                     = DBP_DATA.artbew_wg_tp2_sum.ek_brutto                    + X.ek_brutto
  ,diff_ek_brutto_konz           = DBP_DATA.artbew_wg_tp2_sum.diff_ek_brutto_konz          + X.diff_ek_brutto_konz
  ,ek_netto                      = DBP_DATA.artbew_wg_tp2_sum.ek_netto                     + X.ek_netto
  ,diff_ek_netto_konz            = DBP_DATA.artbew_wg_tp2_sum.diff_ek_netto_konz           + X.diff_ek_netto_konz
  ,ek_nettonetto                 = DBP_DATA.artbew_wg_tp2_sum.ek_nettonetto                + X.ek_nettonetto
  ,diff_ek_nettonetto_konz       = DBP_DATA.artbew_wg_tp2_sum.diff_ek_nettonetto_konz      + X.diff_ek_nettonetto_konz
  ,ek_kal_basis                  = DBP_DATA.artbew_wg_tp2_sum.ek_kal_basis                 + X.ek_kal_basis
  ,diff_ek_kal_basis_konz        = DBP_DATA.artbew_wg_tp2_sum.diff_ek_kal_basis_konz       + X.diff_ek_kal_basis_konz
  ,ek_mep                        = DBP_DATA.artbew_wg_tp2_sum.ek_mep                       + X.ek_mep
  ,diff_ek_mep_konz              = DBP_DATA.artbew_wg_tp2_sum.diff_ek_mep_konz             + X.diff_ek_mep_konz
  ,einstandspreis                = DBP_DATA.artbew_wg_tp2_sum.einstandspreis               + X.einstandspreis
  ,diff_einstandspreis_konz      = DBP_DATA.artbew_wg_tp2_sum.diff_einstandspreis_konz     + X.diff_einstandspreis_konz
  ,logkostenzuschlag             = DBP_DATA.artbew_wg_tp2_sum.logkostenzuschlag            + X.logkostenzuschlag
  ,diff_logkostenzuschlag_konz   = DBP_DATA.artbew_wg_tp2_sum.diff_logkostenzuschlag_konz  + X.diff_logkostenzuschlag_konz
  ,ek_netto_bnk                  = DBP_DATA.artbew_wg_tp2_sum.ek_netto_bnk                 + X.ek_netto_bnk
  ,diff_ek_netto_bnk_konz        = DBP_DATA.artbew_wg_tp2_sum.diff_ek_netto_bnk_konz       + X.diff_ek_netto_bnk_konz
  ,ek_netto_bnk_sachk            = DBP_DATA.artbew_wg_tp2_sum.ek_netto_bnk_sachk           + X.ek_netto_bnk_sachk
  ,diff_ek_netto_bnk_sachk_konz  = DBP_DATA.artbew_wg_tp2_sum.diff_ek_netto_bnk_sachk_konz + X.diff_ek_netto_bnk_sachk_konz
WHERE
  DBP_DATA.artbew_wg_tp2_sum.mandant_id    = X.mandant_id    AND
  DBP_DATA.artbew_wg_tp2_sum.wup_id        = X.wup_id        AND
  DBP_DATA.artbew_wg_tp2_sum.nb_id         = X.nb_id         AND
  DBP_DATA.artbew_wg_tp2_sum.wg_id         = X.wg_id         AND
  DBP_DATA.artbew_wg_tp2_sum.arthiertyp_id = X.arthiertyp_id AND
  DBP_DATA.artbew_wg_tp2_sum.dat           = X.dat           AND
  DBP_DATA.artbew_wg_tp2_sum.bewart_id     = X.bewart_id     AND
  DBP_DATA.artbew_wg_tp2_sum.posten_id     = collate(X.posten_id, 'en-ci') AND
  DBP_DATA.artbew_wg_tp2_sum.arthiertyp_id = 2
;

INSERT INTO DBP_DATA.artbew_wg_tp2_sum (
	 mandant_id
	,wup_id
	,nb_id
	,wg_id
	,arthiertyp_id
	,dat
	,bewart_id
	,posten_id
	,menge
	,menge_ohne_wg_erf_art
	,umsatz_netto
	,diff_umsatz_netto_konz
	,umsatz_mwst_betrag
	,diff_umsatz_mwst_betrag_konz
	,ek_brutto
	,diff_ek_brutto_konz
	,ek_netto
	,diff_ek_netto_konz
	,ek_nettonetto
	,diff_ek_nettonetto_konz
	,ek_kal_basis
	,diff_ek_kal_basis_konz
	,ek_mep
	,diff_ek_mep_konz
	,einstandspreis
	,diff_einstandspreis_konz
	,logkostenzuschlag
	,diff_logkostenzuschlag_konz
	,ek_netto_bnk
	,diff_ek_netto_bnk_konz
	,ek_netto_bnk_sachk
	,diff_ek_netto_bnk_sachk_konz
	)
SELECT
	 t01.mandant_id
	,t01.wup_id
	,t01.nb_id
	,t01.wg_id
	,t01.arthiertyp_id
	,t01.dat
	,t01.bewart_id
	,t01.posten_id
	,t01.menge
	,t01.menge_ohne_wg_erf_art
	,t01.umsatz_netto
	,t01.diff_umsatz_netto_konz
	,t01.umsatz_mwst_betrag
	,t01.diff_umsatz_mwst_betrag_konz
	,t01.ek_brutto
	,t01.diff_ek_brutto_konz
	,t01.ek_netto
	,t01.diff_ek_netto_konz
	,t01.ek_nettonetto
	,t01.diff_ek_nettonetto_konz
	,t01.ek_kal_basis
	,t01.diff_ek_kal_basis_konz
	,t01.ek_mep
	,t01.diff_ek_mep_konz
	,t01.einstandspreis
	,t01.diff_einstandspreis_konz
	,t01.logkostenzuschlag
	,t01.diff_logkostenzuschlag_konz
	,t01.ek_netto_bnk
	,t01.diff_ek_netto_bnk_konz
	,t01.ek_netto_bnk_sachk
	,t01.diff_ek_netto_bnk_sachk_konz
FROM DBP_ETL.artbew_wg_sum_tmp t01
LEFT OUTER JOIN DBP_DATA.artbew_wg_tp2_sum t02
ON t01.mandant_id = t02.mandant_id
AND t01.wup_id = t02.wup_id
AND t01.nb_id = t02.nb_id
AND t01.wg_id = t02.wg_id
AND t01.arthiertyp_id = t02.arthiertyp_id
AND t01.dat = t02.dat
AND t01.bewart_id = t02.bewart_id
AND COLLATE(t01.posten_id, 'en-ci') = t02.posten_id
WHERE t02.mandant_id IS NULL
AND t01.arthiertyp_id = 2
;

DROP TABLE IF EXISTS DBP_ETL.wpuums_build_tmp;
CREATE TABLE DBP_ETL.wpuums_build_tmp  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wg_id SMALLINT NOT NULL,
      bewart_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      nb_id SMALLINT NOT NULL,
      arthiertyp_id BYTEINT,
      umsatz_brutto DECIMAL(18,4),
      umsatz_netto DECIMAL(18,4),
      umsatz_wrg CHAR(3) COLLATE 'en-ci',
      umsatz_brutto_konz DECIMAL(18,4),
      umsatz_netto_konz DECIMAL(18,4),
      umsatz_mwst_betrag DECIMAL(18,4),
      kjmo INTEGER,
      menge DECIMAL(18,3) DEFAULT 0.000  ,
      quelle BYTEINT DEFAULT 0 )
;

DROP TABLE IF EXISTS DBP_ETL.wpuums_build_tmp2;
CREATE TABLE DBP_ETL.wpuums_build_tmp2  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wg_id SMALLINT NOT NULL,
      bewart_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      nb_id SMALLINT NOT NULL,
      arthiertyp_id BYTEINT,
      umsatz_brutto DECIMAL(18,4),
      umsatz_netto DECIMAL(18,4),
      umsatz_wrg CHAR(3) COLLATE 'en-ci',
      umsatz_brutto_konz DECIMAL(18,4),
      umsatz_netto_konz DECIMAL(18,4),
      umsatz_mwst_betrag DECIMAL(18,4),
      kjmo INTEGER,
      menge DECIMAL(18,3) DEFAULT 0.000  ,
      quelle BYTEINT DEFAULT 0 )
;

