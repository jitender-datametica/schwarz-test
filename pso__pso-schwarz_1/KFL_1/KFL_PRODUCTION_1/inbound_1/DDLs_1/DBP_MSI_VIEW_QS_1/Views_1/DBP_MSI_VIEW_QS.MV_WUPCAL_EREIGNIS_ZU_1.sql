CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_WUPCAL_EREIGNIS_ZU_1
(
dat
, wup_id
, nb_id
, ereignis_id
, offen
, ereignistyp_id
, mandant_id
)
AS
SELECT
v01.dat
, v01.wup_id
, v01.nb_id
, v01.ereignis_id
, v01.offen
, v01.ereignistyp_id
, v01.mandant_id

FROM dbp_view.v_wupcal_ereignis_zu_1 v01;