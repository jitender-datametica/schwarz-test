CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_MANDANT_1
   as 
   SELECT mandant_id,
   mandant_bez,
   mandant_kbez,
   wrg_id,
   bis_sort_id
   FROM

   (
   SELECT
   99 AS mandant_id,
   'International' AS mandant_bez,
   'INT' AS mandant_kbez,
   'EUR' AS wrg_id,
   1 AS bis_sort_id
   ) t0

   UNION

   SELECT
   mandant_id,
   mandant_bez,
   mandant_kbez,
    CASE WHEN v04.wrg_typ_id = 1 THEN default_wrg
   ELSE 'EUR'
   END wrg_id,
   bis_sort_id
   FROM DBP_MSI_VIEW_BIS.tbl_MV_MANDANT_1 v01 
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v04;