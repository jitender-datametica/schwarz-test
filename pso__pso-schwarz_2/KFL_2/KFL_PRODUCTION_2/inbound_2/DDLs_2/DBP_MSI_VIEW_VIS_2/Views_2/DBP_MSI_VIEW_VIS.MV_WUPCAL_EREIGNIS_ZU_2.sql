CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUPCAL_EREIGNIS_ZU_2
(
dat
,wup_id
,nb_id
,mandant_id
,ereignistyp_id
,ereignis_id
,offen
)
AS
   SELECT
   v01.dat, v01.wup_id, v01.nb_id, v01.mandant_id, v01.ereignistyp_id, v01.ereignis_id, v01.offen
   FROM dbp_view.v_wupcal_ereignis_zu_2 v01;