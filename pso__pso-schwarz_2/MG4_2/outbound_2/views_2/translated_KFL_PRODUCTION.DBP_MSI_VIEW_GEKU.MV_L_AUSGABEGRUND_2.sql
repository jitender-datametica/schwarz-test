-- 11.02.2016 twie: Lookup Ausgabegrund für Gutschein_2

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_ausgabegrund_2 (ausgeber_id, mandant_id) AS
-- nur GEKU relevante
 SELECT ausgeber_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_ausgeber_2
WHERE ausgeber_id = 'KDM004'
 OR ausgeber_id = 'KDM005';