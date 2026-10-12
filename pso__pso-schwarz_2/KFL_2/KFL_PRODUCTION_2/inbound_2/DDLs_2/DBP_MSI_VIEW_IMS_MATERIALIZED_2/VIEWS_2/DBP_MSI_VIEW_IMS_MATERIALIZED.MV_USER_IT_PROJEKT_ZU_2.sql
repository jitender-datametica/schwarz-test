create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_USER_IT_PROJEKT_ZU_2(
	USER_ID,
	IT_PROJEKT_ID
) as
-- 06.05.2021 twie: SPEC0081686 Zuordnung der User mit den IT Projekten für Steuerung Sicherheitsfilter
-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

SELECT

 LOWER(user_id) AS user_id
,it_projekt_id

FROM DBP_SECURITY.L_IMS_USER_IT_PROJEKT_2 v01;