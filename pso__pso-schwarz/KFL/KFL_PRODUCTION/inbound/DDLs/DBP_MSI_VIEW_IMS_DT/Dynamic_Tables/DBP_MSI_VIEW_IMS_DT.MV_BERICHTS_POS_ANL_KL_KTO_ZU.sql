CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_BERICHTS_POS_ANL_KL_KTO_ZU
(
	ANL_KL_KTO_ID,
	BERICHTS_POSITION_INVEST_ID,
	BERICHTS_POSITION_IT_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 10.05.2013 twie: Anlageklasse und Kostenart in ein Attribut zusammenführen
--                  und mit aktueller Zuordnung zu Berichtspositionen für Prüfbericht ausgeben

   SELECT
   CAST('AKL:' || anlage_klasse_id AS VARCHAR(14)) AS anl_kl_kto_id,
   berichts_position_invest_id,
   berichts_position_it_id
   FROM dbp_msi_v_view.v_berichts_pos_anl_kls_zu_per
   WHERE dat_bis = '9999-12-31'

   UNION

   SELECT
   CAST('KTO:' || kostenart_id AS VARCHAR(14)) AS anl_kl_kto_id,
   berichts_position_invest_id,
   berichts_position_it_id
   FROM dbp_msi_v_view.v_berichts_pos_kostart_zu_per
   WHERE dat_bis = '9999-12-31'
   ;