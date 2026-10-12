CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_KURS_1
(
 kurstyp_id
,von_wrg_id
,nach_wrg_id
,dat
,umrechnungskurs
)
AS
SELECT
 v01.kurstyp_id
,v01.von_wrg_id
,v01.nach_wrg_id
,v02.dat
,v01.umrechnungskurs
FROM dbp_view.v_kurs_1 v01
JOIN dbp_view.v_tag_1 v02
ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
WHERE v01.kurstyp_id = 3
AND v01.von_wrg_id NOT IN ('AUD', 'DEM', 'BGL', 'HRK', 'SIT', 'ROL');