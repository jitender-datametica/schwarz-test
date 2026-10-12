CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_pers_teilbereich_spr_zu_2 (mandant_id, pers_bereich_id,
pers_teilbereich_id, buchungskreis_id, persteilbereich_bez) AS SELECT V01.mandant_id,
 V01.pers_bereich_id,
 V01.pers_teilbereich_id,
 V01.buchungskreis_id,
 V02.persteilbereich_bez
FROM kfl_production_dbp_view.v_l_pers_teilbereich_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_pers_teilbereich_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.pers_bereich_id
       = V02.pers_bereich_id AND V01.pers_teilbereich_id = V02.pers_teilbereich_id AND V01.buchungskreis_id = V02.buchungskreis_id
     AND V02.spr_id = 22;