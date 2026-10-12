CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_season_1 (kfl_client_id, kfl_season_nr, kfl_season_name) AS
SELECT kfl_client_id,
 kfl_season_nr,
 kfl_season_name
FROM nfpow_core.t_dim_kfl_season_1;