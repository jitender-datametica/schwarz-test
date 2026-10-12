CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_ims_systemstatus_spr_zu_1 AS SELECT V01.systemstatus_id,
 V01.mandant_id,
 V01.systemstatus_bez_kurz,
 V01.systemstatus_bez
FROM kfl_production_dbp_view.v_ims_systemstatus_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.spr_id = V02.spr_id;