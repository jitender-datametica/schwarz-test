CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_BERICHTS_POS_KOSTART_ZU_PER_2
(
	MANDANT_ID,
	KOSTENART_ID,
	KRK_ID,
	DAT_VON,
	DAT_BIS,
	MA_LDAP,
	BERICHTS_POSITION_INVEST_ID,
	BERICHTS_POSITION_IT_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 11.07.2013 twie: View zum Rückschreiben der Pflegeberichte, wird nicht im MSI WHC eingelesen

   SELECT
   mandant_id,
   kostenart_id,
   krk_id,
   dat_von,
   dat_bis,
   ma_ldap,
   berichts_position_invest_id,
   berichts_position_it_id

   FROM dbp_msi_v_view.v_berichts_pos_kostart_zu_per_2
   ;