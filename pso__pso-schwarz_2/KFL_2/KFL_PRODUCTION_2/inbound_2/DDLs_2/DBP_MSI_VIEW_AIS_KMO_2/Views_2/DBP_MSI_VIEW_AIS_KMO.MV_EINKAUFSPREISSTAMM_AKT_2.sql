CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_EINKAUFSPREISSTAMM_AKT_2
   AS 
   SELECT
   v01.mandant_id,
   v01.art_id,
   CAST(
   CASE
   WHEN v200.wrg_typ_id  = 1
   THEN  COALESCE( ek_nettonetto,0)
   WHEN  v200.wrg_typ_id  = 0
   THEN COALESCE( ek_nettonetto,0) * v01.umrechnungskurs
   END AS DECIMAL(18,4))  AS ek2_nettonetto,
   CAST(
   CASE
   WHEN v200.wrg_typ_id  = 1
   THEN  COALESCE( einstandspreis,0)
   WHEN  v200.wrg_typ_id  = 0
   THEN COALESCE( einstandspreis,0) * v01.umrechnungskurs
   END AS DECIMAL(18,4))  AS ek4_einstandspreis
   FROM DBP_MSI_VIEW_AIS_KMO.TBL_MV_EINKAUFSPREISSTAMM_AKT_2 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200;