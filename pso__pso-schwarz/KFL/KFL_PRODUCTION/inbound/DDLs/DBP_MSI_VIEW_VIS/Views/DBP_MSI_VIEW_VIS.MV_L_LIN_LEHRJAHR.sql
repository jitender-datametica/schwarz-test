CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_LIN_LEHRJAHR
(
lehrjahr
)
AS
   SELECT lehrjahr FROM (SELECT 1 AS lehrjahr) v01
   UNION ALL
   SELECT lehrjahr FROM (SELECT 2 AS lehrjahr) v02
   UNION ALL
   SELECT lehrjahr FROM (SELECT 3 AS lehrjahr) v03
;