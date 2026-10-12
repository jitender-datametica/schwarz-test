-- Makro zur Pflege der Tabelle wup_stunden_tag_1 - Variante Filiale (FIL)

-- (Variante Zentrale = m_ups_wup_stunden_tag_ZEN)

-- Wenn Sperre (sperre = 1) gesetzt, wird immer der vorhandene Originalwert aus der Tabelle genommen, ansonsten der Eingabewert

-- Sperre Monat_1 > Stunden_1 IST (AUSL) + Stunden_1 IST Sonst (INTEGER ) + Stunden_1 Versetzung (AUSL)

-- Sperre Woche_1 > Umsatz Pflege (INTEGER ) + Stunden_1 Plan (INTEGER ) + Stunden_1 Plan sonst (INTEGER )

-- Die anderen Inhalte der Tabelle werden nicht per Transaction gepflegt. Wichtig: Insert benoetigt Waehrung aus vorhanden Daten, daher kein Parameter.

-- 2017.0116 ssch0611 : neuer Parameter (3. Eingabesperre) + CASE fuer Stunden_1 Plan (DE) ergaenzt + Anpassung stunden_plan_sonstige (analog stunden_sonstige)

-- 2017.0516 ssch0611 : Review Leistung = zwei Sperren (andere Inhalte) + CASE Logik International + neue Spalten/Felder

-- 2017.0710 ssch0611 : neues Macro-Objekt (FIL). 3 Sperren (Zeit_1) + 1 Sperre (Land_1) + Unterscheidung DE/Ausland



-- using select
-- v01



CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wup_stunden_tag_fil_hr(IN MANDANT_ID FLOAT64,
 IN WUP_ID FLOAT64,
 IN NB_ID FLOAT64,
 IN DAT STRING,
 IN UMS_NETTO_PLAN_MAN FLOAT64,
 IN STUNDEN_MARKT FLOAT64,
 IN STUNDEN_SONSTIGE FLOAT64,
 IN STUNDEN_VERSETZUNG FLOAT64,
 IN STUNDEN_PLAN FLOAT64,
 IN STUNDEN_SONSTIGE_PLAN FLOAT64,
 IN SPERRE_WOCHE_SO FLOAT64,
 IN SPERRE_MONAT_7 FLOAT64,
 IN SPERRE_MONAT_15 FLOAT64,
 IN SPERRE_LAND FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;

--Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
SET sql_stmt  =  '''MERGE INTO dbp_data.wup_stunden_tag_hr_1 USING (SELECT v01.wup_id,
   v01.nb_id,
   v01.mandant_id,
   v01.dat,
   v03.wrg_id,
   V02.ums_netto_plan_man,
   V02.stunden_markt,
    CASE    WHEN v01.mandant_id = 1 AND @SPERRE_MONAT_7 = 0    THEN CAST(V02.stunden_sonstige AS FLOAT64)    WHEN @MANDANT_ID_1 <> 1 AND @SPERRE_MONAT_15_1 = 0    THEN COALESCE(@STUNDEN_SONSTIGE_1, V02.stunden_sonstige)    ELSE CAST(IF(V02.stunden_sonstige = 0, NULL, V02.stunden_sonstige) AS FLOAT64)    END AS stunden_sonstige,   
   V02.stunden_versetzung,   
   V02.stunden_plan,   
     CASE    WHEN @MANDANT_ID_1_2_3 = 1 AND @SPERRE_WOCHE_SO_1_2 = 0    THEN CAST(COALESCE(V02.stunden_sonstige, V02.stunden_sonstige_plan) AS FLOAT64)    WHEN @MANDANT_ID_1_2_3_4 <> 1 AND @SPERRE_MONAT_15_1_2_3 = 0    THEN COALESCE(@STUNDEN_SONSTIGE_PLAN_1, V02.stunden_sonstige_plan)    ELSE CAST(V02.stunden_sonstige_plan AS FLOAT64)    END AS stunden_sonstige_plan  
     FROM (SELECT V01_2.wup_id,     V01_2.nb_id,     V01_2.mandant_id,     V01_1.dat    FROM dbp_data.tag_1 AS V01_1     INNER JOIN dbp_data.wup_1 AS V01_2 ON TRUE    WHERE V01_2.mandant_id = @MANDANT_ID_1_2_3_4_5     
     AND V01_1.dat = DATE(V01_1.dat)          AND V01_2.wup_id IS NOT NULL     AND V01_2.nb_id IS NOT NULL) AS v01   
    LEFT JOIN dbp_data.wup_stunden_tag_hr_1 AS V02 ON 
    v01.wup_id = V02.wup_id AND v01.nb_id = V02.nb_id 
    AND      v01.mandant_id = V02.mandant_id AND v01.dat = V02.dat   
    LEFT JOIN (SELECT mandant_id,     wrg_id    FROM dbp_data.mandant_wrg_typ_zu_1    WHERE wrg_typ_id = 1) AS v03     ON v01.mandant_id = v03.mandant_id) AS using_select 
    ON wup_stunden_tag_hr.wup_id = using_select.wup_id 
    AND wup_stunden_tag_hr.nb_id = using_select.nb_id 
    AND    wup_stunden_tag_hr.mandant_id = using_select.mandant_id 
    AND wup_stunden_tag_hr.dat = using_select.dat 
  WHEN MATCHED THEN UPDATE 
  SET  wrg_id = using_select.wrg_id,  
  ums_netto_plan_man = using_select.ums_netto_plan_man,  
  stunden_markt = using_select.stunden_markt,  
  stunden_sonstige = CAST(ROUND(CAST(using_select.stunden_sonstige AS BIGNUMERIC), 0) AS NUMERIC),  
  stunden_versetzung = using_select.stunden_versetzung,  
  stunden_plan = using_select.stunden_plan,  
  stunden_sonstige_plan = CAST(ROUND(CAST(using_select.stunden_sonstige_plan AS BIGNUMERIC), 0) AS NUMERIC) 
  WHEN NOT MATCHED THEN INSERT (wup_id,
   nb_id,
   mandant_id,
   dat,
   stunden_markt,
   stunden_sonstige,
   stunden_plan,
    stunden_co5_sonstige,
   ums_netto_plan,
   ums_netto_plan_man,
   wrg_id,
   stunden_sonstige_plan,
   stunden_co1_iks,
    stunden_co2_ea,
   stunden_co3_anue,
   stunden_co4_reinigung,
   stunden_versetzung,
   stunden_plan_pep) 
  VALUES(using_select.wup_id  ,
   using_select.nb_id, 
   using_select.mandant_id, 
   using_select.dat, 
   using_select.stunden_markt, 
   CAST(ROUND(CAST(using_select.stunden_sonstige AS BIGNUMERIC)    , 0) AS NUMERIC), 
   using_select.stunden_plan, 
   0, 
   0.00, 
   using_select.ums_netto_plan_man, 
   using_select.wrg_id, 
   CAST(ROUND(CAST(using_select.stunden_sonstige_plan AS BIGNUMERIC)    , 0) AS NUMERIC), 
   0, 
   0, 
   0, 
   0, 
   COALESCE(using_select.stunden_versetzung, 0), 
   0) ''';

EXECUTE IMMEDIATE (sql_stmt) USING IF(SPERRE_WOCHE_SO = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SPERRE_WOCHE_SO) AS SPERRE_WOCHE_SO,  IF(UMS_NETTO_PLAN_MAN = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), UMS_NETTO_PLAN_MAN) AS UMS_NETTO_PLAN_MAN,  IF(SPERRE_LAND = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SPERRE_LAND) AS SPERRE_LAND,  IF(SPERRE_MONAT_15 = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SPERRE_MONAT_15) AS SPERRE_MONAT_15,  IF(STUNDEN_MARKT = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), STUNDEN_MARKT) AS STUNDEN_MARKT,  IF(MANDANT_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), MANDANT_ID) AS MANDANT_ID,  IF(SPERRE_MONAT_7 = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SPERRE_MONAT_7) AS SPERRE_MONAT_7,  IF(STUNDEN_SONSTIGE = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), STUNDEN_SONSTIGE) AS STUNDEN_SONSTIGE,  IF(MANDANT_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), MANDANT_ID) AS MANDANT_ID_1,  IF(SPERRE_MONAT_15 = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SPERRE_MONAT_15) AS SPERRE_MONAT_15_1,  IF(STUNDEN_SONSTIGE = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), STUNDEN_SONSTIGE) AS STUNDEN_SONSTIGE_1,  IF(MANDANT_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), MANDANT_ID) AS MANDANT_ID_1_2,  IF(SPERRE_MONAT_15 = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SPERRE_MONAT_15) AS SPERRE_MONAT_15_1_2,  IF(STUNDEN_VERSETZUNG = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), STUNDEN_VERSETZUNG) AS STUNDEN_VERSETZUNG,  IF(SPERRE_WOCHE_SO = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SPERRE_WOCHE_SO) AS SPERRE_WOCHE_SO_1,  IF(STUNDEN_PLAN = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), STUNDEN_PLAN) AS STUNDEN_PLAN,  IF(MANDANT_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), MANDANT_ID) AS MANDANT_ID_1_2_3,  IF(SPERRE_WOCHE_SO = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SPERRE_WOCHE_SO) AS SPERRE_WOCHE_SO_1_2,  IF(STUNDEN_SONSTIGE_PLAN = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), STUNDEN_SONSTIGE_PLAN) AS STUNDEN_SONSTIGE_PLAN,  IF(MANDANT_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), MANDANT_ID) AS MANDANT_ID_1_2_3_4,  IF(SPERRE_MONAT_15 = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SPERRE_MONAT_15) AS SPERRE_MONAT_15_1_2_3,  IF(STUNDEN_SONSTIGE_PLAN = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), STUNDEN_SONSTIGE_PLAN) AS STUNDEN_SONSTIGE_PLAN_1,  IF(MANDANT_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), MANDANT_ID) AS MANDANT_ID_1_2_3_4_5,  IF(WUP_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), WUP_ID) AS WUP_ID,  IF(NB_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), NB_ID) AS NB_ID,  IF(DAT = CAST(NULL AS STRING), CAST(NULL AS STRING), DAT) AS DAT;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;