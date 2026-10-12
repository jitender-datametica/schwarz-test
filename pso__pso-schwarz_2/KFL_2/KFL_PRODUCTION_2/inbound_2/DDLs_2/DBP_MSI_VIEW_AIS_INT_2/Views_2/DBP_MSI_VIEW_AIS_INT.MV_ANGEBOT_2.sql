CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ANGEBOT_2
(
 MANDANT_ID
,ANGEBOT_NR
,KJWO_WW
)
AS
SELECT
-- wird nur für Angebot_2 Prompt benötigt, ansonsten wird mv_angebot_art_wup_zu_2 verwendet (beinhaltet Join auf akt_msi_user_2)
 MANDANT_ID
,ANGEBOT_NR
,KJWO_WW
FROM DBP_DATA.ANGEBOT_2;