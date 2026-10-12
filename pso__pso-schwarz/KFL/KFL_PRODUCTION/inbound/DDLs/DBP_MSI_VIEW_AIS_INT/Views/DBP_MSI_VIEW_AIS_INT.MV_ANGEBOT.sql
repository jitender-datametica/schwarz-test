CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ANGEBOT
(
 MANDANT_ID
,ANGEBOT_NR
,KJWO_WW
)
AS
SELECT
-- wird nur für Angebot Prompt benötigt, ansonsten wird mv_angebot_art_wup_zu verwendet (beinhaltet Join auf akt_msi_user)
 MANDANT_ID
,ANGEBOT_NR
,KJWO_WW
FROM DBP_DATA.ANGEBOT;