CREATE OR REPLACE VIEW P_LEW_BIL.V_AJI_DELIV_ITEM_SIG_FA_1 as

   /*
   #DescStart#
   #$Revision: 7235 $, $LastChangedBy: mmurtenthaler $
   #SubjectAreas#: Anliefermenge
   #DescEnd#
   */
   SELECT
     a.client_id,
   a.item_sid,
   a.sub_item_grp_sid_asis,
   a.foodaction_fg
   FROM p_lew_bil.t_agg_deliv_base_1 a
   GROUP BY 1,2,3,4
;