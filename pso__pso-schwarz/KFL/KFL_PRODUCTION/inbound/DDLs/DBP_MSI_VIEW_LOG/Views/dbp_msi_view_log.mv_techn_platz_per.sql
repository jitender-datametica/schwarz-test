CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TECHN_PLATZ_PER(
	TECHN_PLATZ_ID,
	MANDANT_ID,
	WERK_INSTANDHALTUNG_PLAN,
	WERK_ID
) AS
--2023-02-02, AP0133256,SPEC0166769,dknop, initial
 SELECT 
 v01.techn_platz_id,
 v01.mandant_id,
 v01.werk_instandhaltung_plan, 
 v02.werk_id
FROM dbp_view.v_techn_platz_per v01
JOIN dbp_view.v_in_werk v02
ON v01.mandant_id= v02.mandant_id
AND v01.werk_instandhaltung_plan = v02.werk_nr
WHERE dat_bis='9999-12-31' ;