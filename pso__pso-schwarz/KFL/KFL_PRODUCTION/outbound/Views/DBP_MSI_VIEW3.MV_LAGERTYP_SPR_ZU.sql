-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_lagertyp_spr_zu(USERID STRING) AS SELECT V01.lagernummer_id,
 UPPER(V01.lagertyp_bez) AS lagertyp_bez,
 V01.lagertyp_id,
 V01.mandant_id,
 V01.nb_id,
 V01.spr_id,
 V01.wup_id
FROM kfl_production_dbp_view.v_lagertyp_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu(USERID) AS V02 ON V01.spr_id = V02.spr_id;