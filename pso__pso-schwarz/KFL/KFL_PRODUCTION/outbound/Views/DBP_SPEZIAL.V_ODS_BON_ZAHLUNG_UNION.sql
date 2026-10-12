CREATE OR REPLACE VIEW kfl_production_dbp_spezial.v_ods_bon_zahlung_union (bon_id, bon_zeile, wup_id, mandant_id,
zahlung_typ_id, start_bon_zeile, betrag_zahlung, wrg_id, kpos_zahlung_typ_id, bon_dat, bon_zeile_cashback_referenz,
kartennummer_maskiert) AS SELECT bon_id,
 bon_zeile,
 wup_id,
 mandant_id,
 zahlung_typ_id,
 start_bon_zeile,
 betrag_zahlung,
 wrg_id,
 kpos_zahlung_typ_id,
 bon_dat,
 bon_zeile_cashback_referenz,
 kartennummer_maskiert
FROM kfl_production_dbp_ods.ods_bon_zahlung
UNION ALL
SELECT bon_id,
 bon_zeile,
 wup_id,
 mandant_id,
 zahlung_typ_id,
 start_bon_zeile,
 betrag_zahlung,
 wrg_id,
 kpos_zahlung_typ_id,
 bon_dat,
 bon_zeile_cashback_referenz,
 kartennummer_maskiert
FROM kfl_production_dbp_ods_archiv.ods_bon_zahlung;