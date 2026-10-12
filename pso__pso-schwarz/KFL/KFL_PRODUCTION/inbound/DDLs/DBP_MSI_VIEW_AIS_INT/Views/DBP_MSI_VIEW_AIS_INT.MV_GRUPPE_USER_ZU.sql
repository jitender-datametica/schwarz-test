CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_USER_ZU
-- Erweiterung um loesch_fg im Zuge TransactionServices - sschuecke 29.07.2014
-- Ã×nderung Security AblÃ¶sung Dialog Tabellen - cbru1709 18.12.2018
(
	GRUPPE_ID,
	USER_ID,
	DAT_GUELTIG_BIS,
   TD_UPDATE
)
AS

SELECT
   v01.gruppe_id,
   v01.user_id,
   v01.dat_gueltig_bis,
   DATE(v01.td_update) AS TD_UPDATE

FROM dbp_security.gruppe_user_zu v01;