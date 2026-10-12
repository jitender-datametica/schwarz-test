

DROP TABLE IF EXISTS DBP_ETL.artbew_mis_2;

CREATE TABLE DBP_ETL.artbew_mis_2  (
      mandant_id BYTEINT,
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT,
      wg_id SMALLINT,
      arthiertyp_id BYTEINT,
      bewart_id SMALLINT,
      dat DATE,
      menge DECIMAL(18,4),
      wrg_2 CHAR(3) COLLATE 'en-ci',
      umsatz_netto DECIMAL(18,4),
      diff_umsatz_netto_konz DECIMAL(18,4) ,
      umsatz_mwst_betrag DECIMAL(18,4),
      diff_umsatz_mwst_betrag_konz DECIMAL(18,4) )
;

CREATE OR REPLACE TRANSIENT TABLE _artbew_tmp  (
  art_id                  INTEGER NOT NULL,
  wup_id                  INTEGER NOT NULL,
  mandant_id              BYTEINT NOT NULL,
  bewart_id               SMALLINT NOT NULL,
  gp_id                   INTEGER,
  einkaufsorganisation_id SMALLINT,
  nb_id                   SMALLINT NOT NULL,
  dat                     DATE NOT NULL,
  aktion_id               CHAR(10) COLLATE 'en-ci' NOT NULL,
  ean_kasse               DECIMAL(26,0) NOT NULL,
  herst_id                INTEGER,
  wg_id                   INTEGER,
  mwst_id                 BYTEINT,
  menge                   DECIMAL(18,4) ,
  wrg_2                     CHAR(3) COLLATE 'en-ci',
  umsatz_netto            DECIMAL(18,4),
  umsatz_mwst_betrag      DECIMAL(18,4),
  ek_brutto               DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),
  logkostenzuschlag       DECIMAL(18,4),
  bezugsweg_id            BYTEINT,
  ek_netto_bnk            DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4),
  posten_id               CHAR(2) COLLATE 'en-cs',
  bewart_det_id           INTEGER NOT NULL
)
;

CREATE OR REPLACE TRANSIENT TABLE _artbew_tmp_anr  (
  art_id                  INTEGER NOT NULL,
  mandant_id              BYTEINT NOT NULL,
  gp_id                   INTEGER,
  faktor_fg               SMALLINT,
  wg_id                   INTEGER,
  einkaufsorganisation_id SMALLINT,
  dat                     DATE NOT NULL,
  herst_id                INTEGER,
  zekp_dat_von            DATE, 
  ek_brutto               DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),
  logkostenzuschlag       DECIMAL(18,4),
  bezugsweg_id            BYTEINT,
  ek_netto_bnk            DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4)
)
;

INSERT INTO _artbew_tmp
(
   mandant_id
  ,wrg_2
  ,wup_id
  ,nb_id
  ,dat
  ,posten_id
  ,bezugsweg_id
  ,art_id
  ,ean_kasse 
  ,bewart_id
  ,mwst_id
  ,aktion_id
  ,menge
  ,umsatz_mwst_betrag
  ,umsatz_netto
  ,bewart_det_id
)
SELECT 
   p.mandant_id
  ,'EUR' as wrg_2
  ,p.wup_id
  ,w.nb_id
  ,p.dat
  ,COALESCE(a.posten_id,'') AS posten_id
  ,COALESCE(aw.bezugsweg_id, p.bezugsweg_id) /*fuehrend */
  -- bartosiewiczadm - cloud migration
  --,COALESCE(a.art_id, erf.art_id, 0) AS art_id_
  ,COALESCE(a.art_id, erf.art_id, 0)
  ,COALESCE(p.ean_kasse, 0)          AS ean_kasse 
  ,p.bewart_id
  ,COALESCE(mw.mwst_id, mws.mwst_id) /*fuehrend MWST aus Bondaten*/ 
  ,p.aktion_id
  ,SUM(p.menge) AS menge_
  ,SUM(p.umsatz /(1 + COALESCE(mw.mwst, mws.mwst) / 100)*(COALESCE(mw.mwst, mws.mwst) / 100)) AS umsatz_mwst_betrag
  ,SUM(p.umsatz) - umsatz_mwst_betrag AS umsatz_netto
  ,p.bewart_det_id
FROM
(
  SELECT
        mandant_id
        ,wup_id
        ,dat
        ,kl_art_id
        ,ean_kasse
        ,wg_id
        ,CAST(umsatz_brutto AS FLOAT) AS umsatz
        ,mwst_id
        ,menge
        ,CASE WHEN LTRIM(aktion_id) IN ('0','0000000000','')
        THEN 1001 /*aktoinsfrei*/
        ELSE 1002 /*Sonderaktion*/
        END AS bewart_id
        ,CASE WHEN LTRIM(aktion_id) IN ('0','0000000000','')
        THEN ''
        ELSE aktion_id
        END AS aktion_id
        ,4 AS bezugsweg_id /*Initialisierung, im Anschluss erfolgt Ermittlung ueber MARC_2*/
    ,CASE
      WHEN LTRIM(aktion_id) IN ('0','0000000000','')
           AND kundenkarte_id IS NULL 
		   AND kundenkarte_typ_id = 0
	  THEN 100110
      ELSE
        CASE
          WHEN LTRIM(aktion_id) IN ('0','0000000000','')
               AND kundenkarte_id IS NOT NULL
               AND kundenkarte_typ_id IN (2)
		  THEN 100111  
          ELSE
            CASE
              WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                    AND kundenkarte_id IS NULL
                    AND kundenkarte_typ_id = 0
                    AND aktion_id_obv IS NOT NULL
                    AND (bonuskauf_id IS NULL OR bonuskauf_id = 0)
			  THEN 100210
              ELSE
                CASE 
                  WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                       AND kundenkarte_id IS NOT NULL
                       AND kundenkarte_typ_id IN (2)
                       AND aktion_id_obv IS NOT NULL
                       AND (bonuskauf_id IS NULL OR bonuskauf_id = 0)
				  THEN 100211
                  ELSE
                    CASE
                      WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                           AND bonuskauf_id IS NOT NULL
                           AND kundenkarte_id IS NULL 
						   AND kundenkarte_typ_id = 0 
						   AND customer_promotion_fg = 0
						   AND promotion_art = 'COMMON'
                      THEN 100220
                      ELSE
                        CASE
                          WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                               AND bonuskauf_id IS NOT NULL
                               AND kundenkarte_id IS NOT NULL
                               AND kundenkarte_typ_id IN (2) 
							   AND customer_promotion_fg = 0
							   AND promotion_art = 'COMMON'
                          THEN 100221
                          ELSE
                            CASE
                              WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                                   AND bonuskauf_id IS NOT NULL
								   AND customer_promotion_fg = 1
								   AND promotion_art = 'CUSTOMER'
                              THEN 100231
                              ELSE
                                CASE
                                  WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                                       AND bonuskauf_id IS NOT NULL
									   AND customer_promotion_fg = 1
									   AND promotion_art = 'PERSONAL'
								  THEN 100241
                                  ELSE 9999
                                END
							END
                        END
                    END
                END
            END
        END
	END AS bewart_det_id
FROM dbp_etl.bon_artbew_tmp_talon_2
) p

-- Ermittlung nb_id
INNER JOIN DBP_DATA.wup_2 w
ON w.mandant_id = p.mandant_id 
  AND w.wup_id = p.wup_id

-- Ermittlung art_id
LEFT OUTER JOIN 
(
  SELECT 
     mandant_id
    ,art_id
    ,kl_art_id
    ,posten_id
    ,mwst_id 
  FROM DBP_DATA.art_2 
  -- bartosiewiczadm - cloud migration  
  /*GROUP BY
     mandant_id  
    ,kl_art_id 
  
  QUALIFY CSUM(1, art_id DESC) = 1*/
  QUALIFY row_number() OVER (PARTITION BY mandant_id,kl_art_id ORDER BY art_id DESC) = 1
) a
ON p.kl_art_id = a.kl_art_id
  AND p.mandant_id = a.mandant_id 

-- Ermittlung art_id für unbekannte Artikel_2 und alle Artikel_2, 
-- deren Kassen-wg nicht mit der wg_id arthiertyp_2 2 der Stammdaten übereinstimmt
LEFT OUTER JOIN DBP_ETL_PROCESS.dwh_wg_erfass_artikel_2 erf
ON p.mandant_id = erf.mandant_id 
  AND p.wg_id = erf.wg_id
  AND erf.arthiertyp_id = 2
  
-- Ermittlung MWST ID fuer Artikel_2 der WG Erfassung 
LEFT OUTER JOIN DBP_DATA.art_2 aerf
ON erf.mandant_id = aerf.mandant_id 
  AND erf.art_id = aerf.art_id 

-- Ermittlung der MWST-ID aus den Bondaten (fuehrend) 
LEFT OUTER JOIN DBP_DATA.mwst_per_2 mw
ON mw.mandant_id = p.mandant_id 
  AND p.dat BETWEEN mw.dat_von AND mw.dat_bis
  AND p.mwst_id = mw.mwst_id
  AND COALESCE(mw.mwst, 0) <> 0 

-- Ermittlung der MWST-ID aus den Stammdaten (falls in Bondaten nicht korrekt gepflegt
LEFT OUTER JOIN DBP_DATA.mwst_per_2 mws
ON mws.mandant_id = p.mandant_id 
  AND p.dat BETWEEN mws.dat_von AND mws.dat_bis
  AND COALESCE(a.mwst_id, aerf.mwst_id) = mws.mwst_id
    
-- Ermittlung des Bezugsweges (Default ist 4) aus Stammdaten
LEFT OUTER JOIN DBP_DATA.art_wup_zu_per_2  aw
ON p.mandant_id = aw.mandant_id
  AND p.wup_id = aw.wup_id
  -- Artikelnummer aus Stammdaten!!! s.o.
  -- bartosiewiczadm - cloud migration
  -- AND art_id_ = aw.art_id 
  AND COALESCE(a.art_id, erf.art_id, 0) = aw.art_id 
  AND p.dat BETWEEN aw.dat_von AND aw.dat_bis     

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,16

HAVING (menge_ <> 0 OR umsatz_netto <> 0)
;

INSERT INTO _artbew_tmp_anr
(
   art_id
  ,wg_id
  ,mandant_id
  ,dat
  ,bezugsweg_id
)
SELECT
   a.art_id
  ,w.wg_id
  ,a.mandant_id
  ,a.dat
  ,a.bezugsweg_id
FROM _artbew_tmp a

INNER JOIN DBP_DATA.art_wg_zu_per_2 w
ON a.mandant_id = w.mandant_id 
  AND a.art_id = w.art_id
  AND w.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
  AND w.arthiertyp_id = 2

GROUP BY 1,2,3,4,5
;

create volatile table _xxx as 
select t2.*
from _artbew_tmp_anr t1_2
join DBP_DATA.art_gp_wup_zu_per_2 t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
where t2.wup_id = -1
union
select t2.*
from _artbew_tmp_anr t1_2
join DBP_DATA.art_gp_wup_zu_per_2 t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
where t2.wup_id = 6906 AND (t1.mandant_id,t1.wg_id) NOT IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2  where wg_filter_id =20 group by 1,2)
union
select t2.*
from _artbew_tmp_anr t1_2
join DBP_DATA.art_gp_wup_zu_per_2 t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
where t2.wup_id = 6907 AND (t1.mandant_id,t1.wg_id) IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2  where wg_filter_id =20 group by 1,2)
;

UPDATE _artbew_tmp_anr 
SET 
   herst_id                = _herst_id                
  ,gp_id                   = _gp_id                   
  ,einkaufsorganisation_id = COALESCE(_einkaufsorganisation_id,1000)
  ,ek_brutto               = CASE WHEN _ek_brutto          IS NOT NULL THEN CAST(_ek_brutto           AS DECIMAL(18,4)) END
  ,ek_netto                = CASE WHEN _ek_netto           IS NOT NULL THEN CAST(_ek_netto            AS DECIMAL(18,4)) END
  ,ek_nettonetto           = CASE WHEN _ek_nettonetto      IS NOT NULL THEN CAST(_ek_nettonetto       AS DECIMAL(18,4)) END
  ,ek_kal_basis            = CASE WHEN _ek_kal_basis       IS NOT NULL THEN CAST(_ek_kal_basis        AS DECIMAL(18,4)) END
  ,ek_mep                  = CASE WHEN _ek_mep             IS NOT NULL THEN CAST(_ek_mep              AS DECIMAL(18,4)) END
  ,einstandspreis          = CASE WHEN _einstandspreis     IS NOT NULL THEN CAST(_einstandspreis      AS DECIMAL(18,4)) END
  ,logkostenzuschlag       = CASE WHEN _logkostenzuschlag  IS NOT NULL THEN _logkostenzuschlag                          END
  ,ek_netto_bnk            = CASE WHEN _ek_netto_bnk       IS NOT NULL THEN CAST(_ek_netto_bnk        AS DECIMAL(18,4)) END
  ,ek_netto_bnk_sachk      = CASE WHEN _ek_netto_bnk_sachk IS NOT NULL THEN CAST(_ek_netto_bnk_sachk  AS DECIMAL(18,4)) END

FROM
(
  SELECT
     t1.mandant_id                        AS _mandant_id
    ,t1.art_id                            AS _art_id
    ,t1.bezugsweg_id                      AS _bezugsweg_id
    ,t1.dat                               AS _dat
    ,COALESCE(t4.herst_id , t2.gp_id, -1) AS _herst_id
    ,COALESCE(t2.gp_id, -1)               AS _gp_id
    ,t2.einkaufsorganisation_id           AS _einkaufsorganisation_id
    ,t2.ek_brutto                         AS _ek_brutto
    ,t2.ek_netto                          AS _ek_netto
    ,t2.ek_nettonetto                     AS _ek_nettonetto
    ,t2.ek_kal_basis                      AS _ek_kal_basis
    ,t2.ek_mep                            AS _ek_mep
    ,t2.einstandspreis                    AS _einstandspreis
    ,t2.logistikkostenzuschlag            AS _logkostenzuschlag
    ,t2.ek_netto_bnk                      AS _ek_netto_bnk
    ,t2.ek_netto_bnk_sachk                AS _ek_netto_bnk_sachk
  FROM _artbew_tmp_anr t1_2
   
  -- Ermittelung potentieller ZEKP_2-Sätze für EK und GP_2
  LEFT OUTER JOIN _xxx t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
     
  -- Ermittelung der Hersteller_id
  LEFT OUTER JOIN DBP_DATA.art_gp_zu_per_2 t4
  ON t1.mandant_id = t4.mandant_id
    AND t1.art_id = t4.art_id
    AND t1.dat BETWEEN t4.dat_von AND t4.dat_bis
  
  WHERE t1.mandant_id = 1
  QUALIFY row_number() OVER (PARTITION BY _mandant_id, _art_id, _bezugsweg_id, _dat 
                            ORDER BY CASE WHEN (t1.bezugsweg_id = 1 AND t2.wup_id = -1) OR (t1.bezugsweg_id = 4 AND t2.wup_id <> -1) THEN 1 ELSE 0 END DESC --Richtiger Bezugsweg
                                     ,t2.dat_von DESC -- jüngster Satz
                                     ,CAST(t2.ek_brutto  AS DECIMAL(18,4)) DESC -- kleinster ek_brutto
                                     ,t2.gp_id -- höchte Lieferantennummer
  ) = 1

) dt1 WHERE mandant_id   = _mandant_id              
  AND art_id       = _art_id                  
  AND bezugsweg_id = _bezugsweg_id
  AND dat          = _dat                     
;

UPDATE _artbew_tmp_anr 
SET
    faktor_fg          = 1
   ,ek_brutto          = ZWGE
   ,ek_netto           = ZWGE
   ,ek_nettonetto      = ZWGM
   ,ek_kal_basis       = ZWGM
   ,ek_mep             = ZWGM
   ,einstandspreis     = ZWGS
   ,logkostenzuschlag  = 0
   ,ek_netto_bnk       = ZWGE
   ,ek_netto_bnk_sachk = ZWGM

FROM
(
  SELECT
     t0.mandant_id _mandant_id
    ,t0.art_id     _art_id
    ,t0.dat        _dat
    ,MAX(t1.ek_faktor) AS ZWGS
    ,MAX(COALESCE(t2.ek_faktor, t1.ek_faktor)) AS ZWGM
    ,MAX(COALESCE(t3.ek_faktor, t2.ek_faktor, t1.ek_faktor)) AS ZWGE
  FROM _artbew_tmp_anr t0
  
  INNER JOIN DBP_DATA.art_man_spanne_per_2 t1_2 
  ON t0.mandant_id = t1.mandant_id
    AND t0.art_id = t1.art_id
    AND t0.dat BETWEEN t1.dat_von AND t1.dat_bis
    AND t1.konditionsart_id = 'ZWGS'
    AND t1.loesch_fg = 0
  
  LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_2 t2 
  ON t0.mandant_id = t2.mandant_id
    AND t0.art_id = t2.art_id
    AND t0.dat BETWEEN t2.dat_von AND t2.dat_bis
    AND t2.konditionsart_id = 'ZWGM'
    AND t2.loesch_fg = 0
  
  LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_2 t3 
  ON t0.mandant_id = t3.mandant_id
    AND t0.art_id = t3.art_id
    AND t0.dat BETWEEN t3.dat_von AND t3.dat_bis
    AND t3.konditionsart_id ='ZWGE'
    AND t3.loesch_fg = 0
    
  GROUP BY 1,2,3
)dt1 WHERE mandant_id  = _mandant_id              
  AND art_id      = _art_id                  
  AND dat         = _dat                     
;

UPDATE _artbew_tmp

SET herst_id                =_herst_id                
  ,gp_id                    =_gp_id                   
  ,einkaufsorganisation_id  =_einkaufsorganisation_id 
  -- Wenn mit EKS aus der ZEKP_2 angereichert werden soll, so ist das "faktor_fg" NULL 
  ,ek_brutto                = COALESCE(umsatz_netto * _faktor_fg * _ek_brutto         , menge * _ek_brutto         )
  ,ek_netto                 = COALESCE(umsatz_netto * _faktor_fg * _ek_netto          , menge * _ek_netto          )
  ,ek_nettonetto            = COALESCE(umsatz_netto * _faktor_fg * _ek_nettonetto     , menge * _ek_nettonetto     )
  ,ek_kal_basis             = COALESCE(umsatz_netto * _faktor_fg * _ek_kal_basis      , menge * _ek_kal_basis      )
  ,ek_mep                   = COALESCE(umsatz_netto * _faktor_fg * _ek_mep            , menge * _ek_mep            )
  ,einstandspreis           = COALESCE(umsatz_netto * _faktor_fg * _einstandspreis    , menge * _einstandspreis    )
  ,logkostenzuschlag        = COALESCE(umsatz_netto * _faktor_fg * _logkostenzuschlag , menge * _logkostenzuschlag )
  ,ek_netto_bnk             = COALESCE(umsatz_netto * _faktor_fg * _ek_netto_bnk      , menge * _ek_netto_bnk      )
  ,ek_netto_bnk_sachk       = COALESCE(umsatz_netto * _faktor_fg * _ek_netto_bnk_sachk, menge * _ek_netto_bnk_sachk)
  ,wg_id                    =_wg_id 
            
FROM
(
  SELECT
     mandant_id               _mandant_id              
    ,art_id                   _art_id                  
    ,bezugsweg_id             _bezugsweg_id            
    ,dat                      _dat                     
    ,herst_id                 _herst_id                
    ,wg_id                    _wg_id
    ,gp_id                    _gp_id                   
    ,einkaufsorganisation_id  _einkaufsorganisation_id 
    ,ek_brutto                _ek_brutto               
    ,ek_netto                 _ek_netto                
    ,ek_nettonetto            _ek_nettonetto           
    ,ek_kal_basis             _ek_kal_basis            
    ,ek_mep                   _ek_mep                  
    ,einstandspreis           _einstandspreis          
    ,logkostenzuschlag        _logkostenzuschlag       
    ,ek_netto_bnk             _ek_netto_bnk            
    ,ek_netto_bnk_sachk       _ek_netto_bnk_sachk      
    ,faktor_fg                _faktor_fg
  FROM _artbew_tmp_anr
)t1_2 WHERE mandant_id   = _mandant_id   
  AND art_id       = _art_id       
  AND bezugsweg_id = _bezugsweg_id
  AND dat          = _dat    
;

UPDATE _artbew_tmp

SET 
   ek_brutto          = umsatz_netto * ZWGE
  ,ek_netto           = umsatz_netto * ZWGE
  ,ek_nettonetto      = umsatz_netto * ZWGM
  ,ek_kal_basis       = umsatz_netto * ZWGM
  ,ek_mep             = umsatz_netto * ZWGM
  ,einstandspreis     = umsatz_netto * ZWGS
  ,logkostenzuschlag  = 0
  ,ek_netto_bnk       = umsatz_netto * ZWGE
  ,ek_netto_bnk_sachk = umsatz_netto * ZWGM
   
FROM
(
  SELECT
     t0.mandant_id _mandant_id
    ,t0.art_id     _art_id
    ,t0.wup_id     _wup_id
    ,t0.dat        _dat
    ,MAX(t1.ek_faktor) AS ZWGS
    ,MAX(COALESCE(t2.ek_faktor, t1.ek_faktor)) AS  ZWGM
    ,MAX(COALESCE(t3.ek_faktor, t2.ek_faktor, t1.ek_faktor)) AS ZWGE
  FROM _artbew_tmp t0
  
  INNER JOIN DBP_DATA.art_wup_man_spanne_per_2 t1_2 
  ON t0.mandant_id = t1.mandant_id
    AND t0.art_id = t1.art_id
    AND t0.wup_id = t1.wup_id
    AND t0.dat BETWEEN t1.dat_von AND t1.dat_bis
    AND t1.konditionsart_id = 'ZWGS'
    AND t1.loesch_fg = 0
  
  LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_2 t2 
  ON t0.mandant_id = t2.mandant_id
    AND t0.art_id = t2.art_id
    AND t0.wup_id = t2.wup_id
    AND t0.dat BETWEEN t2.dat_von AND t2.dat_bis
    AND t2.konditionsart_id = 'ZWGM'
    AND t2.loesch_fg = 0
  
  LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_2 t3 
  ON t0.mandant_id = t3.mandant_id
    AND t0.art_id = t3.art_id
    AND t0.wup_id = t3.wup_id
    AND t0.dat BETWEEN t3.dat_von AND t3.dat_bis
    AND t3.konditionsart_id = 'ZWGE'
    AND t3.loesch_fg = 0
  
  GROUP BY 1,2,3,4
)dt1 WHERE mandant_id = _mandant_id   
  AND art_id     = _art_id       
  AND wup_id     = _wup_id 
  AND dat        = _dat    
;

UPDATE _artbew_tmp 
SET
   ek_brutto          = umsatz_netto * (CAST(_ek_brutto AS FLOAT)         / NULLIFZERO(_umsatz_netto))
  ,ek_netto           = umsatz_netto * (CAST(_ek_netto AS FLOAT)          / NULLIFZERO(_umsatz_netto))
  ,ek_nettonetto      = umsatz_netto * (CAST(_ek_nettonetto AS FLOAT)     / NULLIFZERO(_umsatz_netto))
  ,ek_kal_basis       = umsatz_netto * (CAST(_ek_kal_basis AS FLOAT)      / NULLIFZERO(_umsatz_netto))
  ,ek_mep             = umsatz_netto * (CAST(_ek_mep AS FLOAT)            / NULLIFZERO(_umsatz_netto))
  ,einstandspreis     = umsatz_netto * (CAST(_einstandspreis AS FLOAT)    / NULLIFZERO(_umsatz_netto))
  ,logkostenzuschlag  = umsatz_netto * (CAST(_logkostenzuschlag AS FLOAT) / NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk       = umsatz_netto * (CAST(_ek_netto_bnk AS FLOAT)      / NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk_sachk = umsatz_netto * (CAST(_ek_netto_bnk_sachk AS FLOAT)/ NULLIFZERO(_umsatz_netto))

FROM
(
  SELECT
     artbew.wup_id           AS _wup_id
    ,SUM(ek_brutto         ) AS _ek_brutto         
    ,SUM(ek_netto          ) AS _ek_netto          
    ,SUM(ek_nettonetto     ) AS _ek_nettonetto     
    ,SUM(ek_kal_basis      ) AS _ek_kal_basis      
    ,SUM(ek_mep            ) AS _ek_mep            
    ,SUM(einstandspreis    ) AS _einstandspreis    
    ,SUM(logkostenzuschlag ) AS _logkostenzuschlag 
    ,SUM(ek_netto_bnk      ) AS _ek_netto_bnk      
    ,SUM(ek_netto_bnk_sachk) AS _ek_netto_bnk_sachk
    ,SUM(umsatz_netto      ) AS _umsatz_netto
  FROM _artbew_tmp artbew_2

  INNER JOIN DBP_DATA.wg_filter_zu_2 AS wgfz 
	 ON	wgfz.mandant_id  = artbew.mandant_id
	AND wgfz.wg_id       = artbew.wg_id
	
  WHERE	wgfz.wg_filter_id =1
    
  GROUP BY 1
)dt1 WHERE wup_id = _wup_id
  AND (mandant_id,wg_id) in ( SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu_2 where wg_filter_id= 33 GROUP BY 1,2)
;

UPDATE _artbew_tmp 
SET
   ek_brutto          = umsatz_netto * (CAST(_ek_brutto AS FLOAT)         / NULLIFZERO(_umsatz_netto))
  ,ek_netto           = umsatz_netto * (CAST(_ek_netto AS FLOAT)          / NULLIFZERO(_umsatz_netto))
  ,ek_nettonetto      = umsatz_netto * (CAST(_ek_nettonetto AS FLOAT)     / NULLIFZERO(_umsatz_netto))
  ,ek_kal_basis       = umsatz_netto * (CAST(_ek_kal_basis AS FLOAT)      / NULLIFZERO(_umsatz_netto))
  ,ek_mep             = umsatz_netto * (CAST(_ek_mep AS FLOAT)            / NULLIFZERO(_umsatz_netto))
  ,einstandspreis     = umsatz_netto * (CAST(_einstandspreis AS FLOAT)    / NULLIFZERO(_umsatz_netto))
  ,logkostenzuschlag  = umsatz_netto * (CAST(_logkostenzuschlag AS FLOAT) / NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk       = umsatz_netto * (CAST(_ek_netto_bnk AS FLOAT)      / NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk_sachk = umsatz_netto * (CAST(_ek_netto_bnk_sachk AS FLOAT)/ NULLIFZERO(_umsatz_netto))

FROM
(
  SELECT
     artbew.wup_id           AS _wup_id
    ,SUM(ek_brutto         ) AS _ek_brutto         
    ,SUM(ek_netto          ) AS _ek_netto          
    ,SUM(ek_nettonetto     ) AS _ek_nettonetto     
    ,SUM(ek_kal_basis      ) AS _ek_kal_basis      
    ,SUM(ek_mep            ) AS _ek_mep            
    ,SUM(einstandspreis    ) AS _einstandspreis    
    ,SUM(logkostenzuschlag ) AS _logkostenzuschlag 
    ,SUM(ek_netto_bnk      ) AS _ek_netto_bnk      
    ,SUM(ek_netto_bnk_sachk) AS _ek_netto_bnk_sachk
    ,SUM(umsatz_netto      ) AS _umsatz_netto
  FROM _artbew_tmp artbew_2

  INNER JOIN DBP_DATA.wg_filter_zu_2 AS wgfz 
	 ON	wgfz.mandant_id  = artbew.mandant_id
	AND wgfz.wg_id       = artbew.wg_id
	
  WHERE	wgfz.wg_filter_id =32
    
  GROUP BY 1
)dt1 WHERE wup_id = _wup_id
  AND (mandant_id,wg_id) in 
  ( SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu_2 where wg_filter_id= 34 GROUP BY 1,2)

;

DELETE FROM DBP_DATA.artbew_2 a
WHERE a.mandant_id = 1
  AND a.dat IN
  (
    SELECT dat
    FROM DBP_ETL.bon_artbew_dat_2 
  )
  AND (a.mandant_id, a.wup_id, a.dat) IN
  (
    SELECT 
       mandant_id
      ,wup_id
      ,dat
    FROM _artbew_tmp
  )
  AND bewart_id <> 1010
;

DELETE FROM DBP_DATA.artbew_dra_2 d
WHERE d.mandant_id = 1
  AND d.dat IN
  (
    SELECT dat
    FROM DBP_ETL.bon_artbew_dat_2
  )
  AND (d.mandant_id, d.wup_id, d.dat) IN
  (
    SELECT 
       mandant_id
      ,wup_id
      ,dat
    FROM _artbew_tmp
  )
;

/*2021-09-22 mfialkiewicz adding missing scripts after migration*/
--START
INSERT INTO DBP_DATA.artbew_dra_2
(
        wup_id
        ,mandant_id
        ,bewart_id
        ,gp_id
        ,nb_id
        ,art_id
        ,ean_kasse
        ,dat
        ,aktion_id
        ,wrg_2
        ,menge
        ,umsatz_netto
        ,umsatz_mwst_betrag
)
        SELECT
                wup_id
                ,mandant_id
                ,bewart_id
                ,gp_id
                ,nb_id
                ,art_id
                ,ean_kasse
                ,dat
                ,aktion_id
                ,wrg_2
                ,menge_
                ,umsatz_netto_
                ,umsatz_mwst_betrag_
        FROM
(
        SELECT
                wup_id
                ,a.mandant_id
                ,bewart_id
                ,COALESCE(gp_id,-1) gp_id
                ,nb_id
                ,a.art_id
                ,ean_kasse
                ,dat
                ,aktion_id
                ,wrg_2
                ,SUM(menge             ) AS menge_
                ,SUM(umsatz_netto      ) AS umsatz_netto_
                ,SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_
        FROM _artbew_tmp a

        INNER JOIN DBP_DATA.art_wg_zu_per_2 w
        ON a.mandant_id = w.mandant_id
        AND a.art_id = w.art_id

        INNER JOIN DBP_DATA.wg_filter_zu_2 AS wgfz
        ON wgfz.mandant_id    = w.mandant_id
        AND wgfz.arthiertyp_id = w.arthiertyp_id
        AND wgfz.wg_id         = w.wg_id

        WHERE w.arthiertyp_id   = 2
        AND w.dat_bis         = to_date('9999-12-31','YYYY-MM_2-DD')
        AND wgfz.wg_filter_id = 9 
--WG Spenden fuer Aktion_2 Deutschland rundet auf
GROUP BY
        wup_id
        ,a.mandant_id
        ,bewart_id
        ,COALESCE(gp_id,-1)
        ,nb_id
        ,a.art_id
        ,ean_kasse
        ,dat
        ,aktion_id
        ,wrg_2
) a;
--END



DELETE FROM _artbew_tmp

WHERE (mandant_id, art_id) IN 
  (
     SELECT 
        awzp.mandant_id
       ,awzp.art_id
     FROM DBP_DATA.art_wg_zu_per_2 awzp
	 
     INNER JOIN DBP_DATA.wg_filter_zu_2 AS wgfz 
	    ON wgfz.mandant_id    = awzp.mandant_id
       AND wgfz.arthiertyp_id = awzp.arthiertyp_id
       AND wgfz.wg_id         = awzp.wg_id
     
     WHERE awzp.arthiertyp_id = 2
       AND awzp.dat_bis       = to_date('9999-12-31','YYYY-MM_2-DD') 
       AND wgfz.wg_filter_id  = 9 /*WG Spenden fuer Aktion_2 Deutschland rundet auf*/	
	 
	 GROUP BY awzp.mandant_id
           ,awzp.art_id
  )
;

INSERT INTO DBP_DATA.artbew_2
(
   art_id
  ,wup_id
  ,mandant_id
  ,bewart_id
  ,gp_id
  ,einkaufsorganisation_id
  ,nb_id
  ,dat
  ,herst_id
  ,mwst_id
  ,menge
  ,wrg_2
  ,umsatz_netto
  ,umsatz_mwst_betrag
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logkostenzuschlag
  ,bezugsweg_id
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,posten_id
  ,aktion_id
  ,ean_kasse
  ,bewart_det_id
  ,promo_fg
)
SELECT
   art_id
  ,wup_id
  ,mandant_id
  ,bewart_id
  ,gp_id
  ,einkaufsorganisation_id
  ,nb_id
  ,dat
  ,herst_id
  ,mwst_id
  ,menge_
  ,wrg_2
  ,umsatz_netto_
  ,umsatz_mwst_betrag_
  ,COALESCE(ek_brutto_     , 0) 
  ,COALESCE(ek_netto_      , 0) 
  ,COALESCE(ek_nettonetto_ , 0) 
  ,COALESCE(ek_kal_basis_  , 0) 
  ,COALESCE(ek_mep_        , 0) 
  ,COALESCE(einstandspreis_, 0) 
  ,COALESCE(logkostenzuschlag_, 0)
  ,bezugsweg_id
  ,COALESCE(ek_netto_bnk_      , 0) 
  ,COALESCE(ek_netto_bnk_sachk_, 0) 
  ,posten_id
  ,aktion_id
  ,ean_kasse
  ,bewart_det_id
  ,promo_fg 
FROM
(
  SELECT
     art_id
    ,wup_id
    ,mandant_id
    ,bewart_id
    ,COALESCE(gp_id, -1)                     AS gp_id
    ,COALESCE(einkaufsorganisation_id, 1000) AS einkaufsorganisation_id
    ,nb_id
    ,dat
    ,COALESCE(herst_id,-1)              AS herst_id
    ,mwst_id
    ,SUM(menge)                         AS menge_
    ,wrg_2
    ,SUM(umsatz_netto                 ) AS umsatz_netto_
    ,SUM(umsatz_mwst_betrag           ) AS umsatz_mwst_betrag_
    ,SUM(ek_brutto                    ) AS ek_brutto_
    ,SUM(ek_netto                     ) AS ek_netto_
    ,SUM(ek_nettonetto                ) AS ek_nettonetto_
    ,SUM(ek_kal_basis                 ) AS ek_kal_basis_
    ,SUM(ek_mep                       ) AS ek_mep_
    ,SUM(einstandspreis               ) AS einstandspreis_
    ,SUM(logkostenzuschlag            ) AS logkostenzuschlag_
    ,bezugsweg_id
    ,SUM(ek_netto_bnk                 ) AS ek_netto_bnk_
    ,SUM(ek_netto_bnk_sachk           ) AS ek_netto_bnk_sachk_
    ,posten_id
    ,aktion_id
    ,ean_kasse
    ,bewart_det_id
    ,CASE WHEN bewart_det_id IN (100220, 100221, 100231, 100241) THEN 1 ELSE 0 END AS promo_fg
  FROM _artbew_tmp

  GROUP BY
     art_id
    ,wup_id
    ,mandant_id
    ,bewart_id
    ,gp_id
    ,einkaufsorganisation_id
    ,nb_id
    ,dat
    ,herst_id
    ,mwst_id
    ,wrg_2
    ,bezugsweg_id
    ,posten_id
    ,aktion_id
    ,ean_kasse
    ,bewart_det_id
) a
;

--DROP TABLE IF EXISTS DBP_ETL.artbew_agg_tmp_2; moved to _003 script

/*2021-09-22 mfialkiewicz adding missing scripts after migration*/
--START
/*
#------------------------------------------------------------------------------
# 12.) Nach Erfolgreicher Verarbeitung RFI bereinigen und Talons als verarbeitet
#      kennzeichnen
#------------------------------------------------------------------------------
*/
-- Kennzeichnen, welche Talons verarbeitet wurden.
UPDATE dbp_ods.ods_talon_det_2
SET artbew_fg = 1

WHERE (mandant_id, wup_id, talon_id) IN
(
        SELECT
                mandant_id
                ,wup_id
                ,talon_id
        FROM dbp_etl.bon_artbew_tmp_talon_2
)
;

UPDATE dbp_ods.ods_talon_det_2
SET artbew_fg = 1

WHERE (mandant_id, wup_id, talon_id) IN
(
        SELECT
                mandant_id
                ,wup_id
                ,talon_id
        FROM dbp_etl.bon_talon_fix_2
)
;

/*
#------------------------------------------------------------------------------
# 13.) Aktualisiern der Tabelle DBP_DATA.artbew_coupon_zu
#------------------------------------------------------------------------------
*/

DELETE FROM DBP_DATA.artbew_coupon_zu

WHERE (mandant_id, wup_id, dat) IN 
--ganzen Markttag ersetzen
(
SELECT
mandant_id
,wup_id
,dat
FROM dbp_etl.artbew_coupon_zu_tmp_2
)
;

INSERT INTO DBP_DATA.artbew_coupon_zu
(
mandant_id
,wup_id
,nb_id
,dat
,art_id
,coupon_kz
,coupon_menge
,betrag_coupon_netto
,betrag_coupon_mwst
)
SELECT
mandant_id
,wup_id
,nb_id
,dat
,art_id
,coupon_kz
,coupon_menge
,betrag_coupon_netto
,betrag_coupon_mwst
FROM dbp_etl.artbew_coupon_zu_tmp_2
;




