CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_BUCHUNGSKREIS_2
(
mandant_id
, buchungskreis_id
, gj_variante_id
, land_id
, wrg_id
, system_id
, kontenplan_id
, buchungskreis_glob_id
)
AS
   SELECT
   v01.mandant_id, v01.buchungskreis_id, v01.gj_variante_id, v01.land_id, v01.wrg_id, v01.system_id, v01.kontenplan_id, v01.buchungskreis_glob_id

   FROM dbp_view.v_l_buchungskreis_2 v01;