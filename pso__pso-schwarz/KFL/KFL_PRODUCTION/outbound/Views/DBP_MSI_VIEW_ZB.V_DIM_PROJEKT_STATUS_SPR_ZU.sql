CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_dim_projekt_status_spr_zu (projekt_status_id, projekt_status_bez
, projekt_status_bez_de, projekt_status_bez_en) AS SELECT projekt_status_id,
 MAX(projekt_status_bez_de) AS projekt_status_bez,
 projekt_status_bez_de,
 projekt_status_bez_en
FROM kfl_production_dbp_msi_data.zb_dim_projekt
GROUP BY projekt_status_id,
 projekt_status_bez_de,
 projekt_status_bez_en;