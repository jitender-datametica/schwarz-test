/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEM_DESCR
#----------------------------------------------------------------------------
# History:
#  1.0  2024-02-20    Camila Arango         Remove eLWIS logic
#                                          
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_DESCR
AS
SELECT
 country_iso_cd               AS country_lidl_cd
 ,  Cast(orig_item_nr AS BIGINT) AS derived_item_nr
 ,  item_desc                    AS item_descr
 ,  language_id                  AS language_id
  FROM
  (
    SELECT
        country_iso_cd                   AS country_iso_cd
   ,orig_item_nr                      AS orig_item_nr
   ,Coalesce(item_desc, 'undefined') AS item_desc
   ,language_id                      AS language_id
   ,Row_Number() Over (PARTITION BY country_iso_cd,orig_item_nr, language_id ORDER BY Coalesce(item_desc, 'undefined') DESC NULLS LAST) AS qualifier
    FROM
    (
      SELECT
        country_iso_cd
   ,orig_item_nr
   ,item_desc
   ,language_id
      FROM
      (
        SELECT
          cntry.country_iso_cd                       AS country_iso_cd
   ,itm_descr.orig_item_nr                     AS orig_item_nr
   ,Coalesce(itm_descr.item_desc, 'undefined') AS item_desc
   ,itm_descr.language_id                      AS language_id
   ,itm_item.dat_valid_from
        FROM p_lew_core_ac.v_wawi_itm_item_desc AS itm_descr
   INNER JOIN p_lew_core_ac.v_wawi_itm_item_wh AS itm_wh
   ON  itm_descr.client_id = itm_wh.client_id
   AND itm_descr.item_sid = itm_wh.item_sid
   AND Current_Date BETWEEN itm_wh.dat_rec_start AND itm_wh.dat_rec_end
   AND itm_wh.item_status BETWEEN 5 AND 13
   INNER JOIN p_lew_core_ac.v_wawi_itm_item AS itm_item
   ON itm_wh.client_id = itm_item.client_id
   AND itm_wh.item_sid = itm_item.item_sid
   AND Current_Date BETWEEN itm_item.dat_rec_start AND itm_item.dat_rec_end
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_country client_cntry
   ON itm_descr.client_id = client_cntry.client_id
   INNER JOIN p_lew_core_ac.v_wawi_ref_country cntry
   ON client_cntry.country_id = cntry.country_id
   INNER JOIN p_lew_core_ac.v_client_migration_per AS mig
   ON mig.client_id = itm_descr.client_id

   WHERE Current_Date BETWEEN itm_descr.dat_rec_start AND itm_descr.dat_rec_end
     AND (    Current_Date < mig.migration_dat_valid_from
           OR Current_Date > mig.migration_dat_valid_to
         )
   GROUP BY 1,2,3,4,5
 ) q
    QUALIFY dat_valid_from = Max(dat_valid_from)
    Over (PARTITION BY country_iso_cd, orig_item_nr)
)a
)b
WHERE qualifier = 1
;