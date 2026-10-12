CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_LT_LEITER
(
	IT_LT_LEITER_ID,
	MA_NAME,
	MA_LDAP
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 09.04.2013 AL Init
-- 29.04.2021 twie: NSR2133664 Join auf l_ma entfernt, da ma_ldap jetzt aus ma_spr_zu kommt

   SELECT v01.ma_id AS it_lt_leiter_id,
   v01.ma_vorname || ' ' || v01.ma_name AS ma_name,
   v01.ma_ldap

   FROM dbp_view.v_ma_spr_zu  v01
 
   WHERE v01.mandant_id=1 
   AND   spr_id=22
   AND
   (v01. ma_id) IN (SELECT
   ma_id
   FROM dbp_view.v_it_projekt_ma_zu v01
   WHERE v01.mandant_id=1 AND     ma_funktion_id='CLLTKIS'
   )
;