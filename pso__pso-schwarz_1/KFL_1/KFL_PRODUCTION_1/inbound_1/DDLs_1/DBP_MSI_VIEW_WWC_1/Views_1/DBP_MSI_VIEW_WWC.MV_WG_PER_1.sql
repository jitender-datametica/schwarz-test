CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WG_PER_1
-- 05.04.2018, AP0021792, srom: OWG Umstellung
(
mandant_id
,mandant_kbez
,arthiertyp_id
,lead_mwst_id
,MATKL
,abt_id
,dat_von
,dat_bis
,owg_id
,WG_ID_SAP
)
AS
   SELECT
   v01.mandant_id, v02.mandant_kbez, v01.arthiertyp_id, v01.lead_mwst_id, v01.wg_id AS MATKL, v01.abt_id, v01.dat_von, v01.dat_bis, v01.owg_id, CASE WHEN v01.wg_id < 0 THEN TO_VARCHAR(v01.wg_id, 'FM000')
   ELSE TO_VARCHAR(v01.wg_id, 'FM000') END AS WG_ID_SAP
   FROM dbp_view.v_wg_per_1 v01
   INNER JOIN dbp_view.v_mandant_1 v02
   ON v01.mandant_id = v02.mandant_id
   WHERE v01.dat_bis = '9999-12-31'
   AND v01.arthiertyp_id = 2;