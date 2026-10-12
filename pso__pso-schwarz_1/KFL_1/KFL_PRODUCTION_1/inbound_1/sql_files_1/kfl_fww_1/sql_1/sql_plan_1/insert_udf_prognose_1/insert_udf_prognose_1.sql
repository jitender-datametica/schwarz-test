INSERT INTO dbp_data.udf_prognose_1 (
  mandant_id, 
  wup_id, 
  nb_id, 
  art_id, 
  diagnose_id, 
  dat_prognoselauf, 
  dat, 
  prognose_horizont, 
  menge_prognose_af, 
  menge_prognose_sa, 
  menge_prognose_gesteuert,
  td_insert,
  td_update) 
SELECT 
  mandant_id, 
  wup_id, 
  nb_id, 
  art_id, 
  diagnose_id, 
  '2022-11-20' as dat_prognoselauf, 
  dat, 
  prognose_horizont, 
  menge_prognose_af, 
  menge_prognose_sa, 
  menge_prognose_gesteuert, 
  current_timestamp as td_insert, 
  current_timestamp as td_update
FROM dbp_data.udf_prognose_1 
WHERE dat_prognoselauf = '2022-11-19' 
      AND mandant_id = 1;

