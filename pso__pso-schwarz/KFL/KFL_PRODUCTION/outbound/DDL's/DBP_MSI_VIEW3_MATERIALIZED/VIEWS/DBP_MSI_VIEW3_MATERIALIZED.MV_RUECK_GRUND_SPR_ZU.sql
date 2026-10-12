-- in der View mv_l_rueck_grund ist entsprechend UNION auf -1 eingebaut

-- AP0002469, 13.01.2016, srom0404, UNION auf -1 (nicht jede Rückführung hat einen Grund)

-- 20230717 staeblern Umstellung auf Session Variable

-- in der View mv_rueckfuehrung_lt ist entsprechend COALESCE mit -1 eingebaut

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_rueck_grund_spr_zu(USERID STRING) AS SELECT V01.rueck_grund_id,
 V01.mandant_id,
 V01.spr_id,
 V01.rueck_grund_bez
FROM kfl_production_dbp_view.v_rueck_grund_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu(USERID) AS V02 ON V01.spr_id = V02.spr_id
UNION DISTINCT
SELECT -1 AS rueck_grund_id,
 mandant_id,
 22 AS spr_id,
 'DWH - no reason' AS rueck_grund_bez
FROM kfl_production_dbp_view.v_mandant;