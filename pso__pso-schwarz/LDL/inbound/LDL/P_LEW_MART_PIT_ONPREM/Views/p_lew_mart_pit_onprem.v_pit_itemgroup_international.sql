CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ITEMGROUP_INTERNATIONAL

 (
  client_id
, item_grp_int_sid
, item_grp_int_mstr_sid
, src_itemgrp_int_cd
, item_grp_int_descr_int
, item_grp_int_descr_loc
 )
AS
   SELECT
   igi.client_id                                              AS client_id                 --  Ok
   
,   igi.item_grp_int_sid                                       AS item_grp_int_sid          --  Andreas: name: wgi_sid
   
,   ( (igi.item_grp_int_sid * 100::INTEGER ) +  igi.client_id )            AS item_grp_int_mstr_sid     --  Andreas does not have this
   
,   igi.src_itemgrp_int_cd                                     AS src_itemgrp_int_cd        --  Andreas: name: wgi_cd
   
,   igi.item_grp_int_name                                      AS item_grp_int_descr_int    --  Andreas: name: wgi_desc_int
   
,   Coalesce ( dsc.item_grp_int_descr, igi.item_grp_int_name ) AS item_grp_int_descr_loc    --  Andreas: name: wgi_desc_loc: Andreas does not have coalesce

   FROM p_lew_core_ac.v_itemgroup_international AS igi
   INNER JOIN p_lew_core_ac.v_country AS ctr
   ON  igi.client_id = ctr.country_sid
   LEFT JOIN p_lew_core_ac.v_itemgroup_international_descr AS dsc
   ON  igi.client_id        = dsc.client_id
   AND igi.item_grp_int_sid = dsc.item_grp_int_sid
   AND ctr.lang_sid         = dsc.lang_sid
   WHERE  try_TO_NUMBER (igi.src_itemgrp_int_cd ) NOT IN (8, 80)                           --  Exclude 'PC und Zubehör' 
          AND
          igi.client_id IN  (SELECT client_id FROM p_lew_mart_pit_onprem.t_pit_clients )


   UNION ALL
   SELECT
   Clients.client_id                AS client_id
,   -2::INTEGER                               AS item_grp_int_sid                     --  Note! sid no longer 
       
,   ((-2::INTEGER * 100::INTEGER) +  Clients.client_id )   AS item_grp_int_mstr_sid                --  Odd! maybe used -client_id*100 - client_id or some other multiple of 100 so can see the client
   
,   'TOT'                             AS src_itemgrp_int_cd
,   'TOT'                             AS item_grp_int_descr_int
,   'TOT'                             AS item_grp_int_descr_loc
   FROM         
   
   (SELECT DISTINCT client_id FROM p_lew_mart_pit_onprem.t_pit_clients )         AS Clients;