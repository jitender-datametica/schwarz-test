-- 20230717 staeblern Umstellung auf Session Variable

-- 08.07.2018, AP0012522, srom0404 - Dummy Daten 'unbekannte Bestellart'

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_bestellart_spr_zu(USERID STRING) AS SELECT V01.mandant_id,
 V01.bestellart_id,
 V01.spr_id,
 V01.bestellart_bez
FROM kfl_production_dbp_msi_view3_materialized.tbl_mv_bestellart_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu(USERID) AS V03 ON V01.spr_id = V03.spr_id;