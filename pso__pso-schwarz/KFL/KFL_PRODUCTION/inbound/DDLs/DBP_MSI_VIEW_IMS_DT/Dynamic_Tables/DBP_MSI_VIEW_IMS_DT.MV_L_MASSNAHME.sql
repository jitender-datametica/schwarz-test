CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_MASSNAHME
(
	MASSNAHME_ID,
	MASSNAHMENART_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 23.07.2019 twie: SPEC0059595 Lookup für Massnahmenart
-- statt massnahmenart_id wird die massnahme_id als PK genommen, ist 1:1 zugeordnet

   SELECT

   massnahme_id,
   massnahmenart_id

   FROM dbp_view.v_l_massnahme
;