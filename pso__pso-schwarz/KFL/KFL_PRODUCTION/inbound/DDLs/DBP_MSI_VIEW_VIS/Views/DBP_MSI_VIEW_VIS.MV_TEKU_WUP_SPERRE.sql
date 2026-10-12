CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_WUP_SPERRE
(
mandant_id
,wup_id
,hausleiter_sperr_fg
,vkl_sperr_fg
,gf_gbl_vertrieb_sperr_fg
,user_id
,hierarchie_ebene_id
)
AS

   SELECT
   t01.mandant_id, t01.wup_id, t01.hausleiter_sperr_fg, t01.vkl_sperr_fg, t01.gf_gbl_vertrieb_sperr_fg, t02.user_id, t02.hierarchie_ebene_id
   FROM dbp_msi_v_view.v_wup_denorm_per t01
   INNER JOIN (SELECT v02_1.mandant_id, v02_1.user_id, v02_1.hierarchie_element_id, v02_1.hierarchie_ebene_id, v02_2.wup_id
   FROM dbp_msi_v_view.v_user_vis_benchmark_zu v02_1
   INNER JOIN dbp_msi_v_view.v_user_wup_zu v02_2
   ON v02_1.mandant_id = v02_2.mandant_id
   AND v02_1.user_id = v02_2.user_id
   ) t02
   ON t01.mandant_id = t02.mandant_id
   AND t01.wup_id = t02.wup_id

   -- In VIS werden nur die aktuellen Strukturen angezeigt
   WHERE CONTAINS(t01.dat_von_bis,'CURRENT_DATE');