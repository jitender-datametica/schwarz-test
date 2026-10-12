create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_LAGER_BEWART(
	MANDANT_ID,
	LAGER_BEWART_ID
) as
SELECT
 v01.mandant_id
,v01.lager_bewart_id
FROM DBP_VIEW.v_l_lager_bewart v01
--keine Beruecksichtigung der SAP-Industriesysteme fuer DE + CZ
WHERE v01.system_id NOT IN (2,17,28,32,48,53);