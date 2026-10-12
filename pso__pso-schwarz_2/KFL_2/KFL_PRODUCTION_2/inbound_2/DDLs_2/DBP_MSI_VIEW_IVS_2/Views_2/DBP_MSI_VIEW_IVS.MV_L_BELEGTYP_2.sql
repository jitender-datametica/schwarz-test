CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_BELEGTYP_2 as
   -- 2013-04-11
   -- LOOKUP/SPRACHE Belegtyp
   -- 2013-04-11 : Redesign Offene Posten + Mietsicherheiten
   -- 2013-05-02 : Update CASE

   SELECT DISTINCT
   mandant_id,
   CASE
  WHEN (mandant_id=1 AND belegart_id IN ('AD','AM','AN','BM','BN','EK','PV'))
  OR (mandant_id<>1 AND belegart_id IN ('DG','DR','JD','JQ','RV'))  THEN 10 -- miete
  WHEN (mandant_id=1 AND belegart_id IN ('45','46','EA','EB','EE','ES','EU','GE','GZ','KO','SX'))
  OR (mandant_id<>1 AND belegart_id IN ('KO','ZP','SB'))  THEN 20 -- zahlung
  WHEN (mandant_id=1 AND belegart_id IN ('GA','GL'))  THEN 30 -- ruecklast
  WHEN (mandant_id=1 AND belegart_id IN ('31','36','37','38','39','49','79','ZE'))
  OR (mandant_id<>1 AND belegart_id IN ('JB'))  THEN 40 -- storno
  ELSE 99 END::SMALLINT AS belegtyp_id,
   CASE
  WHEN belegtyp_id = 10 THEN 'Miete'
  WHEN belegtyp_id = 20 THEN 'Zahlung'
  WHEN belegtyp_id = 30 THEN 'Rücklastschrift'
  WHEN belegtyp_id = 40 THEN 'Storno'
  WHEN belegtyp_id = 99 THEN 'Sonst. Buchung'
  END::VARCHAR(40) AS belegtyp_bez

   FROM dbp_view.v_ivs_mietertrag_detail_2
;