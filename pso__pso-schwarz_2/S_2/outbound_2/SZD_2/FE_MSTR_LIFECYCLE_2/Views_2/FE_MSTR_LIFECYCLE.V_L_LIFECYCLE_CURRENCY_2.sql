CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_currency_2 (curr_cd, curr_name, curr_name_de, curr_name_en,
curr_name_ch, curr_name_cz, curr_name_lt, curr_name_sk, curr_name_si, curr_name_ro, euro_exchange_rate) AS SELECT
 curr_cd,
 curr_name,
 curr_name_de,
 curr_name_en,
 curr_name_de AS curr_name_ch,
 curr_name_en AS curr_name_cz,
 curr_name_en AS curr_name_lt,
 curr_name_en AS curr_name_sk,
 curr_name_en AS curr_name_si,
 curr_name_en AS curr_name_ro,
 euro_exchange_rate
FROM szd_core.t_dim_currency_2;