--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.kostenrechnung_tmp  (
      kjmo                       INTEGER NOT NULL,
      gjmo                       INTEGER NOT NULL,
      gj                         SMALLINT,
      akt_gj                     SMALLINT,
      akt_mo                     SMALLINT,
      mo_kj                      BYTEINT,
      wup_id                     INTEGER,
      nb_id                      BYTEINT,
      mandant_id                 BYTEINT,
      ums_n_ker                  DECIMAL(18,2),
      ums_n_ker_plan             DECIMAL(18,2),
      rohertrag                  DECIMAL(18,2),
      rohertrag_plan             DECIMAL(18,2),
      pk_ker                     DECIMAL(18,2),
      pk_ker_plan                DECIMAL(18,2),
      pk_ohne                    DECIMAL(18,2),
      pk_ohne_plan               DECIMAL(18,2),
      umsatz_wrg                 CHAR(3)
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_LOAD.kostenrechnung_tmp
--(
--  kjmo                       
--, gjmo                       
--, gj
--, akt_gj
--, akt_mo
--, mo_kj                       
--, wup_id                     
--, nb_id                      
--, mandant_id                 
--, umsatz_wrg      
--, ums_n_ker                  
--, ums_n_ker_plan             
--, rohertrag                  
--, rohertrag_plan             
--, pk_ker                     
--, pk_ker_plan 
--, pk_ohne                     
--, pk_ohne_plan          
--)
--SELECT
--  dd1.kjmo
--, dd1.gjmo
--, dd1.gj
--, COALESCE(m1.akt_gj, m2.akt_gj) AS akt_gj
--, COALESCE(m1.akt_mo, m2.akt_mo) AS akt_mo
--, COALESCE(m1.mo_kj, m2.mo_kj) AS mo_kj
--, dd1.wup_id
--, dd1.nb_id
--, dd1.mandant_id
--, dd1.wrg_id
--, dd1.ums_n_ker
--, dd1.ums_n_ker_plan
--, dd1.rohertrag
--, dd1.rohertrag_plan
--, dd1.pk_ker
--, dd1.pk_ker_plan
--, dd1.pk_ohne
--, dd1.pk_ohne_plan
--FROM 
--(
--SELECT
--    KER.kj_ker_mo_id                    AS kjmo
--  , COALESCE(MO.gjmo, kj_ker_mo_id)     AS gjmo -- 13. Periode
--  , COALESCE(MO.gj, kj_ker_mo_id / 100) AS gj   -- 13. Periode
--  , PC.wup_id                           AS wup_id
--  , PC.nb_id                            AS nb_id
--  , pc.pc_id
--  , KER.mandant_id
--  , KER.wrg_id
--    /*  Logik in KAKA Subselect */
--  , SUM(CASE WHEN KAKA.ka_fg IN ('UMS')        AND KER.plan_fg = 0                                 THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS ums_n_ker
--  , SUM(CASE WHEN KAKA.ka_fg IN ('UMS')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS ums_n_ker_plan
--  , SUM(CASE WHEN KAKA.ka_fg IN ('RE1')                                                            THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS rohertrag
--  , SUM(CASE WHEN KAKA.ka_fg IN ('RE1')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS rohertrag_plan
--  , SUM(CASE WHEN KAKA.ka_fg IN ('PKL')        AND KER.plan_fg = 0                                 THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS pk_ohne
--  , SUM(CASE WHEN KAKA.ka_fg IN ('PKL')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS pk_ohne_plan
--  , SUM(CASE WHEN KAKA.ka_fg IN ('PK_', 'PKL') AND KER.plan_fg = 0                                 THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS pk_ker
--  , SUM(CASE WHEN KAKA.ka_fg IN ('PK_', 'PKL') AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS pk_ker_plan
--  FROM DBX_DATA.kostenrechnung  KER
--
--  INNER JOIN 
--  ( /* Zuordnung basiert auf wup-Mapping in Profitcenter (ker / ker_tgl) */
--    SELECT DISTINCT
--      PC1.mandant_id
--    , PC1.system_id
--    , PC1.krk_id
--    , PC1.pc_id
--    , CASE
--        WHEN (pc1.mandant_id = 5 AND pc1.wup_id = 8980) OR
--             (pc1.mandant_id = 6 AND pc1.wup_id = 8991) OR
--             (pc1.mandant_id = 3 AND pc1.wup_id = 8980) OR
--             (pc1.mandant_id = 7 AND pc1.wup_id = 8980) OR
--             (pc1.mandant_id = 8 AND pc1.wup_id = 8980) OR
--             (pc1.mandant_id = 2 AND pc1.wup_id = 8980)
--        THEN -1
--        ELSE pc1.nb_id
--      END AS nb_id
--  , CASE
--      WHEN (pc1.mandant_id = 5 AND pc1.wup_id = 8980) OR
--           (pc1.mandant_id = 6 AND pc1.wup_id = 8991) OR
--           (pc1.mandant_id = 3 AND pc1.wup_id = 8980) OR
--           (pc1.mandant_id = 7 AND pc1.wup_id = 8980) OR
--           (pc1.mandant_id = 8 AND pc1.wup_id = 8980) OR
--           (pc1.mandant_id = 2 AND pc1.wup_id = 8980)
--      THEN 0
--      ELSE pc1.wup_id
--    END AS wup_id
--    FROM DBX_DATA.profit_center  PC1
--    WHERE PC1.wup_id IS NOT NULL -- nur gemappte PC!
--    AND   PC1.nb_id NOT IN (-111, 6)  -- OHNE Lager, Backshop
--  ) PC
--  ON  KER.pc_id = pc.pc_id
--  AND KER.system_id = pc.system_id
--  AND KER.krk_id = pc.krk_id
--  AND KER.mandant_id = pc.mandant_id
--
--  INNER JOIN 
--  ( /* 2015-11-03 : Mapping auf Basis UGS-Struktur + Gruppierung nach Knoten bzw Kostenarten + Filterung */
--    SELECT ka_lv1, ka_lv2, ka_lv3, ka_lv4, ka_lv5, ka_lv6, ka_lv7, ka_lv8, ka_lv9, ka_lv10, ka_lv11
--         , CASE
--         /* Umsatz (extern) = 'U111' ohne Liste (ehemals: T0-1 // K0-1) */
--         WHEN ka_lv8 IN ('U111-1') AND ka_lv11 NOT IN ('0000380000', '0000380001', '0000380002', '0000380003', '0000380004', '0000380005', 
--                                                       '0000380006', '0000380007', '0000380008', '0000380009', '0000380010', '0000380011', 
--                                                       '0000380012', '0000380013', '0000380014', '0000380015', '0000380016', '0000380017', 
--                                                       '0000380020', '0000380021', '0000380022', '0000380023', '0000380024', '0000380030', 
--                                                       '0000380031', '0000380032', '0000380033', '0000380034', '0000380040', '0000380041', 
--                                                       '0000380042', '0000380043', '0000380044', '0000380045', '0000380050', '0000380051', 
--                                                       '0000380052', '0000380053', '0001429120', '0001429122', '0001429130', '0001429131', 
--                                                       '0001429132', '0001429342', '0001429480', '0001429540', '0001429893', '0001429668',
--                                                       -- 07.12.2018, -dbay-
--                                                       -- Erweiterung laut Vorlage!
--                                                       '0000382006', '0000382007', '0000382008', '0000382009', '0000382010', '0000382011',
--                                                       '0000382012', '0000382013', '0000382014', '0000382015', '0000382016', '0000382017',
--                                                       '0000382018', '0000382019', '0000382020', '0000386001', '0000386002', '0000386003',
--                                                       '0000386004', '0000386005', '0000386006', '0000386007', '0000386008', '0000386009',
--                                                       '0000386010', '0000386011', '0000386012', '0000386013', '0000386014')
--
--         THEN 'UMS'
--         /* Umsatz = 'U11' (ehemals: T0 // K0) -- NOT USED */
--         WHEN ka_lv7 IN ('U111') THEN 'UM_'
--        /* Rohertrag I = '999_T11_1' + '0001519002' (ehemals: T11-1 // K111 ohne 142xxx) */
--         WHEN ka_lv6 IN ('999-T11-1') OR ka_lv11 IN ('0001519002') THEN 'RE1'
--        /* PKL vergleichbar = ('0000500100', '0000500114', '0000500104', '0000500105', '0000500107', '0000500109', '0000500112', '0000500115', '0000500111', '0000503200', '0000500102', '0000500103', '0000500129', '0000500135', '0000500203', '0000500118', '0000500200', '0000500210', '0000500211', '0000500131') (ehemals: T21 // K21) */
--         WHEN ka_lv11 IN ('0000500100', '0000500114', '0000500104', '0000500105', '0000500107', '0000500109', '0000500112', '0000500115', '0000500111', '0000503200', '0000500102', '0000500103', '0000500129', '0000500135', '0000500203', '0000500118', '0000500200', '0000500210', '0000500211', '0000500131') THEN 'PKL'
--         /* PK (Gesamt) = 'U2' (ehemals: T2 // K2 ohne 70200) */
--         WHEN ka_lv6 IN ('U2') THEN 'PK_'
--        ELSE ''
--      END (CHAR(3)) AS ka_fg
--    FROM DBX_MSI_DATA.ka_ka_grp_denorm 
--    WHERE ka_fg <> '' /* nur definierte Knoten / Kostenarten */
--    ) KAKA   
--    ON  KER.kostenart_id = KAKA.ka_lv11
--
--  LEFT OUTER JOIN DBX_DATA.monat  MO              -- LEFT JOIN! 13. Periode
--  ON MO.kjmo = KER.kj_ker_mo_id
--
-- LEFT OUTER JOIN DBX_LOAD.vis_mandant  VM
-- ON pc.mandant_id = VM.mandant_id
--
-- -- 26.01.2018, -dbay-
-- -- Kostenart '0000809070' fuer NB_ID = 2 (DE) raus!
-- WHERE CASE
--         WHEN (pc.mandant_id = 1 AND
--              (NOT(pc.nb_id = 2 AND
--               ker.kostenart_id = '0000809070'))) OR
--              (pc.mandant_id > 1)
--         THEN 1
--         ELSE 0
--       END = 1
--
--  GROUP BY 1, 2, 3, 4, 5, 6, 7,8
--) dd1
--
--LEFT JOIN DBX_DATA.monat m1
--ON m1.kjmo = dd1.kjmo
--
--LEFT JOIN DBX_DATA.monat m2
--ON m2.gjmo = dd1.gjmo - 1
--;
--
--Comment from validation checker
--error line 53 at position 143 unexpected 'DECIMAL'.
--  , SUM(CASE WHEN KAKA.ka_fg IN ('UMS')        AND KER.plan_fg = 0                                 THEN KER.kostenrechnung_betrag ELSE 0 END) ( ^^^> DECIMAL(18,2)) AS ums_n_ker
--syntax error line 53 at position 150 unexpected '('.
--  , SUM(CASE WHEN KAKA.ka_fg IN ('UMS')        AND KER.plan_fg = 0                                 THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL ^^^> (18,2)) AS ums_n_ker
--syntax error line 53 at position 154 unexpected '2'.
--  , SUM(CASE WHEN KAKA.ka_fg IN ('UMS')        AND KER.plan_fg = 0                                 THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18, ^^^> 2)) AS ums_n_ker
--syntax error line 54 at position 7 unexpected '('.
--  , SUM ^^^> (CASE WHEN KAKA.ka_fg IN ('UMS')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS ums_n_ker_plan
--syntax error line 54 at position 154 unexpected '2'.
--  , SUM(CASE WHEN KAKA.ka_fg IN ('UMS')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18, ^^^> 2)) AS ums_n_ker_plan
--syntax error line 55 at position 7 unexpected '('.
--  , SUM ^^^> (CASE WHEN KAKA.ka_fg IN ('RE1')                                                            THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS rohertrag
--syntax error line 55 at position 154 unexpected '2'.
--  , SUM(CASE WHEN KAKA.ka_fg IN ('RE1')                                                            THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18, ^^^> 2)) AS rohertrag
--syntax error line 56 at position 7 unexpected '('.
--  , SUM ^^^> (CASE WHEN KAKA.ka_fg IN ('RE1')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18,2)) AS rohertrag_plan
--syntax error line 56 at position 154 unexpected '2'.
--  , SUM(CASE WHEN KAKA.ka_fg IN ('RE1')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END) (DECIMAL(18, ^^^> 2)) AS rohertrag_plan
--syntax erro
--translated statement
INSERT INTO DBP_ETL.kostenrechnung_tmp
(
  kjmo                       
, gjmo                       
, gj
, akt_gj
, akt_mo
, mo_kj                       
, wup_id                     
, nb_id                      
, mandant_id                 
, umsatz_wrg      
, ums_n_ker                  
, ums_n_ker_plan             
, rohertrag                  
, rohertrag_plan             
, pk_ker                     
, pk_ker_plan 
, pk_ohne                     
, pk_ohne_plan          
)
   
   
   
 
 
 SELECT
  dd1.kjmo
, dd1.gjmo
, dd1.gj
, COALESCE(m1.akt_gj, m2.akt_gj) AS akt_gj
, COALESCE(m1.akt_mo, m2.akt_mo) AS akt_mo
, COALESCE(m1.mo_kj, m2.mo_kj) AS mo_kj
, dd1.wup_id
, dd1.nb_id
, dd1.mandant_id
, dd1.wrg_id
, dd1.ums_n_ker
, dd1.ums_n_ker_plan
, dd1.rohertrag
, dd1.rohertrag_plan
, dd1.pk_ker
, dd1.pk_ker_plan
, dd1.pk_ohne
, dd1.pk_ohne_plan
FROM 
(
SELECT
    KER.kj_ker_mo_id                    AS kjmo
  , COALESCE(MO.gjmo, kj_ker_mo_id)     AS gjmo -- 13. Periode
  , COALESCE(MO.gj, floor(kj_ker_mo_id / 100)) AS gj   -- 13. Periode  -- floor required for SF
  , PC.wup_id                           AS wup_id
  , PC.nb_id                            AS nb_id
  , pc.pc_id
  , KER.mandant_id
  , KER.wrg_id
    /*  Logik in KAKA Subselect */
  , TO_DECIMAL(SUM(CASE WHEN KAKA.ka_fg IN ('UMS')        AND KER.plan_fg = 0                                 THEN KER.kostenrechnung_betrag ELSE 0 END),18,2)  AS ums_n_ker
  , TO_DECIMAL(SUM(CASE WHEN KAKA.ka_fg IN ('UMS')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END),18,2) AS ums_n_ker_plan
  , TO_DECIMAL(SUM(CASE WHEN KAKA.ka_fg IN ('RE1')                                                            THEN KER.kostenrechnung_betrag ELSE 0 END),18,2) AS rohertrag
  , TO_DECIMAL(SUM(CASE WHEN KAKA.ka_fg IN ('RE1')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END),18,2) AS rohertrag_plan
  , TO_DECIMAL(SUM(CASE WHEN KAKA.ka_fg IN ('PKL')        AND KER.plan_fg = 0                                 THEN KER.kostenrechnung_betrag ELSE 0 END),18,2) AS pk_ohne
  , TO_DECIMAL(SUM(CASE WHEN KAKA.ka_fg IN ('PKL')        AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END),18,2) AS pk_ohne_plan
  , TO_DECIMAL(SUM(CASE WHEN KAKA.ka_fg IN ('PK_', 'PKL') AND KER.plan_fg = 0                                 THEN KER.kostenrechnung_betrag ELSE 0 END),18,2) AS pk_ker
  , TO_DECIMAL(SUM(CASE WHEN KAKA.ka_fg IN ('PK_', 'PKL') AND KER.plan_fg = 1 AND KER.planvariante_id = '000' THEN KER.kostenrechnung_betrag ELSE 0 END),18,2) AS pk_ker_plan
  FROM DBP_DATA.kostenrechnung  KER

  INNER JOIN 
  ( /* Zuordnung basiert auf wup-Mapping in Profitcenter (ker / ker_tgl) */
    SELECT DISTINCT
      PC1.mandant_id
    , PC1.system_id
    , PC1.krk_id
    , PC1.pc_id
    , CASE
        WHEN (pc1.mandant_id = 5 AND pc1.wup_id = 8980) OR
             (pc1.mandant_id = 6 AND pc1.wup_id = 8991) OR
             (pc1.mandant_id = 3 AND pc1.wup_id = 8980) OR
             (pc1.mandant_id = 7 AND pc1.wup_id = 8980) OR
             (pc1.mandant_id = 8 AND pc1.wup_id = 8980) OR
             (pc1.mandant_id = 2 AND pc1.wup_id = 8980)
        THEN -1
        ELSE pc1.nb_id
      END AS nb_id
  , CASE
      WHEN (pc1.mandant_id = 5 AND pc1.wup_id = 8980) OR
           (pc1.mandant_id = 6 AND pc1.wup_id = 8991) OR
           (pc1.mandant_id = 3 AND pc1.wup_id = 8980) OR
           (pc1.mandant_id = 7 AND pc1.wup_id = 8980) OR
           (pc1.mandant_id = 8 AND pc1.wup_id = 8980) OR
           (pc1.mandant_id = 2 AND pc1.wup_id = 8980)
      THEN 0
      ELSE pc1.wup_id
    END AS wup_id
    FROM DBP_DATA.profit_center  PC1
    WHERE PC1.wup_id IS NOT NULL -- nur gemappte PC!
    AND   PC1.nb_id NOT IN (-111, 6)  -- OHNE Lager, Backshop
  ) PC
  ON  KER.pc_id = pc.pc_id
  AND KER.system_id = pc.system_id
  AND KER.krk_id = pc.krk_id
  AND KER.mandant_id = pc.mandant_id

  INNER JOIN 
  ( /* 2015-11-03 : Mapping auf Basis UGS-Struktur + Gruppierung nach Knoten bzw Kostenarten + Filterung */
    SELECT ka_lv1, ka_lv2, ka_lv3, ka_lv4, ka_lv5, ka_lv6, ka_lv7, ka_lv8, ka_lv9, ka_lv10, ka_lv11
         , CASE
         /* Umsatz (extern) = 'U111' ohne Liste (ehemals: T0-1 // K0-1) */
         WHEN ka_lv8 IN ('U111-1') AND ka_lv11 NOT IN ('0000380000', '0000380001', '0000380002', '0000380003', '0000380004', '0000380005', 
                                                       '0000380006', '0000380007', '0000380008', '0000380009', '0000380010', '0000380011', 
                                                       '0000380012', '0000380013', '0000380014', '0000380015', '0000380016', '0000380017', 
                                                       '0000380020', '0000380021', '0000380022', '0000380023', '0000380024', '0000380030', 
                                                       '0000380031', '0000380032', '0000380033', '0000380034', '0000380040', '0000380041', 
                                                       '0000380042', '0000380043', '0000380044', '0000380045', '0000380050', '0000380051', 
                                                       '0000380052', '0000380053', '0001429120', '0001429122', '0001429130', '0001429131', 
                                                       '0001429132', '0001429342', '0001429480', '0001429540', '0001429893', '0001429668',
                                                       -- 07.12.2018, -dbay-
                                                       -- Erweiterung laut Vorlage!
                                                       '0000382006', '0000382007', '0000382008', '0000382009', '0000382010', '0000382011',
                                                       '0000382012', '0000382013', '0000382014', '0000382015', '0000382016', '0000382017',
                                                       '0000382018', '0000382019', '0000382020', '0000386001', '0000386002', '0000386003',
                                                       '0000386004', '0000386005', '0000386006', '0000386007', '0000386008', '0000386009',
                                                       '0000386010', '0000386011', '0000386012', '0000386013', '0000386014')

         THEN 'UMS'
         /* Umsatz = 'U11' (ehemals: T0 // K0) -- NOT USED */
         WHEN ka_lv7 IN ('U111') THEN 'UM_'
        /* Rohertrag I = '999_T11_1' + '0001519002' (ehemals: T11-1 // K111 ohne 142xxx) */
         WHEN ka_lv6 IN ('999-T11-1') OR ka_lv11 IN ('0001519002') THEN 'RE1'
        /* PKL vergleichbar = ('0000500100', '0000500114', '0000500104', '0000500105', '0000500107', '0000500109', '0000500112', '0000500115', '0000500111', '0000503200', '0000500102', '0000500103', '0000500129', '0000500135', '0000500203', '0000500118', '0000500200', '0000500210', '0000500211', '0000500131') (ehemals: T21 // K21) */
         WHEN ka_lv11 IN ('0000500100', '0000500114', '0000500104', '0000500105', '0000500107', '0000500109', '0000500112', '0000500115', '0000500111', '0000503200', '0000500102', '0000500103', '0000500129', '0000500135', '0000500203', '0000500118', '0000500200', '0000500210', '0000500211', '0000500131') THEN 'PKL'
         /* PK (Gesamt) = 'U2' (ehemals: T2 // K2 ohne 70200) */
         WHEN ka_lv6 IN ('U2') THEN 'PK_'
        ELSE ''
      END AS ka_fg
    FROM DBP_MSI_DATA.ka_ka_grp_denorm 
    WHERE ka_fg <> '' /* nur definierte Knoten / Kostenarten */
    ) KAKA   
    ON  KER.kostenart_id = KAKA.ka_lv11

  LEFT OUTER JOIN DBP_DATA.monat  MO              -- LEFT JOIN! 13. Periode
  ON MO.kjmo = KER.kj_ker_mo_id

 LEFT OUTER JOIN DBP_data.mandant  VM
 ON pc.mandant_id = VM.mandant_id

 -- 26.01.2018, -dbay-
 -- Kostenart '0000809070' fuer NB_ID = 2 (DE) raus!
 WHERE CASE
         WHEN (pc.mandant_id = 1 AND
              (NOT(pc.nb_id = 2 AND
               ker.kostenart_id = '0000809070'))) OR
              (pc.mandant_id > 1)
         THEN 1
         ELSE 0
       END = 1

  GROUP BY 1, 2, 3, 4, 5, 6, 7,8
) dd1

LEFT JOIN DBP_DATA.monat m1
ON m1.kjmo = dd1.kjmo

LEFT JOIN DBP_DATA.monat m2
ON m2.gjmo = dd1.gjmo - 1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE DBX_LOAD.kostenrechnung_tmp FROM (SELECT ker.mandant_id AS mandant_id_
--                                               , -1 (BYTEINT) AS nb_id_
--                                               , CASE 
--                                                  WHEN pc_id = 'DE0002ZF' THEN 2
--                                                  WHEN pc_id = 'DE0014ZF' THEN 124
--                                                  WHEN pc_id = 'DE0022ZF' THEN 22
--                                                  WHEN pc_id = 'DE0028ZF' THEN 28
--                                                  WHEN pc_id = 'DE0040ZF' THEN 46
--                                                  WHEN pc_id = 'DE0043ZF' THEN 43
--                                                  ELSE 0
--                                                END (INTEGER) AS wup_id_
--                                               , ker.wrg_id AS wrg_id_
--                                               , kj_ker_mo_id AS kjmo_
--                                               , ker.kostenrechnung_betrag AS ums_netto_ -- zu vorhanden Werten/Inhalten addieren
--                                          FROM DBX_DATA.kostenrechnung ker
--                                          WHERE mandant_id = 1 AND 
--                                                kj_ker_mo_id = 201802 AND 
--                                                kostenart_id = '0001429480' AND 
--                                                pc_id IN ('DE0002ZF','DE0014ZF','DE0022ZF','DE0028ZF','DE0040ZF','DE0043ZF')) b
--
--SET ums_n_ker = ums_n_ker+ums_netto_
--
--WHERE mandant_id = mandant_id_ AND
--      wup_id = wup_id_ AND
--      nb_id = nb_id_ AND
--      kjmo = kjmo_ AND
--      umsatz_wrg = wrg_id_
--;
--
--Comment from validation checker
--error line 5 at position 53 unexpected 'BYTEINT'.
--                                               , -1 ( ^^^> BYTEINT) AS nb_id_
--syntax error line 7 at position 55 unexpected 'pc_id'.
--                                                  WHEN  ^^^> pc_id = 'DE0002ZF' THEN 2
--syntax error line 18 at position 42 unexpected 'FROM'.
--                                           ^^^> FROM DBP_DATA.kostenrechnung ker
--syntax error line 22 at position 124 unexpected ')'.
--                                                pc_id IN ('DE0002ZF','DE0014ZF','DE0022ZF','DE0028ZF','DE0040ZF','DE0043ZF') ^^^> ) b
--translated statement
UPDATE DBP_ETL.kostenrechnung_tmp 
SET ums_n_ker = ums_n_ker+ums_netto_

FROM (SELECT 
ker.mandant_id AS mandant_id_
, TO_NUMBER(-1) AS nb_id_
                       
                       , CASE 
                                                  WHEN pc_id = 'DE0002ZF' THEN TO_NUMBER(2)
                                                  WHEN pc_id = 'DE0014ZF' THEN TO_NUMBER(124)
                                                  WHEN pc_id = 'DE0022ZF' THEN TO_NUMBER(22)
                                                  WHEN pc_id = 'DE0028ZF' THEN TO_NUMBER(28)
                                                  WHEN pc_id = 'DE0040ZF' THEN TO_NUMBER(46)
                                                  WHEN pc_id = 'DE0043ZF' THEN TO_NUMBER(43)
                                                  ELSE TO_NUMBER(0)
                                                END  AS wup_id_
                                               , ker.wrg_id AS wrg_id_
                                               , kj_ker_mo_id AS kjmo_
                                               , ker.kostenrechnung_betrag AS ums_netto_ -- zu vorhanden Werten/Inhalten addieren
                                          FROM DBP_DATA.kostenrechnung ker
                                          WHERE mandant_id = 1 AND 
                                                kj_ker_mo_id = 201802 AND 
                                                kostenart_id = '0001429480' AND 
                                                pc_id IN ('DE0002ZF','DE0014ZF','DE0022ZF','DE0028ZF','DE0040ZF','DE0043ZF')) b
 WHERE mandant_id = mandant_id_ AND
      wup_id = wup_id_ AND
      nb_id = nb_id_ AND
      kjmo = kjmo_ AND
      umsatz_wrg = wrg_id_
;

