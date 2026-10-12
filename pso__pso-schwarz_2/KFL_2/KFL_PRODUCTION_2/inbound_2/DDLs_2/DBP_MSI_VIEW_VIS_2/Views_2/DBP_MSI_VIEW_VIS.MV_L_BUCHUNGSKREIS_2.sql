CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_BUCHUNGSKREIS_2
--- MR 12.1.2011 erstellt
(
mandant_id
,buchungskreis_id
,gj_variante_id
,land_id
,wrg_id
,system_id
,kontenplan_id
,buchungskreis_glob_id
)
AS

   SELECT
   v01.mandant_id, v01.buchungskreis_id, v01.gj_variante_id, v01.land_id, v01.wrg_id, v01.system_id, v01.kontenplan_id, v01.buchungskreis_glob_id

   FROM dbp_view.v_l_buchungskreis_2 v01

   JOIN dbp_view.v_l_system_2 v02
   ON v01.system_id=v02.system_id
   -- Nur SAP Retail Systeme werden berücksichtigt
   WHERE  v02.system_gruppe ='SAP RET';