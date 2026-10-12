CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_anlage_klasse_spr_zu_en_1 AS SELECT mandant_id,
 anlage_klasse_id,
 anlage_klasse_bez_kurz,
 anlage_klasse_bez
FROM kfl_production_dbp_view.v_anlage_klasse_spr_zu_1
WHERE spr_id = 24
 AND anlage_klasse_bez_kurz <> 'inaktiv';