CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_KOMPENSATION_KRIT_SPR_ZU_CZ
(

ZCGADV
,ZCGADV_bez
,spr_id
)
AS

   SELECT
   ZCGADV, ZCGADV_bez, spr_id

   FROM
   (
   SELECT
   CAST(0 AS BYTEINT) AS ZCGADV, CAST('Compensation | (equal unit of measure)' AS VARCHAR(100)) AS ZCGADV_bez, CAST(124 AS SMALLINT) AS spr_id
   ) v01

   UNION

   SELECT
   ZCGADV, ZCGADV_bez, spr_id

   FROM
   (
   SELECT
   CAST(1 AS BYTEINT) AS ZCGADV, CAST('Compensation | (different unit of measure)' AS VARCHAR(100)) AS ZCGADV_bez, CAST(124 AS SMALLINT) AS spr_id
   ) v02
;