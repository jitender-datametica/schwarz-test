CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_flw_produktgruppe_spr_zu_2 (mandant_id,
produktgruppe_id, produktgruppe_bez) AS SELECT V01.mandant_id,
 V01.produktgruppe_id,
 V01.produktgruppe_bez
FROM kfl_production_dbp_view.v_flw_produktgruppe_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id;