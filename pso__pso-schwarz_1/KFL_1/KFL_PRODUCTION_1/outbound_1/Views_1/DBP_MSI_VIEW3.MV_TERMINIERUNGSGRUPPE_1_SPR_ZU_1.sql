-- 24.04.2018, AP0018098 - Disporhythmus, srom0404, Anpassung bzgl. Text für -1

-- Es gibt zur Zeit_1 keine Sprachtabelle. Damit es einheitlich und vom Schema vorbereitet ist, wird hier eine_1 Bezeichnung generiert

-- 20230717 staeblern Umstellung auf Session Variable
 -- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_terminierungsgruppe_1_spr_zu_1(USERID STRING) AS SELECT T01.mandant_id,
 T01.spr_id,
 T01.terminierungsgruppe_1_id,
 T01.terminierungsgruppe_1_bez
FROM kfl_production_dbp_msi_view3.tbl_mv_terminierungsgruppe_1_spr_zu_1 AS T01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V03 ON T01.spr_id = V03.spr_id;