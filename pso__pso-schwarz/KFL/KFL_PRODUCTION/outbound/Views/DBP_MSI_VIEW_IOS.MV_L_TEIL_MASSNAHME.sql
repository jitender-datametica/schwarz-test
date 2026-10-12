CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_teil_massnahme AS SELECT teil_massnahme_id
FROM kfl_production_dbp_view.v_cpr_phase_per
WHERE dat_bis = DATE '9999-12-31'
GROUP BY teil_massnahme_id;