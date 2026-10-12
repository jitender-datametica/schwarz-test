CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_MATERIALGRUPPE_2
(
materialgruppe_id
,materialgruppe_bez
)
AS
   SELECT
   materialgruppe_id, material_gruppierung  AS materialgruppe_bez
   FROM
   (
   SELECT  CAST('Schwein' AS VARCHAR(8)) AS material_gruppierung, 1 AS materialgruppe_id
   FROM dbp_view.v_mandant_grp_2
   UNION
   SELECT
   'HAWA', 4
   FROM dbp_view.v_mandant_grp_2
   UNION

   SELECT   'Rind', 2
   FROM dbp_view.v_mandant_grp_2
   UNION

   SELECT    'gemischt', 3
   FROM dbp_view.v_mandant_grp_2
   ) t1_2;