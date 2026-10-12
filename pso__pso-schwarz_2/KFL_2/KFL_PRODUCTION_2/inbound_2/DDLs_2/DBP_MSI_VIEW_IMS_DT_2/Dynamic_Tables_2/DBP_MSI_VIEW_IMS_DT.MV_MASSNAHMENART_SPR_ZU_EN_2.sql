CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_MASSNAHMENART_SPR_ZU_EN_2
(
	MASSNAHME_ID,
	MASSNAHMENART_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 23.07.2019 twie: SPEC0059595 Sprachtabelle für Massnahmenart
-- statt massnahmenart_id wird die massnahme_id als PK genommen, ist 1:1 zugeordnet

   SELECT

   v01.massnahme_id,
   COALESCE(v03.massnahmenart_bez, v02.massnahmenart_bez) AS massnahmenart_bez

   FROM dbp_view.v_l_massnahme_2 v01
   LEFT JOIN dbp_view.v_massnahmenart_spr_zu_2 v02
   ON v01.massnahmenart_id = v02.massnahmenart_id
   LEFT JOIN
   (
   SELECT *
   FROM dbp_view.v_massnahmenart_spr_zu_2
   WHERE spr_id = 24
   ) v03
   ON v02.massnahmenart_id = v03.massnahmenart_id

   WHERE v02.spr_id = 22
;