CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WUG_SPR_ZU_SK_2
(
  mandant_id
, PRDHA
, MATKL
, spr_id
, wug_bez
, wg_wug_id_bez
)
AS
SELECT V01.MANDANT_ID ,
       V01.WUG_ID AS PRDHA ,
       V01.WG_ID AS MATKL ,
       V01.SPR_ID ,
       V01.WUG_BEZ ,
       (to_char(V01.WG_ID,'FM000') || ' ' || to_char(V01.WUG_ID,'FM000') || V01.WUG_BEZ) :: Varchar(100)  WG_WUG_ID_BEZ
FROM DBP_VIEW.V_WUG_SPR_ZU_2 V01
WHERE V01.SPR_ID = 108
  AND V01.ARTHIERTYP_ID = 2;