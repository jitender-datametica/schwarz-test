CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ANGEBOT_1
(
 MANDANT_ID
,ANGEBOT_NR
,KJWO_WW
)
AS
SELECT
-- wird nur für Angebot_1 Prompt benötigt, ansonsten wird mv_angebot_art_wup_zu_1 verwendet (beinhaltet Join auf akt_msi_user_1)
 MANDANT_ID
,ANGEBOT_NR
,KJWO_WW
FROM DBP_DATA.ANGEBOT_1;