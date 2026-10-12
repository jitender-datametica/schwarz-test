CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_flw_qualitaet (flw_qualitaet_id) AS SELECT V01.zusatzinfo_sel_id
  AS flw_qualitaet_id
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'FLW Qualität'
UNION ALL
SELECT - 1 AS flw_qualitaet_id
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;