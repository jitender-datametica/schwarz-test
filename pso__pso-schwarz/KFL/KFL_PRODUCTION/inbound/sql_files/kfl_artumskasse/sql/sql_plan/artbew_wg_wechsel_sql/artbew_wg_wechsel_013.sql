--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Possible parameter resolution issue
--original statement
--INSERT INTO DBX_LOAD.wpuums_build_tmp (mandant_id
--                                       ,wup_id
--                                       ,wg_id
--                                       ,bewart_id
--                                       ,dat
--                                       ,nb_id
--                                       ,arthiertyp_id
--                                       ,umsatz_brutto
--                                       ,umsatz_netto
--                                       ,umsatz_wrg
--                                       ,umsatz_brutto_konz
--                                       ,umsatz_netto_konz
--                                       ,umsatz_mwst_betrag
--                                       ,kjmo
--                                       ,menge
--                                       ,quelle)
--SELECT a.mandant_id
--      ,a.wup_id
--      ,b.wg_id
--      ,1001 AS bewart_id
--      ,a.dat
--      ,a.nb_id
--      ,2 AS arthiertyp_id
--      ,SUM ((umsatz_netto+umsatz_mwst_betrag)*b.alt_neu_kz) AS umsatz_brutto
--      ,SUM(umsatz_netto*b.alt_neu_kz)
--      ,a.wrg
--      ,0
--      ,0
--      ,SUM(a.umsatz_mwst_betrag*b.alt_neu_kz) AS umsatz_mwst_betrag
--      ,(a.dat / 100) +  190000 AS kjmo
--      ,SUM(a.menge*b.alt_neu_kz) AS menge
--      ,1
--      
--FROM $DBX_ARCHIV.artbew_2016 a
--
--JOIN DBX_LOAD.artbew_wg_wechsel_join b
--ON a.mandant_id = b.mandant_id
--AND a.art_id = b.art_id
--AND a.dat = b.dat
--
--INNER JOIN dbp_data.art_wg_zu_per w
--ON  a.mandant_id = w.mandant_id
--AND a.art_id = w.art_id
--AND w.dat_bis = 80991231
--AND w.arthiertyp_id = 2
--
--WHERE CASE
--        WHEN a.mandant_id = 1 AND a.dat >= 1170301 AND
--             a.art_id IN (590006700,590006900)
--        THEN 0
--        WHEN a.mandant_id = 6 AND
--             a.art_id/10 IN (9800130,9800131,9800132)
--        THEN 0
--        WHEN a.mandant_id = 7 AND
--             a.dat >= 1190301 AND
--             w.wg_id = 969 AND
--             w.wug_id = 6
--        THEN 0
--        ELSE 1
--      END = 1 AND
--      b.wg_id NOT IN (818,969)
--
--GROUP BY 1,2,3,4,5,6,7,10,11,12,14,16
--;
--
--Comment from validation checker
--error line 34 at position 5 unexpected '.'.
--FROM  ^^^> $DBX_ARCHIV.artbew_2016 a
--syntax error line 44 at position 49 unexpected ')'.
--AND w.dat_bis = to_date('9999-12-31','YYYY-MM-DD' ^^^> )
--translated statement
INSERT INTO DBP_ETL.wpuums_build_tmp (mandant_id
                                       ,wup_id
                                       ,wg_id
                                       ,bewart_id
                                       ,dat
                                       ,nb_id
                                       ,arthiertyp_id
                                       ,umsatz_brutto
                                       ,umsatz_netto
                                       ,umsatz_wrg
                                       ,umsatz_brutto_konz
                                       ,umsatz_netto_konz
                                       ,umsatz_mwst_betrag
                                       ,kjmo
                                       ,menge
                                       ,quelle)
SELECT a.mandant_id
      ,a.wup_id
      ,b.wg_id
      ,1001 AS bewart_id
      ,a.dat
      ,a.nb_id
      ,2 AS arthiertyp_id
      ,SUM ((umsatz_netto+umsatz_mwst_betrag)*b.alt_neu_kz) AS umsatz_brutto
      ,SUM(umsatz_netto*b.alt_neu_kz)
      ,a.wrg
      ,0
      ,0
      ,SUM(a.umsatz_mwst_betrag*b.alt_neu_kz) AS umsatz_mwst_betrag
      ,(a.dat / 100) +  190000 AS kjmo
      ,SUM(a.menge*b.alt_neu_kz) AS menge
      ,1
      
FROM $DBX_ARCHIV.artbew_2016 a

JOIN DBP_ETL.artbew_wg_wechsel_join b
ON a.mandant_id = b.mandant_id
AND a.art_id = b.art_id
AND a.dat = b.dat

INNER JOIN dbp_data.art_wg_zu_per w
ON  a.mandant_id = w.mandant_id
AND a.art_id = w.art_id
AND w.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND w.arthiertyp_id = 2

WHERE CASE
        WHEN a.mandant_id = 1 AND a.dat >= 1170301 AND
             a.art_id IN (590006700,590006900)
        THEN 0
        WHEN a.mandant_id = 6 AND
             a.art_id/10 IN (9800130,9800131,9800132)
        THEN 0
        WHEN a.mandant_id = 7 AND
             a.dat >= 1190301 AND
             w.wg_id = 969 AND
             w.wug_id = 6
        THEN 0
        ELSE 1
      END = 1 AND
      b.wg_id NOT IN (818,969)

GROUP BY 1,2,3,4,5,6,7,10,11,12,14,16
;

