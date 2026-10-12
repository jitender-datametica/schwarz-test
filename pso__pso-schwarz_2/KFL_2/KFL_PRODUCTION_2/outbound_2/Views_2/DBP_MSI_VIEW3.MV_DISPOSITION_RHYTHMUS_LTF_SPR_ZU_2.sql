-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial

-- 26.09.2018, AP0018098 - Disporhythmus, srom0404, Erweiterung -1 = nicht gepflegt

-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_disposition_rhythmus_ltf_spr_zu_2(USERID STRING) AS SELECT T01.mandant_id,
 T01.spr_id,
 T01.disposition_rhythmus_ltf_id,
 T01.disposition_rhythmus_ltf_id_bez,
 T01.disposition_rhythmus_ltf_bez
FROM kfl_production_dbp_msi_view3.tbl_mv_disposition_rhythmus_ltf_spr_zu_2 AS T01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_2(USERID) AS V03 ON T01.spr_id = V03.spr_id;