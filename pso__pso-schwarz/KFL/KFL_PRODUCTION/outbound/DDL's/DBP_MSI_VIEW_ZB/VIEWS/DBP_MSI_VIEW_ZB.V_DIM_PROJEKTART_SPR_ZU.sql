CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_dim_projektart_spr_zu (projektart_cd, projektart_bez,
projektart_bez_de, projektart_bez_en) AS SELECT projektart_cd,
 MAX(projektart_bez_de) AS projektart_bez,
 projektart_bez_de,
 projektart_bez_en
FROM kfl_production_dbp_msi_data.zb_dim_projekt
GROUP BY projektart_cd,
 projektart_bez_de,
 projektart_bez_en;