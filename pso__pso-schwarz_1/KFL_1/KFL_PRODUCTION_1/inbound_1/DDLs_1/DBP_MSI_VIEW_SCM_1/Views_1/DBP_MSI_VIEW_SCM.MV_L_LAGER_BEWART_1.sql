CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_LAGER_BEWART_1(
	MANDANT_ID,
	LAGER_BEWART_ID
) AS
SELECT
 v01.mandant_id
,v01.lager_bewart_id
FROM DBP_VIEW.v_l_lager_bewart_1 v01
--keine Beruecksichtigung der SAP-Industriesysteme fuer DE + CZ
WHERE v01.system_id NOT IN (2,17,28,32,48,53);