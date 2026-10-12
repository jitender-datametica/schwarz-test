CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_COS_BONUSKAUF_ZIELGRUPPENGROESSE_2
(
 mandant_id
,bonuskauf_id
,dat
,gesamte_zielgruppengroesse
)
AS
SELECT 
 b02.mandant_id
,bonuskauf_id
,dat
,gesamte_zielgruppengroesse
FROM 
(
SELECT  *
,DATE(dat_von) AS dat_voned
FROM dbp_view.v_cos_bonuskauf_2
) b01
JOIN 
(
SELECT 
 KUNDE_MANDANT_ID AS mandant_id
,dat
,COUNT(DISTINCT crm_kunde_id) AS gesamte_zielgruppengroesse
FROM dbp_view.v_tag_2 v01
JOIN dbp_view.v_crm_l_kunde_2 v02
ON  v01.dat >= v02.zeit_registrierung
AND v01.dat <= v02.zeit_abmeldung
GROUP BY 1,2
ORDER BY dat) b02
ON  b01.dat_voned = b02.dat
AND b01.mandant_id = b02.mandant_id;
