CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_STUECKLISTE_DET_1
AS 
SELECT
v1.mandant_id
,v1.stueckliste_id
,v1.art_id
,v1.stueckliste_pos_id
,v1.stueckliste_typ_id
,v1.komponentenmenge
,v2.total_amount_display
,CONCAT(CAST(((v1.komponentenmenge/v2.total_amount_display) * 100) AS NUMBER(38,2)),'%') AS stueckliste_anteil
,v1.komponentenmenge_einh_id
,v1.dat_von
,v1.dat_bis
FROM dbp_view.v_stueckliste_det_1 v1
JOIN (
SELECT
mandant_id
,stueckliste_id
,SUM(komponentenmenge) AS total_amount_display
FROM dbp_view.v_stueckliste_det_1
GROUP BY 1,2
) v2
ON v1.mandant_id = v2.mandant_id
AND v1.stueckliste_id = v2.stueckliste_id;