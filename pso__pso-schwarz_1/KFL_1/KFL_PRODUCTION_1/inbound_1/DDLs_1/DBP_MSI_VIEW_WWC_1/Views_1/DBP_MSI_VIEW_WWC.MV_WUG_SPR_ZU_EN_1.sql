CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WUG_SPR_ZU_EN_1
(
mandant_id
, PRDHA
, MATKL
, wug_bez
, wg_wug_id_bez
, spr_id
)
AS
   SELECT V02.MANDANT_ID ,
       V02.WUG_ID AS PRDHA ,
       V02.WG_ID AS MATKL ,
       V02.WUG_BEZ ,
       (to_char(V02.WG_ID,'FM000') || ' ' || to_char(V02.WUG_ID,'FM000') || V02.WUG_BEZ) :: Varchar(100)  as WG_WUG_ID_BEZ,
            V02.SPR_ID
FROM
  (SELECT V01.MANDANT_ID ,
          V01.WUG_ID ,
          V01.WG_ID ,
          COALESCE(MAX(CASE
                           WHEN V01.SPR_ID = 24 THEN V01.WUG_BEZ
                       END), MAX(CASE
                                     WHEN V01.SPR_ID = 22 THEN V01.WUG_BEZ
                                 END)) AS WUG_BEZ ,
          MAX(V01.SPR_ID) AS SPR_ID
   FROM DBP_VIEW.V_WUG_SPR_ZU_1 V01
   WHERE V01.SPR_ID IN (22 ,
                        24)-- deutsch, englisch

     AND V01.ARTHIERTYP_ID = 2
   GROUP BY V01.MANDANT_ID ,
            V01.WUG_ID ,
            V01.WG_ID) V02;