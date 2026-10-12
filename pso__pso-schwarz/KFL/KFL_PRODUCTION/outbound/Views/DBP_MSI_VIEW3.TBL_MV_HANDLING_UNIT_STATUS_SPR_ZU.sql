CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_handling_unit_status_spr_zu (mandant_id, hu_status_id,
hu_status_bez, spr_id) AS SELECT mandant_id,
 hu_status_id,
 hu_status_bez,
 spr_id
FROM (SELECT mandant_id,
    hu_status_id,
    hu_status_bez,
    spr_id
   FROM kfl_production_dbp_view.v_handling_unit_status_spr_zu AS V01
   UNION DISTINCT
   SELECT V02.mandant_id,
    V02.hu_status_id,
    t1.hu_status_bez,
    t1.spr_id
   FROM kfl_production_dbp_view.v_handling_unit_status_spr_zu AS V02
    LEFT JOIN (SELECT hu_status_id,
      hu_status_bez,
      spr_id
     FROM kfl_production_dbp_view.v_handling_unit_status_spr_zu AS V03
     WHERE mandant_id = 1
      AND spr_id = 22) AS t1 ON V02.hu_status_id = t1.hu_status_id
   WHERE V02.mandant_id <> 1) AS t2;