CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_techn_platz_spr_zu_sk AS SELECT V01.techn_platz_id,
 COALESCE(LS.tech_platz_bez, DE.tech_platz_bez, '') AS techn_platz_bez
FROM kfl_production_dbp_view.v_techn_platz_per AS V01
 LEFT JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per AS DE ON V01.techn_platz_id = DE.techn_platz_id AND DE.dat_bis
     = DATE '9999-12-31' AND DE.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per AS LS ON V01.techn_platz_id = LS.techn_platz_id AND LS.dat_bis
     = DATE '9999-12-31' AND LS.spr_id = 108
WHERE V01.dat_bis = DATE '9999-12-31';