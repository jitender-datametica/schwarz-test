-- 20230717 staeblern Umstellung auf Session Variable
 -- Aktuelle/Letzte gueltige Zuordnung (dat_bis 31.12.9999)

-- 05.08.2018, AP0021792, mkub1811: OWG Umstellung
 -- LOOKUP : Hauptwarengruppe
 -- 20170508 AP0017810, SPEC0021927

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_hwg_spr_zu(USERID STRING) AS SELECT V01.hwg_id,
 V01.hwg_bez,
 V01.hwg_id_bez,
 V01.mandant_id,
 V01.arthiertyp_id,
 V01.spr_id
FROM kfl_production_dbp_msi_view3.tbl_mv_hwg_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu(USERID) AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.arthiertyp_id = 2;