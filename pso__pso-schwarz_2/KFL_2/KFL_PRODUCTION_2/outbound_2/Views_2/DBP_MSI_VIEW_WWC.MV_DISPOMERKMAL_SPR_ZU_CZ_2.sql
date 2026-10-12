CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_dispomerkmal_spr_zu_cz_2 (mandant_id, dismm, spr_id, dibez) AS
SELECT mandant_id,
 dispomerkmal AS dismm,
 spr_id,
 dispomerkmal_bez AS dibez
FROM kfl_production_dbp_view.v_dispomerkmal_spr_zu_2
WHERE spr_id = 124
 AND mandant_id <> 1;