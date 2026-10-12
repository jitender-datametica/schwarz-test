CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_PLANGRUPPE_1(
	MANDANT_ID,
	ARBEITSPLAN_ID,
	WERK_ID,
	ARBEITSPLAN_BEZ
) AS
--2023-01-02,AP0153902_SPEC0181369, dknop, initial
--2023-02-28, AP0153902_SPEC0181369, dknop, updating table name
--2023-04-25,AP0153902_SPEC0181369, dknop, removing leading zeros from plangruppe_id in arbeitsplan_id
SELECT 
 mandant_id
,CONCAT(plantyp_id,'/', LTRIM(plangruppe_id, 0),'/',plangruppenzaehler) AS arbeitsplan_id
,werk_id
,arbeitsplan_bez
FROM dbp_view.v_in_plan_1

;