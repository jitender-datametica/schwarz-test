CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_bon_kassen_informationen_1 AS SELECT bon_id,
 wup_id,
 mandant_id,
 bon_dat,
 kasse_name,
 kassen_untertyp,
 bargeld_abwicklung,
 umsatz_brutto,
 bonanzahl,
 waage_aktiv_fg
FROM kfl_production_dbp_ods.ods_bon_kassen_informationen_1;