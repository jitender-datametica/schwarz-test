-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_in_instandhaltung_leistungsart_spr_zu_2(USERID STRING) AS SELECT V01.mandant_id
 ,
 V01.instandhaltung_leistungsart_id,
 V01.spr_id,
 V01.instandhaltung_leistungsart_bez,
   TRIM(V01.instandhaltung_leistungsart_id) || ' ' || TRIM(V01.instandhaltung_leistungsart_bez) AS
 instandhalt_leistart_bez_lang
FROM kfl_production_dbp_view.v_in_instandhaltung_leistungsart_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_2(USERID) AS V02 ON V01.spr_id = V02.spr_id;