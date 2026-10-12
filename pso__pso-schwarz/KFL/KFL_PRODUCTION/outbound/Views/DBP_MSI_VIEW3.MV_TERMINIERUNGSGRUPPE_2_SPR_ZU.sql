-- Es gibt zur Zeit keine Sprachtabelle. Damit es einheitlich und vom Schema vorbereitet ist, wird hier eine Bezeichnung generiert

-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
 -- 20230717 staeblern Umstellung auf Session Variable

-- 24.04.2018, AP0018098 - Disporhythmus, srom0404, Anpassung bzgl. Text für -1

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_terminierungsgruppe_2_spr_zu(USERID STRING) AS SELECT T01.mandant_id,
 T01.spr_id,
 T01.terminierungsgruppe_2_id,
 T01.terminierungsgruppe_2_bez
FROM kfl_production_dbp_msi_view3.tbl_mv_terminierungsgruppe_2_spr_zu AS T01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu(USERID) AS V03 ON T01.spr_id = V03.spr_id;