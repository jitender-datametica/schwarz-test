CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_aktion_wme_ame_lookup AS SELECT ein_hol.mandant_id,
 ein_hol.aktion_id,
  CASE
  WHEN ein_hol.aktion_typ_id = 'ZAME'
  THEN 'AME'
  ELSE 'WME'
  END AS aktion_typ,
 WME_AME.aktionsart_id,
 ein_hol.schlagwort,
 WME_AME.zusatzinfo,
 ein_hol.dat_von,
 ein_hol.dat_bis
FROM kfl_production_dbp_data.aktion_wme_ame AS WME_AME
 INNER JOIN (SELECT DISTINCT mandant_id,
   aktion_id,
   schlagwort,
   aktion_typ_id,
   dat_von,
   dat_bis
  FROM kfl_production_dbp_data.aktion_werbemengen_einholung) AS ein_hol ON WME_AME.aktion_id = ein_hol.aktion_id AND
   WME_AME.mandant_id = ein_hol.mandant_id
WHERE ein_hol.dat_bis >= CURRENT_DATE;