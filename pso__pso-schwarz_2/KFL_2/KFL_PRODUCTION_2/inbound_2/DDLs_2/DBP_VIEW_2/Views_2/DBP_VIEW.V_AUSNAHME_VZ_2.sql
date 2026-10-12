CREATE OR REPLACE VIEW DBP_VIEW.V_AUSNAHME_VZ_2
AS SELECT
 MANDANT_ID              ,
 AUSNAHME_VZ_GUID        ,
 MELDUNGSTYP_ID          ,
 NACHRICHTENHANDLER_ID   ,
 ARBEITSGEBIET_ID        ,
 Z_ARBEITSGEBIET_ID      ,
 NACHRICHTENNUMMER       ,
 ART_ID                  ,
 NACHRICHTENQUELLE_ID    ,
 WUP_ID                  ,
 NB_ID                   ,
 GP_ID                   ,
 GP_TEILSORTIMENT_ID     ,
 FREMD_LAGERORT_ID       ,
 BEST_BELEG_ID           ,
 NACHRICHTENSTATUS_ID    ,
 DAT_PLAN                ,
 NACHRICHTENKLASSE_ID    ,
 TD_UPDATE               ,
 TD_INSERT   
FROM
   DBP_DATA.AUSNAHME_VZ_2               ;
