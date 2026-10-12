set (rb_date) = (SELECT MIN(t1.dat) AS dat
                 FROM dbp_data.tag_2 t1_2
                 WHERE t1.dat < CURRENT_DATE AND
                      (t1.kj = EXTRACT(YEAR FROM CURRENT_DATE) OR
                      (t1.kj =EXTRACT(YEAR FROM CURRENT_DATE)-1 AND
                       2 = EXTRACT(MONTH FROM CURRENT_DATE))))
;

set (rb_month) = (SELECT MIN(t1.kjmo) AS kjmo
                  FROM dbp_data.tag_2 t1_2
                  WHERE t1.dat < CURRENT_DATE AND
                       (t1.kj = EXTRACT(YEAR FROM CURRENT_DATE) OR
                       (t1.kj =EXTRACT(YEAR FROM CURRENT_DATE)-1 AND
                        2 = EXTRACT(MONTH FROM CURRENT_DATE))))
;

CREATE OR REPLACE VOLATILE TABLE _artbew_tmp (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      mandant_id SMALLINT NOT NULL,
      bewart_id SMALLINT NOT NULL,
      gp_id INTEGER,
      einkaufsorganisation_id SMALLINT,
      nb_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      aktion_id VARCHAR(10) collate 'en-ci' NOT NULL,
      herst_id INTEGER,
      wg_id INTEGER,
      mwst_id SMALLINT,
      menge DECIMAL(18,4) ,
      wrg_2 VARCHAR(3) collate 'en-ci',
      umsatz_netto DECIMAL(18,4),
      umsatz_mwst_betrag DECIMAL(18,4),
      ek_brutto DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_nettonetto DECIMAL(18,4),
      ek_kal_basis DECIMAL(18,4),
      ek_mep DECIMAL(18,4),
      einstandspreis DECIMAL(18,4),
      logkostenzuschlag DECIMAL(18,4),
      bezugsweg_id SMALLINT,
      ek_netto_bnk DECIMAL(18,4),
      ek_netto_bnk_sachk DECIMAL(18,4),
      posten_id VARCHAR(2) collate 'en-cs',
      ean_kasse DECIMAL(26,0),
      bewart_det_id INT NOT NULL,
      promo_fg INT NOT NULL
);

INSERT INTO _artbew_tmp (mandant_id
                       , wrg_2
                       , wup_id
                       , nb_id
                       , dat
                       , gp_id
                       , herst_id
                       , einkaufsorganisation_id
                       , posten_id
                       , ean_kasse
                       , bezugsweg_id
                       , art_id
                       , bewart_id
                       , mwst_id
                       , aktion_id
                       , menge
                       , umsatz_netto
                       , umsatz_mwst_betrag
                       , bewart_det_id
                       , promo_fg)
SELECT a.mandant_id
     , a.wrg_2
     , a.wup_id
     , a.nb_id
     , a.dat
     , a.gp_id
     , a.herst_id
     , a.einkaufsorganisation_id
     , a.posten_id
     , a.ean_kasse
     , COALESCE(b.bezugsweg_id,a.bezugsweg_id) AS bezugsweg_id
     , a.art_id
     , a.bewart_id
     , a.mwst_id
     , a.aktion_id
     , a.menge
     , a.umsatz_netto
     , a.umsatz_mwst_betrag
     , a.bewart_det_id
     , a.promo_fg
FROM DBP_DATA.artbew_2 a
LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  art_id,
                  dat_von,
                  dat_bis,
                  bezugsweg_id
           FROM DBP_DATA.art_wup_zu_per_2
           WHERE mandant_id = 1
             AND dat_bis >= $rb_date
           ) b
  ON a.wup_id = b.wup_id AND
     a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.dat BETWEEN b.dat_von AND b.dat_bis
WHERE a.mandant_id = 1
  AND a.dat >= $rb_date
;

/*
_------------------------------------------------------------------------------
_ 2.) Anreicherung der DBP_LOAD.artbew_tmp1 um
        - eks, gp_id, herst_id, EK-Org
_------------------------------------------------------------------------------
*/

CREATE OR REPLACE VOLATILE TABLE _artbew_tmp_anr (
      art_id INTEGER NOT NULL,
      mandant_id SMALLINT NOT NULL,
      gp_id INTEGER,
      faktor_fg SMALLINT,
      wg_id INTEGER,
      einkaufsorganisation_id SMALLINT,
      dat DATE NOT NULL,
      herst_id INTEGER,
      zekp_dat_von DATE,
      ek_brutto DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      ek_nettonetto DECIMAL(18,4),
      ek_kal_basis DECIMAL(18,4),
      ek_mep DECIMAL(18,4),
      einstandspreis DECIMAL(18,4),
      logkostenzuschlag DECIMAL(18,4),
      bezugsweg_id SMALLINT,
      ek_netto_bnk DECIMAL(18,4),
      ek_netto_bnk_sachk DECIMAL(18,4)
);

/*
_------------------------------------------------------------------------------
_ 2.1) DISTINCT auf Bezugswegebene, um Verschlüsselungsoperationen zu vermeiden
_------------------------------------------------------------------------------
*/

INSERT INTO _artbew_tmp_anr
(
 art_id
,wg_id
,mandant_id
,dat
,bezugsweg_id
)
SELECT
 t1.art_id
,t2.wg_id
,t1.mandant_id
,t1.dat
,t1.bezugsweg_id
FROM _artbew_tmp t1_2
INNER JOIN DBP_DATA.art_wg_zu_per_2 t2
ON t1.art_id=t2.art_id
AND t2.dat_bis='9999-12-31'
AND t2.mandant_id=1
AND t2.arthiertyp_id=2
GROUP BY 1,2,3,4,5;

/*
_------------------------------------------------------------------------------
_ 2.2) Ermittlung der ZEKP_2-Sätze
_------------------------------------------------------------------------------
*/

create or replace volatile table _xxx as 
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
    herst_id                =_herst_id                
   ,gp_id                   =_gp_id                   
   ,einkaufsorganisation_id =COALESCE(_einkaufsorganisation_id,1000)
   ,ek_brutto               =CASE WHEN _ek_brutto          IS NOT NULL THEN CAST( (_ek_brutto  )          AS DECIMAL(18,4)) END
   ,ek_netto                =CASE WHEN _ek_netto           IS NOT NULL THEN CAST( (_ek_netto  )           AS DECIMAL(18,4)) END
   ,ek_nettonetto           =CASE WHEN _ek_nettonetto      IS NOT NULL THEN CAST( (_ek_nettonetto  )      AS DECIMAL(18,4)) END
   ,ek_kal_basis            =CASE WHEN _ek_kal_basis       IS NOT NULL THEN CAST( (_ek_kal_basis  )       AS DECIMAL(18,4)) END
   ,ek_mep                  =CASE WHEN _ek_mep             IS NOT NULL THEN CAST( (_ek_mep  )             AS DECIMAL(18,4)) END
   ,einstandspreis          =CASE WHEN _einstandspreis     IS NOT NULL THEN CAST( (_einstandspreis  )     AS DECIMAL(18,4)) END
   ,logkostenzuschlag       =CASE WHEN _logkostenzuschlag  IS NOT NULL THEN _logkostenzuschlag                                                END
   ,ek_netto_bnk            =CASE WHEN _ek_netto_bnk       IS NOT NULL THEN CAST( (_ek_netto_bnk  )       AS DECIMAL(18,4)) END
   ,ek_netto_bnk_sachk      =CASE WHEN _ek_netto_bnk_sachk IS NOT NULL THEN CAST( (_ek_netto_bnk_sachk  ) AS DECIMAL(18,4)) END
   
FROM
(
SELECT
t1.mandant_id                 _mandant_id
,t1.art_id                    _art_id
,t1.bezugsweg_id              _bezugsweg_id
,t1.dat                       _dat
,COALESCE(t4.herst_id,t2.gp_id,-1)    _herst_id
,COALESCE(t2.gp_id,-1)        _gp_id
,t2.einkaufsorganisation_id   _einkaufsorganisation_id
,t2.ek_brutto                 _ek_brutto
,t2.ek_netto                  _ek_netto
,t2.ek_nettonetto             _ek_nettonetto
,t2.ek_kal_basis              _ek_kal_basis
,t2.ek_mep                    _ek_mep
,t2.einstandspreis            _einstandspreis
,t2.logistikkostenzuschlag    _logkostenzuschlag
,t2.ek_netto_bnk              _ek_netto_bnk
,t2.ek_netto_bnk_sachk        _ek_netto_bnk_sachk
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
 
 -- Filterung des am besten passenden ZEKP_2-Satzes
 QUALIFY row_number() OVER (PARTITION BY _mandant_id, _art_id, _bezugsweg_id, _dat 
                            ORDER BY CASE WHEN (t1.bezugsweg_id = 1 AND t2.wup_id = -1) OR (t1.bezugsweg_id = 4 AND t2.wup_id <> -1) THEN 1 ELSE 0 END DESC --Richtiger Bezugsweg
                                     ,t2.dat_von DESC -- jüngster Satz
                                     ,CAST(t2.ek_brutto  AS DECIMAL(18,4)) DESC -- kleinster ek_brutto
                                     ,t2.gp_id -- höchte Lieferantennummer
  ) = 1
) dt1
   
WHERE mandant_id  = _mandant_id              
AND   art_id      = _art_id                  
AND   bezugsweg_id= _bezugsweg_id
AND   dat         = _dat                     
;

/*
_------------------------------------------------------------------------------
_ 2.4) Update der manuellen Spannen auf Artikelniveau
_------------------------------------------------------------------------------
*/

UPDATE _artbew_tmp_anr 
SET
    faktor_fg               =1
   ,ek_brutto               =ZWGE
   ,ek_netto                =ZWGE
   ,ek_nettonetto           =ZWGM
   ,ek_kal_basis            =ZWGM
   ,ek_mep                  =ZWGM
   ,einstandspreis          =ZWGS
   ,logkostenzuschlag       =0
   ,ek_netto_bnk            =ZWGE
   ,ek_netto_bnk_sachk      =ZWGM

FROM
(
SELECT
  t0.mandant_id _mandant_id
  ,t0.art_id    _art_id
  ,t0.dat       _dat
  ,max(t1.ek_faktor) AS ZWGS
  ,max(COALESCE(t2.ek_faktor,t1.ek_faktor)) AS  ZWGM
  ,max(COALESCE(t3.ek_faktor,t2.ek_faktor,t1.ek_faktor)) AS  ZWGE
FROM _artbew_tmp_anr t0
INNER JOIN DBP_DATA.art_man_spanne_per_2 t1_2 
ON t0.mandant_id=t1.mandant_id
AND t0.art_id=t1.art_id
AND t0.dat BETWEEN t1.dat_von AND t1.dat_bis
AND t1.konditionsart_id='ZWGS'
AND t1.loesch_fg = 0
LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_2 t2 
ON t0.mandant_id=t2.mandant_id
AND t0.art_id=t2.art_id
AND t0.dat BETWEEN t2.dat_von AND t2.dat_bis
AND t2.konditionsart_id='ZWGM'
AND t2.loesch_fg = 0
LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_2 t3 
ON t0.mandant_id=t3.mandant_id
AND t0.art_id=t3.art_id
AND t0.dat BETWEEN t3.dat_von AND t3.dat_bis
AND t3.konditionsart_id='ZWGE'
AND t3.loesch_fg = 0
GROUP BY 1,2,3
)dt1

WHERE mandant_id  = _mandant_id              
AND   art_id      = _art_id                  
AND   dat         = _dat                     
;

/*
_------------------------------------------------------------------------------
_ 3.) Update der Umsätze
_------------------------------------------------------------------------------
*/

UPDATE _artbew_tmp

SET herst_id                  =_herst_id                
    ,gp_id                    =_gp_id                   
    ,einkaufsorganisation_id  =_einkaufsorganisation_id 
    -- Wenn mit EKS aus der ZEKP_2 angereichert werden soll, so ist das "faktor_fg" NULL 
    ,ek_brutto                = COALESCE(umsatz_netto*_faktor_fg*_ek_brutto           ,menge*_ek_brutto           )
    ,ek_netto                 = COALESCE(umsatz_netto*_faktor_fg*_ek_netto            ,menge*_ek_netto            )
    ,ek_nettonetto            = COALESCE(umsatz_netto*_faktor_fg*_ek_nettonetto       ,menge*_ek_nettonetto       )
    ,ek_kal_basis             = COALESCE(umsatz_netto*_faktor_fg*_ek_kal_basis        ,menge*_ek_kal_basis        )
    ,ek_mep                   = COALESCE(umsatz_netto*_faktor_fg*_ek_mep              ,menge*_ek_mep              )
    ,einstandspreis           = COALESCE(umsatz_netto*_faktor_fg*_einstandspreis      ,menge*_einstandspreis      )
    ,logkostenzuschlag        = COALESCE(umsatz_netto*_faktor_fg*_logkostenzuschlag   ,menge*_logkostenzuschlag   )
    ,ek_netto_bnk             = COALESCE(umsatz_netto*_faktor_fg*_ek_netto_bnk        ,menge*_ek_netto_bnk        )
    ,ek_netto_bnk_sachk       = COALESCE(umsatz_netto*_faktor_fg*_ek_netto_bnk_sachk  ,menge*_ek_netto_bnk_sachk  )
    ,wg_id                    =_wg_id         
    
FROM
(SELECT
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
FROM
  _artbew_tmp_anr
)t1_2
    
WHERE mandant_id  = _mandant_id   
AND   art_id      = _art_id       
AND   bezugsweg_id= _bezugsweg_id
AND   dat         = _dat    
;      

/*
_------------------------------------------------------------------------------
_ 4.) Update der Umsätze mit manuellen Spannen auf Marktebene
_------------------------------------------------------------------------------
*/

UPDATE _artbew_tmp

SET 
    ek_brutto               =umsatz_netto*ZWGE
   ,ek_netto                =umsatz_netto*ZWGE
   ,ek_nettonetto           =umsatz_netto*ZWGM
   ,ek_kal_basis            =umsatz_netto*ZWGM
   ,ek_mep                  =umsatz_netto*ZWGM
   ,einstandspreis          =umsatz_netto*ZWGS
   ,logkostenzuschlag       =0
   ,ek_netto_bnk            =umsatz_netto*ZWGE
   ,ek_netto_bnk_sachk      =umsatz_netto*ZWGM
   
FROM
(
SELECT
  t0.mandant_id _mandant_id
  ,t0.art_id    _art_id
  ,t0.wup_id    _wup_id
  ,t0.dat       _dat
  ,max(t1.ek_faktor) AS ZWGS
  ,max(COALESCE(t2.ek_faktor,t1.ek_faktor)) AS  ZWGM
  ,max(COALESCE(t3.ek_faktor,t2.ek_faktor,t1.ek_faktor)) AS  ZWGE
FROM _artbew_tmp t0
INNER JOIN DBP_DATA.art_wup_man_spanne_per_2 t1_2 
ON t0.mandant_id=t1.mandant_id
AND t0.art_id=t1.art_id
AND t0.wup_id=t1.wup_id
AND t0.dat BETWEEN t1.dat_von AND t1.dat_bis
AND t1.konditionsart_id='ZWGS'
AND t1.loesch_fg = 0
LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_2 t2 
ON t0.mandant_id=t2.mandant_id
AND t0.art_id=t2.art_id
AND t0.wup_id=t2.wup_id
AND t0.dat BETWEEN t2.dat_von AND t2.dat_bis
AND t2.konditionsart_id='ZWGM'
AND t2.loesch_fg = 0
LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_2 t3 
ON t0.mandant_id=t3.mandant_id
AND t0.art_id=t3.art_id
AND t0.wup_id=t3.wup_id
AND t0.dat BETWEEN t3.dat_von AND t3.dat_bis
AND t3.konditionsart_id='ZWGE'
AND t3.loesch_fg = 0
GROUP BY 1,2,3,4
)dt1
   
WHERE mandant_id  = _mandant_id   
AND   art_id      = _art_id       
AND   wup_id      = _wup_id 
AND   dat         = _dat    
;      

/*
_------------------------------------------------------------------------------
_ 5.) Fremdsortiment
       WG96:  hier wird die Durchschnittsspanne aller Artikel_2 mit EKs der WG 4 
_             bis 51 (Food) für den aktuellen Tag_2 ermittelt und jeder Artikel_2 
_             der WG 96 damit angereichert.
_      WG97:  wie WG 96, mit dem Unterschied, dass es sich um Non-Food handelt
_             und die Warengruppen 52 bis 94 zur Ermittlung der Spanne betrifft.
_------------------------------------------------------------------------------
*/

UPDATE _artbew_tmp 

SET
  ek_brutto=umsatz_netto*(CAST(_ek_brutto as float)/NULLIFZERO(_umsatz_netto))
  ,ek_netto=umsatz_netto*(CAST(_ek_netto as float)/NULLIFZERO(_umsatz_netto))
  ,ek_nettonetto=umsatz_netto*(CAST(_ek_nettonetto as float)/NULLIFZERO(_umsatz_netto))
  ,ek_kal_basis=umsatz_netto*(CAST(_ek_kal_basis as float)/NULLIFZERO(_umsatz_netto))
  ,ek_mep=umsatz_netto*(CAST(_ek_mep as float)/NULLIFZERO(_umsatz_netto))
  ,einstandspreis=umsatz_netto*(CAST(_einstandspreis as float)/NULLIFZERO(_umsatz_netto))
  ,logkostenzuschlag=umsatz_netto*(CAST(_logkostenzuschlag as float)/NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk=umsatz_netto*(CAST(_ek_netto_bnk as float)/NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk_sachk=umsatz_netto*(CAST(_ek_netto_bnk_sachk as float)/NULLIFZERO(_umsatz_netto))

FROM
(
SELECT
    wup_id                  _wup_id
   ,SUM(ek_brutto         ) _ek_brutto         
   ,SUM(ek_netto          ) _ek_netto          
   ,SUM(ek_nettonetto     ) _ek_nettonetto     
   ,SUM(ek_kal_basis      ) _ek_kal_basis      
   ,SUM(ek_mep            ) _ek_mep            
   ,SUM(einstandspreis    ) _einstandspreis    
   ,SUM(logkostenzuschlag ) _logkostenzuschlag 
   ,SUM(ek_netto_bnk      ) _ek_netto_bnk      
   ,SUM(ek_netto_bnk_sachk) _ek_netto_bnk_sachk
   ,SUM(umsatz_netto      ) _umsatz_netto
 FROM _artbew_tmp artbew_2

  INNER JOIN DBP_DATA.wg_filter_zu_2 AS wgfz 
	 ON	wgfz.mandant_id  = artbew.mandant_id
	AND wgfz.wg_id       = artbew.wg_id
	
  WHERE	wgfz.wg_filter_id = 1
    
  GROUP BY 1
)dt1

WHERE wup_id = _wup_id
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
)dt1

WHERE wup_id = _wup_id
  AND (mandant_id,wg_id) in ( SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu_2 where wg_filter_id= 34 GROUP BY 1,2)

;

/*
_------------------------------------------------------------------------------
_ 7.4.) Befuellen der temporaeren Tabelle DBP_ETL.artbew_wg_tp2_sum_rb
_------------------------------------------------------------------------------
*/

DELETE FROM DBP_DATA.artbew_wg_tp2_sum_2
WHERE dat >= $rb_date
AND mandant_id = 1
;

INSERT INTO DBP_DATA.artbew_wg_tp2_sum_2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,wg_id
  ,arthiertyp_id
  ,dat
  ,bewart_id
  ,posten_id
  ,bewart_det_id  
  ,menge
  ,menge_ohne_wg_erf_art
  ,umsatz_netto
  ,umsatz_mwst_betrag
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT
   t1.mandant_id
  ,t1.wup_id
  ,t1.nb_id
  ,t3.wg_id
  ,2 arthiertyp_id
  ,t1.dat
  ,t1.bewart_id
  ,t1.posten_id
  ,t1.bewart_det_id  
  ,SUM(t1.menge)
  ,SUM(CASE WHEN t2.wg_art_fg = 0 THEN menge ELSE 0 END) AS menge_ohne_wg_erf_art
  ,SUM(t1.umsatz_netto)
  ,SUM(t1.umsatz_mwst_betrag)
  ,SUM(t1.ek_brutto                   )
  ,SUM(t1.ek_netto                    )
  ,SUM(t1.ek_nettonetto               )
  ,SUM(t1.ek_kal_basis                )
  ,SUM(t1.ek_mep                      )
  ,SUM(t1.einstandspreis              )
  ,SUM(t1.logkostenzuschlag           )
  ,SUM(t1.ek_netto_bnk                )
  ,SUM(t1.ek_netto_bnk_sachk          )

FROM _artbew_tmp t1_2

INNER JOIN DBP_DATA.art_2 t2
ON t1.art_id = t2.art_id
  AND t1.mandant_id = t2.mandant_id
INNER JOIN DBP_DATA.art_wg_zu_per_2 t3
ON t1.art_id = t3.art_id
  AND t1.mandant_id = t3.mandant_id
  AND t3.dat_bis = '9999-12-31'
  AND t3.arthiertyp_id=2
GROUP BY 1,2,3,4,5,6,7,8,9
;

/*
_------------------------------------------------------------------------------
_ 7.6.) Befuellen der temporaeren Tabelle DBP_ETL.artbew_wg_sum_tp2_rb
_------------------------------------------------------------------------------
*/

DELETE FROM DBP_PROCESS.artbew_wg_sum_tp2_2
WHERE dat >= $rb_date
AND mandant_id = 1
;

INSERT INTO DBP_PROCESS.artbew_wg_sum_tp2_2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,wg_id
  ,wg_art_fg
  ,dat
  ,posten_id
  ,menge
  ,umsatz_netto
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT
   t1.mandant_id
  ,t1.wup_id
  ,t1.nb_id
  ,t2.wg_id
  ,t3.wg_art_fg
  ,t1.dat
  ,t1.posten_id
  ,SUM(t1.menge               )
  ,SUM(t1.umsatz_netto        )
  ,SUM(t1.ek_brutto           )
  ,SUM(t1.ek_netto            )
  ,SUM(t1.ek_nettonetto       )
  ,SUM(t1.ek_kal_basis        )
  ,SUM(t1.ek_mep              )
  ,SUM(t1.einstandspreis      )
  ,SUM(t1.logkostenzuschlag   )
  ,SUM(t1.ek_netto_bnk        )
  ,SUM(t1.ek_netto_bnk_sachk  )
FROM _artbew_tmp t1_2
INNER JOIN DBP_DATA.art_wg_zu_per_2 t2
ON t1.art_id = t2.art_id
  AND t1.mandant_id = t2.mandant_id
  AND t2.dat_bis = '9999-12-31'
  AND t2.arthiertyp_id=1
INNER JOIN DBP_DATA.art_2 t3
ON t1.art_id = t3.art_id
  AND t1.mandant_id = t3.mandant_id

GROUP BY
   t1.mandant_id
  ,t1.wup_id
  ,t1.nb_id
  ,t2.wg_id
  ,t3.wg_art_fg
  ,t1.dat
  ,t1.posten_id
;

DELETE FROM DBP_DATA.artbew_wg_mo_sum_2
WHERE kjmo >= $rb_date
  AND mandant_id = 1
;

INSERT INTO DBP_DATA.artbew_wg_mo_sum_2
(
   arthiertyp_id
  ,bewart_id
  ,bewart_det_id
  ,wg_id
  ,wup_id
  ,posten_id
  ,mandant_id
  ,nb_id
  ,kjmo
  ,menge
  ,umsatz_netto
  ,umsatz_mwst_betrag
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT
   arthiertyp_id
  ,bewart_id
  ,bewart_det_id
  ,wg_id
  ,wup_id
  ,posten_id
  ,mandant_id
  ,nb_id
  ,to_number(to_char(dat,'yyyymm')) AS kjmo
  ,SUM(menge                        )
  ,SUM(umsatz_netto                 )
  ,SUM(umsatz_mwst_betrag           )
  ,SUM(ek_brutto                    )
  ,SUM(ek_netto                     )
  ,SUM(ek_nettonetto                )
  ,SUM(ek_kal_basis                 )
  ,SUM(ek_mep                       )
  ,SUM(einstandspreis               )
  ,SUM(logkostenzuschlag            )
  ,SUM(ek_netto_bnk                 )
  ,SUM(ek_netto_bnk_sachk           )
FROM DBP_DATA.artbew_wg_tp2_sum_2 t1_2

WHERE t1.dat >= $rb_date
  AND t1.mandant_id = 1
  
GROUP BY
   bewart_id
  ,bewart_det_id
  ,arthiertyp_id
  ,wg_id
  ,wup_id
  ,posten_id
  ,mandant_id
  ,nb_id
  ,kjmo
;

INSERT INTO DBP_DATA.artbew_wg_mo_sum_2
(
   arthiertyp_id
  ,bewart_id
  ,bewart_det_id  
  ,wg_id
  ,wup_id
  ,posten_id
  ,mandant_id
  ,nb_id
  ,kjmo
  ,menge
  ,umsatz_netto
  ,umsatz_mwst_betrag
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT
   1 arthiertyp_id
  ,bewart_id
  ,bewart_det_id  
  ,wg_id/10
  ,wup_id
  ,posten_id
  ,mandant_id
  ,nb_id
  ,kjmo
  ,SUM(menge                       )
  ,SUM(umsatz_netto                )
  ,SUM(umsatz_mwst_betrag          )
  ,SUM(ek_brutto                   )
  ,SUM(ek_netto                    )
  ,SUM(ek_nettonetto               )
  ,SUM(ek_kal_basis                )
  ,SUM(ek_mep                      )
  ,SUM(einstandspreis              )
  ,SUM(logkostenzuschlag           )
  ,SUM(ek_netto_bnk                )
  ,SUM(ek_netto_bnk_sachk          )
FROM DBP_DATA.artbew_wg_mo_sum_2 t1_2

WHERE t1.kjmo >= $rb_month
  AND t1.mandant_id = 1
  
GROUP BY
   bewart_id
  ,bewart_det_id   
  ,arthiertyp_id
  ,wg_id/10
  ,wup_id
  ,posten_id
  ,mandant_id
  ,nb_id
  ,kjmo
;

/*
_------------------------------------------------------------------------------
_ 8.6.) Befuellen der temporaeren Tabelle DBP_ETL.artbew_mo_sum_rb
_------------------------------------------------------------------------------
*/

DELETE FROM DBP_DATA.artbew_mo_sum_2
WHERE kjmo >= $rb_month
AND mandant_id = 1;

INSERT INTO DBP_DATA.artbew_mo_sum_2
(
   art_id
  ,wup_id
  ,kjmo
  ,mandant_id
  ,bewart_id
  ,bewart_det_id  
  ,nb_id
  ,gp_id
  ,posten_id
  ,herst_id
  ,menge
  ,umsatz_netto
  ,umsatz_mwst_betrag
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT
   art_id
  ,wup_id
  ,to_number(to_char(dat,'yyyymm')) AS kjmo
  ,mandant_id
  ,bewart_id
  ,bewart_det_id  
  ,nb_id
  ,gp_id
  ,posten_id
  ,MAX(herst_id)
  ,SUM(menge                       )
  ,SUM(umsatz_netto                )
  ,SUM(umsatz_mwst_betrag          )
  ,SUM(ek_brutto                   )
  ,SUM(ek_netto                    )
  ,SUM(ek_nettonetto               )
  ,SUM(ek_kal_basis                )
  ,SUM(ek_mep                      )
  ,SUM(einstandspreis              )
  ,SUM(logkostenzuschlag           )
  ,SUM(ek_netto_bnk                )
  ,SUM(ek_netto_bnk_sachk          )
FROM _artbew_tmp t1_2

WHERE t1.dat >= $rb_date
  AND t1.mandant_id = 1

GROUP BY
   art_id
  ,wup_id
  ,nb_id
  ,kjmo
  ,mandant_id
  ,bewart_id
  ,bewart_det_id  
  ,gp_id
  ,posten_id
;

/*
_------------------------------------------------------------------------------
_ 8.) Delete und Insert der rückbewerteten Eks für die Tabelle artbew_gp_sum_2
_------------------------------------------------------------------------------
*/

DELETE FROM DBP_DATA.artbew_gp_sum_2
WHERE dat >= $rb_date
  AND mandant_id = 1
;

INSERT INTO DBP_DATA.artbew_gp_sum_2
(
   mandant_id
  ,gp_id
  ,vw_id
  ,dat
  ,wrg_2
  ,umsatz_netto
  ,ek_mep
)
SELECT
   t1.mandant_id
  ,t1.gp_id
  ,t2.vw_id
  ,t1.dat
  ,t1.wrg_2
  ,SUM (t1.umsatz_netto)         AS umsatz_netto
  ,SUM (COALESCE(t1.ek_mep, 0))  AS ek_mep
FROM _artbew_tmp t1_2

INNER JOIN DBP_DATA.wup_2 t2
ON t1.wup_id = t2.wup_id
  AND t1.mandant_id = t2.mandant_id

WHERE t1.mandant_id = 1
  AND t1.dat >= $rb_date

GROUP BY 1,2,3,4,5
;

/*
_------------------------------------------------------------------------------
_ 8.8.) Befuellen der temporaeren Tabelle DBP_ETL.artbew_zek_mo_sum_rb
_------------------------------------------------------------------------------
*/

DELETE FROM DBP_DATA.artbew_zek_mo_sum_2
WHERE kjmo >= $rb_month
AND mandant_id = 1;

INSERT INTO DBP_DATA.artbew_zek_mo_sum_2
(
   bewart_id
  ,bewart_det_id   
  ,zek_id
  ,wup_id
  ,posten_id
  ,mandant_id
  ,nb_id
  ,kjmo
  ,menge
  ,umsatz_netto
  ,umsatz_mwst_betrag
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT
   t1.bewart_id
  ,t1.bewart_det_id
  ,t2.zek_id
  ,t1.wup_id
  ,t1.posten_id
  ,t1.mandant_id
  ,t1.nb_id
  ,t1.kjmo
  ,SUM(t1.menge                       )
  ,SUM(t1.umsatz_netto                )
  ,SUM(t1.umsatz_mwst_betrag          )
  ,SUM(t1.ek_brutto                   )
  ,SUM(t1.ek_netto                    )
  ,SUM(t1.ek_nettonetto               )
  ,SUM(t1.ek_kal_basis                )
  ,SUM(t1.ek_mep                      )
  ,SUM(t1.einstandspreis              )
  ,SUM(t1.logkostenzuschlag           )
  ,SUM(t1.ek_netto_bnk                )
  ,SUM(t1.ek_netto_bnk_sachk          )
FROM DBP_DATA.artbew_mo_sum_2 t1_2

INNER JOIN DBP_DATA.art_2 t2
ON t1.art_id = t2.art_id
AND t1.mandant_id = t2.mandant_id

WHERE t1.kjmo >= $rb_month
  AND t1.mandant_id = 1

GROUP BY
   t1.bewart_id
  ,t1.bewart_det_id   
  ,t2.zek_id
  ,t1.wup_id
  ,t1.mandant_id
  ,t1.nb_id
  ,t1.kjmo
  ,t1.posten_id
;

/*
_------------------------------------------------------------------------------
_ 9.) Prüfstep
_------------------------------------------------------------------------------
*/

DELETE FROM DBP_DATA.artbew_2
WHERE mandant_id = 1
 AND dat >= $rb_date
;

INSERT INTO DBP_DATA.artbew_2
(
   art_id
  ,wup_id
  ,mandant_id
  ,bewart_id
  ,bewart_det_id
  ,promo_fg
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
)
SELECT
   art_id
  ,wup_id
  ,mandant_id
  ,bewart_id
  ,bewart_det_id
  ,promo_fg
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
  ,(COALESCE(ek_brutto     ,0)          )
  ,(COALESCE(ek_netto      ,0)          )
  ,(COALESCE(ek_nettonetto ,0)          )
  ,(COALESCE(ek_kal_basis  ,0)          )
  ,(COALESCE(ek_mep        ,0)          )
  ,(COALESCE(einstandspreis,0)          )
  ,COALESCE(logkostenzuschlag,0)
  ,bezugsweg_id
  ,(COALESCE(ek_netto_bnk      ,0)      )
  ,(COALESCE(ek_netto_bnk_sachk,0)      )
  ,posten_id
  ,aktion_id
  ,ean_kasse
FROM _artbew_tmp
;

/*
_------------------------------------------------------------------------------
_ 10.) Rueckbewertung des Wochenaggregats ARTBEW_WO_SUM_2
_------------------------------------------------------------------------------
*/

-- (a) Anlage_2 volatiler Tabellen.

CREATE OR REPLACE VOLATILE TABLE _artbew_agg_woche (
  dat DATE NOT NULL,
  mandant_id SMALLINT NOT NULL,
  kjwo_kl INTEGER NOT NULL
);

CREATE OR REPLACE VOLATILE TABLE _artbew_wo_sum_tmp (
  kjwo_kl INTEGER NOT NULL,
  mandant_id SMALLINT NOT NULL,
  wup_id INTEGER NOT NULL,
  nb_id SMALLINT NOT NULL,
  art_id INTEGER NOT NULL,
  bewart_id SMALLINT NOT NULL,
  bewart_det_id INT NOT NULL,
  gp_id INTEGER NOT NULL,
  aktion_id VARCHAR(10) collate 'en-ci' NOT NULL,
  bezugsweg_id SMALLINT,
  menge DECIMAL(18,4),
  umsatz_netto DECIMAL(18,4),
  diff_umsatz_netto_konz DECIMAL(18,4),
  umsatz_mwst_betrag DECIMAL(18,4),
  diff_umsatz_mwst_betrag_konz DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  diff_ek_nettonetto_konz DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  diff_einstandspreis_konz DECIMAL(18,4),
  wrg_id VARCHAR(3) NOT NULL
);

-- (b) Aufbau zu aggregierender Wochen ueber RB-Zeitraum fuer DE.

INSERT INTO _artbew_agg_woche (mandant_id,
                               dat,
                               kjwo_kl)
SELECT 1 AS mandant_id,
       b.dat,
       b.kjwo_kl
FROM DBP_DATA.tag_2 a
JOIN DBP_DATA.tag_2 b
  ON a.kjwo_kl = b.kjwo_kl
WHERE a.dat >= $rb_date
GROUP BY 1,2,3;

-- (d) Befuellung der volatilen Tabellen mit allen benoetigten Wochen.

INSERT INTO _artbew_wo_sum_tmp (kjwo_kl,
                                mandant_id,
                                wup_id,
                                nb_id,
                                art_id,
                                bewart_id,
                                bewart_det_id,
                                gp_id,
                                aktion_id,
                                bezugsweg_id,
                                menge,
                                umsatz_netto,
                                diff_umsatz_netto_konz,
                                umsatz_mwst_betrag,
                                diff_umsatz_mwst_betrag_konz,
                                ek_nettonetto,
                                diff_ek_nettonetto_konz,
                                ek_mep,
                                einstandspreis,
                                diff_einstandspreis_konz,
                                wrg_id)
SELECT b.kjwo_kl,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.gp_id,
       a.aktion_id,
       a.bezugsweg_id,
       SUM(COALESCE(a.menge,0)) AS menge,
       SUM(COALESCE(a.umsatz_netto,0)) AS umsatz_netto,
       0 AS diff_umsatz_netto_konz,
       SUM(COALESCE(a.umsatz_mwst_betrag,0)) AS umsatz_mwst_betrag,
       0 AS diff_umsatz_mwst_betrag_konz,
       SUM(COALESCE(CAST((a.ek_nettonetto ) AS DECIMAL(18,4)),0)) AS ek_nettonetto,
       0 AS diff_ek_nettonetto_konz,
       SUM(COALESCE(CAST((a.ek_mep ) AS DECIMAL(18,4)),0)) AS ek_mep,
       SUM(COALESCE(CAST((a.einstandspreis ) AS DECIMAL(18,4)),0)) AS einstandspreis,
       0 AS diff_einstandspreis_konz,
       a.wrg_2 AS wrg_id
FROM DBP_DATA.artbew_2 a
JOIN _artbew_agg_woche b
  ON a.mandant_id = b.mandant_id AND
     a.dat        = b.dat
GROUP BY 1,2,3,4,5,6,7,8,9,10,21
;

-- (e) Austausch der Wochenscheiben im Aggregat.

DELETE FROM DBP_DATA.artbew_wo_sum_2
WHERE (mandant_id, kjwo_kl) IN (SELECT mandant_id,
                                       kjwo_kl
                                FROM _artbew_agg_woche);

INSERT INTO DBP_DATA.artbew_wo_sum_2 (kjwo_kl,
                                    mandant_id,
                                    wup_id,
                                    nb_id,
                                    art_id,
                                    bewart_id,
                                    bewart_det_id,
                                    gp_id,
                                    aktion_id,
                                    bezugsweg_id,
                                    menge,
                                    umsatz_netto,
                                    diff_umsatz_netto_konz,
                                    umsatz_mwst_betrag,
                                    diff_umsatz_mwst_betrag_konz,
                                    ek_nettonetto,
                                    diff_ek_nettonetto_konz,
                                    ek_mep,
                                    einstandspreis,
                                    diff_einstandspreis_konz,
                                    wrg_id)
SELECT kjwo_kl,
       mandant_id,
       wup_id,
       nb_id,
       art_id,
       bewart_id,
       bewart_det_id,
       gp_id,
       aktion_id,
       bezugsweg_id,
       menge,
       umsatz_netto,
       diff_umsatz_netto_konz,
       umsatz_mwst_betrag,
       diff_umsatz_mwst_betrag_konz,
       ek_nettonetto,
       diff_ek_nettonetto_konz,
       ek_mep,
       einstandspreis,
       diff_einstandspreis_konz,
       wrg_id
FROM _artbew_wo_sum_tmp
;

/*
_------------------------------------------------------------------------------
_ 11.) Rueckbewertung des Wochenaggregats ARTBEW_VW_SUM_2 fuer DE.
_------------------------------------------------------------------------------
*/

-- (a) Anlage_2 volatiler Tabellen.

CREATE OR REPLACE VOLATILE TABLE _artbew_vw_sum_tmp (
  dat DATE NOT NULL,
  mandant_id SMALLINT NOT NULL,
  vw_id SMALLINT NOT NULL,
  art_id INTEGER NOT NULL,
  bewart_id SMALLINT NOT NULL,
  bewart_det_id INT NOT NULL,  
  gp_id INTEGER NOT NULL,
  bezugsweg_id SMALLINT,
  menge DECIMAL(18,4),
  umsatz_netto DECIMAL(18,4),
  umsatz_mwst_betrag DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  wrg_id VARCHAR(3) NOT NULL
);

CREATE OR REPLACE VOLATILE TABLE _artbew_dat (
  dat DATE NOT NULL,
  mandant_id SMALLINT NOT NULL
);

-- (b) Aufbau zu aggregierender Tage ueber RB-Zeitraum fuer DE.
INSERT INTO _artbew_dat (dat,
                         mandant_id)
SELECT a.dat,
       1 AS mandant_id
FROM DBP_DATA.tag_2 a
WHERE a.dat >= $rb_date
GROUP BY 1,2;

-- (c) Befuellung der volatilen Tabellen mit allen Tagen.

INSERT INTO _artbew_vw_sum_tmp (dat,
                                mandant_id,
                                vw_id,
                                art_id,
                                bewart_id,
                                bewart_det_id,
                                gp_id,
                                bezugsweg_id,
                                menge,
                                umsatz_netto,
                                umsatz_mwst_betrag,
                                ek_nettonetto,
                                ek_mep,
                                einstandspreis,
                                wrg_id)
SELECT a.dat,
       a.mandant_id,
       b.vw_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.gp_id,
       a.bezugsweg_id,
       SUM(COALESCE(a.menge,0)) AS menge,
       SUM(COALESCE(a.umsatz_netto,0)) AS umsatz_netto,
       SUM(COALESCE(a.umsatz_mwst_betrag,0)) AS umsatz_mwst_betrag,
       SUM(COALESCE(a.ek_nettonetto,0)) AS ek_nettonetto,
       SUM(COALESCE(a.ek_mep,0)) AS ek_mep,
       SUM(COALESCE(a.einstandspreis,0)) AS einstandspreis,
       a.wrg_2 AS wrg_id
FROM _artbew_tmp a
JOIN DBP_DATA.wup_2 b
  ON a.mandant_id = b.mandant_id AND 
     a.wup_id = b.wup_id AND 
     a.nb_id = b.nb_id
JOIN _artbew_dat c
  ON a.mandant_id = c.mandant_id AND
     a.dat = c.dat
GROUP BY 1,2,3,4,5,6,7,8,15
;

-- (d) Austausch der Daten im Aggregat.

DELETE FROM DBP_DATA.artbew_vw_sum_2
WHERE (mandant_id,dat) IN (SELECT mandant_id,
                                  dat
                           FROM _artbew_dat)
;

INSERT INTO DBP_DATA.artbew_vw_sum_2 (dat,
                                    mandant_id,
                                    vw_id,
                                    art_id,
                                    bewart_id,
                                    bewart_det_id,
                                    gp_id,
                                    bezugsweg_id,
                                    menge,
                                    umsatz_netto,
                                    umsatz_mwst_betrag,
                                    ek_nettonetto,
                                    ek_mep,
                                    einstandspreis,
                                    wrg_id)
SELECT a.dat,
       a.mandant_id,
       a.vw_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.gp_id,
       COALESCE(a.bezugsweg_id, -1) AS bezugsweg_id,
       a.menge,
       a.umsatz_netto,
       a.umsatz_mwst_betrag,
       (a.ek_nettonetto ) AS ek_nettonetto,
       (a.ek_mep ) AS ek_mep,
       (a.einstandspreis ) AS einstandspreis,
       COALESCE(a.wrg_id, b.default_wrg) AS wrg_id
FROM _artbew_vw_sum_tmp a
LEFT JOIN DBP_DATA.mandant_2 b
  ON a.mandant_id = b.mandant_id
;

-- Stuecklisten

CREATE OR REPLACE TABLE DBP_ETL.de_wpuums_dat_2 (
  dat DATE
);

CREATE OR REPLACE TABLE DBP_ETL.de_wpuums_dat_min_2 (
  dat DATE
);

CREATE OR REPLACE VOLATILE TABLE _vol_art_gp_wup_zu_per (
  mandant_id              SMALLINT NOT NULL,
  art_id                  INTEGER NOT NULL,
  gp_id                   INTEGER NOT NULL,
  wup_id                  INTEGER NOT NULL,
  nb_id                   SMALLINT,
  einkaufsorganisation_id SMALLINT NOT NULL,
  dat                     DATE NOT NULL,
  ek_brutto               DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),
  logistikkostenzuschlag  DECIMAL(18,4),
  ek_netto_bnk            DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _art_wup_man_spanne_tmp (
  mandant_id SMALLINT NOT NULL,
  art_id     INTEGER NOT NULL,
  wup_id     INTEGER NOT NULL,
  nb_id      SMALLINT NOT NULL,
  dat        DATE NOT NULL,
  zwgs       DECIMAL(9,4),
  zwgm       DECIMAL(9,4),
  zwge       DECIMAL(9,4)
);

INSERT INTO DBP_ETL.de_wpuums_dat_2 (dat)
SELECT dat
FROM DBP_DATA.tag_2
WHERE dat between $rb_date and '2021-09-24'
GROUP BY 1
;

INSERT INTO DBP_ETL.de_wpuums_dat_min_2 (dat)
SELECT MIN(dat)
FROM DBP_DATA.tag_2
WHERE dat between $rb_date and '2021-09-24'
HAVING MIN(dat) IS NOT NULL
;

INSERT INTO _vol_art_gp_wup_zu_per
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,dat
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,dat
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
FROM
(
  SELECT
     mandant_id
    ,wup_id
    ,nb_id
    ,art_id
    ,gp_id
    ,einkaufsorganisation_id
    ,dat_von
    ,dat_bis
    ,wrg_id
    ,CAST(ek_brutto          AS DECIMAL(18,4)) AS ek_brutto
    ,CAST(ek_netto           AS DECIMAL(18,4)) AS ek_netto
    ,CAST(ek_nettonetto      AS DECIMAL(18,4)) AS ek_nettonetto
    ,CAST(ek_kal_basis       AS DECIMAL(18,4)) AS ek_kal_basis
    ,CAST(ek_mep             AS DECIMAL(18,4)) AS ek_mep
    ,CAST(einstandspreis     AS DECIMAL(18,4)) AS einstandspreis
    ,logistikkostenzuschlag
    ,CAST(ek_netto_bnk       AS DECIMAL(18,4)) AS ek_netto_bnk
    ,CAST(ek_netto_bnk_sachk AS DECIMAL(18,4)) AS ek_netto_bnk_sachk
  FROM DBP_DATA.art_gp_wup_zu_per_2 a

  INNER JOIN DBP_ETL.de_wpuums_dat_min_2 m
  ON a.dat_bis >= m.dat

  WHERE a.mandant_id = 1) a

-- auf Tag_2 auffaechern
INNER JOIN DBP_ETL.de_wpuums_dat_2 d
ON d.dat BETWEEN a.dat_von AND a.dat_bis
;

-- Nun die betriebsuebergreifenden manuellen Spannenfaktoren

INSERT INTO _art_wup_man_spanne_tmp (mandant_id,
                                     art_id,
                                     wup_id,
                                     nb_id,
                                     dat,
                                     zwgs,
                                     zwgm,
                                     zwge)
SELECT ein.mandant_id
      ,ein.art_id
      ,-1 AS wup_id
      ,-1 AS nb_id
      ,a.dat
      ,ein.ek_faktor AS zwgs
      ,COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm
      ,COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
FROM DBP_ETL.de_wpuums_dat_2 a

INNER JOIN DBP_DATA.art_man_spanne_per_2 ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_2 mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_2 ekbnk /*optional*/
  ON ekbnk.mandant_id = ein.mandant_id
 AND ekbnk.art_id  = ein.art_id
 AND ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/
 AND ekbnk.loesch_fg = 0
 AND a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
;

-- Nun die betriebsspezifischen manuellen Spannenfaktoren!

INSERT INTO _art_wup_man_spanne_tmp (mandant_id,
                                     art_id,
                                     wup_id,
                                     nb_id,
                                     dat,
                                     zwgs,
                                     zwgm,
                                     zwge)
SELECT ein.mandant_id
      ,ein.art_id
      ,ein.wup_id 
      ,ein.nb_id
      ,a.dat
      ,ein.ek_faktor AS zwgs
      ,COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm
      ,COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
FROM DBP_ETL.de_wpuums_dat_2 a

INNER JOIN DBP_DATA.art_wup_man_spanne_per_2 ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_2 mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.wup_id  = ein.wup_id 
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_2 ekbnk /*optional*/
  ON ekbnk.mandant_id = ein.mandant_id
 AND ekbnk.wup_id  = ein.wup_id 
 AND ekbnk.art_id  = ein.art_id
 AND ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/
 AND ekbnk.loesch_fg = 0
 AND a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
;

/*
_---------------------------------------------------------------------------------------------------------
_                                  STUECKLISTENAUFLOESUNG INKL. EK-BEWERTUNG                                             
_---------------------------------------------------------------------------------------------------------
*/

CREATE OR REPLACE VOLATILE TABLE _step01_2 (
  mandant_id SMALLINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_det_id INTEGER,
  dat DATE,
  wrg_2 CHAR(3),
  ean_kasse DECIMAL(26,0),
  wg_id INTEGER,
  bezugsweg_id SMALLINT,
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER
);

CREATE OR REPLACE VOLATILE TABLE _step02_2 (
  mandant_id SMALLINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_det_id INTEGER,
  dat DATE,
  wrg_2 CHAR(3),
  ean_kasse DECIMAL(26,0),
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER,
  bq_findung_id SMALLINT,
  ek_brutto DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_kal_basis DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  logistikkostenzuschlag DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto_bnk_sachk DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _step02a_2 (
  mandant_id SMALLINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_det_id INTEGER,
  dat DATE,
  wrg_2 CHAR(3),
  ean_kasse DECIMAL(26,0),
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER,
  bq_findung_id SMALLINT,
  umsatz_anteil DECIMAL(18,4),
  umsatz_netto DECIMAL(18,4),
  umsatz_mwst DECIMAL(18,4),
  ek_brutto DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_kal_basis DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  logistikkostenzuschlag DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto_bnk_sachk DECIMAL(18,4),
  diff_ek_brutto_konz DECIMAL(18,4),
  diff_ek_netto_konz DECIMAL(18,4),
  diff_ek_nettonetto_konz DECIMAL(18,4),
  diff_ek_kal_basis_konz DECIMAL(18,4),
  diff_ek_mep_konz DECIMAL(18,4),
  diff_einstandspreis_konz DECIMAL(18,4),
  diff_logkostenzuschlag_konz DECIMAL(18,4),
  diff_ek_netto_bnk_konz DECIMAL(18,4),
  diff_ek_netto_bnk_sachk_konz DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _step03_2 (
  mandant_id SMALLINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_det_id INTEGER,
  dat DATE,
  wrg_2 CHAR(3),
  ean_kasse DECIMAL(26,0),
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER,
  bq_findung_id SMALLINT,
  umsatz_anteil DECIMAL(18,4),
  umsatz_netto DECIMAL(18,4),
  umsatz_mwst DECIMAL(18,4),
  ek_brutto DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_kal_basis DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  logistikkostenzuschlag DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto_bnk_sachk DECIMAL(18,4),
  diff_ek_brutto_konz DECIMAL(18,4),
  diff_ek_netto_konz DECIMAL(18,4),
  diff_ek_nettonetto_konz DECIMAL(18,4),
  diff_ek_kal_basis_konz DECIMAL(18,4),
  diff_ek_mep_konz DECIMAL(18,4),
  diff_einstandspreis_konz DECIMAL(18,4),
  diff_logkostenzuschlag_konz DECIMAL(18,4),
  diff_ek_netto_bnk_konz DECIMAL(18,4),
  diff_ek_netto_bnk_sachk_konz DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _aggregat01_2 (
  mandant_id SMALLINT,
  art_id INTEGER,
  bewart_det_id INTEGER,
  wup_id INTEGER,
  nb_id SMALLINT,
  dat DATE,
  ean_kasse DECIMAL(26,0),
  umsatz_netto DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _spannen_agg1 (
  mandant_id SMALLINT,
  wup_id INTEGER,
  kopf_art_id INTEGER,
  bewart_det_id INTEGER,
  stueckliste_id INTEGER,
  dat DATE,
  ean_kasse DECIMAL(26,0),
  ek_netto_sum DECIMAL(18,4)
);

-- 18.12.2012, -dba-
--
-- Aus der ARTBEW_2 werden zunaechst fuer die relevanten Tage alle betroffenen Kopfartikel ermittelt. Ueber den
-- nachgelagerten JOIN gegen die Komponententabelle STUECKLISTE_DET_2 werden dann die zugehoerigen Fußartikel_2 mit
-- der auf Basismengeneinheit geeichten Menge in die Zwischentabelle STEP01 eingespielt.

INSERT INTO _step01_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     wg_id,
                     bezugsweg_id,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id)
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       b.art_id,
       a.bewart_det_id,
       a.dat,
       a.wrg_2,
       a.ean_kasse,
       y.wg_id,
       COALESCE(x.bezugsweg_id,a.bezugsweg_id) AS bezugsweg_id,
       SUM(CAST(a.menge AS FLOAT)) AS menge,
       SUM(CAST(a.umsatz_netto AS DECIMAL(18,4))) AS umsatz_netto_alt,
       SUM(CAST(a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_mwst_betrag_alt,
       SUM(CAST(a.umsatz_netto+a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_bto,
       CAST(0 AS FLOAT) AS umrechnungskurs,
       a.art_id AS kopf_art_id,
       -- falls eine_2 Komponente mehrfach in der Stueckliste_2 vorhanden ist: Menge aufsummieren 
 	     CAST(SUM(CAST(a.menge AS FLOAT) * CAST(b.komponentenmenge AS FLOAT)) / MAX(COALESCE(c.umrech_faktor, 1.0000)) AS DECIMAL(18,4)) AS komponentenmengen_faktor,
       b.stueckliste_id
FROM DBP_DATA.artbew_2 a

LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  art_id,
                  dat_von,
                  dat_bis,
                  bezugsweg_id
           FROM DBP_DATA.art_wup_zu_per_2
           WHERE mandant_id = 1
             AND dat_bis >= (SELECT dat FROM DBP_ETL.de_wpuums_dat_min_2)
           ) x
  ON a.wup_id = x.wup_id AND
     a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     a.dat BETWEEN x.dat_von AND x.dat_bis

JOIN DBP_DATA.art_wg_zu_per_2 y
  ON a.mandant_id = y.mandant_id AND
     a.art_id = y.art_id AND
	 y.arthiertyp_id = 2 AND
	 y.dat_bis = '9999-12-31'

JOIN DBP_ETL.de_wpuums_dat_2 d
  ON a.dat = d.dat

-- Ermittlung Kopfartikel
--
-- 29.01.2013, DBA
--
-- Aenderung hinsichtlich des Abgreifens von Stuecklistenkoepfen! Die Stammtabelle ist laut
-- Vorgabe (!!!) nicht eindeutig pro Kopfartikel versorgt, so dass zu einem Stichtag durchaus
-- mehrere Koepfe in verschiedenen Stuecklisten gefuehrt werden koennen. Das ist natuerlich
-- fachlich vollkommener Bloedsinn, aber laut FB sollte man hier mit einem MAX(...) das Ganze
-- zurechtstutzen. (Aufgefallen war das Problem am 29.01.2013 bei den Artikeln 180600, 180580
-- fuer den Mandant_2 8 mit Stichtag 28.01.2013.)
--
-- Des Weiteren die Filter auf STLAN=3 u. WERKS IS NULL fuer Stuecklistenkopf hinterlegt (s.
-- IT-Konzept [DWH BE TP5-016-Abbildung VK_2 Set]).
JOIN (SELECT a.mandant_id,
             a.stueckliste_id,
             a.dat_von,
             a.dat_bis,
             a.art_id,
             NULL wup_id,
             NULL nb_id,
             a.stueckliste_verwendung_id
      FROM DBP_DATA.stueckliste_2 a
      JOIN DBP_ETL.de_wpuums_dat_min_2 m
        ON a.dat_bis >= m.dat
      WHERE --a.wup_id IS NULL AND
            a.stueckliste_verwendung_id = 3 AND
           (a.mandant_id, a.art_id, a.stueckliste_id) IN (SELECT mandant_id,
                                                                 art_id,
                                                                 MAX(stueckliste_id) AS stueckliste_id
                                                          FROM DBP_DATA.stueckliste_2
                                                          GROUP BY 1,2)) k
  ON a.mandant_id = k.mandant_id  AND 
     a.art_id     = k.art_id      AND
     a.dat BETWEEN k.dat_von AND k.dat_bis

-- Ermittlung Fußartikel_2
JOIN (SELECT *
      FROM DBP_DATA.stueckliste_det_2
      WHERE stueckliste_typ_id = 'M') b
  ON k.mandant_id     = b.mandant_id     AND 
     k.stueckliste_id = b.stueckliste_id AND
     a.dat BETWEEN b.dat_von AND b.dat_bis

-- Ermittlung Umrechnungsfaktor, damit korrekter Bezug zur Basismengeneinheit hergestellt wird.
LEFT JOIN DBP_DATA.art_umrechnung_faktor_per_2 c
ON b.mandant_id               = c.mandant_id          AND 
   b.art_id                   = c.art_id              AND 
   b.komponentenmenge_einh_id = c.altnv_menge_einh_id AND 
   c.dat_bis = '9999-12-31'
   
WHERE a.mandant_id = 1    AND
      a.menge <> 0        AND  /* nur Positionen mit Abverkauf beruecksichtigen! */
      a.umsatz_netto <> 0      /* nur Positionen mit Abverkauf beruecksichtigen! */

GROUP BY a.mandant_id,a.wup_id,a.nb_id,b.art_id,a.dat,a.art_id,b.stueckliste_id,a.wrg_2,a.ean_kasse,y.wg_id,COALESCE(x.bezugsweg_id,a.bezugsweg_id),a.bewart_det_id
;

-- 18.12.2012, -dba-
--
-- Nachgelagert werden dann alle Koepfe in dieselbe volatile Tabelle gespielt. Als Kennung wird in die Spalte
-- KOPF_ART_ID nun der Wert "-100" eingestellt, um spaeter zwischen Kopf und Fuß unterscheiden zu koennen.

INSERT INTO _step01_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     wg_id,
                     bezugsweg_id,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id)
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bewart_det_id,
       a.dat,
       a.wrg_2,
       a.ean_kasse,
	     y.wg_id,
	     COALESCE(x.bezugsweg_id,a.bezugsweg_id) AS bezugsweg_id,
       SUM(CAST(a.menge AS FLOAT)) AS menge,
       SUM(CAST(a.umsatz_netto AS DECIMAL(18,4))) AS umsatz_netto_alt,
       SUM(CAST(a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_mwst_betrag_alt,
       SUM(CAST(a.umsatz_netto+a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_bto,
       CAST(0 AS FLOAT) AS umrechnungskurs,
       -100 AS kopf_art_id,
       0 AS komponentenmengen_faktor,
       c.stueckliste_id
FROM DBP_DATA.artbew_2 a

LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  art_id,
                  dat_von,
                  dat_bis,
                  bezugsweg_id
           FROM DBP_DATA.art_wup_zu_per_2
           WHERE mandant_id = 1
             AND dat_bis >= (SELECT dat FROM DBP_ETL.de_wpuums_dat_min_2)
           ) x
  ON a.wup_id = x.wup_id AND
     a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     a.dat BETWEEN x.dat_von AND x.dat_bis

JOIN DBP_DATA.art_wg_zu_per_2 y
  ON a.mandant_id = y.mandant_id AND
     a.art_id = y.art_id AND
	 y.arthiertyp_id = 2 AND
	 y.dat_bis = '9999-12-31'

JOIN DBP_ETL.de_wpuums_dat_2 d
  ON a.dat = d.dat

-- Ermittlung Kopfartikel
--
-- 29.01.2013, DBA
--
-- Aenderung hinsichtlich des Abgreifens von Stuecklistenkoepfen! Die Stammtabelle ist laut
-- Vorgabe (!!!) nicht eindeutig pro Kopfartikel versorgt, so dass zu einem Stichtag durchaus
-- mehrere Koepfe in verschiedenen Stuecklisten gefuehrt werden koennen. Das ist natuerlich
-- fachlich vollkommener Bloedsinn, aber laut FB sollte man hier mit einem MAX(...) das Ganze
-- zurechtstutzen. (Aufgefallen war das Problem am 29.01.2013 bei den Artikeln 180600, 180580
-- fuer den Mandant_2 8 mit Stichtag 28.01.2013.)
--
-- Des Weiteren die Filter auf STLAN=3 u. WERKS IS NULL fuer Stuecklistenkopf hinterlegt (s.
-- IT-Konzept [DWH BE TP5-016-Abbildung VK_2 Set]).
JOIN (SELECT a.mandant_id,
             a.stueckliste_id,
             a.dat_von,
             a.dat_bis,
             a.art_id,
             NULL wup_id,
             NULL nb_id,
             a.stueckliste_verwendung_id
      FROM DBP_DATA.stueckliste_2 a
      JOIN DBP_ETL.de_wpuums_dat_min_2 m
        ON a.dat_bis >= m.dat
      WHERE a.stueckliste_verwendung_id = 3 AND
           (a.mandant_id, a.art_id, a.stueckliste_id) IN (SELECT mandant_id,
                                                                 art_id,
                                                                 MAX(stueckliste_id) AS stueckliste_id
                                                          FROM DBP_DATA.stueckliste_2
                                                          GROUP BY 1,2)) c
  ON a.mandant_id = c.mandant_id  AND 
     a.art_id     = c.art_id      AND
     a.dat BETWEEN c.dat_von AND c.dat_bis

WHERE a.mandant_id = 1    AND
      a.menge <> 0        AND /* nur Positionen mit Abverkauf beruecksichtigen! */
      a.umsatz_netto <> 0     /* nur Positionen mit Abverkauf beruecksichtigen! */
  
GROUP BY a.mandant_id,a.wup_id,a.nb_id,a.art_id,a.dat,umrechnungskurs,a.art_id,c.stueckliste_id,a.wrg_2,a.ean_kasse,y.wg_id,COALESCE(x.bezugsweg_id,a.bezugsweg_id),a.bewart_det_id
;

-- 18.12.2012, -dba-
--
-- Standardmaeßige EK-Ermittlung, die an dieser Stelle nur fuer die Fußartikel_2 greift, da die VK_2-Set Kopfartikel
-- NICHT in der EK-Tabelle gefuehrt werden! Somit sind selbige nach diesem Step noch NULL!

create or replace volatile table _xxx as 
select t2.*
from _step01_2 t1_2
join DBP_DATA.art_gp_wup_zu_per_2 t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
where t2.wup_id = -1
union
select t2.*
from _step01_2 t1_2
join DBP_DATA.art_gp_wup_zu_per_2 t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
where t2.wup_id = 6906 AND (t1.mandant_id,t1.wg_id) NOT IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2  where wg_filter_id =20 group by 1,2)
union
select t2.*
from _step01_2 t1_2
join DBP_DATA.art_gp_wup_zu_per_2 t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
where t2.wup_id = 6907 AND (t1.mandant_id,t1.wg_id) IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_2  where wg_filter_id =20 group by 1,2)
;

INSERT INTO _step02_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id,
                     bq_findung_id,
                     ek_brutto,
                     ek_netto,
                     ek_nettonetto,
                     ek_kal_basis,
                     ek_mep,
                     einstandspreis,
                     logistikkostenzuschlag,
                     ek_netto_bnk,
                     ek_netto_bnk_sachk)
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bewart_det_id,
       a.dat,
       a.wrg_2,
       a.ean_kasse,
       a.menge,
       a.umsatz_netto_alt,
       a.umsatz_mwst_betrag_alt,
       a.umsatz_bto,
       a.umrechnungskurs,
       a.kopf_art_id,
       a.komponentenmengen_faktor,
       a.stueckliste_id,
       0 AS bq_findung_id,
       a.komponentenmengen_faktor * COALESCE(x.ek_brutto , 0)                                  AS ek_brutto_,
       a.komponentenmengen_faktor * COALESCE(x.ek_netto , 0)                                    AS ek_netto_,
       a.komponentenmengen_faktor * COALESCE(x.ek_nettonetto , 0)                          AS ek_nettonetto_,
       a.komponentenmengen_faktor * COALESCE(x.ek_kal_basis , 0)                            AS ek_kal_basis_,
       a.komponentenmengen_faktor * COALESCE(x.ek_mep , 0)                                        AS ek_mep_,
       a.komponentenmengen_faktor * COALESCE(x.einstandspreis , 0)                        AS einstandspreis_,
       a.komponentenmengen_faktor * COALESCE(x.logistikkostenzuschlag, 0.0000) AS logistikkostenzuschlag_,
       a.komponentenmengen_faktor * COALESCE(x.ek_netto_bnk , 0)                            AS ek_netto_bnk_,
       a.komponentenmengen_faktor * COALESCE(x.ek_netto_bnk_sachk , 0)                AS ek_netto_bnk_sachk_

FROM _step01_2 a

JOIN DBP_DATA.art_wg_zu_per_2 y
  ON a.mandant_id = y.mandant_id AND
     a.art_id = y.art_id AND
     y.arthiertyp_id = 2 AND
     y.dat_bis = '9999-12-31'

-- Ermittelung potentieller ZEKP_2-Sätze für EK und GP_2
LEFT OUTER JOIN _xxx x
  ON a.mandant_id = x.mandant_id AND 
     a.art_id = x.art_id AND 
     a.dat BETWEEN x.dat_von AND x.dat_bis

QUALIFY row_number() OVER (PARTITION BY a.mandant_id, a.wup_id, a.nb_id, a.art_id, a.dat, a.wrg_2, a.ean_kasse, a.menge, a.kopf_art_id, a.stueckliste_id, a.bewart_det_id
                            ORDER BY CASE WHEN (a.bezugsweg_id = 1 AND x.wup_id = -1) OR (a.bezugsweg_id = 4 AND x.wup_id <> -1) THEN 1 ELSE 0 END DESC --Richtiger Bezugsweg
                            ,x.dat_von DESC -- jüngster Satz
                            ,x.ek_brutto DESC
                            ,x.gp_id -- höchte Lieferantennummer
                            ) = 1
;

-- 18.12.2012, -dba-
--
-- Im normalen Deltabetrieb eigentlich ein obsoleter Step. Allerdings können durch das Anziehen unserer neuen
-- BQ-Tabelle ART_GP_NM_ZU_PER_2, die erst ab Oktober regelmaeßig mitlief, Ungenauigkeiten beim Lieferanten fuer
-- historische Daten (z.B. auf Q fuer Initialbefuellung!) entstehen. Deswegen zur Sicherheit noch einmal ein
-- Update und das Setzen auf den UMSATZ_NETTO (Spanne 0%) fuer solche Faelle.

UPDATE _step02_2

SET ek_brutto = umsatz_netto_alt,
    ek_netto  = umsatz_netto_alt,
    ek_nettonetto = umsatz_netto_alt,
    ek_kal_basis = umsatz_netto_alt,
    ek_mep = umsatz_netto_alt,
    einstandspreis = umsatz_netto_alt,
    ek_netto_bnk = umsatz_netto_alt,
    ek_netto_bnk_sachk = umsatz_netto_alt

WHERE _step02.kopf_art_id <> -100 AND
      _step02.ek_brutto = 0
;

-- 18.12.2012, -dba-
--
-- Zunaechst wird eine_2 Tabelle mit Kopfinformationen bzgl. UMSATZ_NETTO erstellt.
INSERT INTO _aggregat01_2 (mandant_id,
                         art_id,
                         bewart_det_id,
                         wup_id,
                         nb_id,
                         dat,
                         ean_kasse,
                         umsatz_netto)
SELECT a.mandant_id,
       a.art_id,
       a.bewart_det_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       a.ean_kasse,
       a.umsatz_netto_alt AS umsatz_netto
FROM _step02_2 a
WHERE a.kopf_art_id = -100
;

-- 18.12.2012, -dba-
--
-- Hier die ungleich wichtigere Tabelle! Da wir bei der Bestimmung der Umsatzanteile pro Komponente uns am
-- Verhaeltnis von EKN1 (Gesamt) zum EK-Wert eines Einzelartikels orientieren, wird hier in EK_NETTO_SUM 
-- der gesamte EKN1-Wert der Komponenten gespeichert.

INSERT INTO _spannen_agg1 (mandant_id,
                           wup_id,
                           kopf_art_id,
                           bewart_det_id,
                           stueckliste_id,
                           dat,
                           ean_kasse,
                           ek_netto_sum)
SELECT a.mandant_id,
       a.wup_id,
       a.kopf_art_id,
       a.bewart_det_id,
       a.stueckliste_id,
       a.dat,
       a.ean_kasse,
       SUM(a.ek_netto) AS ek_netto_sum
FROM _step02_2 a
JOIN _aggregat01_2 b
  ON a.mandant_id  = b.mandant_id AND
     a.wup_id      = b.wup_id     AND
     a.kopf_art_id = b.art_id     AND
     a.dat         = b.dat        AND
     a.ean_kasse   = b.ean_kasse  and
     a.bewart_det_id = b.bewart_det_id
GROUP BY 1,2,3,4,5,6,7
;

INSERT INTO _step02a_2 (mandant_id,
                      wup_id,
                      nb_id,
                      art_id,
                      bewart_det_id,
                      dat,
                      wrg_2,
                      ean_kasse,
                      menge,
                      umsatz_netto_alt,
                      umsatz_mwst_betrag_alt,
                      umsatz_bto,
                      umrechnungskurs,
                      kopf_art_id,
                      komponentenmengen_faktor,
                      stueckliste_id,
                      bq_findung_id,
                      umsatz_anteil,
                      umsatz_netto,
                      umsatz_mwst,
                      ek_brutto,
                      ek_netto,
                      ek_nettonetto,
                      ek_kal_basis,
                      ek_mep,
                      einstandspreis,
                      logistikkostenzuschlag,
                      ek_netto_bnk,
                      ek_netto_bnk_sachk,
                      diff_ek_brutto_konz,
                      diff_ek_netto_konz,
                      diff_ek_nettonetto_konz,
                      diff_ek_kal_basis_konz,
                      diff_ek_mep_konz,
                      diff_einstandspreis_konz,
                      diff_logkostenzuschlag_konz,
                      diff_ek_netto_bnk_konz,
                      diff_ek_netto_bnk_sachk_konz)
SELECT DISTINCT
       z.mandant_id,
       z.wup_id,
       z.nb_id,
       z.art_id,
       z.bewart_det_id,
       z.dat,
       z.wrg_2,
       z.ean_kasse,
       z.menge,
       z.umsatz_netto_alt,
       z.umsatz_mwst_betrag_alt,
       z.umsatz_bto,
       z.umrechnungskurs,
       z.kopf_art_id,
       z.komponentenmengen_faktor,
       z.stueckliste_id,
       z.bq_findung_id,
       CAST(z.ek_netto AS DECIMAL(18,10))/CAST(a.ek_netto_sum AS DECIMAL(18,10)) AS umsatz_anteil_,
       CAST(z.umsatz_netto_alt*umsatz_anteil_ AS DECIMAL(18,4)) AS umsatz_netto,
       CAST(z.umsatz_mwst_betrag_alt*umsatz_anteil_ AS DECIMAL(18,4)) AS umsatz_mwst,
       z.ek_brutto,
       z.ek_netto,
       z.ek_nettonetto,
       z.ek_kal_basis,
       z.ek_mep,
       z.einstandspreis,
       z.logistikkostenzuschlag,
       z.ek_netto_bnk,
       z.ek_netto_bnk_sachk,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_brutto_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_netto_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_nettonetto_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_kal_basis_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_mep_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_einstandspreis_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_logkostenzuschlag_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_netto_bnk_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_netto_bnk_sachk_konz
FROM _step02_2 z
JOIN _spannen_agg1 a
  ON z.mandant_id     = a.mandant_id     AND
     z.wup_id         = a.wup_id         AND
     z.kopf_art_id    = a.kopf_art_id    AND
     z.stueckliste_id = a.stueckliste_id AND
     z.ean_kasse      = a.ean_kasse      AND
     z.dat            = a.dat            and
     z.bewart_det_id  = a.bewart_det_id
WHERE a.ek_netto_sum <> 0
;

-- 18.12.2012, -dba-
--
-- Laut Konzept gilt die Regel: Manuelle Spannen stehen ueber der Stuecklistenaufloesung! Falls also fuer die
-- Komponentenartikel manuelle Spannen gepflegt sein sollten, wird das Ganze wieder ueberschrieben!!! Es obliegt 
-- somit dem Fachbereich, hier fuer eine_2 adäquate Pflege der VK_2-Set Artikel_2 zu sorgen, da ansonsten das Prozedere 
-- obsolet waere!

-- manuelle Spanne ohne Betriebsbezug
UPDATE _step02a_2 FROM (SELECT ein.mandant_id,
                             ein.art_id,
                             a.dat,
                             ein.ek_faktor AS zwgs,
                             COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
                             COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
                      FROM DBP_ETL.de_wpuums_dat_2 a
                     
                      JOIN DBP_DATA.art_man_spanne_per_2 ein /*Einstandspreis zwingend erforderlich*/
                        ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/ AND 
                           ein.loesch_fg = 0 AND 
                           a.dat BETWEEN ein.dat_von AND ein.dat_bis
                     
                      LEFT JOIN DBP_DATA.art_man_spanne_per_2 mep /*optional*/
                        ON mep.mandant_id = ein.mandant_id AND 
                           mep.art_id  = ein.art_id AND 
                           mep.konditionsart_id = 'ZWGM' /*MEP*/ AND 
                           mep.loesch_fg = 0 AND 
                           a.dat BETWEEN mep.dat_von AND mep.dat_bis
                     
                      LEFT JOIN DBP_DATA.art_man_spanne_per_2 ekbnk /*optional*/
                        ON ekbnk.mandant_id = ein.mandant_id AND 
                           ekbnk.art_id  = ein.art_id AND 
                           ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/ AND 
                           ekbnk.loesch_fg = 0 AND 
                           a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis) ms
                          
SET ek_brutto                    = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto                     = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_nettonetto                = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_kal_basis                 = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep                       = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,einstandspreis               = CAST(umsatz_netto * zwgs AS DECIMAL(18,4))
   ,ek_netto_bnk                 = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto_bnk_sachk           = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))

WHERE _step02a.mandant_id     = ms.mandant_id
  AND _step02a.art_id         = ms.art_id
  AND _step02a.dat            = ms.dat
  AND _step02a.kopf_art_id   <> -100
;

-- Hier die betriebsspezifischen manuellen Spannenfaktoren
UPDATE _step02a_2 FROM (SELECT ein.mandant_id,
                             ein.wup_id,
                             ein.art_id,
                             a.dat,
                             ein.ek_faktor AS zwgs,
                             COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
                             COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
                      FROM DBP_ETL.de_wpuums_dat_2 a
                      
                      JOIN DBP_DATA.art_wup_man_spanne_per_2 ein /*Einstandspreis zwingend erforderlich*/
                        ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/ AND 
                           ein.loesch_fg = 0 AND 
                           a.dat BETWEEN ein.dat_von AND ein.dat_bis
                      
                      LEFT JOIN DBP_DATA.art_wup_man_spanne_per_2 mep /*optional*/
                        ON mep.mandant_id = ein.mandant_id AND 
                           mep.wup_id  = ein.wup_id AND 
                           mep.art_id  = ein.art_id AND 
                           mep.konditionsart_id = 'ZWGM' /*MEP*/ AND 
                           mep.loesch_fg = 0 AND 
                           a.dat BETWEEN mep.dat_von AND mep.dat_bis
                      
                      LEFT JOIN DBP_DATA.art_wup_man_spanne_per_2 ekbnk /*optional*/
                        ON ekbnk.mandant_id = ein.mandant_id AND 
                           ekbnk.wup_id  = ein.wup_id AND 
                           ekbnk.art_id  = ein.art_id AND 
                           ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/ AND 
                           ekbnk.loesch_fg = 0 AND 
                           a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis) ms
                          
SET ek_brutto                    = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto                     = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_nettonetto                = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_kal_basis                 = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep                       = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,einstandspreis               = CAST(umsatz_netto * zwgs AS DECIMAL(18,4))
   ,ek_netto_bnk                 = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto_bnk_sachk           = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))

WHERE _step02a.mandant_id     = ms.mandant_id
  AND _step02a.wup_id         = ms.wup_id 
  AND _step02a.art_id         = ms.art_id
  AND _step02a.dat            = ms.dat
  AND _step02a.kopf_art_id   <> -100
;

-- 18.12.2012, -dba-
--
-- Des Weiteren werden fuer die einzelnen Konditionsstufen die zugrunde liegende Spanne im Verhaeltnis zum 
-- Gesamtabverkauf (UMSATZ_NETTO ermittelt. Mit diesen Spannen werden spaeter die EK-Werte fuer die Kom-
-- ponentenartikel festgeschrieben.

CREATE OR REPLACE VOLATILE TABLE _spannen_agg2_2 AS (
SELECT a.mandant_id,
       a.wup_id,
       a.kopf_art_id,
       a.bewart_det_id,
       a.ean_kasse,
       a.stueckliste_id,
       a.dat,
       1-SUM(a.ek_brutto/b.umsatz_netto) AS ek_brutto_spn,
       1-SUM(a.ek_netto/b.umsatz_netto) AS ek_netto_spn,
       1-SUM(a.ek_nettonetto/b.umsatz_netto) AS ek_nettonetto_spn,
       1-SUM(a.ek_kal_basis/b.umsatz_netto) AS ek_kal_basis_spn,
       1-SUM(a.ek_mep/b.umsatz_netto) AS ek_mep_spn,
       1-SUM(a.einstandspreis/b.umsatz_netto) AS einstandspreis_spn,
       1-SUM(a.logistikkostenzuschlag/b.umsatz_netto) AS logkostenzuschlag_spn,
       1-SUM(a.ek_netto_bnk/b.umsatz_netto) AS ek_netto_bnk_spn,
       1-SUM(a.ek_netto_bnk_sachk/b.umsatz_netto) AS ek_netto_bnk_sachk_spn
FROM _step02a_2 a
JOIN _aggregat01_2 b
  ON a.mandant_id  = b.mandant_id AND
     a.wup_id      = b.wup_id     AND
     a.kopf_art_id = b.art_id     AND
     a.dat         = b.dat        AND
     a.ean_kasse   = b.ean_kasse  and
     a.bewart_det_id = b.bewart_det_id
WHERE b.umsatz_netto <> 0
GROUP BY 1,2,3,4,5,6,7
);

-- 18.12.2012, -dba-
--
-- Wie dem obigen Titel zu entnehmen ist, werden hier fuer saemtliche Komponenten eines VK_2-Set die entsprechenden
-- Werte ermittelt. Als Anmerkung waere hier noch zu erwaehnen, dass aufgrund von Rundungsungenauigkeiten im Teradata-
-- Umfeld bei der EK-Berechnung laut Spanne leider die Genauigkeit von DECIMAL(18,4) auf DECIMAL(18,2) gesetzt werden
-- musste, da wir ansonsten kein stimmiges Verhaeltnis der EK-Werte im Vergleich von vorher zu nachher gehabt haetten.

INSERT INTO _step03_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id,
                     bq_findung_id,
                     umsatz_anteil,
                     umsatz_netto,
                     umsatz_mwst,
                     ek_brutto,
                     ek_netto,
                     ek_nettonetto,
                     ek_kal_basis,
                     ek_mep,
                     einstandspreis,
                     logistikkostenzuschlag,
                     ek_netto_bnk,
                     ek_netto_bnk_sachk,
                     diff_ek_brutto_konz,
                     diff_ek_netto_konz,
                     diff_ek_nettonetto_konz,
                     diff_ek_kal_basis_konz,
                     diff_ek_mep_konz,
                     diff_einstandspreis_konz,
                     diff_logkostenzuschlag_konz,
                     diff_ek_netto_bnk_konz,
                     diff_ek_netto_bnk_sachk_konz)
SELECT DISTINCT
       z.mandant_id,
       z.wup_id,
       z.nb_id,
       z.art_id,
       z.bewart_det_id,
       z.dat,
       z.wrg_2,
       z.ean_kasse,
       z.menge,
       z.umsatz_netto_alt,
       z.umsatz_mwst_betrag_alt,
       z.umsatz_bto,
       z.umrechnungskurs,
       z.kopf_art_id,
       z.komponentenmengen_faktor,
       z.stueckliste_id,
       z.bq_findung_id,
       z.umsatz_anteil,
       z.umsatz_netto,
       z.umsatz_mwst,
       -1*((a.ek_brutto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_brutto_ ,
       -1*((a.ek_netto_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_netto_,
       -1*((a.ek_nettonetto_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_nettonetto_,
       -1*((a.ek_kal_basis_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_kal_basis_,
       -1*((a.ek_mep_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_mep_,
       -1*((a.einstandspreis_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS einstandspreis_,
       -1*((a.logkostenzuschlag_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS logistikkostenzuschlag_,
       -1*((a.ek_netto_bnk_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_netto_bnk_,
       -1*((a.ek_netto_bnk_sachk_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_netto_bnk_sachk_,
       CAST(ek_brutto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_brutto_konz,
       CAST(ek_netto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_konz,
       CAST(ek_nettonetto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_nettonetto_konz,
       CAST(ek_kal_basis_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_kal_basis_konz,
       CAST(ek_mep_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_mep_konz,
       CAST(einstandspreis_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_einstandspreis_konz,
       CAST(logistikkostenzuschlag_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_logkostenzuschlag_konz,
       CAST(ek_netto_bnk_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_konz,
       CAST(ek_netto_bnk_sachk_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_sachk_konz
FROM _step02a_2 z
JOIN _spannen_agg2_2 a
  ON z.mandant_id     = a.mandant_id     AND
     z.wup_id         = a.wup_id         AND
     z.kopf_art_id    = a.kopf_art_id    AND
     z.stueckliste_id = a.stueckliste_id AND
     z.dat            = a.dat            AND
     z.ean_kasse      = a.ean_kasse      and
     z.bewart_det_id  = a.bewart_det_id
;

INSERT INTO _step03_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id,
                     bq_findung_id,
                     umsatz_anteil,
                     umsatz_netto,
                     umsatz_mwst,
                     ek_brutto,
                     ek_netto,
                     ek_nettonetto,
                     ek_kal_basis,
                     ek_mep,
                     einstandspreis,
                     logistikkostenzuschlag,
                     ek_netto_bnk,
                     ek_netto_bnk_sachk,
                     diff_ek_brutto_konz,
                     diff_ek_netto_konz,
                     diff_ek_nettonetto_konz,
                     diff_ek_kal_basis_konz,
                     diff_ek_mep_konz,
                     diff_einstandspreis_konz,
                     diff_logkostenzuschlag_konz,
                     diff_ek_netto_bnk_konz,
                     diff_ek_netto_bnk_sachk_konz)
SELECT DISTINCT
       z.mandant_id,
       z.wup_id,
       z.nb_id,
       z.art_id,
       z.bewart_det_id,
       z.dat,
       z.wrg_2,
       z.ean_kasse,
       z.menge,
       z.umsatz_netto_alt,
       z.umsatz_mwst_betrag_alt,
       z.umsatz_bto,
       z.umrechnungskurs,
       z.kopf_art_id,
       z.komponentenmengen_faktor,
       z.stueckliste_id,
       z.bq_findung_id,
       0 AS umsatz_anteil,
       z.umsatz_netto_alt AS umsatz_netto,
       z.umsatz_mwst_betrag_alt AS umsatz_mwst,
       (1-a.ek_brutto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_brutto_,
       (1-a.ek_netto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_netto_,
       (1-a.ek_nettonetto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_nettonetto_,
       (1-a.ek_kal_basis_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_kal_basis_,
       (1-a.ek_mep_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_mep_,
       (1-a.einstandspreis_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS einstandspreis_,
       (1-a.logkostenzuschlag_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS logistikkostenzuschlag_,
       (1-a.ek_netto_bnk_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_netto_bnk_,
       (1-a.ek_netto_bnk_sachk_spn)*(CAST(umsatz_netto AS DECIMAL(18,2))) AS ek_netto_bnk_sachk_,
       CAST(ek_brutto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_brutto_konz,
       CAST(ek_netto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_konz,
       CAST(ek_nettonetto_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_nettonetto_konz,
       CAST(ek_kal_basis_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_kal_basis_konz,
       CAST(ek_mep_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_mep_konz,
       CAST(einstandspreis_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_einstandspreis_konz,
       CAST(logistikkostenzuschlag_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_logkostenzuschlag_konz,
       CAST(ek_netto_bnk_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_konz,
       CAST(ek_netto_bnk_sachk_ * umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_sachk_konz
FROM _step02_2 z
JOIN _spannen_agg2_2 a
  ON z.mandant_id     = a.mandant_id     AND
     z.wup_id         = a.wup_id         AND
     z.art_id         = a.kopf_art_id    AND
     z.stueckliste_id = a.stueckliste_id AND
     z.dat            = a.dat            AND
     z.ean_kasse      = a.ean_kasse      and
     z.bewart_det_id  = a.bewart_det_id
WHERE z.kopf_art_id = -100
;

MERGE INTO DBP_DATA.artbew_2 a
USING (SELECT *
       FROM _step03_2
       WHERE kopf_art_id = -100) b

  ON a.mandant_id = b.mandant_id AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.art_id     = b.art_id     AND
     a.ean_kasse  = b.ean_kasse  AND
     a.dat        = b.dat        AND
     a.bewart_det_id = b.bewart_det_id and
     a.menge      >= 0 
     
WHEN MATCHED THEN UPDATE SET ek_brutto                    =  b.ek_brutto                     ,
                             ek_netto                     =  b.ek_netto                      ,
                             ek_nettonetto                =  b.ek_nettonetto                 ,
                             ek_kal_basis                 =  b.ek_kal_basis                  ,
                             ek_mep                       =  b.ek_mep                        ,
                             einstandspreis               =  b.einstandspreis                ,
                             logkostenzuschlag            = b.logistikkostenzuschlag,
                             ek_netto_bnk                 =  b.ek_netto_bnk                  ,
                             ek_netto_bnk_sachk           =  b.ek_netto_bnk_sachk            
;

MERGE INTO DBP_DATA.artbew_2 a
USING (SELECT *
       FROM _step03_2
       WHERE kopf_art_id = -100) b

  ON a.mandant_id = b.mandant_id AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.art_id     = b.art_id     AND
     a.ean_kasse  = b.ean_kasse  AND
     a.dat        = b.dat        AND
     a.bewart_det_id = b.bewart_det_id and
     a.menge      < 0
     
WHEN MATCHED THEN UPDATE SET ek_brutto                    =  0,
                             ek_netto                     =  0,
                             ek_nettonetto                =  0,
                             ek_kal_basis                 =  0,
                             ek_mep                       =  0,
                             einstandspreis               =  0,
                             logkostenzuschlag            =  0,
                             ek_netto_bnk                 =  0,
                             ek_netto_bnk_sachk           =  0
;

DELETE FROM DBP_DATA.artbew_stueckliste_zu_2
WHERE (mandant_id, wup_id, dat) IN (SELECT mandant_id,
                                           wup_id,
                                           dat
                                    FROM _step03_2
                                    WHERE mandant_id = 1)
;

INSERT INTO DBP_DATA.artbew_stueckliste_zu_2 (mandant_id,
                                             wup_id,
                                             nb_id,
                                             art_id,
                                             dat,
                                             komponente_art_id,
                                             stueckliste_id,
                                             wrg_id,
                                             umsatz_netto,
                                             umsatz_mwst_betrag,
                                             menge,
                                             ek_brutto,
                                             ek_netto,
                                             ek_nettonetto,
                                             ek_kal_basis,
                                             ek_mep,
                                             einstandspreis,
                                             logkostenzuschlag,
                                             ek_netto_bnk,
                                             ek_netto_bnk_sachk,
                                             bq_findung_id,
                                             umrechnungskurs)

SELECT x.mandant_id,
       x.wup_id,
       x.nb_id,
       x.kopf_art_id AS art_id,
       x.dat,
       x.art_id AS komponente_art_id,
       x.stueckliste_id,
       x.wrg_2 AS wrg_id,
       COALESCE(x.umsatz_netto,0) AS umsatz_netto,
       COALESCE(x.umsatz_mwst,0) AS umsatz_mwst_betrag,
       x.komponentenmengen_faktor AS menge,
       COALESCE((x.ek_brutto           ),0) AS ek_brutto,
       COALESCE((x.ek_netto            ),0) AS ek_netto,
       COALESCE((x.ek_nettonetto       ),0) AS ek_nettonetto,
       COALESCE((x.ek_kal_basis        ),0) AS ek_kal_basis,
       COALESCE((x.ek_mep              ),0) AS ek_mep,
       COALESCE((x.einstandspreis      ),0) AS einstandspreis,
       COALESCE(x.logistikkostenzuschlag                  ,0) AS logkostenzuschlag,
       COALESCE((x.ek_netto_bnk        ),0) AS ek_netto_bnk,
       COALESCE((x.ek_netto_bnk_sachk  ),0) AS ek_netto_bnk_sachk,
       COALESCE(x.bq_findung_id,30) AS bq_findung_id,
       1 AS umrechnungskurs
FROM (SELECT mandant_id,
             wup_id,
             nb_id,
             kopf_art_id,
             dat,
             art_id,
             stueckliste_id,
             wrg_2,
             SUM(umsatz_netto) AS umsatz_netto,
             SUM(umsatz_mwst) AS umsatz_mwst,
             SUM(komponentenmengen_faktor) AS komponentenmengen_faktor,
             SUM(ek_brutto) AS ek_brutto,
             SUM(ek_netto) AS ek_netto,
             SUM(ek_nettonetto) AS ek_nettonetto,
             SUM(ek_kal_basis) AS ek_kal_basis,
             SUM(ek_mep) AS ek_mep,
             SUM(einstandspreis) AS einstandspreis,
             SUM(logistikkostenzuschlag) AS logistikkostenzuschlag,
             SUM(ek_netto_bnk) AS ek_netto_bnk,
             SUM(ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
             bq_findung_id,
             MAX(umrechnungskurs) AS umrechnungskurs
      FROM _step03_2
      WHERE kopf_art_id <> -100
      GROUP BY 1,2,3,4,5,6,7,8,21) x
;
