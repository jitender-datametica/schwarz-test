--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.KOSTENRECHNUNG_TMP_2 (
KJMO INTEGER NOT NULL,
GJMO INTEGER NOT NULL,
GJ SMALLINT,
AKT_GJ SMALLINT,
AKT_MO SMALLINT,
MO_KJ BIGNUMERIC,
WUP_ID INTEGER,
NB_ID BIGNUMERIC,
MANDANT_ID BIGNUMERIC,
UMS_N_KER NUMERIC(18,2),
UMS_N_KER_PLAN NUMERIC(18,2),
ROHERTRAG NUMERIC(18,2),
ROHERTRAG_PLAN NUMERIC(18,2),
PK_KER NUMERIC(18,2),
PK_KER_PLAN NUMERIC(18,2),
PK_OHNE NUMERIC(18,2),
PK_OHNE_PLAN NUMERIC(18,2),
UMSATZ_WRG STRING
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------


--original statement


--INSERT INTO KFL_PRODUCTION.DBX_LOAD.kostenrechnung_tmp_2


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


--  FROM KFL_PRODUCTION.DBX_DATA.kostenrechnung_2  KER


--


--  INNER JOIN 


--  ( /* Zuordnung basiert auf wup_2-Mapping in Profitcenter (ker / ker_tgl) */


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


--    FROM KFL_PRODUCTION.DBX_DATA.profit_center_2  PC1


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


--        /* Rohertrag I = '999_T11_1' + '0001519002' (ehemals: T11-1 // K111 ohne 142xxx_2) */


--         WHEN ka_lv6 IN ('999-T11-1') OR ka_lv11 IN ('0001519002') THEN 'RE1'


--        /* PKL vergleichbar = ('0000500100', '0000500114', '0000500104', '0000500105', '0000500107', '0000500109', '0000500112', '0000500115', '0000500111', '0000503200', '0000500102', '0000500103', '0000500129', '0000500135', '0000500203', '0000500118', '0000500200', '0000500210', '0000500211', '0000500131') (ehemals: T21 // K21) */


--         WHEN ka_lv11 IN ('0000500100', '0000500114', '0000500104', '0000500105', '0000500107', '0000500109', '0000500112', '0000500115', '0000500111', '0000503200', '0000500102', '0000500103', '0000500129', '0000500135', '0000500203', '0000500118', '0000500200', '0000500210', '0000500211', '0000500131') THEN 'PKL'


--         /* PK (Gesamt) = 'U2' (ehemals: T2 // K2 ohne 70200) */


--         WHEN ka_lv6 IN ('U2') THEN 'PK_'


--        ELSE ''


--      END (CHAR(3)) AS ka_fg


--    FROM KFL_PRODUCTION.DBX_MSI_DATA.ka_ka_grp_denorm_2 


--    WHERE ka_fg <> '' /* nur definierte Knoten / Kostenarten */


--    ) KAKA   


--    ON  KER.kostenart_id = KAKA.ka_lv11


--


--  LEFT OUTER JOIN KFL_PRODUCTION.DBX_DATA.monat_2  MO              -- LEFT JOIN! 13. Periode


--  ON MO.kjmo = KER.kj_ker_mo_id


--


-- LEFT OUTER JOIN KFL_PRODUCTION.DBX_LOAD.vis_mandant_2  VM


-- ON pc.mandant_id = VM.mandant_id


--


-- -- 26.01.2018, -dbay-


-- -- Kostenart_2 '0000809070' fuer NB_ID = 2 (DE) raus!


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


--LEFT JOIN KFL_PRODUCTION.DBX_DATA.monat_2 m1


--ON m1.kjmo = dd1.kjmo


--


--LEFT JOIN KFL_PRODUCTION.DBX_DATA.monat_2 m2


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







INSERT INTO KFL_PRODUCTION_DBP_ETL.KOSTENRECHNUNG_TMP_2 (KJMO, GJMO, GJ, AKT_GJ, AKT_MO, MO_KJ, WUP_ID, NB_ID, MANDANT_ID
 , UMS_N_KER, UMS_N_KER_PLAN, ROHERTRAG, ROHERTRAG_PLAN, PK_KER, PK_KER_PLAN, PK_OHNE, PK_OHNE_PLAN, UMSATZ_WRG)
(SELECT CAST(dd1.KJMO AS INTEGER) AS KJMO,
  CAST(dd1.GJMO AS INTEGER) AS GJMO,
  CAST(dd1.GJ AS SMALLINT) AS GJ,
  CAST(COALESCE(M1.AKT_GJ, M2.AKT_GJ) AS SMALLINT) AS AKT_GJ,
  CAST(COALESCE(M1.AKT_MO, M2.AKT_MO) AS SMALLINT) AS AKT_MO,
  COALESCE(M1.MO_KJ, M2.MO_KJ) AS MO_KJ,
  CAST(dd1.WUP_ID AS INTEGER) AS WUP_ID,
  dd1.NB_ID,
  dd1.MANDANT_ID,
  dd1.UMS_N_KER,
  dd1.UMS_N_KER_PLAN,
  dd1.ROHERTRAG,
  dd1.ROHERTRAG_PLAN,
  dd1.PK_KER,
  dd1.PK_KER_PLAN,
  dd1.PK_OHNE,
  dd1.PK_OHNE_PLAN,
  dd1.WRG_ID
 FROM (SELECT KER.KJ_KER_MO_ID AS KJMO,
    COALESCE(MO.GJMO, KER.KJ_KER_MO_ID) AS GJMO,-- 13. Periode
    COALESCE(MO.GJ, CAST(FLOOR(KER.KJ_KER_MO_ID / 100) AS INTEGER)) AS GJ,-- 13. Periode  -- floor required for SF
    PC.WUP_ID,
    PC.NB_ID,
    PC.PC_ID,
    KER.MANDANT_ID,
    KER.WRG_ID,
    /*  Logik in KAKA Subselect */
    CAST(SUM(CASE
       WHEN KAKA.KA_FG IN ('UMS') AND KER.PLAN_FG = 0
       THEN KER.KOSTENRECHNUNG_BETRAG
       ELSE 0
       END) AS NUMERIC) AS UMS_N_KER,
    CAST(SUM(CASE
       WHEN KAKA.KA_FG IN ('UMS') AND KER.PLAN_FG = 1 AND KER.PLANVARIANTE_ID = '000'
       THEN KER.KOSTENRECHNUNG_BETRAG
       ELSE 0
       END) AS NUMERIC) AS UMS_N_KER_PLAN,
    CAST(SUM(CASE
       WHEN KAKA.KA_FG IN ('RE1')
       THEN KER.KOSTENRECHNUNG_BETRAG
       ELSE 0
       END) AS NUMERIC) AS ROHERTRAG,
    CAST(SUM(CASE
       WHEN KAKA.KA_FG IN ('UMS') AND KER.PLAN_FG = 1 AND KER.PLANVARIANTE_ID = '000'
       THEN KER.KOSTENRECHNUNG_BETRAG
       ELSE 0
       END) AS NUMERIC) AS ROHERTRAG_PLAN,
    CAST(SUM(CASE
       WHEN KAKA.KA_FG IN ('UMS') AND KER.PLAN_FG = 0
       THEN KER.KOSTENRECHNUNG_BETRAG
       ELSE 0
       END) AS NUMERIC) AS PK_OHNE,
    CAST(SUM(CASE
       WHEN KAKA.KA_FG IN ('UMS') AND KER.PLAN_FG = 1 AND KER.PLANVARIANTE_ID = '000'
       THEN KER.KOSTENRECHNUNG_BETRAG
       ELSE 0
       END) AS NUMERIC) AS PK_OHNE_PLAN,
    CAST(SUM(CASE
       WHEN KAKA.KA_FG IN ('UMS') AND KER.PLAN_FG = 0
       THEN KER.KOSTENRECHNUNG_BETRAG
       ELSE 0
       END) AS NUMERIC) AS PK_KER,
    CAST(SUM(CASE
       WHEN KAKA.KA_FG IN ('UMS') AND KER.PLAN_FG = 1 AND KER.PLANVARIANTE_ID = '000'
       THEN KER.KOSTENRECHNUNG_BETRAG
       ELSE 0
       END) AS NUMERIC) AS PK_KER_PLAN
   FROM KFL_PRODUCTION_DBP_DATA.KOSTENRECHNUNG_2 AS KER
    INNER JOIN
     (/* Zuordnung basiert auf wup_2-Mapping in Profitcenter (ker / ker_tgl) */
     SELECT DISTINCT MANDANT_ID,
      SYSTEM_ID,
      KRK_ID,
      PC_ID,
       CASE
       WHEN MANDANT_ID = 5 AND WUP_ID = 8980 OR MANDANT_ID = 6 AND WUP_ID = 8991 OR MANDANT_ID = 3 AND WUP_ID = 8980 OR
            MANDANT_ID = 7 AND WUP_ID = 8980 OR MANDANT_ID = 8 AND WUP_ID = 8980 OR MANDANT_ID = 2 AND WUP_ID = 8980
       THEN CAST(- 1 AS BIGNUMERIC)
       ELSE NB_ID
       END AS NB_ID,
       CASE
       WHEN MANDANT_ID = 5 AND WUP_ID = 8980 OR MANDANT_ID = 6 AND WUP_ID = 8991 OR MANDANT_ID = 3 AND WUP_ID = 8980 OR
            MANDANT_ID = 7 AND WUP_ID = 8980 OR MANDANT_ID = 8 AND WUP_ID = 8980 OR MANDANT_ID = 2 AND WUP_ID = 8980
       THEN 0
       ELSE WUP_ID
       END AS WUP_ID
     FROM KFL_PRODUCTION_DBP_DATA.PROFIT_CENTER_2 AS PC1
     WHERE NB_ID NOT IN (- 111, 6)-- OHNE Lager, Backshop
  ) PC
      AND WUP_ID IS NOT NULL -- nur gemappte PC!
      ) AS PC ON KER.PC_ID = PC.PC_ID AND KER.SYSTEM_ID = PC.SYSTEM_ID AND KER.KRK_ID = PC.KRK_ID
     AND KER.MANDANT_ID = PC.MANDANT_ID
    INNER JOIN ( /* 2015-11-03 : Mapping auf Basis UGS-Struktur + Gruppierung nach Knoten bzw Kostenarten + Filterung */
      SELECT KA_LV1,
      KA_LV2,
      KA_LV3,
      KA_LV4,
      KA_LV5,
      KA_LV6,
      KA_LV7,
      KA_LV8,
      KA_LV9,
      KA_LV10,
      KA_LV11,
       CASE
       /* Umsatz (extern) = 'U111' ohne Liste (ehemals: T0-1 // K0-1) */
       WHEN KA_LV8 IN ('U111-1') AND KA_LV11 NOT IN ('0000380000', '0000380001', '0000380002', '0000380003',
          '0000380004', '0000380005', '0000380006', '0000380007', '0000380008', '0000380009', '0000380010', '0000380011'
          , '0000380012', '0000380013', '0000380014', '0000380015', '0000380016', '0000380017', '0000380020',
          '0000380021', '0000380022', '0000380023', '0000380024', '0000380030', '0000380031', '0000380032', '0000380033'
          , '0000380034', '0000380040', '0000380041', '0000380042', '0000380043', '0000380044', '0000380045',
          '0000380050', '0000380051', '0000380052', '0000380053', '0001429120', '0001429122', '0001429130', '0001429131'
          , '0001429132', '0001429342', '0001429480', '0001429540', '0001429893', '0001429668', '0000382006',
           -- 07.12.2018, -dbay-
                                                       -- Erweiterung laut Vorlage!
          '0000382007', '0000382008', '0000382009', '0000382010', '0000382011', '0000382012', '0000382013', '0000382014'
          , '0000382015', '0000382016', '0000382017', '0000382018', '0000382019', '0000382020', '0000386001',
          '0000386002', '0000386003', '0000386004', '0000386005', '0000386006', '0000386007', '0000386008', '0000386009'
          , '0000386010', '0000386011', '0000386012', '0000386013', '0000386014')
       THEN 'UMS'
       /* Umsatz = 'U11' (ehemals: T0 // K0) -- NOT USED */
       WHEN KA_LV7 IN ('U111')
       THEN 'UM_'
       /* Rohertrag I = '999_T11_1' + '0001519002' (ehemals: T11-1 // K111 ohne 142xxx_2) */
       WHEN KA_LV6 IN ('999-T11-1') OR KA_LV11 IN ('0001519002')
       THEN 'RE1'
       /* PKL vergleichbar = ('0000500100', '0000500114', '0000500104', '0000500105', '0000500107', '0000500109', '0000500112', '0000500115', '0000500111', '0000503200', '0000500102', '0000500103', '0000500129', '0000500135', '0000500203', '0000500118', '0000500200', '0000500210', '0000500211', '0000500131') (ehemals: T21 // K21) */
       WHEN KA_LV11 IN ('0000500100', '0000500114', '0000500104', '0000500105', '0000500107', '0000500109', '0000500112'
         , '0000500115', '0000500111', '0000503200', '0000500102', '0000500103', '0000500129', '0000500135',
         '0000500203', '0000500118', '0000500200', '0000500210', '0000500211', '0000500131')
       THEN 'PKL'
       /* PK (Gesamt) = 'U2' (ehemals: T2 // K2 ohne 70200) */
       WHEN KA_LV6 IN ('U2')
       THEN 'PK_'
       ELSE ''
       END AS KA_FG
     FROM KFL_PRODUCTION_DBP_MSI_DATA.KA_KA_GRP_DENORM_2
     WHERE CASE /* nur definierte Knoten / Kostenarten */
    ) KAKA   
        WHEN KA_LV8 IN ('U111-1') AND KA_LV11 NOT IN ('0000380000', '0000380001', '0000380002', '0000380003',
           '0000380004', '0000380005', '0000380006', '0000380007', '0000380008', '0000380009', '0000380010',
           '0000380011', '0000380012', '0000380013', '0000380014', '0000380015', '0000380016', '0000380017',
           '0000380020', '0000380021', '0000380022', '0000380023', '0000380024', '0000380030', '0000380031',
           '0000380032', '0000380033', '0000380034', '0000380040', '0000380041', '0000380042', '0000380043',
           '0000380044', '0000380045', '0000380050', '0000380051', '0000380052', '0000380053', '0001429120',
           '0001429122', '0001429130', '0001429131', '0001429132', '0001429342', '0001429480', '0001429540',
           '0001429893', '0001429668', '0000382006', '0000382007', '0000382008', '0000382009', '0000382010',
           '0000382011', '0000382012', '0000382013', '0000382014', '0000382015', '0000382016', '0000382017',
           '0000382018', '0000382019', '0000382020', '0000386001', '0000386002', '0000386003', '0000386004',
           '0000386005', '0000386006', '0000386007', '0000386008', '0000386009', '0000386010', '0000386011',
           '0000386012', '0000386013', '0000386014')
        THEN 'UMS'
        WHEN KA_LV7 IN ('U111')
        THEN 'UM_'
        WHEN KA_LV6 IN ('999-T11-1') OR KA_LV11 IN ('0001519002')
        THEN 'RE1'
        WHEN KA_LV11 IN ('0000500100', '0000500114', '0000500104', '0000500105', '0000500107', '0000500109',
          '0000500112', '0000500115', '0000500111', '0000503200', '0000500102', '0000500103', '0000500129', '0000500135'
          , '0000500203', '0000500118', '0000500200', '0000500210', '0000500211', '0000500131')
        THEN 'PKL'
        WHEN KA_LV6 IN ('U2')
        THEN 'PK_'
        ELSE ''
        END <> '') AS KAKA ON KER.KOSTENART_ID = KAKA.KA_LV11
    LEFT JOIN KFL_PRODUCTION_DBP_DATA.MONAT_2 AS MO  -- LEFT JOIN! 13. Periode
    ON KER.KJ_KER_MO_ID = MO.KJMO
    LEFT JOIN KFL_PRODUCTION_DBP_DATA.MANDANT_2 AS VM ON PC.MANDANT_ID = VM.MANDANT_ID
   -- 26.01.2018, -dbay-
 -- Kostenart_2 '0000809070' fuer NB_ID = 2 (DE) raus!
   WHERE CASE
      WHEN PC.MANDANT_ID = 1 AND (PC.NB_ID <> 2 OR KER.KOSTENART_ID <> '0000809070') OR PC.MANDANT_ID > 1
      THEN 1
      ELSE 0
      END = 1
   GROUP BY KJMO,
    GJMO,
    GJ,
    PC.WUP_ID,
    PC.NB_ID,
    PC.PC_ID,
    KER.MANDANT_ID,
    KER.WRG_ID) AS dd1
  LEFT JOIN KFL_PRODUCTION_DBP_DATA.MONAT_2 AS M1 ON dd1.KJMO = M1.KJMO
  LEFT JOIN KFL_PRODUCTION_DBP_DATA.MONAT_2 AS M2 ON M2.GJMO = dd1.GJMO - 1);


--[not OK] statement is not translated correctly-----------------------------------------------------------------


--original statement


--UPDATE KFL_PRODUCTION.DBX_LOAD.kostenrechnung_tmp_2 FROM (SELECT ker.mandant_id AS mandant_id_


--                                               , -1 (NUMBER) AS nb_id_


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


--                                          FROM KFL_PRODUCTION.DBX_DATA.kostenrechnung_2 ker


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


--error line 5 at position 53 unexpected 'NUMBER'.


--                                               , -1 ( ^^^> NUMBER) AS nb_id_


--syntax error line 7 at position 55 unexpected 'pc_id'.


--                                                  WHEN  ^^^> pc_id = 'DE0002ZF' THEN 2


--syntax error line 18 at position 42 unexpected 'FROM'.


--                                           ^^^> FROM KFL_PRODUCTION.DBP_DATA.kostenrechnung_2 ker


--syntax error line 22 at position 124 unexpected ')'.


--                                                pc_id IN ('DE0002ZF','DE0014ZF','DE0022ZF','DE0028ZF','DE0040ZF','DE0043ZF') ^^^> ) b


--translated statement





UPDATE KFL_PRODUCTION_DBP_ETL.KOSTENRECHNUNG_TMP_2 SET
 UMS_N_KER = KOSTENRECHNUNG_TMP.UMS_N_KER + b.UMS_NETTO_ FROM (SELECT MANDANT_ID AS MANDANT_ID_,
   CAST(- 1 AS BIGNUMERIC) AS NB_ID_,
    CASE
    WHEN PC_ID = 'DE0002ZF'
    THEN 2
    WHEN PC_ID = 'DE0014ZF'
    THEN 124
    WHEN PC_ID = 'DE0022ZF'
    THEN 22
    WHEN PC_ID = 'DE0028ZF'
    THEN 28
    WHEN PC_ID = 'DE0040ZF'
    THEN 46
    WHEN PC_ID = 'DE0043ZF'
    THEN 43
    ELSE 0
    END AS WUP_ID_,
   WRG_ID AS WRG_ID_,
   KJ_KER_MO_ID AS KJMO_,
   KOSTENRECHNUNG_BETRAG AS UMS_NETTO_-- zu vorhanden Werten/Inhalten addieren
  FROM KFL_PRODUCTION_DBP_DATA.KOSTENRECHNUNG_2 AS KER
  WHERE MANDANT_ID = 1
   AND KJ_KER_MO_ID = 201802
   AND KOSTENART_ID = '0001429480'
   AND PC_ID IN ('DE0002ZF', 'DE0014ZF', 'DE0022ZF', 'DE0028ZF', 'DE0040ZF', 'DE0043ZF')) AS b
WHERE KOSTENRECHNUNG_TMP.MANDANT_ID = b.MANDANT_ID_ AND KOSTENRECHNUNG_TMP.WUP_ID = b.WUP_ID_ AND KOSTENRECHNUNG_TMP.NB_ID
     = b.NB_ID_ AND KOSTENRECHNUNG_TMP.KJMO = b.KJMO_ AND KOSTENRECHNUNG_TMP.UMSATZ_WRG = b.WRG_ID_;