CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_anlage_klasse_zu_per AS SELECT anlage_id,
 anlage_sub_id,
 mandant_id,
 buchungskreis_id AS anlage_buchungskreis_id,
 anlage_klasse_id
FROM kfl_production_dbp_view.v_anlage_klasse_zu_per
WHERE dat_bis = DATE '9999-12-31';