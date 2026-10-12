CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ABT_2
(
mandant_id
, abt_id
, arthiertyp_id
)
AS
   SELECT
  mandant_id,
   abt_id,
   arthiertyp_id
  FROM dbp_view.v_abt_2
  WHERE arthiertyp_id = 2
  AND mandant_id <> 1;