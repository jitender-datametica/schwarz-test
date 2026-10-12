CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_PRUEFGRUND
-- snik1809 - 04302020 - SPEC0067726 - AP0047448 Reiter FWWS
(
pruef_id
,mandant_id
,pruef_bez
,z_arbeitsgebiet_id
)
AS

SELECT
v01.pruef_id
,v01.mandant_id
,v01.pruef_bez
,v01.z_arbeitsgebiet_id
FROM dbp_data.l_pruefgrund v01
WHERE v01.pruef_id IN (202,203,205,206,207,209,210,214,216,218,223,225,231,700)
AND v01.mandant_id > 1
AND v01.z_arbeitsgebiet_id = 1
OR (v01.mandant_id > 1
AND v01.pruef_id IN (250,252,001,005,002,253)
AND v01.z_arbeitsgebiet_id = 0);