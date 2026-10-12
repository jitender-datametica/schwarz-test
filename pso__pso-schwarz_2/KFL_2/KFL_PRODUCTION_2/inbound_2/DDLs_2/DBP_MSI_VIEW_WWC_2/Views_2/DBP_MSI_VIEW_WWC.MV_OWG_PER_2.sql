CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_OWG_PER_2
-- 05.04.2018, AP0021792, srom: OWG Umstellung
-- 29.12.2020, AP0078017/SPEC0097095 snik1809 - change all views with a filter owg_id >=0
(
owg_id
,arthiertyp_id
,mandant_id
,dat_von
,dat_bis
,hwg_id
,OWG_ID_SAP
,mandant_kbez
)
AS
   SELECT
   v01.owg_id, v01.arthiertyp_id, v01.mandant_id, v01.dat_von, v01.dat_bis, v01.hwg_id, CASE WHEN v01.owg_id < 0 THEN TO_VARCHAR(v01.owg_id, 'FM0000')
   ELSE TO_VARCHAR(v01.owg_id, 'FM0000') END AS OWG_ID_SAP, v02.mandant_kbez
   FROM dbp_view.v_owg_per_2 v01
   INNER JOIN dbp_view.v_mandant_2 v02
   ON v01.mandant_id = v02.mandant_id
   WHERE v01.dat_bis = '9999-12-31'
   AND v01.arthiertyp_id = 2
   AND v01.owg_id >= 0;