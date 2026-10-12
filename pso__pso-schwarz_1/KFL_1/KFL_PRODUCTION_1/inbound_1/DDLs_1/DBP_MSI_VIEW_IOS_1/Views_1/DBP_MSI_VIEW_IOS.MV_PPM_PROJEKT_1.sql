CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_PPM_PROJEKT_1
(
projekt_nr
,projekt_id
,PSP_Projekt
--,PSP_ID
--,Satus_PSP
,in_budget_typ_id
/*,in_budget_typ_bez*/
--,systemstatus_id
,mandant_id
)
AS
   SELECT

   t1.projekt_id AS projekt_nr, v111.projekt_id AS projekt_id, t2.in_projekt_id_char AS PSP_Projekt, t3.in_budget_typ_id, t1.mandant_id

   FROM dbp_view.v_rpm_element_per_1 t1_1
   JOIN dbp_view.v_in_projekt_1 t2
   ON t1.mandant_id=t2.mandant_id
   AND  t2.projekt_ext_id=t1.projekt_id
   AND  t1.dat_bis='9999-12-31'

   JOIN dbp_view.v_in_projekt_1 t3
   ON t1.mandant_id=t3.mandant_id
   AND t2.in_projekt_id=t3.in_projekt_id

   --join dbp_view.v_in_psp_element_1 t4
   --on t1.mandant_id=t4.mandant_id
   --and t2.in_projekt_id=t4.in_projekt_id

   JOIN
   dbp_view.v_cpr_projekt_per_1  v111
   ON v111.cpr_ext_id = t1.projekt_id
   AND v111.dat_bis = '9999-12-31'

   --LEFT OUTER JOIN dbp_view.v_ims_psp_ele_sysstat_zu_1 t5
   --ON t4.psp_id = t5.psp_id
   --AND t4.mandant_id = t5.mandant_id

   /*LEFT OUTER JOIN dbp_view.v_in_budget_typ_spr_zu_1 t7
   ON t3.in_budget_typ_id = t7.in_budget_typ_id
   --AND t3.mandant_id = t7.mandant_id
   AND t7.spr_id = 22*/

   GROUP BY 1,2,3,4,5/*,6*/
   ;