CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_dim_projektart_spr_zu_1 (projektart_cd, projektart_bez,
projektart_bez_de, projektart_bez_en) AS SELECT projektart_cd,
 MAX(projektart_bez_de) AS projektart_bez,
 projektart_bez_de,
 projektart_bez_en
FROM kfl_production_dbp_msi_data.zb_dim_projekt_1
GROUP BY projektart_cd,
 projektart_bez_de,
 projektart_bez_en;