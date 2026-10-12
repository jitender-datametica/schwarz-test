CREATE OR REPLACE VIEW kfl_production_dbp_view.v_eps_anstossherkunft_spr_zu AS SELECT mandant_id,
 spr_id,
 anstossherkunft_kz,
 anstossherkunft_bez
FROM kfl_production_dbp_data.eps_anstossherkunft_spr_zu;