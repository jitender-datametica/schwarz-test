CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MIETERTRAG_DETAIL as
      -- 2009-03-12
      -- FAKTVIEW Mietertraege Debitoren
      -- enthaelt netto betrage
      -- 2009KW17 EUR + LW über waehrungstyp
      -- 2009KW27 Historisierung Kurs
      -- 2009KW47 Umstellung mv_zeit auf v_monat
      -- 2013-04-11 : Redesign Offene Posten + Mietsicherheiten
      -- 2013-05-02 : Update CASE

      SELECT
      med.mandant_id,
      med.debitor_id,
      med.immo_objekt_id,
      med.kjmo,
      med.sachkonto_id,
      med.belegart_id,
      CASE
     WHEN (med.mandant_id=1 AND belegart_id IN ('AD','AM','AN','BM','BN','EK','PV'))
     OR (med.mandant_id<>1 AND belegart_id IN ('DG','DR','JD','JQ','RV'))  THEN 10 -- miete
     WHEN (med.mandant_id=1 AND belegart_id IN ('45','46','EA','EB','EE','ES','EU','GE','GZ','KO','SX'))
     OR (med.mandant_id<>1 AND belegart_id IN ('KO','ZP','SB'))  THEN 20 -- zahlung
     WHEN (med.mandant_id=1 AND belegart_id IN ('GA','GL'))  THEN 30 -- ruecklast
     WHEN (med.mandant_id=1 AND belegart_id IN ('31','36','37','38','39','49','79','ZE'))
     OR (med.mandant_id<>1 AND belegart_id IN ('JB'))  THEN 40 -- storno
     ELSE 99 END::SMALLINT AS belegtyp_id,
      med.konto_betrag * kurs AS konto_betrag,
      kurs.wrg_id,
      kurs.wrg_typ_id
     FROM dbp_view.v_ivs_mietertrag_detail  med
      INNER JOIN dbp_view.v_monat  zeit
      ON zeit.kjmo = med.kjmo
      INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per  kurs
      ON kurs.mandant_id = med.mandant_id
      AND zeit.max_dat BETWEEN kurs_dat_von AND kurs_dat_bis
;