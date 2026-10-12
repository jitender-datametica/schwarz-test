-- 2023-07-17, staeblern Umstellen auf Session Variable
 -- 2023-05-05, AP0133256_SPEC0166769, dknop, initial

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_techn_platz_spr_zu_per_2(USERID STRING) AS SELECT V01.techn_platz_id,
 V03.mandant_id,
 V01.spr_id,
 V01.dat_von,
 V01.dat_bis,
 V01.tech_platz_bez
FROM kfl_production_dbp_view.v_techn_platz_spr_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view_log.mv_user_spr_zu_2(USERID) AS V02 ON V01.spr_id = V02.spr_id
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V03 ON TRUE
WHERE V01.dat_bis = DATE '9999-12-31';