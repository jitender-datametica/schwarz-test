CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_materialgruppe (materialgruppe_id, materialgruppe_bez) AS
SELECT materialgruppe_id,
 material_gruppierung AS materialgruppe_bez
FROM (((SELECT 'Schwein' AS material_gruppierung,
      1 AS materialgruppe_id
     FROM kfl_production_dbp_view.v_mandant_grp
     UNION DISTINCT
     SELECT 'HAWA',
      4
     FROM kfl_production_dbp_view.v_mandant_grp)
    UNION DISTINCT
    SELECT 'Rind',
     2
    FROM kfl_production_dbp_view.v_mandant_grp)
   UNION DISTINCT
   SELECT 'gemischt',
    3
   FROM kfl_production_dbp_view.v_mandant_grp) AS t1;