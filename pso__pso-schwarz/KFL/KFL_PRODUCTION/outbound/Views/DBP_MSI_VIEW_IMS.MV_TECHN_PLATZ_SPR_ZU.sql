CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_techn_platz_spr_zu AS SELECT V01.techn_platz_id,
 COALESCE(V02.tech_platz_bez, '') AS techn_platz_bez
FROM kfl_production_dbp_view.v_techn_platz_per AS V01
 LEFT JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per AS V02 ON V01.techn_platz_id = V02.techn_platz_id AND V02.dat_bis
     = DATE '9999-12-31' AND V02.spr_id = 22
WHERE V01.dat_bis = DATE '9999-12-31';