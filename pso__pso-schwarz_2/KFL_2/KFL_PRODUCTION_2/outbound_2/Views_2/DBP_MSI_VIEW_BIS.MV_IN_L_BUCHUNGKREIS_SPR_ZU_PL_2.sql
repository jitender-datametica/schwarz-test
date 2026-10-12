CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_in_l_buchungkreis_spr_zu_pl_2 (buchungskreis_id, mandant_id,
spr_id, buchungskreis_bez) AS SELECT V01.buchungskreis_id,
 V01.mandant_id,
 V01.spr_id,
 V01.buchungskreis_bez
FROM kfl_production_dbp_view.v_in_buchungskreis_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_l_buchungskreis_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.buchungskreis_id
    = V02.buchungskreis_id
WHERE V01.spr_id = 90
 AND V02.sako_fg = 1;