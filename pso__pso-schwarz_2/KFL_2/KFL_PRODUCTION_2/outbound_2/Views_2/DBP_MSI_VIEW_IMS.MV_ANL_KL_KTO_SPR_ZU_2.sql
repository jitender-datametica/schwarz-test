CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_anl_kl_kto_spr_zu_2 AS SELECT SUBSTR('AKL', 1, 3) AS
 objektart_id,
  'AKL:' || anlage_klasse_id AS anl_kl_kto_id,
 anlage_klasse_bez AS anl_kl_kto_bez
FROM kfl_production_dbp_view.v_anlage_klasse_spr_zu_2
WHERE anlage_klasse_bez_kurz <> 'inaktiv'
 AND spr_id = 22
QUALIFY (ROW_NUMBER() OVER (PARTITION BY anlage_klasse_id ORDER BY mandant_id IS NULL, mandant_id)) = 1
UNION DISTINCT
SELECT SUBSTR('KTO', 1, 3) AS objektart_id,
  'KTO:' || kostenart_id AS anl_kl_kto_id,
 kostenart_bez AS anl_kl_kto_bez
FROM kfl_production_dbp_view.v_kostenart_spr_zu_2
WHERE spr_id = 22
 AND mandant_id = 1
 AND krk_id = 'XX01';