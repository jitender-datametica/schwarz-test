CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_ods_bon_kopf_1 AS SELECT bon_id,
 bon_dat,
 wup_id,
 mandant_id,
 bon_nr,
 kasse_nr,
 kunde_fg,
 bon_beginn,
 bon_ende,
 umsatz_mwst,
 umsatz_brutto,
 bon_booking,
 dat_booking,
 turnover_fg,
 wrg_id,
 kasse_typ_id,
 reactivated_fg,
 kpos_kasse_typ,
 wagen_nr,
 kundenkarte_id,
 kundenkarte_typ_id
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS V01
WHERE mandant_id = 7
 AND kundenkarte_id IS NOT NULL;